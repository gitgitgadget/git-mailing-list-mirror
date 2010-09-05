From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 17/17] Add narrow clone demonstration test
Date: Sun,  5 Sep 2010 16:47:44 +1000
Message-ID: <1283669264-15759-18-git-send-email-pclouds@gmail.com>
References: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 08:51:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os949-0000CX-0U
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 08:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669Ab0IEGuw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 02:50:52 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:35545 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab0IEGuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 02:50:51 -0400
Received: by mail-pw0-f46.google.com with SMTP id 3so717333pwi.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 23:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lW9/fiZ9WzbCJvkzT0P0N01JRKzSo0Uj95Km9/NK1zo=;
        b=LfREtTf7qZ3A0Je889zU8Y/wa10AWurqgqnPh6rAyaegdtK7im6QBaUcoHtngbfu3/
         4Bg2FrtnFYmQpfTmxPMHuBm9DwJsVtiOGYFZq0kX79EhkUdF4KxR4Eso0g6RqsE2QGPU
         68TVOiM8tAUXCTpJj694u0tTWOeGBZZKdxM5A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=NEDBP5bXKUAO+9Qsu2Az8UQTmtzN8r5CSuhg7mE9EXON3C0gOu390gKWfR1Uviqj1J
         kHn+QrSIqLnD94DK3ZImeHWkw8xFeMvGhbUTg5npFLQsHZXt7n1wQaN0OnFyXvX7KQbC
         Ar71vQEQakwJX3FOxQ95tAVtJVCNtDWh1E5wA=
Received: by 10.114.137.15 with SMTP id k15mr1419922wad.225.1283669451725;
        Sat, 04 Sep 2010 23:50:51 -0700 (PDT)
Received: from dektop ([119.12.225.18])
        by mx.google.com with ESMTPS id o17sm8037451wal.21.2010.09.04.23.50.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 23:50:50 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Sun,  5 Sep 2010 16:50:44 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1283669264-15759-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155443>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 t/t9999-narrow.sh |   87 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100755 t/t9999-narrow.sh

diff --git a/t/t9999-narrow.sh b/t/t9999-narrow.sh
new file mode 100755
index 0000000..2974ddc
--- /dev/null
+++ b/t/t9999-narrow.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description=3D'narrow misc tests'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	git clone --mirror ../../.git src.git
+'
+
+test_expect_success clone '
+	git clone --depth=3D50 --narrow=3DDocumentation --narrow=3Dblock-sha1=
 file://"`pwd`"/src.git dst &&
+	test -f dst/Documentation/git.txt &&
+	test -f dst/block-sha1/sha1.c &&
+	! test -f git.c
+'
+
+test_expect_success 'into dst' '
+	cd dst
+'
+
+#test_expect_failure 'fsck' 'git fsck'
+
+test_expect_success 'checkout -b ' '
+	git checkout -b mybranch
+'
+
+test_expect_success 'log' '
+	git log --stat HEAD~20.. >/dev/null
+'
+
+test_expect_success 'modify worktree' '
+	echo 1 >>Documentation/git.txt
+'
+
+test_expect_success 'diff' '
+	git diff
+'
+
+test_expect_success 'diff HEAD' '
+	git diff HEAD
+'
+
+test_expect_success 'diff --cached' '
+	git add Documentation/git.txt &&
+	git diff --cached
+'
+
+test_expect_success 'commit' '
+	git commit -a -m 1 &&
+	git tag branch0 &&
+	echo 2 >>block-sha1/sha1.c &&
+	git commit -a -m 2 &&
+	echo 3 >>Documentation/git.txt &&
+	echo 3 >>block-sha1/sha1.c &&
+	git commit -a -m 3 &&
+	git tag branch1
+'
+
+test_expect_success 'internal merge' '
+	git checkout branch0 &&
+	echo 4 >>block-sha1/sha1.h &&
+	git commit -a -m 4 && false
+	git tag branch2 &&
+	git merge branch1 &&
+	grep "^2$" block-sha1/sha1.c &&
+	git tag merge1.2
+'
+
+test_expect_success 'rebase' '
+	git checkout branch1 &&
+	git rebase --onto branch2 branch0
+'
+
+test_expect_success 'push' '
+	git push ../src.git +merge1.2:refs/heads/mybranch &&
+	git rev-parse merge1.2 >../expected &&
+	(
+		cd ../src.git &&
+		git rev-parse mybranch >result &&
+		test_cmp ../expected result &&
+		echo fscking... &&
+		git fsck --no-full
+	)
+'
+
+test_done
--=20
1.7.1.rc1.69.g24c2f7
