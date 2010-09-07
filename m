From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] Add testcases showing how pathspecs are ignored with rev-list --objects
Date: Wed,  8 Sep 2010 01:48:00 +1000
Message-ID: <1283874483-32017-3-git-send-email-pclouds@gmail.com>
References: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 08 03:38:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ot9cQ-00051e-Jk
	for gcvg-git-2@lo.gmane.org; Wed, 08 Sep 2010 03:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab0IHBi2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Sep 2010 21:38:28 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33851 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0IHBi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 21:38:26 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so1635270pwi.19
        for <git@vger.kernel.org>; Tue, 07 Sep 2010 18:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0sC/+arohHiA2CMpBOL3eiVd4c/aBkk4fAZkT4N/Z3g=;
        b=Oq3cXUX/s0uFbKglAKSVORcJnpgZEGKSkSoT2kgdsxy5AHjBh7jNPeXrB7OUfJZetR
         m+5b/KueAT2VBkZn+ZOnG0JjYUiCGYRPsSL0a5rI9kKAvBWo6btB3IHGgmXkMcNnivQX
         dwLtaSeo8Fzjv86jMu5/yJYUEngPLLuvYOV1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lziypS5GoGtSgAjj7RftKRzDd7x7As4WmMttL36jRrPAsaJpczpjajH0JJYUwp9ryx
         DYtkvGzOuvRp+AwmjX1hu3CjP1vmLwihLAZz+3gtdaeiOhoK87tx3Mj2ecl3pxVPW497
         gbk8G46fMlSDvT3yP2uj4epKKEtp3mAKKq+Kk=
Received: by 10.114.120.6 with SMTP id s6mr441375wac.224.1283909906238;
        Tue, 07 Sep 2010 18:38:26 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id 33sm14566328wad.18.2010.09.07.18.38.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Sep 2010 18:38:25 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed,  8 Sep 2010 11:38:20 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283874483-32017-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155754>

=46rom: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t6000-rev-list-misc.sh |   51 ++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
new file mode 100755
index 0000000..b3c1dd8
--- /dev/null
+++ b/t/t6000-rev-list-misc.sh
@@ -0,0 +1,51 @@
+#!/bin/sh
+
+test_description=3D'miscellaneous rev-list tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo content1 >wanted_file &&
+	echo content2 >unwanted_file &&
+	git add wanted_file unwanted_file &&
+	git commit -m one
+'
+
+test_expect_failure 'rev-list --objects heeds pathspecs' '
+	git rev-list --objects HEAD -- wanted_file >output &&
+	grep wanted_file output &&
+	! grep unwanted_file output
+'
+
+test_expect_failure 'rev-list --objects with pathspecs and deeper path=
s' '
+	mkdir foo &&
+	>foo/file &&
+	git add foo/file &&
+	git commit -m two &&
+
+	git rev-list --objects HEAD -- foo >output &&
+	grep foo/file output &&
+
+	git rev-list --objects HEAD -- foo/file >output &&
+	grep foo/file output &&
+	! grep unwanted_file output
+'
+
+test_expect_failure 'rev-list --objects with pathspecs and copied file=
s' '
+	git checkout --orphan junio-testcase &&
+	git rm -rf . &&
+
+	mkdir two &&
+	echo frotz >one &&
+	cp one two/three &&
+	git add one two/three &&
+	test_tick &&
+	git commit -m that &&
+
+	ONE=3D$(git rev-parse HEAD:one)
+	git rev-list --objects HEAD two >output &&
+	grep "$ONE two/three" output &&
+	! grep one output
+'
+
+test_done
--=20
1.7.1.rc1.69.g24c2f7
