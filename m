From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/47] remote-helpers: test: cleanup style
Date: Mon, 13 May 2013 23:36:35 -0500
Message-ID: <1368506230-19614-13-git-send-email-felipe.contreras@gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 14 06:39:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc71b-0004Aq-Jp
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 06:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752785Ab3ENEjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 00:39:25 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:40024 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3ENEjS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 00:39:18 -0400
Received: by mail-oa0-f42.google.com with SMTP id i10so102510oag.15
        for <git@vger.kernel.org>; Mon, 13 May 2013 21:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=fCmcVr1569SSB9GDLVA7oqTFUxWijJ7BSdspmcY+Gpw=;
        b=qplUwGdNvpzjc5JFt6hfEjejDFgmWPTDUZtsy9RhnjOFevCvk/nTsNuMwUmh93pMDd
         r3E4GnJgMBb6vLXB31nxhXck82Vm6Oj8zldtnAlEh1fv5ft0po6KA9/0AHbhGxq2X7i4
         g0ykfTg37oSGLFaLdKanvjPkpeLsMJIVWHX7FH1SCFueqsu7c/XwlDgPFLJ4LZwpGEBn
         ZnB24jD3qTHCOhLyKPgPkl1y6S1JMbQIOnrs+5JX8PuolStIbwxPOGecxyJDE6nJhBSe
         HYwiz4z+wOaKRVGlYPlOHavnwvGxbVznViB9ynEDje3YkEjbjZ23D5TGqAb5orlbUitV
         BMqg==
X-Received: by 10.60.155.137 with SMTP id vw9mr15272121oeb.81.1368506358371;
        Mon, 13 May 2013 21:39:18 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm19987815obi.8.2013.05.13.21.39.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 21:39:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc1.579.g184e698
In-Reply-To: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224247>

So it's more standardized between all the tests.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-bzr.sh | 88 +++++++++++++++++++++++++-------------
 contrib/remote-helpers/test-hg.sh  | 12 ++++--
 2 files changed, 66 insertions(+), 34 deletions(-)

diff --git a/contrib/remote-helpers/test-bzr.sh b/contrib/remote-helpers/test-bzr.sh
index 00df2d1..6332050 100755
--- a/contrib/remote-helpers/test-bzr.sh
+++ b/contrib/remote-helpers/test-bzr.sh
@@ -18,18 +18,23 @@ if ! "$PYTHON_PATH" -c 'import bzrlib'; then
 fi
 
 check () {
-	(cd $1 &&
+	(
+	cd $1 &&
 	git log --format='%s' -1 &&
-	git symbolic-ref HEAD) > actual &&
-	(echo $2 &&
-	echo "refs/heads/$3") > expected &&
+	git symbolic-ref HEAD
+	) > actual &&
+	(
+	echo $2 &&
+	echo "refs/heads/$3"
+	) > expected &&
 	test_cmp expected actual
 }
 
 bzr whoami "A U Thor <author@example.com>"
 
 test_expect_success 'cloning' '
-	(bzr init bzrrepo &&
+	(
+	bzr init bzrrepo &&
 	cd bzrrepo &&
 	echo one > content &&
 	bzr add content &&
@@ -41,7 +46,8 @@ test_expect_success 'cloning' '
 '
 
 test_expect_success 'pulling' '
-	(cd bzrrepo &&
+	(
+	cd bzrrepo &&
 	echo two > content &&
 	bzr commit -m two
 	) &&
@@ -52,7 +58,8 @@ test_expect_success 'pulling' '
 '
 
 test_expect_success 'pushing' '
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	echo three > content &&
 	git commit -a -m three &&
 	git push
@@ -64,15 +71,18 @@ test_expect_success 'pushing' '
 '
 
 test_expect_success 'roundtrip' '
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	git pull &&
-	git log --format="%s" -1 origin/master > actual) &&
+	git log --format="%s" -1 origin/master > actual
+	) &&
 	echo three > expected &&
 	test_cmp expected actual &&
 
 	(cd gitrepo && git push && git pull) &&
 
-	(cd bzrrepo &&
+	(
+	cd bzrrepo &&
 	echo four > content &&
 	bzr commit -m four
 	) &&
@@ -81,7 +91,8 @@ test_expect_success 'roundtrip' '
 
 	check gitrepo four master &&
 
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	echo five > content &&
 	git commit -a -m five &&
 	git push && git pull
@@ -101,7 +112,8 @@ cat > expected <<EOF
 EOF
 
 test_expect_success 'special modes' '
-	(cd bzrrepo &&
+	(
+	cd bzrrepo &&
 	echo exec > executable
 	chmod +x executable &&
 	bzr add executable
@@ -111,16 +123,21 @@ test_expect_success 'special modes' '
 	bzr commit -m link &&
 	mkdir dir &&
 	bzr add dir &&
-	bzr commit -m dir) &&
+	bzr commit -m dir
+	) &&
 
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	git pull
-	git ls-tree HEAD > ../actual) &&
+	git ls-tree HEAD > ../actual
+	) &&
 
 	test_cmp expected actual &&
 
-	(cd gitrepo &&
-	git cat-file -p HEAD:link > ../actual) &&
+	(
+	cd gitrepo &&
+	git cat-file -p HEAD:link > ../actual
+	) &&
 
 	printf content > expected &&
 	test_cmp expected actual
@@ -134,32 +151,40 @@ cat > expected <<EOF
 EOF
 
 test_expect_success 'moving directory' '
-	(cd bzrrepo &&
+	(
+	cd bzrrepo &&
 	mkdir movedir &&
 	echo one > movedir/one &&
 	echo two > movedir/two &&
 	bzr add movedir &&
 	bzr commit -m movedir &&
 	bzr mv movedir movedir-new &&
-	bzr commit -m movedir-new) &&
+	bzr commit -m movedir-new
+	) &&
 
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	git pull &&
-	git ls-tree HEAD > ../actual) &&
+	git ls-tree HEAD > ../actual
+	) &&
 
 	test_cmp expected actual
 '
 
 test_expect_success 'different authors' '
-	(cd bzrrepo &&
+	(
+	cd bzrrepo &&
 	echo john >> content &&
 	bzr commit -m john \
 	  --author "Jane Rey <jrey@example.com>" \
-	  --author "John Doe <jdoe@example.com>") &&
+	  --author "John Doe <jdoe@example.com>"
+	) &&
 
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	git pull &&
-	git show --format="%an <%ae>, %cn <%ce>" --quiet > ../actual) &&
+	git show --format="%an <%ae>, %cn <%ce>" --quiet > ../actual
+	) &&
 
 	echo "Jane Rey <jrey@example.com>, A U Thor <author@example.com>" > expected &&
 	test_cmp expected actual
@@ -171,6 +196,7 @@ test_expect_success 'fetch utf-8 filenames' '
 
 	LC_ALL=en_US.UTF-8
 	export LC_ALL
+
 	(
 	bzr init bzrrepo &&
 	cd bzrrepo &&
@@ -276,23 +302,23 @@ test_expect_success 'proper bzr repo' '
 
 	bzr init-repo bzrrepo &&
 
-	bzr init bzrrepo/trunk &&
 	(
+	bzr init bzrrepo/trunk &&
 	cd bzrrepo/trunk &&
 	echo one >> content &&
 	bzr add content &&
 	bzr commit -m one
 	) &&
 
-	bzr branch bzrrepo/trunk bzrrepo/branch &&
 	(
+	bzr branch bzrrepo/trunk bzrrepo/branch &&
 	cd bzrrepo/branch &&
 	echo two >> content &&
 	bzr commit -m one
 	) &&
 
-	git clone "bzr::$PWD/bzrrepo" gitrepo &&
 	(
+	git clone "bzr::$PWD/bzrrepo" gitrepo &&
 	cd gitrepo &&
 	git for-each-ref --format "%(refname:short)" refs/remotes/origin > ../actual
 	) &&
@@ -331,9 +357,11 @@ test_expect_success 'strip' '
 	bzr log --line | sed -e "s/^[0-9]\+: //" > ../expected
 	) &&
 
-	(cd gitrepo &&
+	(
+	cd gitrepo &&
 	git fetch &&
-	git log --format="%an %ad %s" --date=short origin/master > ../actual) &&
+	git log --format="%an %ad %s" --date=short origin/master > ../actual
+	) &&
 
 	test_cmp expected actual
 '
diff --git a/contrib/remote-helpers/test-hg.sh b/contrib/remote-helpers/test-hg.sh
index dac3756..8d1154b 100755
--- a/contrib/remote-helpers/test-hg.sh
+++ b/contrib/remote-helpers/test-hg.sh
@@ -21,11 +21,15 @@ if ! "$PYTHON_PATH" -c 'import mercurial'; then
 fi
 
 check () {
-	(cd $1 &&
+	(
+	cd $1 &&
 	git log --format='%s' -1 &&
-	git symbolic-ref HEAD) > actual &&
-	(echo $2 &&
-	echo "refs/heads/$3") > expected &&
+	git symbolic-ref HEAD
+	) > actual &&
+	(
+	echo $2 &&
+	echo "refs/heads/$3"
+	) > expected &&
 	test_cmp expected actual
 }
 
-- 
1.8.3.rc1.579.g184e698
