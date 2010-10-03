From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 10/16] t5602 (clone-remote-exec): add missing &&
Date: Sun,  3 Oct 2010 14:00:08 -0600
Message-ID: <1286136014-7728-11-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uie-0002yx-0i
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754893Ab0JCT7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:12 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55187 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754868Ab0JCT7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:06 -0400
Received: by mail-pz0-f46.google.com with SMTP id 34so1156376pzk.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=aZdE2aWarjvbMtUieOJZU3IbCkezE94Kw2mfs/GHbWE=;
        b=AE4wT0mlWoNGGgIIssQKUFfVkVmaXo0hrc4EuRbdH4kv0a6V4mROdI4/KUFt08QIvO
         SYPazNyk9ErKa8bK8wLScGAQ9V26lTaor92DMXwZJ1ADAalhsiyHlHJDLD13VB1OPGk/
         F3Ba81fFEjizA7xfUTokzY3vqO//g1rpoNU/o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gDpkKidRXRguT7r5GCTuTZCiVAVhGPzl6922zVVZ7s7bYQwds8fw6gtcWxJF/OUGFm
         cLtd3TI9yUI/caLBCWEDHee3IJ3d6oFuQLiqWIZEMICM+2FKmg5GZiCdx7GJW/KqKOtG
         BOu6wV8rRzv3iAg0gMJK97wVDXKfWm3F92/DA=
Received: by 10.114.160.2 with SMTP id i2mr10070092wae.110.1286135946227;
        Sun, 03 Oct 2010 12:59:06 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.04
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157906>

Also add a couple test_must_fail invocations where needed, and avoid
one-shot environment variable export and function calls.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
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
