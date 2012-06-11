From: vfr@lyx.org
Subject: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Mon, 11 Jun 2012 19:01:53 +0000
Message-ID: <1339441313-5296-1-git-send-email-vfr@lyx.org>
Cc: gitster@pobox.om, Vincent van Ravesteijn <vfr@lyx.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 11 21:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se9sv-0004Kt-O2
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 21:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110Ab2FKTCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 15:02:20 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51629 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab2FKTCP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 15:02:15 -0400
Received: by wibhj8 with SMTP id hj8so3235648wib.1
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 12:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
        bh=7na2OFKqRbXbswUY2Cgp9VFWUVl5PHGF/A4+s9d4m6E=;
        b=RqonA6ifhWou+07OrmeXSqEvYfCcflcAy8dCrkmSjxLVTazgrq0W+Nat/Ll2L/IQHT
         E7ca8CSh1FtPs0uQagYgWnOBYfPTLOFE/cYJ2kr6umJ2IGQs+Xu6eK9i9zy+t9dYbIUR
         hfcJWldkt5slmPNBUEZaeKzDEWo2yYd9f5kW5COnf9uJtWwSi0vTgkH777AsCtOzVYjE
         anmpxKLh0vrpE0B+0BiFsBjScv3AQBy/C3USCEdmDfxeYquuAHoumo7+E3pTvSaGpjxr
         FKCv7VsrfDrnH/vB26QcuyWtt2m1c7b/dgOXAbtikDU9L0m2kngWP/RMCHlJ4IiC1Rn9
         iSww==
Received: by 10.216.226.101 with SMTP id a79mr6710214weq.151.1339441334138;
        Mon, 11 Jun 2012 12:02:14 -0700 (PDT)
Received: from localhost (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id gc6sm278131wib.0.2012.06.11.12.02.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Jun 2012 12:02:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.msysgit.0
X-Gm-Message-State: ALoCoQkuWSHwvAE43rrZVpCWS1ANL864tveWebOQe+94r1jLNL9AF+eV0ZSSFSs1eWnKM/7e3njU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199703>

From: Vincent van Ravesteijn <vfr@lyx.org>

GIT-BUILD-OPTIONS defines PERL_PATH to be used in the test suite. Only a
few tests already actually use this variable when perl is needed. The
other test just call 'perl' and it might happen that the wrong perl
interpreter is used.

This becomes problematic on Windows, when the perl interpreter that is
compiled and installed on the Windows system is used, because this perl
interpreter might introduce some unexpected LF->CRLF conversions.

This patch makes sure that $PERL_PATH is used everywhere in the test suite
and that the correct perl interpreter is used.

Signed-off-by: Vincent van Ravesteijn <vfr@lyx.org>
---
 t/t1010-mktree.sh                         |    4 ++--
 t/t3300-funny-names.sh                    |    6 +++---
 t/t4014-format-patch.sh                   |    2 +-
 t/t4020-diff-external.sh                  |    2 +-
 t/t4029-diff-trailing-space.sh            |    2 +-
 t/t4030-diff-textconv.sh                  |    2 +-
 t/t4031-diff-rewrite-binary.sh            |    2 +-
 t/t4103-apply-binary.sh                   |    4 ++--
 t/t4116-apply-reverse.sh                  |    4 ++--
 t/t4200-rerere.sh                         |    8 ++++----
 t/t5300-pack-object.sh                    |    8 ++++----
 t/t5303-pack-corruption-resilience.sh     |    4 ++--
 t/t5532-fetch-proxy.sh                    |    2 +-
 t/t5551-http-fetch.sh                     |    2 +-
 t/t6011-rev-list-with-bad-commit.sh       |    2 +-
 t/t6013-rev-list-reverse-parents.sh       |    4 ++--
 t/t7508-status.sh                         |    2 +-
 t/t8006-blame-textconv.sh                 |    2 +-
 t/t9129-git-svn-i18n-commitencoding.sh    |    2 +-
 t/t9137-git-svn-dcommit-clobber-series.sh |    8 ++++----
 t/t9300-fast-import.sh                    |    2 +-
 t/t9350-fast-export.sh                    |    2 +-
 t/t9810-git-p4-rcs.sh                     |    2 +-
 t/test-lib-functions.sh                   |    4 ++--
 24 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index b946f87..3535761 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -42,13 +42,13 @@ test_expect_success 'ls-tree piped to mktree (2)' '
 '
 
 test_expect_success 'ls-tree output in wrong order given to mktree (1)' '
-	perl -e "print reverse <>" <top |
+	$PERL_PATH -e "print reverse <>" <top |
 	git mktree >actual &&
 	test_cmp tree actual
 '
 
 test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
-	perl -e "print reverse <>" <top.withsub |
+	$PERL_PATH -e "print reverse <>" <top.withsub |
 	git mktree >actual &&
 	test_cmp tree.withsub actual
 '
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index c53c9f6..f42adc4 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -71,7 +71,7 @@ test_expect_success 'ls-files -z does not quote funny filename' '
 	tabs	," (dq) and spaces
 	EOF
 	git ls-files -z >ls-files.z &&
-	perl -pe "y/\000/\012/" <ls-files.z >current &&
+	$PERL_PATH -pe "y/\000/\012/" <ls-files.z >current &&
 	test_cmp expected current
 '
 
@@ -108,7 +108,7 @@ test_expect_success 'diff-index -z does not quote funny filename' '
 	tabs	," (dq) and spaces
 	EOF
 	git diff-index -z --name-status $t0 >diff-index.z &&
-	perl -pe "y/\000/\012/" <diff-index.z >current &&
+	$PERL_PATH -pe "y/\000/\012/" <diff-index.z >current &&
 	test_cmp expected current
 '
 
@@ -118,7 +118,7 @@ test_expect_success 'diff-tree -z does not quote funny filename' '
 	tabs	," (dq) and spaces
 	EOF
 	git diff-tree -z --name-status $t0 $t1 >diff-tree.z &&
-	perl -pe y/\\000/\\012/ <diff-tree.z >current &&
+	$PERL_PATH -pe y/\\000/\\012/ <diff-tree.z >current &&
 	test_cmp expected current
 '
 
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b473b6d..4c22c17 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -243,7 +243,7 @@ check_threading () {
 	(git format-patch --stdout "$@"; echo $? > status.out) |
 	# Prints everything between the Message-ID and In-Reply-To,
 	# and replaces all Message-ID-lookalikes by a sequence number
-	perl -ne '
+	$PERL_PATH -ne '
 		if (/^(message-id|references|in-reply-to)/i) {
 			$printing = 1;
 		} elsif (/^\S/) {
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index 083f62d..3d9307b 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -118,7 +118,7 @@ test_expect_success 'no diff with -diff' '
 	git diff | grep Binary
 '
 
-echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
+echo NULZbetweenZwords | $PERL_PATH -pe 'y/Z/\000/' > file
 
 test_expect_success 'force diff with "diff"' '
 	echo >.gitattributes "file diff" &&
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 3ccc237..7f7f504 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -27,7 +27,7 @@ test_expect_success \
      git config --bool diff.suppressBlankEmpty true &&
      git diff f > actual &&
      test_cmp exp actual &&
-     perl -i.bak -p -e "s/^\$/ /" exp &&
+     $PERL_PATH -i.bak -p -e "s/^\$/ /" exp &&
      git config --bool diff.suppressBlankEmpty false &&
      git diff f > actual &&
      test_cmp exp actual &&
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index d4ab4f2..82e36ec 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -21,7 +21,7 @@ EOF
 
 cat >hexdump <<'EOF'
 #!/bin/sh
-perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
+$PERL_PATH -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
 EOF
 chmod +x hexdump
 
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index c8296fa..e8ee06e 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -60,7 +60,7 @@ test_expect_success 'diff --stat counts binary rewrite as 0 lines' '
 {
 	echo "#!$SHELL_PATH"
 	cat <<'EOF'
-perl -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
+$PERL_PATH -e '$/ = undef; $_ = <>; s/./ord($&)/ge; print $_' < "$1"
 EOF
 } >dump
 chmod +x dump
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index dbbf56c..5b533cf 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -25,10 +25,10 @@ test_expect_success 'setup' "
 	git commit -m 'Initial Version' 2>/dev/null &&
 
 	git checkout -b binary &&
-	perl -pe 'y/x/\000/' <file1 >file3 &&
+	$PERL_PATH -pe 'y/x/\000/' <file1 >file3 &&
 	cat file3 >file4 &&
 	git add file2 &&
-	perl -pe 'y/\000/v/' <file3 >file1 &&
+	$PERL_PATH -pe 'y/\000/v/' <file3 >file1 &&
 	rm -f file2 &&
 	git update-index --add --remove file1 file2 file3 file4 &&
 	git commit -m 'Second Version' &&
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 2298ece..7b0c02a 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -12,14 +12,14 @@ test_description='git apply in reverse
 test_expect_success setup '
 
 	for i in a b c d e f g h i j k l m n; do echo $i; done >file1 &&
-	perl -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
+	$PERL_PATH -pe "y/ijk/\\000\\001\\002/" <file1 >file2 &&
 
 	git add file1 file2 &&
 	git commit -m initial &&
 	git tag initial &&
 
 	for i in a b c g h i J K L m o n p q; do echo $i; done >file1 &&
-	perl -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
+	$PERL_PATH -pe "y/mon/\\000\\001\\002/" <file1 >file2 &&
 
 	git commit -a -m second &&
 	git tag second &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 36255d6..ec7622c 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -78,7 +78,7 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	test_might_fail git config --unset rerere.enabled &&
 	test_must_fail git merge first &&
 
-	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$($PERL_PATH -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
 	! test -f $rr/postimage &&
@@ -91,7 +91,7 @@ test_expect_success 'rerere.enabled works, too' '
 	git reset --hard &&
 	test_must_fail git merge first &&
 
-	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$($PERL_PATH -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep ^=======$ $rr/preimage
 '
@@ -101,7 +101,7 @@ test_expect_success 'set up rr-cache' '
 	git config rerere.enabled true &&
 	git reset --hard &&
 	test_must_fail git merge first &&
-	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
+	sha1=$($PERL_PATH -pe "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1
 '
 
@@ -185,7 +185,7 @@ test_expect_success 'rerere updates postimage timestamp' '
 
 test_expect_success 'rerere clear' '
 	rm $rr/postimage &&
-	echo "$sha1	a1" | perl -pe "y/\012/\000/" >.git/MERGE_RR &&
+	echo "$sha1	a1" | $PERL_PATH -pe "y/\012/\000/" >.git/MERGE_RR &&
 	git rerere clear &&
 	! test -d $rr
 '
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index d9d856b..a97bb74 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -13,9 +13,9 @@ TRASH=`pwd`
 test_expect_success \
     'setup' \
     'rm -f .git/index* &&
-     perl -e "print \"a\" x 4096;" > a &&
-     perl -e "print \"b\" x 4096;" > b &&
-     perl -e "print \"c\" x 4096;" > c &&
+     $PERL_PATH -e "print \"a\" x 4096;" > a &&
+     $PERL_PATH -e "print \"b\" x 4096;" > b &&
+     $PERL_PATH -e "print \"c\" x 4096;" > c &&
      test-genrandom "seed a" 2097152 > a_big &&
      test-genrandom "seed b" 2097152 > b_big &&
      git update-index --add a a_big b b_big c &&
@@ -129,7 +129,7 @@ test_expect_success \
 cd "$TRASH"
 
 test_expect_success 'compare delta flavors' '
-	perl -e '\''
+	$PERL_PATH -e '\''
 		defined($_ = -s $_) or die for @ARGV;
 		exit 1 if $ARGV[0] <= $ARGV[1];
 	'\'' test-2-$packname_2.pack test-3-$packname_3.pack
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index 5f6cd4f..ee4e1af 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -98,7 +98,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
+     $PERL_PATH -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
      test_must_fail git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
@@ -155,7 +155,7 @@ test_expect_success \
     'create_new_pack &&
      git prune-packed &&
      chmod +w ${pack}.pack &&
-     perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
+     $PERL_PATH -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
      git cat-file blob $blob_1 > /dev/null &&
      test_must_fail git cat-file blob $blob_2 > /dev/null &&
      test_must_fail git cat-file blob $blob_3 > /dev/null'
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index 62f2460..6ef4378 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -15,7 +15,7 @@ test_expect_success 'setup remote repo' '
 cat >proxy <<'EOF'
 #!/bin/sh
 echo >&2 "proxying for $*"
-cmd=`perl -e '
+cmd=`$PERL_PATH -e '
 	read(STDIN, $buf, 4);
 	my $n = hex($buf) - 4;
 	read(STDIN, $buf, $n);
diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index be6094b..0667a3b 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -130,7 +130,7 @@ test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
 	done | git fast-import --export-marks=marks &&
 
 	# now assign tags to all the dangling commits we created above
-	tag=$(perl -e "print \"bla\" x 30") &&
+	tag=$($PERL_PATH -e "print \"bla\" x 30") &&
 	sed -e "s/^:\(.\+\) \(.\+\)$/\2 refs\/tags\/$tag-\1/" <marks >>packed-refs
 	)
 '
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index e51eb41..b2c6125 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -37,7 +37,7 @@ test_expect_success 'verify number of revisions' \
 
 test_expect_success 'corrupt second commit object' \
    '
-   perl -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
+   $PERL_PATH -i.bak -pe "s/second commit/socond commit/" .git/objects/pack/*.pack &&
    test_must_fail git fsck --full
    '
 
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 59fc2f0..3178c14 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -25,7 +25,7 @@ test_expect_success 'set up --reverse example' '
 
 test_expect_success '--reverse --parents --full-history combines correctly' '
 	git rev-list --parents --full-history master -- foo |
-		perl -e "print reverse <>" > expected &&
+		$PERL_PATH -e "print reverse <>" > expected &&
 	git rev-list --reverse --parents --full-history master -- foo \
 		> actual &&
 	test_cmp actual expected
@@ -33,7 +33,7 @@ test_expect_success '--reverse --parents --full-history combines correctly' '
 
 test_expect_success '--boundary does too' '
 	git rev-list --boundary --parents --full-history master ^root -- foo |
-		perl -e "print reverse <>" > expected &&
+		$PERL_PATH -e "print reverse <>" > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
 		master ^root -- foo > actual &&
 	test_cmp actual expected
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 28e1848..5e9160f 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -941,7 +941,7 @@ test_expect_success 'status -s submodule summary (clean submodule)' '
 
 test_expect_success 'status -z implies porcelain' '
 	git status --porcelain |
-	perl -pe "s/\012/\000/g" >expect &&
+	$PERL_PATH -pe "s/\012/\000/g" >expect &&
 	git status -z >output &&
 	test_cmp expect output
 '
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index c3c22f7..06b8f86 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -10,7 +10,7 @@ find_blame() {
 cat >helper <<'EOF'
 #!/bin/sh
 grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
-perl -p -e 's/^bin: /converted: /' "$1"
+$PERL_PATH -p -e 's/^bin: /converted: /' "$1"
 EOF
 chmod +x helper
 
diff --git a/t/t9129-git-svn-i18n-commitencoding.sh b/t/t9129-git-svn-i18n-commitencoding.sh
index 8cfdfe7..c9c8d02 100755
--- a/t/t9129-git-svn-i18n-commitencoding.sh
+++ b/t/t9129-git-svn-i18n-commitencoding.sh
@@ -29,7 +29,7 @@ fi
 compare_svn_head_with () {
 	# extract just the log message and strip out committer info.
 	# don't use --limit here since svn 1.1.x doesn't have it,
-	LC_ALL="$a_utf8_locale" svn log `git svn info --url` | perl -w -e '
+	LC_ALL="$a_utf8_locale" svn log `git svn info --url` | $PERL_PATH -w -e '
 		use bytes;
 		$/ = ("-"x72) . "\n";
 		my @x = <STDIN>;
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index d60da63..726875a 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -20,8 +20,8 @@ test_expect_success '(supposedly) non-conflicting change from SVN' '
 	test x"`sed -n -e 61p < file`" = x61 &&
 	svn_cmd co "$svnrepo" tmp &&
 	(cd tmp &&
-		perl -i.bak -p -e "s/^58$/5588/" file &&
-		perl -i.bak -p -e "s/^61$/6611/" file &&
+		$PERL_PATH -i.bak -p -e "s/^58$/5588/" file &&
+		$PERL_PATH -i.bak -p -e "s/^61$/6611/" file &&
 		poke file &&
 		test x"`sed -n -e 58p < file`" = x5588 &&
 		test x"`sed -n -e 61p < file`" = x6611 &&
@@ -40,8 +40,8 @@ test_expect_success 'some unrelated changes to git' "
 test_expect_success 'change file but in unrelated area' "
 	test x\"\`sed -n -e 4p < file\`\" = x4 &&
 	test x\"\`sed -n -e 7p < file\`\" = x7 &&
-	perl -i.bak -p -e 's/^4\$/4444/' file &&
-	perl -i.bak -p -e 's/^7\$/7777/' file &&
+	$PERL_PATH -i.bak -p -e 's/^4\$/4444/' file &&
+	$PERL_PATH -i.bak -p -e 's/^7\$/7777/' file &&
 	test x\"\`sed -n -e 4p < file\`\" = x4444 &&
 	test x\"\`sed -n -e 7p < file\`\" = x7777 &&
 	git commit -m '4 => 4444, 7 => 7777' file &&
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 2aa1824..007e5af 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -12,7 +12,7 @@ test_description='test git fast-import utility'
 # This could be written as "head -c $1", but IRIX "head" does not
 # support the -c option.
 head_c () {
-	perl -e '
+	$PERL_PATH -e '
 		my $len = $ARGV[1];
 		while ($len > 0) {
 			my $s;
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b00196b..6b6dc20 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -424,7 +424,7 @@ test_expect_success 'fast-export quotes pathnames' '
 		--cacheinfo 100644 $blob "path with \\backslash" \
 		--cacheinfo 100644 $blob "path with space" &&
 	 git commit -m addition &&
-	 git ls-files -z -s | perl -0pe "s{\\t}{$&subdir/}" >index &&
+	 git ls-files -z -s | $PERL_PATH -0pe "s{\\t}{$&subdir/}" >index &&
 	 git read-tree --empty &&
 	 git update-index -z --index-info <index &&
 	 git commit -m rename &&
diff --git a/t/t9810-git-p4-rcs.sh b/t/t9810-git-p4-rcs.sh
index d8d9ca4..ce38c10 100755
--- a/t/t9810-git-p4-rcs.sh
+++ b/t/t9810-git-p4-rcs.sh
@@ -246,7 +246,7 @@ test_expect_success 'cope with rcs keyword expansion damage' '
 		git config git-p4.attemptRCSCleanup true &&
 		(cd ../cli && p4_append_to_file kwfile1.c) &&
 		old_lines=$(wc -l <kwfile1.c) &&
-		perl -n -i -e "print unless m/Revision:/" kwfile1.c &&
+		$PERL_PATH -n -i -e "print unless m/Revision:/" kwfile1.c &&
 		new_lines=$(wc -l <kwfile1.c) &&
 		test $new_lines = $(($old_lines - 1)) &&
 
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 7b3b4be..fc0c080 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -76,11 +76,11 @@ test_decode_color () {
 }
 
 nul_to_q () {
-	perl -pe 'y/\000/Q/'
+	$PERL_PATH -pe 'y/\000/Q/'
 }
 
 q_to_nul () {
-	perl -pe 'y/Q/\000/'
+	$PERL_PATH -pe 'y/Q/\000/'
 }
 
 q_to_cr () {
-- 
1.7.9.msysgit.0
