Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB486C433FE
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944E961357
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbhJDQ75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237932AbhJDQ7v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 12:59:51 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A72C061786
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 09:57:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t2so8415096wrb.8
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 09:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=8AgoE4x6pFlEAgdAVwM5FjKoJLl1pgqUb7ScpI1FJL0=;
        b=nVISyDov2cUf7Q0wtJTBiU/eFYzJU/x5j+NwSgeAU6/LGVSGcyYEYRnuosK+IsA8OR
         zDESv/g7iTdGm3EncvHUV34K9dU1YXbRFjWjh6iMiEmVYbLrG/waojwVakqRYGjrsGPa
         +9NM9gP32n3GbKBfXijnD/87bCr9ColQgHZzBghQLK6pd8/JdOGzYRoCMU3yGHDvuz8J
         CWs97ISKR+dEegE//Uma8SWXPG6r31poR3DtO+J8HS2fP134dgaO+O5QjreJ5loctuHP
         VlMMbDgOCk2xdDAwOzQnpxjwBHNrGgCNeoFJfGvq1+cBLybp9j1ufxuGYIxbnlNf+lVf
         3VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=8AgoE4x6pFlEAgdAVwM5FjKoJLl1pgqUb7ScpI1FJL0=;
        b=llw4NvS5QzEM0a8U3nAJyMkPf5BFGemyyu7HVLn6Yd6Ezau27kgStfeSZ84bC/Tn9w
         GD+eIIwcUBpZQ1hJAh6BwO0iInQ9MdcbLFpcY6OlER/VGc5LjWcTYWst28wdKGmy4R9v
         9ly2tOZBnbyNTB32UavrN0Lv8bMrFxYYc4bxeVlYqrSsLB2D38TqxG4WGSGgC6gM0Dfd
         tfxtspYwieRcIJCu1DCXIPwO1Ddmy+0f2nsdUQJVChYTwY7OCD1xa61ufcD5JIAQ/R3D
         QnJU5xK9ZlDRCjgejwtmF1G9l8Q4L2ZqDVJ1W3NhrHzLUi+9nuUOr+9zAPbGH0xYMHsX
         T5QQ==
X-Gm-Message-State: AOAM5326h100WemIgIp94cuA8maiAt0AWgAJYz5vnpm0PKEOcuz6sEGm
        BqRGg0pldVYL5mHnXrqJEr6IGfVymPI=
X-Google-Smtp-Source: ABdhPJyXldX28OPBqltxhBYvF1rAbDJ3LhUC2JygZ+jWQ/XkKGlLa9S0FVF6UXO8PykVLJ+8qTgtkg==
X-Received: by 2002:a5d:6305:: with SMTP id i5mr5240814wru.33.1633366674666;
        Mon, 04 Oct 2021 09:57:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c15sm15144683wrs.19.2021.10.04.09.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:57:54 -0700 (PDT)
Message-Id: <811d6d315098924b0f588c83c74dacef829eb147.1633366667.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
References: <pull.1076.v7.git.git.1632871971.gitgitgadget@gmail.com>
        <pull.1076.v8.git.git.1633366667.gitgitgadget@gmail.com>
From:   "Neeraj Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Oct 2021 16:57:46 +0000
Subject: [PATCH v8 8/9] core.fsyncobjectfiles: tests for batch mode
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
        Elijah Newren <newren@gmail.com>,
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

