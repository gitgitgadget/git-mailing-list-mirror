Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3759C4332F
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3A261357
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 23:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243312AbhI1Xep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243292AbhI1Xej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 19:34:39 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6F0C061755
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v127so343437wme.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8AgoE4x6pFlEAgdAVwM5FjKoJLl1pgqUb7ScpI1FJL0=;
        b=QqE+hKmSf8VhDnnubJn//AjTjFm06LXW2HDEbOj9mcm17XIfBr3CHnNWFoSov0ygPN
         x06Wz4kKL6tiPVyZFjSe1R7QO5QkvaGem4wMovDb1KKWXZabwjvZhpNIHxYU94qYL1x9
         7F/U8AYbC4P02lcQcoyMvTrdfnt09QuYMtpCRHfWnB5ZiUe5ZVu7/uLGxAdNrnYQNial
         j+R/+0CKWXEGSHbbRVoVe+Uv459EaXM9gwXJugAI78YeMX9Eg5sthPrMxFpFKRsGSLCP
         pQE0TAdFOLf5IMvgryRlt26TQyxn991JxsZ3okSyJgW8B5nTqRhII8vVL2PIfaei5GW2
         KIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8AgoE4x6pFlEAgdAVwM5FjKoJLl1pgqUb7ScpI1FJL0=;
        b=3vXpGMv2zpyppkCTGmODAaoGgnk2vhmaaFKQZx06vqJmqy+QsxAr6E8N3Hk6dXx5rE
         a1UdHCqTttusKacuc7fvUHjU0+uoGBColWka/f/cXPCzX8cFkZ6WqE4tOPyoStqAibHl
         X1LJK7IWcyYESZ4xnXZ2VKyPSk2DnD+jfv+9TwV/D3jfWkgUqyqD3FToXlgPBKrivQfu
         k4dSrlvht7Om15GgsEdEK7l4g3EdX8ZyPZ2y3+u8WnU3rf5upDETvUMGp/VrjwBXTQX0
         wun6i1V3RRpigKR6Yns6Bf6OGSbn+2eMOWwyu8VyewTrNL5Lh5Z0pSmZqkooqOjsTYKg
         cMqw==
X-Gm-Message-State: AOAM533JNCt6OF+KvUjN7Zs27iVpCVBfFSu0d2C6KD6Mgq2QNFKFd3+9
        ibVN0BwaReTZy8bG9UNWPAv41Nu8P98=
X-Google-Smtp-Source: ABdhPJyAnVQVYqLWcaII9zo4mX2wxS4mUHRz+ft68u2rW2nN6I74qBw2KP4Wlf7I5hmaBd9W2UPXIw==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr7141718wmh.137.1632871977833;
        Tue, 28 Sep 2021 16:32:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v8sm474364wrt.12.2021.09.28.16.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:32:57 -0700 (PDT)
Message-Id: <7aaa08d5f5fc2b3c83bc48de8dac25dea90d956b.1632871972.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
References: <pull.1076.v6.git.git.1632527609.gitgitgadget@gmail.com>
        <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 23:32:50 +0000
Subject: [PATCH v7 8/9] core.fsyncobjectfiles: tests for batch mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Neeraj-Personal <nksingh85@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, "Randall S. Becker" <rsbecker@nexbridge.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Neeraj Singh <neerajsi@microsoft.com>

Add test cases to exercise batch mode for:
 * 'git add'
 * 'git stash'
 * 'git update-index'
 * 'git unpack-objects'

These tests ensure that the added data winds up in the object database.

In this change we introduce a new test helper lib-unique-files.sh. The
goal of this library is to create a tree of files that have different
oids from any other files that may have been created in the current test
repo. This helps us avoid missing validation of an object being added due
to it already being in the repo.

Signed-off-by: Neeraj Singh <neerajsi@microsoft.com>
---
 t/lib-unique-files.sh  | 36 ++++++++++++++++++++++++++++++++++++
 t/t3700-add.sh         | 20 ++++++++++++++++++++
 t/t3903-stash.sh       | 14 ++++++++++++++
 t/t5300-pack-object.sh | 30 +++++++++++++++++++-----------
 4 files changed, 89 insertions(+), 11 deletions(-)
 create mode 100644 t/lib-unique-files.sh

diff --git a/t/lib-unique-files.sh b/t/lib-unique-files.sh
new file mode 100644
index 00000000000..a7de4ca8512
--- /dev/null
+++ b/t/lib-unique-files.sh
@@ -0,0 +1,36 @@
+# Helper to create files with unique contents
+
+
+# Create multiple files with unique contents. Takes the number of
+# directories, the number of files in each directory, and the base
+# directory.
+#
+# test_create_unique_files 2 3 my_dir -- Creates 2 directories with 3 files
+#					 each in my_dir, all with unique
+#					 contents.
+
+test_create_unique_files() {
+	test "$#" -ne 3 && BUG "3 param"
+
+	local dirs=$1
+	local files=$2
+	local basedir=$3
+	local counter=0
+	test_tick
+	local basedata=$test_tick
+
+
+	rm -rf $basedir
+
+	for i in $(test_seq $dirs)
+	do
+		local dir=$basedir/dir$i
+
+		mkdir -p "$dir"
+		for j in $(test_seq $files)
+		do
+			counter=$((counter + 1))
+			echo "$basedata.$counter"  >"$dir/file$j.txt"
+		done
+	done
+}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index 4086e1ebbc9..36049a53ff7 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -7,6 +7,8 @@ test_description='Test of git add, including the -- option.'
 
 . ./test-lib.sh
 
+. $TEST_DIRECTORY/lib-unique-files.sh
+
 # Test the file mode "$1" of the file "$2" in the index.
 test_mode_in_index () {
 	case "$(git ls-files -s "$2")" in
@@ -33,6 +35,24 @@ test_expect_success \
     'Test that "git add -- -q" works' \
     'touch -- -q && git add -- -q'
 
+test_expect_success 'git add: core.fsyncobjectfiles=batch' "
+	test_create_unique_files 2 4 fsync-files &&
+	git -c core.fsyncobjectfiles=batch add -- ./fsync-files/ &&
+	rm -f fsynced_files &&
+	git ls-files --stage fsync-files/ > fsynced_files &&
+	test_line_count = 8 fsynced_files &&
+	awk -- '{print \$2}' fsynced_files | xargs -n1 git cat-file -e
+"
+
+test_expect_success 'git update-index: core.fsyncobjectfiles=batch' "
+	test_create_unique_files 2 4 fsync-files2 &&
+	find fsync-files2 ! -type d -print | xargs git -c core.fsyncobjectfiles=batch update-index --add -- &&
+	rm -f fsynced_files2 &&
+	git ls-files --stage fsync-files2/ > fsynced_files2 &&
+	test_line_count = 8 fsynced_files2 &&
+	awk -- '{print \$2}' fsynced_files2 | xargs -n1 git cat-file -e
+"
+
 test_expect_success \
 	'git add: Test that executable bit is not used if core.filemode=0' \
 	'git config core.filemode 0 &&
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359..2fc819e5584 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -9,6 +9,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. $TEST_DIRECTORY/lib-unique-files.sh
 
 diff_cmp () {
 	for i in "$1" "$2"
@@ -1293,6 +1294,19 @@ test_expect_success 'stash handles skip-worktree entries nicely' '
 	git rev-parse --verify refs/stash:A.t
 '
 
+test_expect_success 'stash with core.fsyncobjectfiles=batch' "
+	test_create_unique_files 2 4 fsync-files &&
+	git -c core.fsyncobjectfiles=batch stash push -u -- ./fsync-files/ &&
+	rm -f fsynced_files &&
+
+	# The files were untracked, so use the third parent,
+	# which contains the untracked files
+	git ls-tree -r stash^3 -- ./fsync-files/ > fsynced_files &&
+	test_line_count = 8 fsynced_files &&
+	awk -- '{print \$3}' fsynced_files | xargs -n1 git cat-file -e
+"
+
+
 test_expect_success 'stash -c stash.useBuiltin=false warning ' '
 	expected="stash.useBuiltin support has been removed" &&
 
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index e13a8842075..38663dc1393 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -162,23 +162,23 @@ test_expect_success 'pack-objects with bogus arguments' '
 
 check_unpack () {
 	test_when_finished "rm -rf git2" &&
-	git init --bare git2 &&
-	git -C git2 unpack-objects -n <"$1".pack &&
-	git -C git2 unpack-objects <"$1".pack &&
-	(cd .git && find objects -type f -print) |
-	while read path
-	do
-		cmp git2/$path .git/$path || {
-			echo $path differs.
-			return 1
-		}
-	done
+	git $2 init --bare git2 &&
+	(
+		git $2 -C git2 unpack-objects -n <"$1".pack &&
+		git $2 -C git2 unpack-objects <"$1".pack &&
+		git $2 -C git2 cat-file --batch-check="%(objectname)"
+	) <obj-list >current &&
+	cmp obj-list current
 }
 
 test_expect_success 'unpack without delta' '
 	check_unpack test-1-${packname_1}
 '
 
+test_expect_success 'unpack without delta (core.fsyncobjectfiles=batch)' '
+	check_unpack test-1-${packname_1} "-c core.fsyncobjectfiles=batch"
+'
+
 test_expect_success 'pack with REF_DELTA' '
 	packname_2=$(git pack-objects --progress test-2 <obj-list 2>stderr) &&
 	check_deltas stderr -gt 0
@@ -188,6 +188,10 @@ test_expect_success 'unpack with REF_DELTA' '
 	check_unpack test-2-${packname_2}
 '
 
+test_expect_success 'unpack with REF_DELTA (core.fsyncobjectfiles=batch)' '
+       check_unpack test-2-${packname_2} "-c core.fsyncobjectfiles=batch"
+'
+
 test_expect_success 'pack with OFS_DELTA' '
 	packname_3=$(git pack-objects --progress --delta-base-offset test-3 \
 			<obj-list 2>stderr) &&
@@ -198,6 +202,10 @@ test_expect_success 'unpack with OFS_DELTA' '
 	check_unpack test-3-${packname_3}
 '
 
+test_expect_success 'unpack with OFS_DELTA (core.fsyncobjectfiles=batch)' '
+       check_unpack test-3-${packname_3} "-c core.fsyncobjectfiles=batch"
+'
+
 test_expect_success 'compare delta flavors' '
 	perl -e '\''
 		defined($_ = -s $_) or die for @ARGV;
-- 
gitgitgadget

