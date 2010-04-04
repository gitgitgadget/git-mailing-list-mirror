From: Johannes Sixt <j6t@kdbg.org>
Subject: Tests with broken && chains in pu
Date: Sun, 4 Apr 2010 22:08:58 +0200
Message-ID: <201004042208.58939.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Chris Webb <chris@arachsys.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 22:11:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyWAQ-0000go-1z
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 22:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab0DDULR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Apr 2010 16:11:17 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:29739 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751483Ab0DDULQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Apr 2010 16:11:16 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2FA16CDF88;
	Sun,  4 Apr 2010 22:11:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 10AB419F5E9;
	Sun,  4 Apr 2010 22:08:59 +0200 (CEST)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143942>

Junio,

two commits in pu currently add tests with broken && chains:

abbfd017 in cw/ws-indent-with-tab:

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 9e57f80..e92eab0 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -354,7 +354,7 @@ test_expect_success 'check tabs and spaces as indentation (indent-with-non-tab:
 
 test_expect_success 'check tabs as indentation (tab-in-indent: off)' '
 
-	git config core.whitespace "-tab-in-indent"
+	git config core.whitespace "-tab-in-indent" &&
 	echo "	foo ();" > x &&
 	git diff --check
 
@@ -378,7 +378,7 @@ test_expect_success 'check tabs and spaces as indentation (tab-in-indent: on)' '
 
 test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
 
-	git config core.whitespace "tab-in-indent,indent-with-non-tab"
+	git config core.whitespace "tab-in-indent,indent-with-non-tab" &&
 	echo "foo ();" > x &&
 	test_must_fail git diff --check
 
@@ -386,7 +386,7 @@ test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
 
 test_expect_success 'check tab-in-indent excluded from wildcard whitespace attribute' '
 
-	git config --unset core.whitespace
+	git config --unset core.whitespace &&
 	echo "x whitespace" > .gitattributes &&
 	echo "	  foo ();" > x &&
 	git diff --check &&



c8eeb6301 in sr/remote-helper-export

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 33f546b..eb31709 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -9,7 +9,7 @@ test_description='Test remote-helper import and export commands'
 
 test_expect_success 'setup repository' '
 	git init --bare server/.git &&
-	git clone server public
+	git clone server public &&
 	(cd public &&
 	 echo content >file &&
 	 git add file &&
@@ -18,7 +18,7 @@ test_expect_success 'setup repository' '
 '
 
 test_expect_success 'cloning from local repo' '
-	git clone "testgit::${PWD}/server" localclone
+	git clone "testgit::${PWD}/server" localclone &&
 	test_cmp public/file localclone/file
 '
 
