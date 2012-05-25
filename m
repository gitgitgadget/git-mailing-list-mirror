From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensimag.imag.fr>
Subject: [PATCH 2/2] Test File Name: t1306-second-config-file.sh
Date: Fri, 25 May 2012 21:47:19 +0200
Message-ID: <1337975239-17169-2-git-send-email-nguyenhu@ensibm.imag.fr>
References: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
Cc: Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 22:05:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SY0lX-000869-2m
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 22:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105Ab2EYUFf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 16:05:35 -0400
Received: from mx2.imag.fr ([129.88.30.17]:59453 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756768Ab2EYUFe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 16:05:34 -0400
X-Greylist: delayed 1088 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 May 2012 16:05:34 EDT
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4PJdGv0002091
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 21:39:16 +0200
Received: from ensibm.imag.fr (ensibm [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4PJlOnC013901;
	Fri, 25 May 2012 21:47:24 +0200
Received: from ensibm.imag.fr (localhost [127.0.0.1])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id q4PJlOoM011845;
	Fri, 25 May 2012 21:47:24 +0200
Received: (from nguyenhu@localhost)
	by ensibm.imag.fr (8.13.8/8.13.8/Submit) id q4PJlOFq011840;
	Fri, 25 May 2012 21:47:24 +0200
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1337975239-17169-1-git-send-email-nguyenhu@ensibm.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 May 2012 21:39:16 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PJdGv0002091
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: huynh-khoi-nguyen.nguyen@phelma.grenoble-inp.fr
MailScanner-NULL-Check: 1338579556.97134@8pnM/z24nW8y3SU1WZ72cg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198517>

There are 4 tests:
test1 and test2: read tests
test1: ~/.config/git/config exists and ~/.gitconfig doesn't
git reads ~/.config/git/config
test2: ~/.config/git/config exists and ~/.gitconfig exists
git reads ~/.gitconfig
test3 and test4: write tests
test3: ~/.config/git/config exists and ~/.gitconfig doesn't
git writes in ~/.config/git/config
test4: ~/.config/git/config exists and ~/.gitconfig exists
git writes in ~/.gitconfig
---
 t/t1306-second-config-file.sh |   47 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 47 insertions(+), 0 deletions(-)
 create mode 100755 t/t1306-second-config-file.sh

diff --git a/t/t1306-second-config-file.sh b/t/t1306-second-config-file.sh
new file mode 100755
index 0000000..5406456
--- /dev/null
+++ b/t/t1306-second-config-file.sh
@@ -0,0 +1,47 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Valentin Duperray, Lucien Kong, Franck Jonas,
+#		     Thomas Nguy, Khoi Nguyen
+#		     Grenoble INP Ensimag
+#
+
+test_description='~/.config/git/config instead of ~/.gitconfig'
+
+. ./test-lib.sh
+
+test_expect_success 'read: ~/.config/git/config exists and ~/.gitconfig doesn'\''t' '
+	mkdir .config &&
+	mkdir .config/git &&
+	echo "[user]" >.config/git/config &&
+	echo "	name = read_config" >>.config/git/config &&
+	echo read_config >expect &&
+	git config --global --get user.name >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'read: ~/.config/git/config exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	echo "[user]" >.gitconfig &&
+	echo "	name = read_gitconfig" >>.gitconfig &&
+	echo read_gitconfig >expect &&
+	git config --global --get user.name >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'write: ~/.config/git/config exists and ~/.gitconfig doesn'\''t' '
+	rm .gitconfig &&
+	git config --global user.name "write_config" &&
+	echo "[user]" >expect &&
+	echo "	name = write_config" >>expect &&
+	test_cmp expect .config/git/config
+'
+
+test_expect_success 'write: ~/.config/git/config exists and ~/.gitconfig exists' '
+	>.gitconfig &&
+	git config --global user.name "write_gitconfig" &&
+	echo "[user]" >expect &&
+	echo "	name = write_gitconfig" >>expect &&
+	test_cmp expect .gitconfig
+'
+
+test_done
-- 
1.7.0.4
