Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58541C433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 06:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiF3G5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 02:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbiF3G5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 02:57:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFCD31205
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:13 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r20so25784517wra.1
        for <git@vger.kernel.org>; Wed, 29 Jun 2022 23:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tv2+taQaU2E2Puvf4Rgr0j3ZUya2qngVVu5UN/CEVco=;
        b=AOCeccOkZet1V8PfygZeG08HHGHJkNWwYun/ZOyVxSIhuaGIVRO2pRIUgZZJLNWwdi
         U0tmzdOKPZsURlTfcVowtCQgXaPpwFXYF5SCHZ7BceVtYPHVjTUuft+jybOu9+tXANHP
         x4a/aIihhUVRn7mZxErMNbGF4c4DKancY7JTiRIbLZvXKaf3ExPAZkxzOl6aqyqJ9sed
         V5Bwbpe4GE+QbZAcJvPaNk+1mhh0K6XsHwfA1CniHQMk4lMuTV7azeuSP7FecDObEhyq
         /uqO/yHQz7fErlNu1l9vfbeRZBqAycCTKV6bqe3/sk+fYIsCACs5koobCVPzwuPi+Rcr
         PkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tv2+taQaU2E2Puvf4Rgr0j3ZUya2qngVVu5UN/CEVco=;
        b=2E1ZnK/q6tRCkbJMv0CJpowGFRV6Blht0za9/4yQgUIqNUfFFvOr6SqUOwFQeerZ10
         KcTWn7vX30WACjaLjVNfnkHgFwWkOSpWXawDfIL8tew1OD8lQG77tdD9OE905JYoJmAQ
         CqzOhCv5tKwQtwlPjGVGzep6l3CHQSnaeaq0bvB5aHhFJr+2tohw2geCKxuC+VcMSVwN
         IpY2JYuUeJxyeRS77bd4OJ2KVr4wdi4jA6n+J2Lpm+W36nO+ZoThX9ZbPwOOF4aC4lwe
         bbrGi4HXuhcZJYzwaNleEISgNP2aA0w1sMfhRtb1E5tJPDWEp80KIxWN0GK+sV3Ycw36
         yXlg==
X-Gm-Message-State: AJIora9Ugyin5uucX8HEbJny1P6gOay/+JXqPRL4OQEH4yT/3kvgQcjA
        HhUMbdQL7PgZ4B6Qlvw0aaR2qKUKJhnyPg==
X-Google-Smtp-Source: AGRyM1uMA3bOUxcZ1wj/jj3aE7hR0cSy6GXxk2JBJQYRzXnQl086gfX1TdtTcCoH1oCbeIuPjd8Y/w==
X-Received: by 2002:adf:d1ca:0:b0:21b:a81c:47f3 with SMTP id b10-20020adfd1ca000000b0021ba81c47f3mr6802965wrd.22.1656572231413;
        Wed, 29 Jun 2022 23:57:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm22179623wrr.63.2022.06.29.23.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 23:57:10 -0700 (PDT)
Message-Id: <da3ae38e390df8acf86e910389d1620569a95a87.1656572226.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
References: <pull.1268.git.1655871651.gitgitgadget@gmail.com>
        <pull.1268.v2.git.1656572225.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 06:57:05 +0000
Subject: [PATCH v2 3/3] merge-ort: fix issue with dual rename and add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

There is code in both merge-recursive and merge-ort for avoiding doubly
transitive renames (i.e. one side renames directory A/ -> B/, and the
other side renames directory B/ -> C/), because this combination would
otherwise make a mess for new files added to A/ on the first side and
wondering which directory they end up in -- especially if there were
even more renames such as the first side renaming C/ -> D/.  In such
cases, it just turns "off" directory rename detection for the higher
order transitive cases.

The testcases added in t6423 a couple commits ago are slightly different
but similar in principle.  They involve a similar case of paired
renaming but instead of A/ -> B/ and B/ -> C/, the second side renames
a leading directory of B/ to C/.  And both sides add a new file
somewhere under the directory that the other side will rename.  While
the new files added start within different directories and thus could
logically end up within different directories, it is weird for a file
on one side to end up where the other one started and not move along
with it.  So, let's just turn off directory rename detection in this
case as well.

Another way to look at this is that if the source name involved in a
directory rename on one side is the target name of a directory rename
operation for a file from the other side, then we avoid the doubly
transitive rename.  (More concretely, if a directory rename on side D
wants to rename a file on side E from OLD_NAME -> NEW_NAME, and side D
already had a file named NEW_NAME, and a directory rename on side E
wants to rename side D's NEW_NAME -> NEWER_NAME, then we turn off the
directory rename detection for NEW_NAME to prevent the
NEW_NAME -> NEWER_NAME rename, and instead end up with an add/add
conflict on NEW_NAME.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c                         | 7 +++++++
 t/t6423-merge-rename-directories.sh | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index fa6667de18c..17db4c30e5b 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2292,9 +2292,16 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	struct strmap_entry *rename_info;
 	struct strmap_entry *otherinfo = NULL;
 	const char *new_dir;
+	int other_side = 3 - side_index;
 
+	/*
+	 * Cases where we don't have or don't want a directory rename for
+	 * this path, so we return NULL.
+	 */
 	if (strmap_empty(dir_renames))
 		return new_path;
+	if (strmap_get(&collisions[other_side], path))
+		return new_path;
 	rename_info = check_dir_renamed(path, dir_renames);
 	if (!rename_info)
 		return new_path;
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index db13bb995f3..1300a01206a 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5245,7 +5245,7 @@ test_setup_12l () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (B into A): Rename into each other + add/add conflict' '
 	test_setup_12l BintoA &&
 	(
 		cd 12l_BintoA &&
@@ -5273,7 +5273,7 @@ test_expect_merge_algorithm failure failure '12l (B into A): Rename into each ot
 	)
 '
 
-test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (A into B): Rename into each other + add/add conflict' '
 	test_setup_12l AintoB &&
 	(
 		cd 12l_AintoB &&
-- 
gitgitgadget
