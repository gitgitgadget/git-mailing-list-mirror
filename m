Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625983C3F70
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788554159; cv=none; b=T1CEGILLg4sZ3cIbbYq1iZm51P+hkqe/EwegfO5gWlyvTpniTadzflwfgd8JfbHHEA//B7EOYubmuvdeO3HNJS8Wic3rDU1dG7bTwY/qIuv+wVz84oXnQ5oAFuPfnhMoEjop++5nsRLslpF8xh35QCfcUEAOcGEA/Vg9fym6w4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788554159; c=relaxed/simple;
	bh=vaKmSy5b7IT669u3ul1n0IZsBWIgW/BLSOwdSoQGgGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qrqskYrkV/uGcLOAziUo2CJXeRuqLNORNz8M9JB+C68YypvG6D4tn6iB/Z8bfssyCezJpTHBUQQTWFi1gObZM1QCDMr261ot1pP+jrH9G+eCh2Lg9Amnrv59NH69fEado+bugFTyOsyxQfGVxYOjRNOGvfXvxhC642XZQ2K7fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+pfuL2J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+pfuL2J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 602BDC2BCF5;
	Fri,  4 Sep 2026 20:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788554158;
	bh=vaKmSy5b7IT669u3ul1n0IZsBWIgW/BLSOwdSoQGgGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L+pfuL2JBzOb0B06LaTUB69/89HblEN8oJDtAHXVTE8fMzewUhp5JStea3/Rzn548
	 xQjTeSNK1tLFc0pljI/kcTspvedFXuHbqHVyxsW+TyZk1fkymBlpIYaGr0OOAQztD8
	 eDxLsC36RXCFmEMdhCeMQTL8VobgwjNojtd165GDXDwRjZ2PkCvhZ16WQL44MEdl+x
	 NkqYfGZEPnQ8LGBynQEhmR5vuxWVPkVnAtVB1x8VykEsDf5aOTcoo95zZlhc3yDSY3
	 tG8NXq7+i2DuK0wG6YDckZc/DBcFgQLumevQKhnd47XdvSYgvyr8JAzlCaDD7Rd692
	 YrNyB0CecBQGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D571C79F85;
	Fri,  4 Sep 2026 20:35:58 +0000 (UTC)
From: "Mark C. Chu-Carroll via B4 Relay" <devnull+markchucarroll.fastmail.com@kernel.org>
Date: Fri, 04 Sep 2026 16:35:52 -0400
Subject: [PATCH 1/2] Update shell tests to use semantic functions
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-file-tests-use-shell-functions-v1-1-b66f9cb4adbe@fastmail.com>
References: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
In-Reply-To: <20260904-file-tests-use-shell-functions-v1-0-b66f9cb4adbe@fastmail.com>
To: git@vger.kernel.org
Cc: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=31196;
 i=markchucarroll@fastmail.com; h=from:subject:message-id;
 bh=G/D7q972lbFFODMhv+9zl9+PA2yYB+CEuUwxUIlLoHc=;
 b=owGbwMvMwCUWOPFJle/8tn2Mp9WSGLJma6+Rn9Ho2fWoxfTKOg8DN3c3O8MJd0J/y3Ma1Ynys
 ausOvSgo5SFQYyLQVZMkeX/P4HGVywPJPyC3n2CmcPKBDKEgYtTACby4yIjw0uRrZv0vihWBjyz
 UozRF7z+Xa3tatenR8sYKt2mvtq4excjwzVN8/OfzJ1vTb6y8bF7x6fEG4bcie6++0sNRc4Lip1
 8xQAA
X-Developer-Key: i=markchucarroll@fastmail.com; a=openpgp;
 fpr=FFFE1081EA04E0184E52EEF25191E47A4D9F86BE
X-Endpoint-Received: by B4 Relay for markchucarroll@fastmail.com/default
 with auth_id=1002
X-Original-From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Reply-To: markchucarroll@fastmail.com

From: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>

This updates an initial bash of shell tests to replace uses
of "test -f" and "! test -f" with "test_path_is_file" and
"test_path_is_missing".
---
 t/t0031-lockfile-pid.sh            |  2 +-
 t/t0200-gettext-basic.sh           |  2 +-
 t/t1007-hash-object.sh             |  6 +++---
 t/t2030-unresolve-info.sh          |  8 ++++----
 t/t2201-add-update-typechange.sh   |  2 +-
 t/t3300-funny-names.sh             |  2 +-
 t/t3306-notes-prune.sh             |  2 +-
 t/t3311-notes-merge-fanout.sh      |  2 +-
 t/t4014-format-patch.sh            |  6 +++---
 t/t4032-diff-inter-hunk-context.sh |  4 ++--
 t/t4102-apply-rename.sh            |  2 +-
 t/t4131-apply-fake-ancestor.sh     |  2 +-
 t/t4132-apply-removal.sh           |  4 ++--
 t/t5300-pack-object.sh             | 10 +++++-----
 t/t5301-sliding-window.sh          |  4 ++--
 t/t5302-pack-index.sh              |  8 ++++----
 t/t5502-quickfetch.sh              |  2 +-
 t/t5510-fetch.sh                   |  8 ++++----
 t/t5516-fetch-push.sh              |  2 +-
 t/t5534-push-signed.sh             |  6 +++---
 t/t5550-http-fetch-dumb.sh         |  2 +-
 t/t5604-clone-reference.sh         |  2 +-
 t/t6500-gc.sh                      |  2 +-
 t/t7012-skip-worktree-writing.sh   |  2 +-
 t/t7102-reset.sh                   |  2 +-
 t/t7104-reset-hard.sh              |  2 +-
 t/t7113-post-index-change-hook.sh  | 12 ++++++------
 t/t7201-co.sh                      |  6 +++---
 t/t7400-submodule-basic.sh         | 10 +++++-----
 t/t7407-submodule-foreach.sh       |  6 +++---
 t/t7412-submodule-absorbgitdirs.sh |  8 ++++----
 t/t7602-merge-octopus-many.sh      |  2 +-
 t/t9001-send-email.sh              |  6 +++---
 t/t9400-git-cvsserver-server.sh    |  6 +++---
 34 files changed, 76 insertions(+), 76 deletions(-)

diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
index e9e2f04049..9cca369e32 100755
--- a/t/t0031-lockfile-pid.sh
+++ b/t/t0031-lockfile-pid.sh
@@ -40,7 +40,7 @@ test_expect_success 'running process detected when PID is alive' '
 		echo content >file &&
 		# Get the correct PID for this platform
 		shell_pid=$$ &&
-		if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
+		if test_have_prereq MINGW && test_path_is_file /proc/$shell_pid/winpid
 		then
 			# In Git for Windows, Bash uses MSYS2 PIDs but git.exe
 			# uses Windows PIDs. Use the Windows PID.
diff --git a/t/t0200-gettext-basic.sh b/t/t0200-gettext-basic.sh
index 8db26c1ada..8305291ce9 100755
--- a/t/t0200-gettext-basic.sh
+++ b/t/t0200-gettext-basic.sh
@@ -36,7 +36,7 @@ test_expect_success GETTEXT 'sanity: $TEXTDOMAINDIR exists without NO_GETTEXT=Ye
 '
 
 test_expect_success GETTEXT 'sanity: Icelandic locale was compiled' '
-    test -f "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
+     test_path_is_file "$TEXTDOMAINDIR/is/LC_MESSAGES/git.mo"
 '
 
 # TODO: When we have more locales, generalize this to test them
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 463b38f990..e6d1fe3e13 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -271,7 +271,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash correctly via --stdin' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test_path_is_file big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	git hash-object --stdin <big >actual &&
 	test_cmp expect actual
@@ -279,7 +279,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'files over 4GB hash correctly' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test_path_is_file big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	git hash-object -- big >actual &&
 	test_cmp expect actual
@@ -289,7 +289,7 @@ test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 # We ensure that cleaning doesn't mangle large files on 64-bit Windows.
 test_expect_success EXPENSIVE,SIZE_T_IS_64BIT \
 		'hash filtered files over 4GB correctly' '
-	{ test -f big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
+	{ test_path_is_file big || test-tool genzeros $((5*1024*1024*1024)) >big; } &&
 	test_oid large5GB >expect &&
 	test_config filter.null-filter.clean "cat" &&
 	echo "big filter=null-filter" >.gitattributes &&
diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
index 9af24b1204..f4ff7591fc 100755
--- a/t/t2030-unresolve-info.sh
+++ b/t/t2030-unresolve-info.sh
@@ -170,7 +170,7 @@ test_expect_success 'rerere and rerere forget' '
 	git rerere &&
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
-	test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	git checkout -m fi/le &&
 	echo resurrect the conflict &&
 	test_grep "^=======" fi/le &&
@@ -182,7 +182,7 @@ test_expect_success 'rerere and rerere forget' '
 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
 	git rerere forget fi/le &&
-	! test -f .git/rr-cache/$rerere_id/postimage &&
+	! test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
 	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual
@@ -196,7 +196,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	(cd fi && git rerere) &&
 	rerere_id=$(cd .git/rr-cache && echo */postimage) &&
 	rerere_id=${rerere_id%/postimage} &&
-	test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_file .git/rr-cache/$rerere_id/postimage &&
 	(cd fi && git checkout -m le) &&
 	echo resurrect the conflict &&
 	test_grep "^=======" fi/le &&
@@ -208,7 +208,7 @@ test_expect_success 'rerere and rerere forget (subdirectory)' '
 	check_resolve_undo kept fi/le initial:fi/le second:fi/le third:fi/le &&
 	test -z "$(git ls-files -u)" &&
 	(cd fi && git rerere forget le) &&
-	! test -f .git/rr-cache/$rerere_id/postimage &&
+	test_path_is_missing .git/rr-cache/$rerere_id/postimage &&
 	tr "\0" "\n" <.git/MERGE_RR >actual &&
 	echo "$rerere_id	fi/le" >expect &&
 	test_cmp expect actual
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index 687be974d4..f46ddc0100 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -131,7 +131,7 @@ test_expect_success 'add -u' '
 '
 
 test_expect_success 'commit -a' '
-	if test -f ".git/saved-index"
+	if test_path_is_file ".git/saved-index"
 	then
 		rm -f ".git/index" &&
 		mv ".git/saved-index" ".git/index"
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index dd0586b007..d73049922a 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -15,7 +15,7 @@ HT='	'
 
 test_have_prereq MINGW ||
 echo 2>/dev/null > "Name with an${HT}HT"
-if ! test -f "Name with an${HT}HT"
+if test_path_is_missing "Name with an${HT}HT"
 then
 	# since FAT/NTFS does not allow tabs in filenames, skip this test
 	skip_all='Your filesystem does not allow tabs in filenames'
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index 8f4102ff9e..40c1eac56b 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -24,7 +24,7 @@ test_expect_success 'setup: create a few commits with notes' '
 	git commit -m 3rd &&
 	third=$(git rev-parse HEAD) &&
 	COMMIT_FILE=$(echo $third | sed "s!^..!.git/objects/&/!") &&
-	test -f $COMMIT_FILE &&
+	test_path_is_file $COMMIT_FILE &&
 	test-tool chmtime =+0 $COMMIT_FILE &&
 	git notes add -m "Note #3"
 '
diff --git a/t/t3311-notes-merge-fanout.sh b/t/t3311-notes-merge-fanout.sh
index 5b675417e9..a90999d6b4 100755
--- a/t/t3311-notes-merge-fanout.sh
+++ b/t/t3311-notes-merge-fanout.sh
@@ -10,7 +10,7 @@ test_description='Test notes merging at various fanout levels'
 verify_notes () {
 	notes_ref="$1"
 	commit="$2"
-	if test -f "expect_notes_$notes_ref"
+	if test_path_is_file "expect_notes_$notes_ref"
 	then
 		git -c core.notesRef="refs/notes/$notes_ref" notes |
 			sort >"output_notes_$notes_ref" &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 4afcd85779..53257e7e0a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -888,7 +888,7 @@ test_expect_success 'format-patch from a subdirectory (1)' '
 		false
 		;;
 	esac &&
-	test -f "$filename"
+	test_path_is_file "$filename"
 '
 
 test_expect_success 'format-patch from a subdirectory (2)' '
@@ -907,7 +907,7 @@ test_expect_success 'format-patch from a subdirectory (2)' '
 		;;
 	esac &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
-	test -f "sub/$basename"
+	test_path_is_file "sub/$basename"
 '
 
 test_expect_success 'format-patch from a subdirectory (3)' '
@@ -919,7 +919,7 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 		git format-patch -1 -o "$TRASH_DIRECTORY"
 	) &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
-	test -f "$basename"
+	test_path_is_file "$basename"
 '
 
 test_expect_success 'format-patch --in-reply-to' '
diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
index 7d443968e3..cc213c04a1 100755
--- a/t/t4032-diff-inter-hunk-context.sh
+++ b/t/t4032-diff-inter-hunk-context.sh
@@ -28,7 +28,7 @@ t() {
 	file=f$1
 	expected=expected.$file.$3.$hunks
 
-	if ! test -f $file
+	if test_path_is_missing $file
 	then
 		f A $1 B >$file
 		git add $file
@@ -40,7 +40,7 @@ t() {
 		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
 	"
 
-	if test -f $expected
+	if test_path_is_file $expected
 	then
 		test_expect_success "$label: check output" "
 			git $cmd $file | grep -v '^index ' >actual &&
diff --git a/t/t4102-apply-rename.sh b/t/t4102-apply-rename.sh
index e42a31c917..6910289e88 100755
--- a/t/t4102-apply-rename.sh
+++ b/t/t4102-apply-rename.sh
@@ -33,7 +33,7 @@ test_expect_success apply \
     'git apply --index --stat --summary --apply test-patch'
 
 test_expect_success FILEMODE validate \
-	    'test -f bar && ls -l bar | grep "^-..x......"'
+	    'test_path_is_file bar && ls -l bar | grep "^-..x......"'
 
 test_expect_success 'apply reverse' \
     'git apply -R --index --stat --summary --apply test-patch &&
diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index b1361ce546..648f928f7a 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -33,7 +33,7 @@ test_expect_success 'apply --build-fake-ancestor in a subdirectory' '
 	(
 		cd sub &&
 		git apply --build-fake-ancestor 3.ancestor ../3.patch &&
-		test -f 3.ancestor
+		test_path_is_file 3.ancestor
 	) &&
 	git apply --build-fake-ancestor 3.ancestor 3.patch &&
 	test_cmp sub/3.ancestor 3.ancestor
diff --git a/t/t4132-apply-removal.sh b/t/t4132-apply-removal.sh
index ab1628d27d..55fc9d1700 100755
--- a/t/t4132-apply-removal.sh
+++ b/t/t4132-apply-removal.sh
@@ -80,7 +80,7 @@ do
 			cat something >file &&
 			git add file &&
 			git apply --index $patch &&
-			test -f file &&
+			test_path_is_file file &&
 			test_must_be_empty file
 			;;
 		remove*)
@@ -88,7 +88,7 @@ do
 			cat something >file &&
 			git add file &&
 			git apply --index $patch &&
-			! test -f file
+			test_path_is_missing file
 			;;
 		esac
 	'
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 9dabb3615a..7e244a76df 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -259,11 +259,11 @@ test_expect_success 'survive missing objects/pack directory' '
 		GOP=.git/objects/pack &&
 		rm -fr $GOP &&
 		git index-pack --stdin --keep=test <../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.pack &&
+		test_path_is_file $GOP/pack-${packname_3}.pack &&
 		cmp $GOP/pack-${packname_3}.pack ../test-3-${packname_3}.pack &&
-		test -f $GOP/pack-${packname_3}.idx &&
+		test_path_is_file $GOP/pack-${packname_3}.idx &&
 		cmp $GOP/pack-${packname_3}.idx ../test-3-${packname_3}.idx &&
-		test -f $GOP/pack-${packname_3}.keep
+		test_path_is_file $GOP/pack-${packname_3}.keep
 	)
 '
 
@@ -352,7 +352,7 @@ test_expect_success 'build pack index for an existing pack' '
 	rm -f test-4.keep &&
 	git index-pack --keep=why test-4.pack &&
 	cmp test-1-${packname_1}.idx test-4.idx &&
-	test -f test-4.keep &&
+	test_path_is_file test-4.keep &&
 
 	:
 '
@@ -592,7 +592,7 @@ test_expect_success 'setup: fake a SHA1 hash collision' '
 		cd corrupt &&
 		long_a=$(git hash-object -w ../a | sed -e "s!^..!&/!") &&
 		long_b=$(git hash-object -w ../b | sed -e "s!^..!&/!") &&
-		test -f	.git/objects/$long_b &&
+		test_path_is_file	.git/objects/$long_b &&
 		cp -f	.git/objects/$long_a \
 			.git/objects/$long_b
 	)
diff --git a/t/t5301-sliding-window.sh b/t/t5301-sliding-window.sh
index 3c3666b278..b6868229bf 100755
--- a/t/t5301-sliding-window.sh
+++ b/t/t5301-sliding-window.sh
@@ -22,7 +22,7 @@ test_expect_success 'setup' '
 	git repack -a -d &&
 	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
 	pack1=$(ls .git/objects/pack/*.pack) &&
-	test -f "$pack1"
+	test_path_is_file "$pack1"
 '
 
 test_expect_success 'verify-pack -v, defaults' '
@@ -48,7 +48,7 @@ test_expect_success 'repack -a -d, packedGit{WindowSize,Limit} == 1 page' '
 	git repack -a -d &&
 	test "$(git count-objects)" = "0 objects, 0 kilobytes" &&
 	pack2=$(ls .git/objects/pack/*.pack) &&
-	test -f "$pack2" &&
+	test_path_is_file "$pack2" &&
 	test "$pack1" \!= "$pack2"
 '
 
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 735de1023e..3182ff2023 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -169,7 +169,7 @@ test_expect_success \
 
 test_expect_success \
 	'[index v1] 3) corrupted delta happily returned wrong data' '
-	test -f file_101_foo1 && ! cmp file_101 file_101_foo1
+	test_path_is_file file_101_foo1 && ! cmp file_101 file_101_foo1
 '
 
 test_expect_success \
@@ -180,7 +180,7 @@ test_expect_success \
 test_expect_success \
 	'[index v1] 5) pack-objects happily reuses corrupted data' '
 	pack4=$(git pack-objects test-4 <obj-list) &&
-	test -f "test-4-${pack4}.pack"
+	test_path_is_file "test-4-${pack4}.pack"
 '
 
 test_expect_success '[index v1] 6) newly created pack is BAD !' '
@@ -214,7 +214,7 @@ test_expect_success \
 
 test_expect_success \
 	'[index v2] 3) corrupted delta happily returned wrong data' '
-	test -f file_101_foo2 && ! cmp file_101 file_101_foo2
+	test_path_is_file file_101_foo2 && ! cmp file_101 file_101_foo2
 '
 
 test_expect_success \
@@ -251,7 +251,7 @@ test_expect_success 'running index-pack in the object store' '
 		cd .git/objects/pack &&
 		git index-pack pack-${pack1}.pack
 	) &&
-	test -f .git/objects/pack/pack-${pack1}.idx
+	test_path_is_file .git/objects/pack/pack-${pack1}.idx
 '
 
 test_expect_success 'index-pack --strict warns upon missing tagger in tag' '
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b160f8b7fb..62d2284752 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -63,7 +63,7 @@ test_expect_success 'copy commit and tree but not blob by hand' '
 	test $cnt -eq 6 &&
 
 	blob=$(git rev-parse HEAD:file | sed -e "s|..|&/|") &&
-	test -f "cloned/.git/objects/$blob" &&
+	test_path_is_file "cloned/.git/objects/$blob" &&
 	rm -f "cloned/.git/objects/$blob" &&
 
 	cnt=$( (
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index a8d38d9176..c4b0770d0d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1009,21 +1009,21 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 test_expect_success 'fetch --dry-run does not touch FETCH_HEAD, but still prints what would be written' '
 	rm -f .git/FETCH_HEAD err &&
 	git fetch --dry-run . 2>err &&
-	! test -f .git/FETCH_HEAD &&
+	test_path_is_missing .git/FETCH_HEAD &&
 	test_grep FETCH_HEAD err
 '
 
 test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD, and does not print what would be written' '
 	rm -f .git/FETCH_HEAD err &&
 	git fetch --no-write-fetch-head . 2>err &&
-	! test -f .git/FETCH_HEAD &&
+	test_path_is_missing .git/FETCH_HEAD &&
 	test_grep ! FETCH_HEAD err
 '
 
 test_expect_success '--write-fetch-head gets defeated by --dry-run' '
 	rm -f .git/FETCH_HEAD &&
 	git fetch --dry-run --write-fetch-head . &&
-	! test -f .git/FETCH_HEAD
+	test_path_is_missing .git/FETCH_HEAD
 '
 
 test_expect_success "should be able to fetch with duplicate refspecs" '
@@ -2026,7 +2026,7 @@ test_expect_success REFFILES "HEAD is updated even with conflicts" '
 		mkdir -p refs/remotes/origin &&
 		>refs/remotes/origin/branch.lock &&
 		test_must_fail git fetch origin &&
-		test -f refs/remotes/origin/HEAD
+		test_path_is_file refs/remotes/origin/HEAD
 	)
 '
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index f3b3efc47f..8efb6b185d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -688,7 +688,7 @@ test_expect_success 'push preserves up-to-date packed refs' '
 	(
 		cd child &&
 		git push &&
-		! test -f .git/refs/remotes/origin/main
+		test_path_is_missing .git/refs/remotes/origin/main
 	)
 '
 
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index 21f0262cbd..d60f5fe69c 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -46,7 +46,7 @@ test_expect_success 'unsigned push does not send push certificate' '
 	EOF
 
 	git push dst noop ff +noff &&
-	! test -f dst/push-cert
+	test_path_is_missing dst/push-cert
 '
 
 test_expect_success 'talking with a receiver without push certificate support' '
@@ -62,7 +62,7 @@ test_expect_success 'talking with a receiver without push certificate support' '
 	EOF
 
 	git push dst noop ff +noff &&
-	! test -f dst/push-cert
+	test_path_is_missing dst/push-cert
 '
 
 test_expect_success 'push --signed fails with a receiver without push certificate support' '
@@ -86,7 +86,7 @@ test_expect_success GPG 'no certificate for a signed push with no update' '
 	fi
 	EOF
 	git push dst noop &&
-	! test -f dst/push-cert
+	test_path_is_missing dst/push-cert
 '
 
 test_expect_success GPG 'signed push sends push certificate' '
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index b5758f1c9c..449d75b7c5 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -334,7 +334,7 @@ test_expect_success 'http-fetch --packfile permits unlink while indexing' '
 		ls objects/pack/pack-*.pack) &&
 	tmpfile="packfileclient-unlink/.git/objects/pack/pack-$ARBITRARY.pack.temp" &&
 	write_script git-unlink-index-pack <<-\EOF &&
-	test -f "$GIT_TEST_PACK_TEMP" || exit 1
+	test_path_is_file "$GIT_TEST_PACK_TEMP" || exit 1
 	rm "$GIT_TEST_PACK_TEMP" || exit 1
 	exec git index-pack "$@"
 	EOF
diff --git a/t/t5604-clone-reference.sh b/t/t5604-clone-reference.sh
index 39a0c318df..14e93c4352 100755
--- a/t/t5604-clone-reference.sh
+++ b/t/t5604-clone-reference.sh
@@ -220,7 +220,7 @@ test_expect_success 'clone, dissociate from alternates' '
 	git clone --reference=A A B &&
 	test_line_count = 1 B/.git/objects/info/alternates &&
 	git clone --local --dissociate B C &&
-	! test -f C/.git/objects/info/alternates &&
+	test_path_is_missing C/.git/objects/info/alternates &&
 	( cd C && git fsck )
 '
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index a7142ab815..1ae9192cd2 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -415,7 +415,7 @@ test_expect_success 'background auto gc respects lock for all operations' '
 	# shell pid so that it looks valid.
 	hostname=$(hostname || echo unknown) &&
 	shell_pid=$$ &&
-	if test_have_prereq MINGW && test -f /proc/$shell_pid/winpid
+	if test_have_prereq MINGW && test_path_is_file /proc/$shell_pid/winpid
 	then
 		# In Git for Windows, Bash (actually, the MSYS2 runtime) has a
 		# different idea of PIDs than git.exe (actually Windows). Use
diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 526cc4ec83..4073d87753 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -54,7 +54,7 @@ test_expect_success 'read-tree removes worktree, dirty case' '
 '
 
 setup_absent() {
-	test -f 1 && rm 1
+	test_path_is_file 1 && rm 1
 	git update-index --remove 1 &&
 	git update-index --add --cacheinfo 100644 $EMPTY_BLOB 1 &&
 	git update-index --skip-worktree 1
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 298272cb13..70fac59847 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -558,7 +558,7 @@ test_expect_success 'disambiguation (1)' '
 	git reset secondfile &&
 	test_must_fail git diff --quiet -- secondfile &&
 	test -z "$(git diff --cached --name-only)" &&
-	test -f secondfile &&
+	test_path_is_file secondfile &&
 	test_must_be_empty secondfile
 '
 
diff --git a/t/t7104-reset-hard.sh b/t/t7104-reset-hard.sh
index c23d6e3f52..acf145e69b 100755
--- a/t/t7104-reset-hard.sh
+++ b/t/t7104-reset-hard.sh
@@ -29,7 +29,7 @@ test_expect_success 'reset --hard should restore unmerged ones' '
 
 	git reset --hard &&
 	git ls-files --error-unmatch before/1 before/2 hello later/3 &&
-	test -f hello
+	test_path_is_file hello
 
 '
 
diff --git a/t/t7113-post-index-change-hook.sh b/t/t7113-post-index-change-hook.sh
index c10d94fe3d..0d97ab5fd3 100755
--- a/t/t7113-post-index-change-hook.sh
+++ b/t/t7113-post-index-change-hook.sh
@@ -25,11 +25,11 @@ test_expect_success 'test status, add, commit, others trigger hook without flags
 			echo "Invalid combination of flags passed to hook; updated_skipworktree is set." >testfailure
 			exit 1
 		fi
-		if test -f ".git/index.lock"; then
+		if test_path_is_file ".git/index.lock"; then
 			echo ".git/index.lock exists" >testfailure
 			exit 3
 		fi
-		if ! test -f ".git/index"; then
+		if test_path_is_missing ".git/index"; then
 			echo ".git/index does not exist" >testfailure
 			exit 3
 		fi
@@ -71,11 +71,11 @@ test_expect_success 'test checkout and reset trigger the hook' '
 			exit 2
 		fi
 		if test "$1" -eq 1; then
-			if test -f ".git/index.lock"; then
+			if test_path_is_file ".git/index.lock"; then
 				echo "updated_workdir set but .git/index.lock exists" >testfailure
 				exit 3
 			fi
-			if ! test -f ".git/index"; then
+			if test_path_is_missing ".git/index"; then
 				echo "updated_workdir set but .git/index does not exist" >testfailure
 				exit 3
 			fi
@@ -114,11 +114,11 @@ test_expect_success 'test reset --mixed and update-index triggers the hook' '
 			exit 2
 		fi
 		if test "$2" -eq 1; then
-			if test -f ".git/index.lock"; then
+			if test_path_is_file ".git/index.lock"; then
 				echo "updated_skipworktree set but .git/index.lock exists" >testfailure
 				exit 3
 			fi
-			if ! test -f ".git/index"; then
+			if test_path_is_missing ".git/index"; then
 				echo "updated_skipworktree set but .git/index does not exist" >testfailure
 				exit 3
 			fi
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 0ddd1ad7aa..835dd5eb4d 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -135,7 +135,7 @@ test_expect_success 'checkout -m with dirty tree, renamed' '
 	git checkout -m renamer &&
 	fill 1 3 4 5 7 8 >expect &&
 	test_cmp expect uno &&
-	! test -f one &&
+	test_path_is_missing one &&
 	git diff --cached >current &&
 	test_must_be_empty current
 '
@@ -422,7 +422,7 @@ test_expect_success 'switch branches while in subdirectory' '
 
 	mkdir subs &&
 	git -C subs checkout side &&
-	! test -f subs/one &&
+	test_path_is_missing subs/one &&
 	rm -fr subs
 '
 
@@ -437,7 +437,7 @@ test_expect_success 'checkout specific path while in subdirectory' '
 	git checkout main &&
 	mkdir -p subs &&
 	git -C subs checkout side -- bero &&
-	test -f subs/bero
+	test_path_is_file subs/bero
 '
 
 test_expect_success 'checkout w/--track sets up tracking' '
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index eefdecb0bd..de291a03b0 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -1147,7 +1147,7 @@ test_expect_success 'submodule deinit should remove the whole submodule section
 	git submodule deinit init &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -n "$(git config --get-regexp "submodule\.example2\.")" &&
-	test -f example2/.git &&
+	test_path_is_file example2/.git &&
 	rmdir init
 '
 
@@ -1167,7 +1167,7 @@ test_expect_success 'submodule deinit from subdirectory' '
 	test_grep "\\.\\./init" output &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -n "$(git config --get-regexp "submodule\.example2\.")" &&
-	test -f example2/.git &&
+	test_path_is_file example2/.git &&
 	rmdir init
 '
 
@@ -1213,7 +1213,7 @@ test_expect_success 'submodule deinit fails when the submodule contains modifica
 	echo X >>init/s &&
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
-	test -f example2/.git &&
+	test_path_is_file example2/.git &&
 	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test_grep "Cleared directory .init" actual &&
@@ -1225,7 +1225,7 @@ test_expect_success 'submodule deinit fails when the submodule contains untracke
 	echo X >>init/untracked &&
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
-	test -f example2/.git &&
+	test_path_is_file example2/.git &&
 	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test_grep "Cleared directory .init" actual &&
@@ -1240,7 +1240,7 @@ test_expect_success 'submodule deinit fails when the submodule HEAD does not mat
 	) &&
 	test_must_fail git submodule deinit init &&
 	test -n "$(git config --get-regexp "submodule\.example\.")" &&
-	test -f example2/.git &&
+	test_path_is_file example2/.git &&
 	git submodule deinit -f init >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test_grep "Cleared directory .init" actual &&
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 77b6d0040e..fcdf298055 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -368,9 +368,9 @@ test_expect_success 'test "update --recursive" with a flag with spaces' '
 		git rev-parse --resolve-git-dir nested1/.git &&
 		git rev-parse --resolve-git-dir nested1/nested2/.git &&
 		git rev-parse --resolve-git-dir nested1/nested2/nested3/.git &&
-		test -f .git/modules/nested1/objects/info/alternates &&
-		test -f .git/modules/nested1/modules/nested2/objects/info/alternates &&
-		test -f .git/modules/nested1/modules/nested2/modules/nested3/objects/info/alternates
+		test_path_is_file .git/modules/nested1/objects/info/alternates &&
+		test_path_is_file .git/modules/nested1/modules/nested2/objects/info/alternates &&
+		test_path_is_file .git/modules/nested1/modules/nested2/modules/nested3/objects/info/alternates
 	)
 '
 
diff --git a/t/t7412-submodule-absorbgitdirs.sh b/t/t7412-submodule-absorbgitdirs.sh
index 0490499573..70df34ac28 100755
--- a/t/t7412-submodule-absorbgitdirs.sh
+++ b/t/t7412-submodule-absorbgitdirs.sh
@@ -34,7 +34,7 @@ test_expect_success 'absorb the git dir' '
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
 	git fsck &&
-	test -f sub1/.git &&
+	test_path_is_file sub1/.git &&
 	test -d .git/modules/sub1 &&
 	git status >actual.1 &&
 	git -C sub1 rev-parse HEAD >actual.2 &&
@@ -72,7 +72,7 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
-	test -f sub1/nested/.git &&
+	test_path_is_file sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
@@ -109,8 +109,8 @@ test_expect_success 'absorb the git dir in a nested submodule' '
 	EOF
 	git submodule absorbgitdirs 2>actual &&
 	test_cmp expect actual &&
-	test -f sub1/.git &&
-	test -f sub1/nested/.git &&
+	test_path_is_file sub1/.git &&
+	test_path_is_file sub1/nested/.git &&
 	test -d .git/modules/sub1/modules/nested &&
 	git status >actual.1 &&
 	git -C sub1/nested rev-parse HEAD >actual.2 &&
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 42f675b739..20bc57ef30 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -44,7 +44,7 @@ test_expect_success 'merge c1 with c2, c3, c4, ... c29' '
 	i=1 &&
 	while test $i -le 30
 	do
-		test -f c$i.c &&
+		test_path_is_file  c$i.c &&
 		i=$(expr $i + 1) || return 1
 	done
 '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index d1393ef197..78db65189e 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -26,7 +26,7 @@ test_expect_success $PREREQ 'Setup helper tool' '
 	write_script fake.sendmail <<-\EOF &&
 	shift
 	output=1
-	while test -f commandline$output
+	while test_path_is_file commandline$output
 	do
 		output=$(($output+1))
 	done
@@ -66,7 +66,7 @@ test_no_confirm () {
 
 # Exit immediately to prevent hang if a no-confirm test fails
 check_no_confirm () {
-	if ! test -f no_confirm_okay
+	if test_path_is_missing no_confirm_okay
 	then
 		say 'confirm test failed; skipping remaining tests to prevent hanging'
 		PREREQ="$PREREQ,CHECK_NO_CONFIRM"
@@ -2722,7 +2722,7 @@ test_expect_success $PREREQ 'invoke hook' '
 		false
 		;;
 	esac &&
-	test -f 0001-add-main.patch &&
+	test_path_is_file 0001-add-main.patch &&
 	grep "add main" "$1"
 	EOF
 
diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index b2379e4671..c9f9fb6975 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -286,7 +286,7 @@ test_expect_success 'gitcvs.dbname' '
 	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
 	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
 	test_cmp cvswork cvswork2 &&
-	test -f "$SERVERDIR/gitcvs.ext.main.sqlite" &&
+	test_path_is_file "$SERVERDIR/gitcvs.ext.main.sqlite" &&
 	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"
 '
 
@@ -297,8 +297,8 @@ test_expect_success 'gitcvs.ext.dbname' '
 	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
 	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
 	test_cmp cvswork cvswork2 &&
-	test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
-	test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
+	test_path_is_file "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
+	test_path_is_missing "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
 	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs1.ext.main.sqlite"
 '
 

-- 
2.53.0


