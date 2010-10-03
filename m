From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv5 10/16] t5602 (clone-remote-exec): add missing &&
Date: Sat,  2 Oct 2010 23:10:38 -0600
Message-ID: <1286082644-31595-11-git-send-email-newren@gmail.com>
References: <1286082644-31595-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 07:10:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Gps-0001zH-EI
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 07:10:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752324Ab0JCFJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 01:09:39 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50266 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751886Ab0JCFJh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 01:09:37 -0400
Received: by mail-pw0-f46.google.com with SMTP id 5so856544pwj.19
        for <git@vger.kernel.org>; Sat, 02 Oct 2010 22:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=6n5EJ+jwOintau0X4959QIiRyk8RH1nZbYSdK98jKqo=;
        b=IxRyhp1nUrtXR4LVXViRS0/YDTPzmlv+5eNllFEvt60scyRx/H6eUR9pcbBKztR5Yh
         Jd35SicV059d2qPkcngxHGB393O7Z2wvXlBKvP4f+vquEBT8EJ26UQn5eSGfKXpwutzB
         lKMECQu1/Hxcf+Cbx/7W0sAcb9p7j+pMQOkBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=V69yX8vvS9aaWbQ3IYQBWVtd6enxBWiLE7AVdcgpaVMJYDvu88KG10aJUL9llHPSJ8
         5kbFukjzO9qOwFd33Rd3XqBI2diwy1V3bCEOzbGsa0dSvl79tNIJrxu32cKMUy7ao02/
         GCkx2GXyXh7shEA+HwqCagdm/Y5UIlw4Caf9s=
Received: by 10.143.34.9 with SMTP id m9mr1747527wfj.18.1286082577232;
        Sat, 02 Oct 2010 22:09:37 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o16sm4140250wfh.19.2010.10.02.22.09.34
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 02 Oct 2010 22:09:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286082644-31595-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157834>

Also add a couple test_must_fail invocations where needed, and avoid
one-shot environment variable export and function calls.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5602-clone-remote-exec.sh |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.s=
h
index deffdae..3f353d9 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -5,21 +5,29 @@ test_description=3Dclone
 . ./test-lib.sh
=20
 test_expect_success setup '
-	echo "#!/bin/sh" > not_ssh
-	echo "echo \"\$*\" > not_ssh_output" >> not_ssh
-	echo "exit 1" >> not_ssh
+	echo "#!/bin/sh" > not_ssh &&
+	echo "echo \"\$*\" > not_ssh_output" >> not_ssh &&
+	echo "exit 1" >> not_ssh &&
 	chmod +x not_ssh
 '
=20
 test_expect_success 'clone calls git upload-pack unqualified with no -=
u option' '
-	GIT_SSH=3D./not_ssh git clone localhost:/path/to/repo junk
-	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected
+	(
+		GIT_SSH=3D./not_ssh &&
+		export GIT_SSH &&
+		test_must_fail git clone localhost:/path/to/repo junk
+	) &&
+	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
=20
 test_expect_success 'clone calls specified git upload-pack with -u opt=
ion' '
-	GIT_SSH=3D./not_ssh git clone -u ./something/bin/git-upload-pack loca=
lhost:/path/to/repo junk
-	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''=
" >expected
+	(
+		GIT_SSH=3D./not_ssh &&
+		export GIT_SSH &&
+		test_must_fail git clone -u ./something/bin/git-upload-pack localhos=
t:/path/to/repo junk
+	) &&
+	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''=
" >expected &&
 	test_cmp expected not_ssh_output
 '
=20
--=20
1.7.3.1.66.gab790
