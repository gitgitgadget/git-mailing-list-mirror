Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF313446AB
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437442; cv=none; b=HSUUZqu6YYhI2v/drVosJv+sJa4mYV1NZ56gBwMDhn6pS+gVXJhGu3s+q8lA//WHZe12yopZR9/+m5nLmAVOp6qlkB6jgS8/w5JgYHzIPLW/DeKYbCnabap7sMDG5KLGWwXhQjQu1+56PJmlm1LymyAzRT5FMRzpQX+BARPq7E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437442; c=relaxed/simple;
	bh=MXMUeoqybivQmVlg0UR3iO1iwJhNvxcoMin0gxw+tmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDL7ZMMrnJmhq1x+sy9aEMEqsPoHRCx2L3QtNJr88qZunLK0qBqyKTfm7j0KSknaV6WvV3FDpLP7VQgQsknWjAsQPxKqmwfqC9EH16XXmZ019and9lQ+VFngEhkYZyYT1aeCdBwLOLDfWdnjkn1lxkCnAmEAtKujouxq60DmalA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGhvATg8; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGhvATg8"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8230c33f477so19327b3a.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771437441; x=1772042241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9KCWLqwGvcZYum7eXJBlQ0oDT/j/dg8Y6pDYGgmw6s=;
        b=nGhvATg8kBJ2fI+KWAMe0AODbjZVk5TBVVERSEfWPlc6qFXJoV4w0aPgWq+u26ZIaX
         2LMh4JgKox5SgBXyUEhC6Cg6DUIxMztQLM+8MREtGU+BjhImphNGvwUJZVmYJOvIkKm8
         Ji/f6INW/ZP6ZFr72YyrFkeAAJKr1PXq2gqDdZTTDb8yoNl/FrSzL5Ar/zeE10UsVp6a
         eynnajYxlv6MwuUm/VzaVUD8qNp2gq1dkR0OPNOFQZqTmJuZ2FYu8C/mMPhr+FmxVD8m
         YPTqjRvjBz1pUL+yH0wZzxj73zUFi8qzwZiZXPYPH+gW5a4O/jP9yxTgq+lS7aaoCwpi
         /NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437441; x=1772042241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/9KCWLqwGvcZYum7eXJBlQ0oDT/j/dg8Y6pDYGgmw6s=;
        b=v+/SendG6+cDmO+zw0TEiYbIKSqnpQkVNnVU7XHL7ydfSXVHyH71brrzMegU1Sa/3y
         JOI1liSkCNlwKw5HJyk4GCvd1/OaPp9TbkTVxdLL0J2MO4SBE8SEK4z2NnPu2niyUzkY
         5ZXM1TZvcM3BUFuwFQpJRJo75lbvPPiJeWEllQTKmRY4qybGG2f/YmcwtkcS9hL1y/8i
         2vdw4NVqqpKNtwuejJ5wigquI0THBbJHZwxnzxvt3VkmybLaecP3yFUr++OAEEKOxPud
         ymL5CT8+ZMlnUg1NfY5jhy1iDsolMdSAGr3QBqZEGm2nPxU08xW+zEmnITLBn+hsBjds
         59lA==
X-Gm-Message-State: AOJu0Yz4ZnHaJrMhbu3J13mjy7uYmhKgN0vYqXMbHqpCOCJlCRgG/VXA
	gDTrqx1/agLnB4M3OHONhqY3/L3W9Br9GSTyPLNNKmx/DV4qR6PtQpExu1iApQ==
X-Gm-Gg: AZuq6aKcL52n9Yt0BIaPZllT40YRbnn15WU+wtgDrTgJVRTZlU0lubQJ4yYapLqkBIH
	eFm0GKw0VY4VpzqGVYAcVlYJf+0jHawGEIHDleCHI0e524ciTkuZH3MVjrsjokzQrqUCbzKKCzI
	mdB5hZlDyiBHhRZxeBfCkedNA24rhVMf06q5NiQyMbmpC5KSlLEtqd1zrrmrdxG2tqCkLnMBHFH
	T4+6DLQ1i+nYdBAnCyFRJCmYbqe0EWJhMg4cs2O5ViTdL+xRAKyURVpRB6C4PVLWMpKGXxhUJ/v
	R/vJldglGjpWFbtExchBDj6vqK2GP1xfBN9MI/EFQx0ChtVoZfzAIvd1m4KirN6ktzaa/J6z5Lt
	dKDY527ueeIWqtMtKDX6lGM52+8XCCVpzRni0FVUb/my6cinfqMuTlef4SEoIGDUNWAZSdiTrCf
	EciEHvalfkwoOAwfRv8fxwWYNDQXc/P+p9ur02+20dh8lfyZRZIaadzmkY+w==
X-Received: by 2002:a05:6300:189:b0:384:d09f:f610 with SMTP id adf61e73a8af0-394fc23620amr2262032637.32.1771437440715;
        Wed, 18 Feb 2026 09:57:20 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:181:cb2d:52e8:2ca0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e531e6c51sm13440957a12.16.2026.02.18.09.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:57:20 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 2/3] wt-status: replace uses of the_repository with local repository instances
Date: Wed, 18 Feb 2026 23:23:41 +0530
Message-ID: <20260218175654.66004-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c uses the global the_repository in several places even when a
repository instance is already available via struct wt_status *s or struct
repository *r.

Replace these uses of the_repository with the repository available in the
local context (i.e. s->repo or r).

The replacements of all the_repository with s->repo are mostly to cases
where a repository instance is already available via struct wt_status *s
and struct repository *r, all functions operating on struct wt_status *s
are only used after s is initialized by wt_status_prepare(), which sets
s->repo from the repository provided by the caller. As a result, s->repo is
guaranteed to be available and consistent whenever these functions are
invoked.

This reduces reliance on global state and keeps wt-status consistent,
though many functions operating on struct wt_status *s are called via
commit.c and it still relies on the_repository, but within wt-status.c the
local repository pointer refers to the same underlying repository object.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 97c2e10a8c..b44b8377e5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
 	s->use_color = GIT_COLOR_UNKNOWN;
 	s->relative_paths = 1;
-	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
+	s->branch = refs_resolve_refdup(get_main_ref_store(r),
 					"HEAD", 0, NULL, NULL);
 	s->reference = "HEAD";
 	s->fp = stdout;
-	s->index_file = repo_get_index_file(the_repository);
+	s->index_file = repo_get_index_file(r);
 	s->change.strdup_strings = 1;
 	s->untracked.strdup_strings = 1;
 	s->ignored.strdup_strings = 1;
@@ -646,7 +646,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 
 	repo_init_revisions(s->repo, &rev, NULL);
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.flags.override_submodule_config = 1;
@@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
@@ -1317,9 +1317,9 @@ static int split_commit_in_progress(struct wt_status *s)
 	    !s->branch || strcmp(s->branch, "HEAD"))
 		return 0;
 
-	if (refs_read_ref_full(get_main_ref_store(the_repository), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+	if (refs_read_ref_full(get_main_ref_store(s->repo), "HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			       &head_oid, &head_flags) ||
-	    refs_read_ref_full(get_main_ref_store(the_repository), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+	    refs_read_ref_full(get_main_ref_store(s->repo), "ORIG_HEAD", RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
 			       &orig_head_oid, &orig_head_flags))
 		return 0;
 	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
@@ -1432,7 +1432,7 @@ static void show_rebase_information(struct wt_status *s,
 				i++)
 				status_printf_ln(s, color, "   %s", have_done.items[i].string);
 			if (have_done.nr > nr_lines_to_show && s->hints) {
-				char *path = repo_git_path(the_repository, "rebase-merge/done");
+				char *path = repo_git_path(s->repo, "rebase-merge/done");
 				status_printf_ln(s, color,
 					_("  (see more in file %s)"), path);
 				free(path);
@@ -1534,7 +1534,7 @@ static void show_cherry_pick_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 			_("You are currently cherry-picking commit %s."),
-			repo_find_unique_abbrev(the_repository, &s->state.cherry_pick_head_oid,
+			repo_find_unique_abbrev(s->repo, &s->state.cherry_pick_head_oid,
 						DEFAULT_ABBREV));
 
 	if (s->hints) {
@@ -1564,7 +1564,7 @@ static void show_revert_in_progress(struct wt_status *s,
 	else
 		status_printf_ln(s, color,
 			_("You are currently reverting commit %s."),
-			repo_find_unique_abbrev(the_repository, &s->state.revert_head_oid,
+			repo_find_unique_abbrev(s->repo, &s->state.revert_head_oid,
 						DEFAULT_ABBREV));
 	if (s->hints) {
 		if (has_unmerged(s))
@@ -1691,7 +1691,7 @@ static void wt_status_get_detached_from(struct repository *r,
 	char *ref = NULL;
 
 	strbuf_init(&cb.buf, 0);
-	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(the_repository), "HEAD", grab_1st_switch, &cb) <= 0) {
+	if (refs_for_each_reflog_ent_reverse(get_main_ref_store(r), "HEAD", grab_1st_switch, &cb) <= 0) {
 		strbuf_release(&cb.buf);
 		return;
 	}
@@ -2099,7 +2099,7 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
 		upstream_is_gone = 1;
 	}
 
-	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+	short_base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
 						  base, 0);
 	color_fprintf(s->fp, header_color, "...");
 	color_fprintf(s->fp, branch_color_remote, "%s", short_base);
@@ -2233,7 +2233,7 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
 		ab_info = stat_tracking_info(branch, &nr_ahead, &nr_behind,
 					     &base, 0, s->ahead_behind_flags);
 		if (base) {
-			base = refs_shorten_unambiguous_ref(get_main_ref_store(the_repository),
+			base = refs_shorten_unambiguous_ref(get_main_ref_store(s->repo),
 							    base, 0);
 			fprintf(s->fp, "# branch.upstream %s%c", base, eol);
 			free((char *)base);
-- 
2.53.0

