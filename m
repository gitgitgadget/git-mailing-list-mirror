From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH] Fix typo: existant->existent
Date: Thu, 16 Jun 2011 17:26:35 +0600
Message-ID: <1308223595-6319-1-git-send-email-divanorama@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 13:26:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXAiW-0000Su-6Z
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 13:26:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab1FPL0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 07:26:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55177 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932Ab1FPL0U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 07:26:20 -0400
Received: by bwz15 with SMTP id 15so1160959bwz.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 04:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=sKhKYcZprykmLLPY+SUXV2C0a3zmPRBJ2ZF6NB27Vf8=;
        b=Q3j2dSK4Jqjkn1Et45oJ7FPTi3dPxdWaHmzNn+6N3Jb5VGQJNzotwTclGVjo8M5Uvd
         aIHL9xvumfIqb9B66Q/ff0QHEGjNcCAoR6w2ByMC+oMKjAjWdkZi7vmq6eFcvUBm/XhK
         Xr9b/7ZhV3VidS5o10NwJh90QIgiK74Vp5Mpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=omcvW5rpcjq7+qTqYfYBASV78NkmFOfBvlTbdHJTL+4rX8D0kfGjcexQldgcU6CUd4
         obBbZbhkhO8qoHjcLOkhogFHxNGrBSEeqJro64Q0R/q+nWeyirL+7kVsnYFYUL5hjrjr
         QjOnxXBY6t3R8k68vuxVpbgIA/sd4oIRSRyn8=
Received: by 10.204.189.74 with SMTP id dd10mr499607bkb.174.1308223576582;
        Thu, 16 Jun 2011 04:26:16 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id q20sm1134701bka.5.2011.06.16.04.26.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 04:26:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175892>

refs.c had a error message "Trying to write ref with nonexistent object".
And no tests relied on the wrong spelling.
Also typo was present in some test scripts internals, these tests still pass.

Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
---
This is a reroll of previously sent series 
http://thread.gmane.org/gmane.comp.version-control.git/174910/focus=174909, git-gui patch will go separately.
Existant is a valid word in French, so in po/fr it's ok.

 refs.c                        |    2 +-
 t/t3903-stash.sh              |    2 +-
 t/t4203-mailmap.sh            |    2 +-
 t/t4205-log-pretty-formats.sh |    2 +-
 t/t5506-remote-groups.sh      |    6 +++---
 t/t5516-fetch-push.sh         |   10 +++++-----
 t/t9300-fast-import.sh        |    4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index e3c0511..b10419a 100644
--- a/refs.c
+++ b/refs.c
@@ -1451,7 +1451,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	}
 	o = parse_object(sha1);
 	if (!o) {
-		error("Trying to write ref %s with nonexistant object %s",
+		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
 		return -1;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5c72540..7197aae 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -536,7 +536,7 @@ test_expect_success 'stash pop - fail early if specified stash is not a stash re
 	git reset --hard HEAD
 '
 
-test_expect_success 'ref with non-existant reflog' '
+test_expect_success 'ref with non-existent reflog' '
 	git stash clear &&
 	echo bar5 > file &&
 	echo bar6 > file2 &&
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index e818de6..1f182f6 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -94,7 +94,7 @@ nick1 (1):
 
 EOF
 
-test_expect_success 'mailmap.file non-existant' '
+test_expect_success 'mailmap.file non-existent' '
 	rm internal_mailmap/.mailmap &&
 	rmdir internal_mailmap &&
 	git shortlog HEAD >actual &&
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index cb9f2bd..2ae9faa 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -45,7 +45,7 @@ test_expect_success 'alias user-defined tformat' '
 	test_cmp expected actual
 '
 
-test_expect_success 'alias non-existant format' '
+test_expect_success 'alias non-existent format' '
 	git config pretty.test-alias format-that-will-never-exist &&
 	test_must_fail git log --pretty=test-alias
 '
diff --git a/t/t5506-remote-groups.sh b/t/t5506-remote-groups.sh
index b7b7dda..530b016 100755
--- a/t/t5506-remote-groups.sh
+++ b/t/t5506-remote-groups.sh
@@ -43,10 +43,10 @@ test_expect_success 'no group updates all' '
 	repo_fetched two
 '
 
-test_expect_success 'nonexistant group produces error' '
-	mark nonexistant &&
+test_expect_success 'nonexistent group produces error' '
+	mark nonexistent &&
 	update_repos &&
-	test_must_fail git remote update nonexistant &&
+	test_must_fail git remote update nonexistent &&
 	! repo_fetched one &&
 	! repo_fetched two
 '
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index d73731e..3abb290 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -367,7 +367,7 @@ test_expect_success 'push with colon-less refspec (4)' '
 
 '
 
-test_expect_success 'push head with non-existant, incomplete dest' '
+test_expect_success 'push head with non-existent, incomplete dest' '
 
 	mk_test &&
 	git push testrepo master:branch &&
@@ -375,7 +375,7 @@ test_expect_success 'push head with non-existant, incomplete dest' '
 
 '
 
-test_expect_success 'push tag with non-existant, incomplete dest' '
+test_expect_success 'push tag with non-existent, incomplete dest' '
 
 	mk_test &&
 	git tag -f v1.0 &&
@@ -384,14 +384,14 @@ test_expect_success 'push tag with non-existant, incomplete dest' '
 
 '
 
-test_expect_success 'push sha1 with non-existant, incomplete dest' '
+test_expect_success 'push sha1 with non-existent, incomplete dest' '
 
 	mk_test &&
 	test_must_fail git push testrepo `git rev-parse master`:foo
 
 '
 
-test_expect_success 'push ref expression with non-existant, incomplete dest' '
+test_expect_success 'push ref expression with non-existent, incomplete dest' '
 
 	mk_test &&
 	test_must_fail git push testrepo master^:branch
@@ -436,7 +436,7 @@ test_expect_success 'push with +HEAD' '
 
 '
 
-test_expect_success 'push HEAD with non-existant, incomplete dest' '
+test_expect_success 'push HEAD with non-existent, incomplete dest' '
 
 	mk_test &&
 	git checkout master &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 6b1ba6c..2a53640 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1893,7 +1893,7 @@ test_expect_success \
     test_cmp marks.out marks.new'
 
 cat >input <<EOF
-feature import-marks=nonexistant.marks
+feature import-marks=nonexistent.marks
 feature export-marks=marks.new
 EOF
 
@@ -1904,7 +1904,7 @@ test_expect_success \
 
 
 cat >input <<EOF
-feature import-marks=nonexistant.marks
+feature import-marks=nonexistent.marks
 feature export-marks=combined.marks
 EOF
 
-- 
1.7.3.4
