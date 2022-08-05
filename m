Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69196C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241593AbiHER7f (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241368AbiHER7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB57823D
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:03 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso2028615wmc.1
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=SSoKbBX4fOn0jStfB3yrGWby2dz6SNXA92d8LumyZyU=;
        b=S/fb/HUDcyaeLPWqXR3hSiXWy0FmRtleKdRrQ0V9YP1RoLrEC4QeODFyYpS/IfveDI
         mVRp/bRisSX2hI7+f5xuQ3BkVjb9HMmY6rpnoA3ciu58KfTGo1Xaww81xksTyWu0Wghz
         v+pehdPDk+x8104yXqxP8N8/VGYiGAzITcCNEu90lzoF4WW8WQRSJZ37vQ/CJWzHZY09
         SR/XVaU3Wj2KNDpx3QcG+6pMEC7xK5A7VDlQv5ZOSnMFrZkN8YtyNuOt0M4L/Rfexo2N
         K2joRWccWv34PRdp9G/uxyufPWPna9vdH+64w2WqVn4SRwry6AyCiTyzfa04zVScmsJm
         FBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=SSoKbBX4fOn0jStfB3yrGWby2dz6SNXA92d8LumyZyU=;
        b=e4a5tH68gwB50nUR6Qi7uS9fMo0Al23tLUyOiQlup68eUuh7aNi7gRUVRq6psx6N1M
         Mu+Xw2J6ONa/AJrKokUc2jiEWyNFgWEpqVsptzw1H03ns9JkeGk4lw59O0usqTialFzh
         yungH8950XF4ssdqL4KB89XFf4rD9zqvgFKFzSD9fjijVZVQFKRR9U7S8FtpQ0UQDYsx
         nxmUHpRqbwC5iOw2gu4jezB5HWViZJC/9xRzQVGgI5MvK5ESvKm5sz14ZOyl0duKJ7jF
         OZvMCMzCAK0MzFm6aRRwDBYjtTSIHl4iahZmBf5EjjzhmQl6lZvY//mw1yRV9CKrBYmK
         D1RQ==
X-Gm-Message-State: ACgBeo3QM3qW9ZW96v4VaPb5nfhIiTLWIvYsccPQwPzkO+JTI2qwIq6s
        v9LOc8vg6VGRVzTRBFaUZ1pj4eQZ/Vk=
X-Google-Smtp-Source: AA6agR6ls/+3oP0jFKAw5PmI40KbMWyIenWwFXHgVBkC4Ic1ZFNwHOR6h2Ioz8V5Lxxgms3fDyD0PA==
X-Received: by 2002:a05:600c:4e12:b0:3a3:2fe2:7d0e with SMTP id b18-20020a05600c4e1200b003a32fe27d0emr10571089wmq.151.1659722341654;
        Fri, 05 Aug 2022 10:59:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b17-20020adfee91000000b0021edfa75204sm4537513wro.48.2022.08.05.10.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:59:01 -0700 (PDT)
Message-Id: <1b12374ff1b1836522c6af2ea70cbd3f96cc75e3.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:40 +0000
Subject: [PATCH v3 08/11] log: add --clear-decorations option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous changes introduced a new default ref filter for decorations
in the 'git log' command. This can be overridden using
--decorate-refs=HEAD and --decorate-refs=refs/, but that is cumbersome
for users.

Instead, add a --clear-decorations option that resets all previous
filters to a blank filter that accepts all refs.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-log.txt                     |   5 +
 builtin/log.c                                 |  24 +++-
 t/t4013-diff-various.sh                       |   2 +
 ..._--decorate=full_--clear-decorations_--all |  61 +++++++++++
 ...f.log_--decorate=full_--decorate-all_--all |  61 +++++++++++
 ...f.log_--decorate_--clear-decorations_--all |  61 +++++++++++
 .../diff.log_--decorate_--decorate-all_--all  |  61 +++++++++++
 t/t4202-log.sh                                | 103 +++++++++++++++++-
 8 files changed, 371 insertions(+), 7 deletions(-)
 create mode 100644 t/t4013/diff.log_--decorate=full_--clear-decorations_--all
 create mode 100644 t/t4013/diff.log_--decorate=full_--decorate-all_--all
 create mode 100644 t/t4013/diff.log_--decorate_--clear-decorations_--all
 create mode 100644 t/t4013/diff.log_--decorate_--decorate-all_--all

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b2ac89dfafc..f2ce16fba71 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -56,6 +56,11 @@ If none of these options or config settings are given, then references are
 used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 `refs/stash/`, or `refs/tags/`.
 
+--clear-decorations::
+	When specified, this option clears all previous `--decorate-refs`
+	or `--decorate-refs-exclude` options and relaxes the default
+	decoration filter to include all references.
+
 --source::
 	Print out the ref name given on the command line by which each
 	commit was reached.
diff --git a/builtin/log.c b/builtin/log.c
index 6683e5ff134..7d35d1ecab1 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -101,6 +101,20 @@ static int parse_decoration_style(const char *value)
 	return -1;
 }
 
+static int use_default_decoration_filter = 1;
+static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+
+static int clear_decorations_callback(const struct option *opt,
+					    const char *arg, int unset)
+{
+	string_list_clear(&decorate_refs_include, 0);
+	string_list_clear(&decorate_refs_exclude, 0);
+	use_default_decoration_filter = 0;
+	return 0;
+}
+
 static int decorate_callback(const struct option *opt, const char *arg, int unset)
 {
 	if (unset)
@@ -176,7 +190,8 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 					   item->string);
 	}
 
-	if (decoration_filter->exclude_ref_pattern->nr ||
+	if (!use_default_decoration_filter ||
+	    decoration_filter->exclude_ref_pattern->nr ||
 	    decoration_filter->include_ref_pattern->nr ||
 	    decoration_filter->exclude_ref_config_pattern->nr)
 		return;
@@ -199,9 +214,6 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	struct userformat_want w;
 	int quiet = 0, source = 0, mailmap;
 	static struct line_opt_callback_data line_cb = {NULL, NULL, STRING_LIST_INIT_DUP};
-	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
-	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
 	struct decoration_filter decoration_filter = {
 		.exclude_ref_pattern = &decorate_refs_exclude,
 		.include_ref_pattern = &decorate_refs_include,
@@ -214,6 +226,10 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		OPT_BOOL(0, "source", &source, N_("show source")),
 		OPT_BOOL(0, "use-mailmap", &mailmap, N_("use mail map file")),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
+		OPT_CALLBACK_F(0, "clear-decorations", NULL, NULL,
+			       N_("clear all previously-defined decoration filters"),
+			       PARSE_OPT_NOARG | PARSE_OPT_NONEG,
+			       clear_decorations_callback),
 		OPT_STRING_LIST(0, "decorate-refs", &decorate_refs_include,
 				N_("pattern"), N_("only decorate refs that match <pattern>")),
 		OPT_STRING_LIST(0, "decorate-refs-exclude", &decorate_refs_exclude,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 056e922164d..dfcf3a0aaae 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -352,6 +352,8 @@ log -GF -p --pickaxe-all master
 log -IA -IB -I1 -I2 -p master
 log --decorate --all
 log --decorate=full --all
+log --decorate --clear-decorations --all
+log --decorate=full --clear-decorations --all
 
 rev-list --parents HEAD
 rev-list --children HEAD
diff --git a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
new file mode 100644
index 00000000000..1c030a6554e
--- /dev/null
+++ b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
@@ -0,0 +1,61 @@
+$ git log --decorate=full --clear-decorations --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (refs/heads/mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (refs/heads/note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4013/diff.log_--decorate=full_--decorate-all_--all b/t/t4013/diff.log_--decorate=full_--decorate-all_--all
new file mode 100644
index 00000000000..d6e79287846
--- /dev/null
+++ b/t/t4013/diff.log_--decorate=full_--decorate-all_--all
@@ -0,0 +1,61 @@
+$ git log --decorate=full --decorate-all --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (refs/heads/mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (refs/heads/note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (refs/heads/rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> refs/heads/master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (refs/heads/initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4013/diff.log_--decorate_--clear-decorations_--all b/t/t4013/diff.log_--decorate_--clear-decorations_--all
new file mode 100644
index 00000000000..88be82cce31
--- /dev/null
+++ b/t/t4013/diff.log_--decorate_--clear-decorations_--all
@@ -0,0 +1,61 @@
+$ git log --decorate --clear-decorations --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4013/diff.log_--decorate_--decorate-all_--all b/t/t4013/diff.log_--decorate_--decorate-all_--all
new file mode 100644
index 00000000000..5d22618bb60
--- /dev/null
+++ b/t/t4013/diff.log_--decorate_--decorate-all_--all
@@ -0,0 +1,61 @@
+$ git log --decorate --decorate-all --all
+commit b7e0bc69303b488b47deca799a7d723971dfa6cd (mode)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode
+
+commit a6f364368ca320bc5a92e18912e16fa6b3dff598 (note)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    update mode (file2)
+
+Notes:
+    note
+
+commit cd4e72fd96faed3f0ba949dc42967430374e2290 (rearrange)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Rearranged lines in dir/sub
+
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:06:00 2006 +0000
+
+    Notes added by 'git notes add'
+
+commit 59d314ad6f356dd08601a4cd5e530381da3e3c64 (HEAD -> master)
+Merge: 9a6d494 c7a2ab9
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:04:00 2006 +0000
+
+    Merge branch 'side'
+
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:03:00 2006 +0000
+
+    Side
+
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:02:00 2006 +0000
+
+    Third
+
+commit 1bde4ae5f36c8d9abe3a0fce0c6aab3c4a12fe44
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:01:00 2006 +0000
+
+    Second
+    
+    This is the second commit.
+
+commit 444ac553ac7612cc88969031b02b3767fb8a353a (initial)
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+$
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 4c3ce863074..90800feb0f1 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -704,9 +704,12 @@ test_expect_success 'set up more tangled history' '
 	git checkout -b tangle HEAD~6 &&
 	test_commit tangle-a tangle-a a &&
 	git merge main~3 &&
+	git update-ref refs/prefetch/merge HEAD &&
 	git merge side~1 &&
+	git update-ref refs/rewritten/merge HEAD &&
 	git checkout main &&
 	git merge tangle &&
+	git update-ref refs/hidden/tangle HEAD &&
 	git checkout -b reach &&
 	test_commit reach &&
 	git checkout main &&
@@ -974,9 +977,9 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	Merge-tag-reach (HEAD -> main)
 	reach (tag: reach, reach)
 	seventh (tag: seventh)
-	Merge-branch-tangle
-	Merge-branch-side-early-part-into-tangle (tangle)
-	tangle-a (tag: tangle-a)
+	Merge-branch-tangle (refs/hidden/tangle)
+	Merge-branch-side-early-part-into-tangle (refs/rewritten/merge, tangle)
+	Merge-branch-main-early-part-into-tangle (refs/prefetch/merge)
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="*octopus*" \
@@ -1037,6 +1040,100 @@ test_expect_success 'decorate-refs focus from default' '
 	! grep HEAD actual
 '
 
+test_expect_success '--clear-decorations overrides defaults' '
+	cat >expect.default <<-\EOF &&
+	Merge-tag-reach (HEAD -> refs/heads/main)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: refs/tags/seventh)
+	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
+	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
+	reach (tag: refs/tags/reach, refs/heads/reach)
+	Merge-branch-tangle
+	Merge-branch-side-early-part-into-tangle (refs/heads/tangle)
+	Merge-branch-main-early-part-into-tangle
+	tangle-a (tag: refs/tags/tangle-a)
+	Merge-branch-side
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	Second
+	sixth
+	fifth
+	fourth
+	third
+	second
+	initial
+	EOF
+	git log --decorate=full --pretty="tformat:%f%d" >actual &&
+	test_cmp expect.default actual &&
+
+	cat >expect.all <<-\EOF &&
+	Merge-tag-reach (HEAD -> refs/heads/main)
+	Merge-tags-octopus-a-and-octopus-b
+	seventh (tag: refs/tags/seventh)
+	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
+	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
+	reach (tag: refs/tags/reach, refs/heads/reach)
+	Merge-branch-tangle (refs/hidden/tangle)
+	Merge-branch-side-early-part-into-tangle (refs/rewritten/merge, refs/heads/tangle)
+	Merge-branch-main-early-part-into-tangle (refs/prefetch/merge)
+	tangle-a (tag: refs/tags/tangle-a)
+	Merge-branch-side
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	Second
+	sixth
+	fifth
+	fourth
+	third
+	second
+	initial
+	EOF
+	git log --decorate=full --pretty="tformat:%f%d" \
+		--clear-decorations >actual &&
+	test_cmp expect.all actual
+'
+
+test_expect_success '--clear-decorations clears previous exclusions' '
+	cat >expect.all <<-\EOF &&
+	Merge-tag-reach (HEAD -> refs/heads/main)
+	reach (tag: refs/tags/reach, refs/heads/reach)
+	Merge-tags-octopus-a-and-octopus-b
+	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
+	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
+	seventh (tag: refs/tags/seventh)
+	Merge-branch-tangle (refs/hidden/tangle)
+	Merge-branch-side-early-part-into-tangle (refs/rewritten/merge, refs/heads/tangle)
+	Merge-branch-main-early-part-into-tangle (refs/prefetch/merge)
+	tangle-a (tag: refs/tags/tangle-a)
+	side-2 (tag: refs/tags/side-2, refs/heads/side)
+	side-1 (tag: refs/tags/side-1)
+	initial
+	EOF
+
+	git log --decorate=full --pretty="tformat:%f%d" \
+		--simplify-by-decoration \
+		--decorate-refs-exclude="heads/octopus*" \
+		--decorate-refs="heads" \
+		--clear-decorations >actual &&
+	test_cmp expect.all actual &&
+
+	cat >expect.filtered <<-\EOF &&
+	Merge-tags-octopus-a-and-octopus-b
+	octopus-b (refs/heads/octopus-b)
+	octopus-a (refs/heads/octopus-a)
+	initial
+	EOF
+
+	git log --decorate=full --pretty="tformat:%f%d" \
+		--simplify-by-decoration \
+		--decorate-refs-exclude="heads/octopus" \
+		--decorate-refs="heads" \
+		--clear-decorations \
+		--decorate-refs-exclude="tags/" \
+		--decorate-refs="heads/octopus*" >actual &&
+	test_cmp expect.filtered actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
gitgitgadget

