From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] test: use $_z40 from test-lib
Date: Sun, 24 Apr 2011 13:51:26 -0700
Message-ID: <1303678289-27627-2-git-send-email-gitster@pobox.com>
References: <1303678289-27627-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 22:51:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QE6HN-00071f-5l
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 22:51:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757766Ab1DXUvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 16:51:36 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701Ab1DXUvf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 16:51:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5EB1F46BC
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=jHiW
	1YNGhSWjX2AemgLmHoCCbCo=; b=CYBt+82fGM6D2Q2t0bOdPJvK6nD1HINddXFa
	xlRa1OHqOqySDXY3vlmA+adJ1xdbozrbKwQ+RfjR6rrddqCHIh74GoSyDvCoocwR
	TbSPd/5JiLNdLewfxMHUdAIDt3Oq49KQrJM826jNaqvJp0lriiLuFz8dMzdjnD5V
	emNfLlk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=r1atOX
	KGr45013knSX+h/gapnpPgqV6ZnNnYKk2ISGj0L9F1Uzmllv/5bBWwA52v1tczy0
	4K5di+jjlZ28vkXGZyOelrlA8zOJwQA1cIFTEQI53IGui4GHSoOu4DitLrSbZ0Nl
	zVjufAfsSZ4rgEYhqHtMtrWp7W+XDh6YxUh84=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B7C046BB
	for <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7029146BA for
 <git@vger.kernel.org>; Sun, 24 Apr 2011 16:53:35 -0400 (EDT)
X-Mailer: git-send-email 1.7.5
In-Reply-To: <1303678289-27627-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: EC8829E8-6EB4-11E0-BA6D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172000>

There is no need to duplicate the definition of $_z40 and $_x40 that
test-lib.sh supplies the test scripts.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1400-update-ref.sh            |    2 +-
 t/t1501-worktree.sh              |    7 +++----
 t/t2011-checkout-invalid-head.sh |    2 +-
 t/t2201-add-update-typechange.sh |    2 --
 t/t3200-branch.sh                |    4 ++--
 t/t3600-rm.sh                    |    3 +--
 t/t4002-diff-basic.sh            |    5 +----
 t/t4020-diff-external.sh         |    2 --
 t/t4027-diff-submodule.sh        |    1 -
 t/t7011-skip-worktree-reading.sh |    4 ++--
 t/t7012-skip-worktree-writing.sh |    2 +-
 t/test-lib.sh                    |    3 +++
 12 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 54ba3df..6b39915 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -6,7 +6,7 @@
 test_description='Test git update-ref and basic ref logging'
 . ./test-lib.sh
 
-Z=0000000000000000000000000000000000000000
+Z=$_z40
 
 test_expect_success setup '
 
diff --git a/t/t1501-worktree.sh b/t/t1501-worktree.sh
index 2c8f01f..dc7c992 100755
--- a/t/t1501-worktree.sh
+++ b/t/t1501-worktree.sh
@@ -7,7 +7,6 @@ test_expect_success 'setup' '
 	EMPTY_TREE=$(git write-tree) &&
 	EMPTY_BLOB=$(git hash-object -t blob --stdin </dev/null) &&
 	CHANGED_BLOB=$(echo changed | git hash-object -t blob --stdin) &&
-	ZEROES=0000000000000000000000000000000000000000 &&
 	EMPTY_BLOB7=$(echo $EMPTY_BLOB | sed "s/\(.......\).*/\1/") &&
 	CHANGED_BLOB7=$(echo $CHANGED_BLOB | sed "s/\(.......\).*/\1/") &&
 
@@ -239,10 +238,10 @@ test_expect_success '_gently() groks relative GIT_DIR & GIT_WORK_TREE' '
 
 test_expect_success 'diff-index respects work tree under .git dir' '
 	cat >diff-index-cached.expected <<-EOF &&
-	:000000 100644 $ZEROES $EMPTY_BLOB A	sub/dir/tracked
+	:000000 100644 $_z40 $EMPTY_BLOB A	sub/dir/tracked
 	EOF
 	cat >diff-index.expected <<-EOF &&
-	:000000 100644 $ZEROES $ZEROES A	sub/dir/tracked
+	:000000 100644 $_z40 $_z40 A	sub/dir/tracked
 	EOF
 
 	(
@@ -258,7 +257,7 @@ test_expect_success 'diff-index respects work tree under .git dir' '
 
 test_expect_success 'diff-files respects work tree under .git dir' '
 	cat >diff-files.expected <<-EOF &&
-	:100644 100644 $EMPTY_BLOB $ZEROES M	sub/dir/tracked
+	:100644 100644 $EMPTY_BLOB $_z40 M	sub/dir/tracked
 	EOF
 
 	(
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index 15ebdc2..300f8bf 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -15,7 +15,7 @@ test_expect_success 'checkout should not start branch from a tree' '
 '
 
 test_expect_success 'checkout master from invalid HEAD' '
-	echo 0000000000000000000000000000000000000000 >.git/HEAD &&
+	echo $_z40 >.git/HEAD &&
 	git checkout master --
 '
 
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 2e8f702..954fc51 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -4,8 +4,6 @@ test_description='more git add -u'
 
 . ./test-lib.sh
 
-_z40=0000000000000000000000000000000000000000
-
 test_expect_success setup '
 	>xyzzy &&
 	_empty=$(git hash-object --stdin <xyzzy) &&
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index f54a533..4c4cff1 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -35,7 +35,7 @@ test_expect_success \
     'git branch a/b/c && test -f .git/refs/heads/a/b/c'
 
 cat >expect <<EOF
-0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
 test_expect_success \
     'git branch -l d/e/f should create a branch and a log' \
@@ -214,7 +214,7 @@ test_expect_success \
 
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
-0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
+$_z40 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
 EOF
 test_expect_success \
     'git checkout -b g/h/i -l should create a branch and a log' \
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..66523bd 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -240,11 +240,10 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
 	git reset -q --hard &&
-	H=0000000000000000000000000000000000000000 &&
 	i=0 &&
 	while test $i -lt 12000
 	do
-	    echo "100644 $H 0	some-file-$i"
+	    echo "100644 $_z40 0	some-file-$i"
 	    i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | :;
diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index 73441a5..66e1a52 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -126,15 +126,12 @@ cat >.test-recursive-AB <<\EOF
 :100644 100644 3fdbe17fd013303a2e981e1ca1c6cd6e72789087 7e09d6a3a14bd630913e8c75693cea32157b606d M	Z/NM
 EOF
 
-x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-x40="$x40$x40$x40$x40$x40$x40$x40$x40"
-z40='0000000000000000000000000000000000000000'
 cmp_diff_files_output () {
     # diff-files never reports additions.  Also it does not fill in the
     # object ID for the changed files because it wants you to look at the
     # filesystem.
     sed <"$2" >.test-tmp \
-	-e '/^:000000 /d;s/'$x40'\( [MCRNDU][0-9]*\)	/'$z40'\1	/' &&
+	-e '/^:000000 /d;s/'$_x40'\( [MCRNDU][0-9]*\)	/'$_z40'\1	/' &&
     test_cmp "$1" .test-tmp
 }
 
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index a7602cf..083f62d 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -4,8 +4,6 @@ test_description='external diff interface test'
 
 . ./test-lib.sh
 
-_z40=0000000000000000000000000000000000000000
-
 test_expect_success setup '
 
 	test_tick &&
diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
index d99814a..fbe44a3 100755
--- a/t/t4027-diff-submodule.sh
+++ b/t/t4027-diff-submodule.sh
@@ -5,7 +5,6 @@ test_description='difference in submodules'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/diff-lib.sh
 
-_z40=0000000000000000000000000000000000000000
 test_expect_success setup '
 	test_tick &&
 	test_create_repo sub &&
diff --git a/t/t7011-skip-worktree-reading.sh b/t/t7011-skip-worktree-reading.sh
index bb4066f..8f3b54d 100755
--- a/t/t7011-skip-worktree-reading.sh
+++ b/t/t7011-skip-worktree-reading.sh
@@ -24,7 +24,7 @@ H sub/2
 EOF
 
 NULL_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
-ZERO_SHA0=0000000000000000000000000000000000000000
+
 setup_absent() {
 	test -f 1 && rm 1
 	git update-index --remove 1 &&
@@ -120,7 +120,7 @@ test_expect_success 'grep with skip-worktree file' '
 	test "$(git grep --no-ext-grep test)" = "1:test"
 '
 
-echo ":000000 100644 $ZERO_SHA0 $NULL_SHA1 A	1" > expected
+echo ":000000 100644 $_z40 $NULL_SHA1 A	1" > expected
 test_expect_success 'diff-index does not examine skip-worktree absent entries' '
 	setup_absent &&
 	git diff-index HEAD -- 1 > result &&
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 582d0b5..d70fe2f 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -54,7 +54,7 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 '
 
 NULL_SHA1=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
-ZERO_SHA0=0000000000000000000000000000000000000000
+
 setup_absent() {
 	test -f 1 && rm 1
 	git update-index --remove 1 &&
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 830e5e7..7afa25f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -97,6 +97,9 @@ esac
 _x05='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x05$_x05$_x05$_x05$_x05$_x05$_x05$_x05"
 
+# Zero SHA-1
+_z40=0000000000000000000000000000000000000000
+
 # Each test should start with something like this, after copyright notices:
 #
 # test_description='Description of this test...
-- 
1.7.5
