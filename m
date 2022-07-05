Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7DC433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 01:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiGEBeD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 21:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbiGEBd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 21:33:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B710EE31
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 18:33:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f2so10058975wrr.6
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 18:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tq7o8w9fCrQpzQViPTwZNmvwvJyhoUZRDlIWyQl3OSI=;
        b=GqY3B8uQNDxWbPRz9NfqSIOjN60ZuZiI6/uMTueu0HdtlmYWIYnvWse/XVv8QGEfUz
         Chtf7kq+0dFvONcRLsNyc+DHAswI520SMjo/dUhxceL8zd77ziAGprduy9otwh8SQjkx
         1csXdNLSy91uHaxhrWAE/j/7Bv/Y8eL/lclRONU6QUOeq1revSmF8gv2dHKSJAMHF/to
         tZ6UBQ3SzX23dL/MWsBLc8aQfzjdP+M/CiFag5FF40sh4/LLTb/FHvUjYr/r9Dv1Y/E3
         9yM3PYeVdBBKR/yPx/hLL0E7N+SoL6Men2Nt4xscxF1ugRweDX6IwhhUdgAe+mOqn5Uc
         83Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tq7o8w9fCrQpzQViPTwZNmvwvJyhoUZRDlIWyQl3OSI=;
        b=k25KQm6TUEHBs/NA1nCUIND0GK7mo4Fp42GwzDA5P0gBPJD1Ds9C/3D2NdgiFjmPq4
         sc5hTV+bc4LLIiYtRr7ORn8VbdTdfmN0TMtaoxw1rBIBKlWlN7x8Qve35y2up8XdPW9d
         JbjOz+C4XA/f8ghemFUt0+wOjMPb4GCd/Z4hqoT7aVP2Kj6DWVLgIL/AHwyw0sKmvsAJ
         4zPMA8SGZUqX8iKgc/0YQ2SqzTgCjFu64iOfK3S/l7OYlSYMmNNV+gQzIDEpi4g1mN1e
         B25Lo8SjdvplErmmJWIgT6L3q5TrEgNL9hczJSt0orGbT9aqpo/now7tBpIjVzUN2Svb
         DF8g==
X-Gm-Message-State: AJIora9gd1m3ksY21oHJjmsf0l+/2vq9hzIcyY5W9EUjdv6e0zh80ge6
        zsJsCrbsEXNwc9RSBGUO8iz5qvk0HK0=
X-Google-Smtp-Source: AGRyM1t2SGLp94T1EOuQvlXwt45KfmFzN6oB7YormU/iSDZjN4QFY2ND1oZLi2XFP45n07/+ifZBmQ==
X-Received: by 2002:adf:eace:0:b0:21d:6e90:2bf8 with SMTP id o14-20020adfeace000000b0021d6e902bf8mr3268813wrn.349.1656984833731;
        Mon, 04 Jul 2022 18:33:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c1c8500b003a0fb88a197sm21131637wms.16.2022.07.04.18.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 18:33:53 -0700 (PDT)
Message-Id: <993ac4054087846bde0261a309167eb947c27f50.1656984824.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
References: <pull.1268.v3.git.1656653000.gitgitgadget@gmail.com>
        <pull.1268.v4.git.1656984823.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Jul 2022 01:33:43 +0000
Subject: [PATCH v4 5/5] merge-ort: fix issue with dual rename and add/add
 conflict
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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
 merge-ort.c                         | 8 +++++++-
 t/t6423-merge-rename-directories.sh | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index a37c1c19aca..3855f9de25e 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2292,10 +2292,16 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	struct strmap_entry *rename_info;
 	struct strmap_entry *otherinfo;
 	const char *new_dir;
+	int other_side = 3 - side_index;
 
-	/* Cases where we don't have a directory rename for this path */
+	/*
+	 * Cases where we don't have or don't want a directory rename for
+	 * this path.
+	 */
 	if (strmap_empty(dir_renames))
 		return NULL;
+	if (strmap_get(&collisions[other_side], path))
+		return NULL;
 	rename_info = check_dir_renamed(path, dir_renames);
 	if (!rename_info)
 		return NULL;
diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index ed5586de28c..99baf77cbfd 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5250,7 +5250,7 @@ test_setup_12l () {
 	)
 }
 
-test_expect_merge_algorithm failure failure '12l (B into A): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (B into A): Rename into each other + add/add conflict' '
 	test_setup_12l BintoA &&
 	(
 		cd 12l_BintoA &&
@@ -5277,7 +5277,7 @@ test_expect_merge_algorithm failure failure '12l (B into A): Rename into each ot
 	)
 '
 
-test_expect_merge_algorithm failure failure '12l (A into B): Rename into each other + add/add conflict' '
+test_expect_merge_algorithm failure success '12l (A into B): Rename into each other + add/add conflict' '
 	test_setup_12l AintoB &&
 	(
 		cd 12l_AintoB &&
-- 
gitgitgadget
