Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C3C433EF
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383818AbiFRAVu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383745AbiFRAV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AD966F9C
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:19 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id s1so7511966wra.9
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zJfRyoBvuWNcOv1lkfUlG+kXrpIMd7GAkbs1CMlB9DM=;
        b=lpxmfKIiECHhJSePorKAxZRvsUU6+UvhrXUru69NPS+tLOL01XX9E9sCZBYrvtcyqZ
         F5M1jFDyNbgDQvpNS9A9QhB7Ns2Bir/MDzfO01zK8piFWu7qp448KcxHQu7K49jinqkD
         UNTd46ehBlPhl8N3anDsiB0/oTzV4/o62zrapvSW1qGI7b29jy4gnKghPYVLTx/CXwaE
         kWWZZgK9oiATp3xzK7Dctz5Twv1ZKyTOqwTeiSer3tpm+tmq1UG0x3XB6XA0xTSzJs4j
         z3ZcC9UEgFVsN8txAeHE9ninY0rWt50LGRZp3kLch1Xy6Doe2FfUs07adq182B5d32X7
         vfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zJfRyoBvuWNcOv1lkfUlG+kXrpIMd7GAkbs1CMlB9DM=;
        b=cDw7Xq9wRTPUtixqBDHOWC6octwY0fxo/bPN243B/T+vxIIBL797QRJgyzk7oOWyno
         CtURYG+ByioJC8/vSVq5il5bXfb4LAkVVixFHM5fIGWR51JUe1LlsN8GcXVtun/8T0u4
         LxlB1Xc8lQYIs0Y2zhw3r1365I1n7Vm8L8ZyvkLcY8PUbValG54Io0lgdmruLTJtfEHj
         7l6tXSTCqndN1/OLngjHcufn2PKKrqtlF0lHNc5HjbI89L7sEGkdMt3TeyQJldnBorTc
         8XT1kEjKnEvqvvzwg/6PNghpbceKoJ3Tw6WVckJt7ClE2papNP7P6gocigsvME4qc8ga
         6glQ==
X-Gm-Message-State: AJIora/Hsjy0780RV0LRuIkrojgilJX7KCtFcy0U8RmVs3ZxiMfQrdNG
        NExCPDsXPU6LBWmIan+GQ3S/cS7xTAtL+A==
X-Google-Smtp-Source: AGRyM1s9gXGpyUaZ7QokNfZczn15+FbyqwYYi8LUMvZbpEU9K3VpfyZTtqHzrKCuQDDymLIlgYCD3w==
X-Received: by 2002:adf:d1ca:0:b0:218:47e1:ab0b with SMTP id b10-20020adfd1ca000000b0021847e1ab0bmr11659486wrd.90.1655511678736;
        Fri, 17 Jun 2022 17:21:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d5-20020a5d4f85000000b0021b862ad439sm432639wru.9.2022.06.17.17.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:18 -0700 (PDT)
Message-Id: <7eb70f77c81bd506c6d6be680961677407bf68df.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:56 +0000
Subject: [PATCH v7 13/17] merge-ort: store more specific conflict information
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

It is all fine and dandy for a regular Git command that is intended to
be run interactively to produce a bunch of messages upon an error.

However, in `merge-ort`'s case, we want to call the command e.g. in
server-side software, where the actual error messages are not quite as
interesting as machine-readable, immutable terms that describe the exact
nature of any given conflict.

With this patch, the `merge-ort` machinery records the exact type (as
specified via an `enum` value) as well as the involved path(s) together
with the conflict's message.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 267 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 212 insertions(+), 55 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index dfec08c88be..432937255f6 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -483,6 +483,100 @@ struct conflict_info {
 	unsigned match_mask:3;
 };
 
+enum conflict_and_info_types {
+	/* "Simple" conflicts and informational messages */
+	INFO_AUTO_MERGING = 0,
+	CONFLICT_CONTENTS,       /* text file that failed to merge */
+	CONFLICT_BINARY,
+	CONFLICT_FILE_DIRECTORY,
+	CONFLICT_DISTINCT_MODES,
+	CONFLICT_MODIFY_DELETE,
+	CONFLICT_PRESENT_DESPITE_SKIPPED,
+
+	/* Regular rename */
+	CONFLICT_RENAME_RENAME,   /* same file renamed differently */
+	CONFLICT_RENAME_COLLIDES, /* rename/add or two files renamed to 1 */
+	CONFLICT_RENAME_DELETE,
+
+	/* Basic directory rename */
+	CONFLICT_DIR_RENAME_SUGGESTED,
+	INFO_DIR_RENAME_APPLIED,
+
+	/* Special directory rename cases */
+	INFO_DIR_RENAME_SKIPPED_DUE_TO_RERENAME,
+	CONFLICT_DIR_RENAME_FILE_IN_WAY,
+	CONFLICT_DIR_RENAME_COLLISION,
+	CONFLICT_DIR_RENAME_SPLIT,
+
+	/* Basic submodule */
+	INFO_SUBMODULE_FAST_FORWARDING,
+	CONFLICT_SUBMODULE_FAILED_TO_MERGE,
+
+	/* Special submodule cases broken out from FAILED_TO_MERGE */
+	CONFLICT_SUBMODULE_FAILED_TO_MERGE_BUT_POSSIBLE_RESOLUTION,
+	CONFLICT_SUBMODULE_NOT_INITIALIZED,
+	CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE,
+	CONFLICT_SUBMODULE_MAY_HAVE_REWINDS,
+
+	/* Keep this entry _last_ in the list */
+	NB_CONFLICT_TYPES,
+};
+
+/*
+ * Short description of conflict type, relied upon by external tools.
+ *
+ * We can add more entries, but DO NOT change any of these strings.  Also,
+ * Order MUST match conflict_info_and_types.
+ */
+static const char *type_short_descriptions[] = {
+	/*** "Simple" conflicts and informational messages ***/
+	[INFO_AUTO_MERGING] = "Auto-merging",
+	[CONFLICT_CONTENTS] = "CONFLICT (contents)",
+	[CONFLICT_BINARY] = "CONFLICT (binary)",
+	[CONFLICT_FILE_DIRECTORY] = "CONFLICT (file/directory)",
+	[CONFLICT_DISTINCT_MODES] = "CONFLICT (distinct modes)",
+	[CONFLICT_MODIFY_DELETE] = "CONFLICT (modify/delete)",
+	[CONFLICT_PRESENT_DESPITE_SKIPPED] =
+		"CONFLICT (upgrade your version of git)",
+
+	/*** Regular rename ***/
+	[CONFLICT_RENAME_RENAME] = "CONFLICT (rename/rename)",
+	[CONFLICT_RENAME_COLLIDES] = "CONFLICT (rename involved in collision)",
+	[CONFLICT_RENAME_DELETE] = "CONFLICT (rename/delete)",
+
+	/*** Basic directory rename ***/
+	[CONFLICT_DIR_RENAME_SUGGESTED] =
+		"CONFLICT (directory rename suggested)",
+	[INFO_DIR_RENAME_APPLIED] = "Path updated due to directory rename",
+
+	/*** Special directory rename cases ***/
+	[INFO_DIR_RENAME_SKIPPED_DUE_TO_RERENAME] =
+		"Directory rename skipped since directory was renamed on both sides",
+	[CONFLICT_DIR_RENAME_FILE_IN_WAY] =
+		"CONFLICT (file in way of directory rename)",
+	[CONFLICT_DIR_RENAME_COLLISION] = "CONFLICT(directory rename collision)",
+	[CONFLICT_DIR_RENAME_SPLIT] = "CONFLICT(directory rename unclear split)",
+
+	/*** Basic submodule ***/
+	[INFO_SUBMODULE_FAST_FORWARDING] = "Fast forwarding submodule",
+	[CONFLICT_SUBMODULE_FAILED_TO_MERGE] = "CONFLICT (submodule)",
+
+	/*** Special submodule cases broken out from FAILED_TO_MERGE ***/
+	[CONFLICT_SUBMODULE_FAILED_TO_MERGE_BUT_POSSIBLE_RESOLUTION] =
+		"CONFLICT (submodule with possible resolution)",
+	[CONFLICT_SUBMODULE_NOT_INITIALIZED] =
+		"CONFLICT (submodule not initialized)",
+	[CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE] =
+		"CONFLICT (submodule history not available)",
+	[CONFLICT_SUBMODULE_MAY_HAVE_REWINDS] =
+		"CONFLICT (submodule may have rewinds)",
+};
+
+struct logical_conflict_info {
+	enum conflict_and_info_types type;
+	struct strvec paths;
+};
+
 /*** Function Grouping: various utility functions ***/
 
 /*
@@ -571,6 +665,11 @@ static void clear_or_reinit_internal_opts(struct merge_options_internal *opti,
 		/* Release and free each strbuf found in output */
 		strmap_for_each_entry(&opti->conflicts, &iter, e) {
 			struct string_list *list = e->value;
+			for (int i = 0; i < list->nr; i++) {
+				struct logical_conflict_info *info =
+					list->items[i].util;
+				strvec_clear(&info->paths);
+			}
 			/*
 			 * While strictly speaking we don't need to
 			 * free(conflicts) here because we could pass
@@ -629,31 +728,56 @@ static void format_commit(struct strbuf *sb,
 	strbuf_addch(sb, '\n');
 }
 
-__attribute__((format (printf, 4, 5)))
+__attribute__((format (printf, 8, 9)))
 static void path_msg(struct merge_options *opt,
-		     const char *path,
+		     enum conflict_and_info_types type,
 		     int omittable_hint, /* skippable under --remerge-diff */
+		     const char *primary_path,
+		     const char *other_path_1, /* may be NULL */
+		     const char *other_path_2, /* may be NULL */
+		     struct string_list *other_paths, /* may be NULL */
 		     const char *fmt, ...)
 {
 	va_list ap;
 	struct string_list *path_conflicts;
+	struct logical_conflict_info *info;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf *dest;
 	struct strbuf tmp = STRBUF_INIT;
 
+	/* Sanity checks */
+	assert(omittable_hint ==
+	       !starts_with(type_short_descriptions[type], "CONFLICT") ||
+	       type == CONFLICT_DIR_RENAME_SUGGESTED ||
+	       type == CONFLICT_PRESENT_DESPITE_SKIPPED);
 	if (opt->record_conflict_msgs_as_headers && omittable_hint)
 		return; /* Do not record mere hints in headers */
 	if (opt->priv->call_depth && opt->verbosity < 5)
 		return; /* Ignore messages from inner merges */
 
 	/* Ensure path_conflicts (ptr to array of logical_conflict) allocated */
-	path_conflicts = strmap_get(&opt->priv->conflicts, path);
+	path_conflicts = strmap_get(&opt->priv->conflicts, primary_path);
 	if (!path_conflicts) {
 		path_conflicts = xmalloc(sizeof(*path_conflicts));
 		string_list_init_dup(path_conflicts);
-		strmap_put(&opt->priv->conflicts, path, path_conflicts);
+		strmap_put(&opt->priv->conflicts, primary_path, path_conflicts);
 	}
 
+	/* Add a logical_conflict at the end to store info from this call */
+	info = xcalloc(1, sizeof(*info));
+	info->type = type;
+	strvec_init(&info->paths);
+
+	/* Handle the list of paths */
+	strvec_push(&info->paths, primary_path);
+	if (other_path_1)
+		strvec_push(&info->paths, other_path_1);
+	if (other_path_2)
+		strvec_push(&info->paths, other_path_2);
+	if (other_paths)
+		for (int i = 0; i < other_paths->nr; i++)
+		strvec_push(&info->paths, other_paths->items[i].string);
+
 	/* Handle message and its format, in normal case */
 	dest = (opt->record_conflict_msgs_as_headers ? &tmp : &buf);
 
@@ -690,7 +814,8 @@ static void path_msg(struct merge_options *opt,
 
 		strbuf_release(&tmp);
 	}
-	string_list_append_nodup(path_conflicts, strbuf_detach(&buf, NULL));
+	string_list_append_nodup(path_conflicts, strbuf_detach(&buf, NULL))
+		->util = info;
 }
 
 static struct diff_filespec *pool_alloc_filespec(struct mem_pool *pool,
@@ -1631,16 +1756,18 @@ static int merge_submodule(struct merge_options *opt,
 		return 0;
 
 	if (repo_submodule_init(&subrepo, opt->repo, path, null_oid())) {
-		path_msg(opt, path, 0,
-				_("Failed to merge submodule %s (not checked out)"),
-				path);
+		path_msg(opt, CONFLICT_SUBMODULE_NOT_INITIALIZED, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s (not checked out)"),
+			 path);
 		return 0;
 	}
 
 	if (!(commit_o = lookup_commit_reference(&subrepo, o)) ||
 	    !(commit_a = lookup_commit_reference(&subrepo, a)) ||
 	    !(commit_b = lookup_commit_reference(&subrepo, b))) {
-		path_msg(opt, path, 0,
+		path_msg(opt, CONFLICT_SUBMODULE_HISTORY_NOT_AVAILABLE, 0,
+			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s (commits not present)"),
 			 path);
 		goto cleanup;
@@ -1649,7 +1776,8 @@ static int merge_submodule(struct merge_options *opt,
 	/* check whether both changes are forward */
 	if (!repo_in_merge_bases(&subrepo, commit_o, commit_a) ||
 	    !repo_in_merge_bases(&subrepo, commit_o, commit_b)) {
-		path_msg(opt, path, 0,
+		path_msg(opt, CONFLICT_SUBMODULE_MAY_HAVE_REWINDS, 0,
+			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s "
 			   "(commits don't follow merge-base)"),
 			 path);
@@ -1659,7 +1787,8 @@ static int merge_submodule(struct merge_options *opt,
 	/* Case #1: a is contained in b or vice versa */
 	if (repo_in_merge_bases(&subrepo, commit_a, commit_b)) {
 		oidcpy(result, b);
-		path_msg(opt, path, 1,
+		path_msg(opt, INFO_SUBMODULE_FAST_FORWARDING, 1,
+			 path, NULL, NULL, NULL,
 			 _("Note: Fast-forwarding submodule %s to %s"),
 			 path, oid_to_hex(b));
 		ret = 1;
@@ -1667,7 +1796,8 @@ static int merge_submodule(struct merge_options *opt,
 	}
 	if (repo_in_merge_bases(&subrepo, commit_b, commit_a)) {
 		oidcpy(result, a);
-		path_msg(opt, path, 1,
+		path_msg(opt, INFO_SUBMODULE_FAST_FORWARDING, 1,
+			 path, NULL, NULL, NULL,
 			 _("Note: Fast-forwarding submodule %s to %s"),
 			 path, oid_to_hex(a));
 		ret = 1;
@@ -1690,13 +1820,16 @@ static int merge_submodule(struct merge_options *opt,
 					 &merges);
 	switch (parent_count) {
 	case 0:
-		path_msg(opt, path, 0, _("Failed to merge submodule %s"), path);
+		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE, 0,
+			 path, NULL, NULL, NULL,
+			 _("Failed to merge submodule %s"), path);
 		break;
 
 	case 1:
 		format_commit(&sb, 4, &subrepo,
 			      (struct commit *)merges.objects[0].item);
-		path_msg(opt, path, 0,
+		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE_BUT_POSSIBLE_RESOLUTION, 0,
+			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s, but a possible merge "
 			   "resolution exists: %s"),
 			 path, sb.buf);
@@ -1706,7 +1839,8 @@ static int merge_submodule(struct merge_options *opt,
 		for (i = 0; i < merges.nr; i++)
 			format_commit(&sb, 4, &subrepo,
 				      (struct commit *)merges.objects[i].item);
-		path_msg(opt, path, 0,
+		path_msg(opt, CONFLICT_SUBMODULE_FAILED_TO_MERGE_BUT_POSSIBLE_RESOLUTION, 0,
+			 path, NULL, NULL, NULL,
 			 _("Failed to merge submodule %s, but multiple "
 			   "possible merges exist:\n%s"), path, sb.buf);
 		strbuf_release(&sb);
@@ -1832,7 +1966,8 @@ static int merge_3way(struct merge_options *opt,
 				&src1, name1, &src2, name2,
 				&opt->priv->attr_index, &ll_opts);
 	if (merge_status == LL_MERGE_BINARY_CONFLICT)
-		path_msg(opt, path, 0,
+		path_msg(opt, CONFLICT_BINARY, 0,
+			 path, NULL, NULL, NULL,
 			 "warning: Cannot merge binary files: %s (%s vs. %s)",
 			 path, name1, name2);
 
@@ -1944,7 +2079,8 @@ static int handle_content_merge(struct merge_options *opt,
 		if (ret)
 			return -1;
 		clean &= (merge_status == 0);
-		path_msg(opt, path, 1, _("Auto-merging %s"), path);
+		path_msg(opt, INFO_AUTO_MERGING, 1, path, NULL, NULL, NULL,
+			 _("Auto-merging %s"), path);
 	} else if (S_ISGITLINK(a->mode)) {
 		int two_way = ((S_IFMT & o->mode) != (S_IFMT & a->mode));
 		clean = merge_submodule(opt, pathnames[0],
@@ -2082,21 +2218,24 @@ static char *handle_path_level_conflicts(struct merge_options *opt,
 		c_info->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &c_info->source_files);
-		path_msg(opt, new_path, 0,
-			 _("CONFLICT (implicit dir rename): Existing file/dir "
-			   "at %s in the way of implicit directory rename(s) "
-			   "putting the following path(s) there: %s."),
-		       new_path, collision_paths.buf);
+		path_msg(opt, CONFLICT_DIR_RENAME_FILE_IN_WAY, 0,
+			 new_path, NULL, NULL, &c_info->source_files,
+			 _("CONFLICT (implicit dir rename): Existing "
+			   "file/dir at %s in the way of implicit "
+			   "directory rename(s) putting the following "
+			   "path(s) there: %s."),
+			 new_path, collision_paths.buf);
 		clean = 0;
 	} else if (c_info->source_files.nr > 1) {
 		c_info->reported_already = 1;
 		strbuf_add_separated_string_list(&collision_paths, ", ",
 						 &c_info->source_files);
-		path_msg(opt, new_path, 0,
-			 _("CONFLICT (implicit dir rename): Cannot map more "
-			   "than one path to %s; implicit directory renames "
-			   "tried to put these paths there: %s"),
-		       new_path, collision_paths.buf);
+		path_msg(opt, CONFLICT_DIR_RENAME_COLLISION, 0,
+			 new_path, NULL, NULL, &c_info->source_files,
+			 _("CONFLICT (implicit dir rename): Cannot map "
+			   "more than one path to %s; implicit directory "
+			   "renames tried to put these paths there: %s"),
+			 new_path, collision_paths.buf);
 		clean = 0;
 	}
 
@@ -2150,13 +2289,14 @@ static void get_provisional_directory_renames(struct merge_options *opt,
 			continue;
 
 		if (bad_max == max) {
-			path_msg(opt, source_dir, 0,
-			       _("CONFLICT (directory rename split): "
-				 "Unclear where to rename %s to; it was "
-				 "renamed to multiple other directories, with "
-				 "no destination getting a majority of the "
-				 "files."),
-			       source_dir);
+			path_msg(opt, CONFLICT_DIR_RENAME_SPLIT, 0,
+				 source_dir, NULL, NULL, NULL,
+				 _("CONFLICT (directory rename split): "
+				   "Unclear where to rename %s to; it was "
+				   "renamed to multiple other directories, "
+				   "with no destination getting a majority of "
+				   "the files."),
+				 source_dir);
 			*clean = 0;
 		} else {
 			strmap_put(&renames->dir_renames[side],
@@ -2304,7 +2444,8 @@ static char *check_for_directory_rename(struct merge_options *opt,
 	 */
 	otherinfo = strmap_get_entry(dir_rename_exclusions, new_dir);
 	if (otherinfo) {
-		path_msg(opt, rename_info->key, 1,
+		path_msg(opt, INFO_DIR_RENAME_SKIPPED_DUE_TO_RERENAME, 1,
+			 rename_info->key, path, new_dir, NULL,
 			 _("WARNING: Avoiding applying %s -> %s rename "
 			   "to %s, because %s itself was renamed."),
 			 rename_info->key, new_dir, path, new_dir);
@@ -2444,14 +2585,16 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 	if (opt->detect_directory_renames == MERGE_DIRECTORY_RENAMES_TRUE) {
 		/* Notify user of updated path */
 		if (pair->status == 'A')
-			path_msg(opt, new_path, 1,
+			path_msg(opt, INFO_DIR_RENAME_APPLIED, 1,
+				 new_path, old_path, NULL, NULL,
 				 _("Path updated: %s added in %s inside a "
 				   "directory that was renamed in %s; moving "
 				   "it to %s."),
 				 old_path, branch_with_new_path,
 				 branch_with_dir_rename, new_path);
 		else
-			path_msg(opt, new_path, 1,
+			path_msg(opt, INFO_DIR_RENAME_APPLIED, 1,
+				 new_path, old_path, NULL, NULL,
 				 _("Path updated: %s renamed to %s in %s, "
 				   "inside a directory that was renamed in %s; "
 				   "moving it to %s."),
@@ -2464,7 +2607,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 		 */
 		ci->path_conflict = 1;
 		if (pair->status == 'A')
-			path_msg(opt, new_path, 1,
+			path_msg(opt, CONFLICT_DIR_RENAME_SUGGESTED, 1,
+				 new_path, old_path, NULL, NULL,
 				 _("CONFLICT (file location): %s added in %s "
 				   "inside a directory that was renamed in %s, "
 				   "suggesting it should perhaps be moved to "
@@ -2472,7 +2616,8 @@ static void apply_directory_rename_modifications(struct merge_options *opt,
 				 old_path, branch_with_new_path,
 				 branch_with_dir_rename, new_path);
 		else
-			path_msg(opt, new_path, 1,
+			path_msg(opt, CONFLICT_DIR_RENAME_SUGGESTED, 1,
+				 new_path, old_path, NULL, NULL,
 				 _("CONFLICT (file location): %s renamed to %s "
 				   "in %s, inside a directory that was renamed "
 				   "in %s, suggesting it should perhaps be "
@@ -2628,7 +2773,8 @@ static int process_renames(struct merge_options *opt,
 			 * and remove the setting of base->path_conflict to 1.
 			 */
 			base->path_conflict = 1;
-			path_msg(opt, oldpath, 0,
+			path_msg(opt, CONFLICT_RENAME_RENAME, 0,
+				 pathnames[0], pathnames[1], pathnames[2], NULL,
 				 _("CONFLICT (rename/rename): %s renamed to "
 				   "%s in %s and to %s in %s."),
 				 pathnames[0],
@@ -2723,7 +2869,8 @@ static int process_renames(struct merge_options *opt,
 			memcpy(&newinfo->stages[target_index], &merged,
 			       sizeof(merged));
 			if (!clean) {
-				path_msg(opt, newpath, 0,
+				path_msg(opt, CONFLICT_RENAME_COLLIDES, 0,
+					 newpath, oldpath, NULL, NULL,
 					 _("CONFLICT (rename involved in "
 					   "collision): rename of %s -> %s has "
 					   "content conflicts AND collides "
@@ -2742,7 +2889,8 @@ static int process_renames(struct merge_options *opt,
 			 */
 
 			newinfo->path_conflict = 1;
-			path_msg(opt, newpath, 0,
+			path_msg(opt, CONFLICT_RENAME_DELETE, 0,
+				 newpath, oldpath, NULL, NULL,
 				 _("CONFLICT (rename/delete): %s renamed "
 				   "to %s in %s, but deleted in %s."),
 				 oldpath, newpath, rename_branch, delete_branch);
@@ -2766,7 +2914,8 @@ static int process_renames(struct merge_options *opt,
 			} else if (source_deleted) {
 				/* rename/delete */
 				newinfo->path_conflict = 1;
-				path_msg(opt, newpath, 0,
+				path_msg(opt, CONFLICT_RENAME_DELETE, 0,
+					 newpath, oldpath, NULL, NULL,
 					 _("CONFLICT (rename/delete): %s renamed"
 					   " to %s in %s, but deleted in %s."),
 					 oldpath, newpath,
@@ -3687,7 +3836,8 @@ static void process_entry(struct merge_options *opt,
 		path = unique_path(opt, path, branch);
 		strmap_put(&opt->priv->paths, path, new_ci);
 
-		path_msg(opt, path, 0,
+		path_msg(opt, CONFLICT_FILE_DIRECTORY, 0,
+			 path, old_path, NULL, NULL,
 			 _("CONFLICT (file/directory): directory in the way "
 			   "of %s from %s; moving it to %s instead."),
 			 old_path, branch, path);
@@ -3763,15 +3913,23 @@ static void process_entry(struct merge_options *opt,
 				rename_b = 1;
 			}
 
+			if (rename_a)
+				a_path = unique_path(opt, path, opt->branch1);
+			if (rename_b)
+				b_path = unique_path(opt, path, opt->branch2);
+
 			if (rename_a && rename_b) {
-				path_msg(opt, path, 0,
+				path_msg(opt, CONFLICT_DISTINCT_MODES, 0,
+					 path, a_path, b_path, NULL,
 					 _("CONFLICT (distinct types): %s had "
 					   "different types on each side; "
 					   "renamed both of them so each can "
 					   "be recorded somewhere."),
 					 path);
 			} else {
-				path_msg(opt, path, 0,
+				path_msg(opt, CONFLICT_DISTINCT_MODES, 0,
+					 path, rename_a ? a_path : b_path,
+					 NULL, NULL,
 					 _("CONFLICT (distinct types): %s had "
 					   "different types on each side; "
 					   "renamed one of them so each can be "
@@ -3808,14 +3966,10 @@ static void process_entry(struct merge_options *opt,
 
 			/* Insert entries into opt->priv_paths */
 			assert(rename_a || rename_b);
-			if (rename_a) {
-				a_path = unique_path(opt, path, opt->branch1);
+			if (rename_a)
 				strmap_put(&opt->priv->paths, a_path, ci);
-			}
 
-			if (rename_b)
-				b_path = unique_path(opt, path, opt->branch2);
-			else
+			if (!rename_b)
 				b_path = path;
 			strmap_put(&opt->priv->paths, b_path, new_ci);
 
@@ -3866,7 +4020,8 @@ static void process_entry(struct merge_options *opt,
 				reason = _("add/add");
 			if (S_ISGITLINK(merged_file.mode))
 				reason = _("submodule");
-			path_msg(opt, path, 0,
+			path_msg(opt, CONFLICT_CONTENTS, 0,
+				 path, NULL, NULL, NULL,
 				 _("CONFLICT (%s): Merge conflict in %s"),
 				 reason, path);
 		}
@@ -3910,7 +4065,8 @@ static void process_entry(struct merge_options *opt,
 			 * since the contents were not modified.
 			 */
 		} else {
-			path_msg(opt, path, 0,
+			path_msg(opt, CONFLICT_MODIFY_DELETE, 0,
+				 path, NULL, NULL, NULL,
 				 _("CONFLICT (modify/delete): %s deleted in %s "
 				   "and modified in %s.  Version %s of %s left "
 				   "in tree."),
@@ -4206,7 +4362,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 								     path,
 								     "cruft");
 
-					path_msg(opt, path, 1,
+					path_msg(opt, CONFLICT_PRESENT_DESPITE_SKIPPED, 1,
+						 path, NULL, NULL, NULL,
 						 _("Note: %s not up to date and in way of checking out conflicted version; old copy renamed to %s"),
 						 path, new_name);
 					errs |= rename(path, new_name);
-- 
gitgitgadget

