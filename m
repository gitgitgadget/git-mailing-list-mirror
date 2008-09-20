From: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/14] ls-files: Add tests for --sparse and friends
Date: Sat, 20 Sep 2008 17:01:45 +0700
Message-ID: <1221904913-25887-7-git-send-email-pclouds@gmail.com>
References: <1221904913-25887-1-git-send-email-pclouds@gmail.com>
 <1221904913-25887-2-git-send-email-pclouds@gmail.com>
 <1221904913-25887-3-git-send-email-pclouds@gmail.com>
 <1221904913-25887-4-git-send-email-pclouds@gmail.com>
 <1221904913-25887-5-git-send-email-pclouds@gmail.com>
 <1221904913-25887-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 20 12:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgzJx-0001Fq-Aw
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 12:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbYITKCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Sep 2008 06:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYITKCz
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 06:02:55 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:21281 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbYITKCy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 06:02:54 -0400
Received: by wf-out-1314.google.com with SMTP id 27so880198wfd.4
        for <git@vger.kernel.org>; Sat, 20 Sep 2008 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=1RPAzbRtxu7rE+zfxkp6HUeSo+/6UKG/X73u/wJsccc=;
        b=ljJ+E66eukhRXIcZR9k2CXyiIphY9HUP6l6n0i1E2KR0c6DO3FOgjT0PRTKC5TL1Q+
         +LfoyyQAm2h7I5bUdlvb9ObWMmgOLbBPDFi+UvevDK2ROdHtDlIOlQ4kmVWPrfuMUFQf
         UpQETB/UukqQFtUfwdvS3OZAiZPXntWmYmsOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=KSkJpmqUfruGdHOIbHmt/mrmW7xoHHoq2hvOOyHXKTEWgOU6RaA4MwwawPvgpuj1cx
         /0W7hj8NP+fLx4AqVvWdtR1unKQSmKukZifdrwOF5gaTjItvRqXTaBpbLLZVyKDczX1x
         CHoU21d8ycIY5+Ie9zqScnqbvYj2jbZxVVtvw=
Received: by 10.142.162.9 with SMTP id k9mr455510wfe.93.1221904973999;
        Sat, 20 Sep 2008 03:02:53 -0700 (PDT)
Received: from pclouds@gmail.com ( [117.5.36.54])
        by mx.google.com with ESMTPS id 30sm3592506wfg.9.2008.09.20.03.02.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Sep 2008 03:02:52 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sat, 20 Sep 2008 17:02:43 +0700
X-Mailer: git-send-email 1.6.0.96.g2fad1.dirty
In-Reply-To: <1221904913-25887-6-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96344>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t3004-ls-files-sparse.sh            |   40 +++++++++++++++++++++++++=
++++++++
 t/t3004/cached.expected               |    5 ++++
 t/t3004/deleted.expected              |    1 +
 t/t3004/everything.expected           |   10 ++++++++
 t/t3004/modified.expected             |    2 +
 t/t3004/no-checkout.expected          |    2 +
 t/t3004/orphaned-no-checkout.expected |    3 ++
 t/t3004/orphaned.expected             |    1 +
 t/t3004/others.expected               |    2 +
 t/t3004/sparse-cached.expected        |    3 ++
 t/t3004/sparse-everything.expected    |   11 +++++++++
 11 files changed, 80 insertions(+), 0 deletions(-)
 create mode 100755 t/t3004-ls-files-sparse.sh
 create mode 100644 t/t3004/cached.expected
 create mode 100644 t/t3004/deleted.expected
 create mode 100644 t/t3004/everything.expected
 create mode 100644 t/t3004/modified.expected
 create mode 100644 t/t3004/no-checkout.expected
 create mode 100644 t/t3004/orphaned-no-checkout.expected
 create mode 100644 t/t3004/orphaned.expected
 create mode 100644 t/t3004/others.expected
 create mode 100644 t/t3004/sparse-cached.expected
 create mode 100644 t/t3004/sparse-everything.expected

diff --git a/t/t3004-ls-files-sparse.sh b/t/t3004-ls-files-sparse.sh
new file mode 100755
index 0000000..ec2c869
--- /dev/null
+++ b/t/t3004-ls-files-sparse.sh
@@ -0,0 +1,40 @@
+#!/bin/sh
+
+test_description=3D"test ls-files in --sparse mode"
+
+. test-lib.sh
+
+test_ls_files() {
+	T=3D../t3004/$1.expected
+	shift
+	test_expect_success "ls-files $*" "git ls-files $* > result && test_c=
mp $T result"
+}
+
+test_expect_success 'setup' '
+	touch other orphaned no-checkout cached modified deleted &&
+	git add orphaned no-checkout cached modified deleted &&
+	git update-index --no-checkout orphaned no-checkout &&
+	echo modified >> modified &&
+	rm no-checkout deleted
+'
+
+test_ls_files cached
+test_ls_files cached --cached
+test_ls_files sparse-cached --sparse
+test_ls_files sparse-cached --sparse --cached
+test_ls_files no-checkout --no-checkout
+test_ls_files no-checkout --sparse --no-checkout
+test_ls_files orphaned --orphaned
+test_ls_files orphaned --sparse --orphaned
+test_ls_files orphaned-no-checkout -v --no-checkout --orphaned
+test_ls_files orphaned-no-checkout -v --sparse --no-checkout --orphane=
d
+test_ls_files deleted --deleted
+test_ls_files deleted --sparse --deleted
+test_ls_files modified --modified
+test_ls_files modified --sparse --modified
+test_ls_files others --others
+test_ls_files others --sparse --others
+test_ls_files everything -v --cached --deleted --modified --others
+test_ls_files sparse-everything -v --cached --no-checkout --orphaned -=
-deleted --modified --others
+
+test_done
\ No newline at end of file
diff --git a/t/t3004/cached.expected b/t/t3004/cached.expected
new file mode 100644
index 0000000..6fd0c78
--- /dev/null
+++ b/t/t3004/cached.expected
@@ -0,0 +1,5 @@
+cached
+deleted
+modified
+no-checkout
+orphaned
diff --git a/t/t3004/deleted.expected b/t/t3004/deleted.expected
new file mode 100644
index 0000000..71779d2
--- /dev/null
+++ b/t/t3004/deleted.expected
@@ -0,0 +1 @@
+deleted
diff --git a/t/t3004/everything.expected b/t/t3004/everything.expected
new file mode 100644
index 0000000..6000328
--- /dev/null
+++ b/t/t3004/everything.expected
@@ -0,0 +1,10 @@
+? other
+? result
+H cached
+H deleted
+H modified
+H no-checkout
+H orphaned
+R deleted
+C deleted
+C modified
diff --git a/t/t3004/modified.expected b/t/t3004/modified.expected
new file mode 100644
index 0000000..644a96e
--- /dev/null
+++ b/t/t3004/modified.expected
@@ -0,0 +1,2 @@
+deleted
+modified
diff --git a/t/t3004/no-checkout.expected b/t/t3004/no-checkout.expecte=
d
new file mode 100644
index 0000000..b2a429f
--- /dev/null
+++ b/t/t3004/no-checkout.expected
@@ -0,0 +1,2 @@
+no-checkout
+orphaned
diff --git a/t/t3004/orphaned-no-checkout.expected b/t/t3004/orphaned-n=
o-checkout.expected
new file mode 100644
index 0000000..d687ef0
--- /dev/null
+++ b/t/t3004/orphaned-no-checkout.expected
@@ -0,0 +1,3 @@
+- no-checkout
+- orphaned
+O orphaned
diff --git a/t/t3004/orphaned.expected b/t/t3004/orphaned.expected
new file mode 100644
index 0000000..571b267
--- /dev/null
+++ b/t/t3004/orphaned.expected
@@ -0,0 +1 @@
+orphaned
diff --git a/t/t3004/others.expected b/t/t3004/others.expected
new file mode 100644
index 0000000..bf5bf2b
--- /dev/null
+++ b/t/t3004/others.expected
@@ -0,0 +1,2 @@
+other
+result
diff --git a/t/t3004/sparse-cached.expected b/t/t3004/sparse-cached.exp=
ected
new file mode 100644
index 0000000..3453483
--- /dev/null
+++ b/t/t3004/sparse-cached.expected
@@ -0,0 +1,3 @@
+cached
+deleted
+modified
diff --git a/t/t3004/sparse-everything.expected b/t/t3004/sparse-everyt=
hing.expected
new file mode 100644
index 0000000..5df0599
--- /dev/null
+++ b/t/t3004/sparse-everything.expected
@@ -0,0 +1,11 @@
+? other
+? result
+H cached
+H deleted
+H modified
+- no-checkout
+- orphaned
+O orphaned
+R deleted
+C deleted
+C modified
--=20
1.6.0.96.g2fad1.dirty
