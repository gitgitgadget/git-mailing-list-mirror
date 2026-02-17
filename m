Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58927F18F
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349459; cv=none; b=XsNekWg+syDe/h7KTxY0JPbcur9bZ7Z7ndnJzqnwkUK0MgqEmptf84SacMf+rdSzVnrQcct/4CUTYgQfSRBdZxISWeCFELEyabZpc19QConjAKwzOLeNs0TQ+71M3/n0bI9K7hWjCAGVmbNJy10qiJ3cJ2LijoBl0dDI1GP/68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349459; c=relaxed/simple;
	bh=3nDP8H6qOiH/94T4Ii57dF604XwdVEDd2Ja9D0vj7Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ya+LK5B+0Db3ATPyM8u8ZB7J5gNzXwkbCnw/g5XMTeH9G9WWMunaZfaaju0KaY7Xry8cGR5eO1Pe9hGOL45W6n/zBQwWKCUGPOGeIx9pVnEKUTReGlPEoRtoCTZrd/4QbhhDcK7dWm4S2gVx8ylGrOU7jRKNmlDJjSWB/xbLdLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dmRFsAA8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dmRFsAA8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-354c6619a07so1790257a91.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771349457; x=1771954257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3ltpCbKGIUml+gkxShJviq+V9R94KVl8VMLBBkg7Xs=;
        b=dmRFsAA8roKucTogT/S/xN3rqtBXZqDW8ncPOZWYmC3c1r1lCPn7UxQ7H2/oPRCA5f
         gzQKmSZUO3fE7R+wBmzbaptDJwb3wcGXvEUKcYmTtQ5pfb3a//g/EWpXJeQ3AMryrXHP
         +XQv1mndMbFzxOMoiDJJLFDlf3eInbjOn4+HHtHPBC63BFQrrINUYbBxckicUvRBH9dv
         ixcrefiseNElSYAPjsp+tZVInRzwHCFZXvovj4lWx91tNjQ55OwO4pUBYifFMgNpGnEO
         REwFs34BeeB/H1XqNr9wekBKDz0Y9t956VuzYa2WDRFqJ2Dc0Y7Bkc2c5QW2ycGOq1RO
         EbUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771349457; x=1771954257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3ltpCbKGIUml+gkxShJviq+V9R94KVl8VMLBBkg7Xs=;
        b=nwVIAM8DAT3Bx5m8OO6jfklmpdFC7jbZ174dwhN31T/ZH5cRx4EZ0qfqQUxv7h+Lvh
         62bXLp2YZj+HE5O75yZ6VsYB1S8JIFbAg7DjTiJnjf5+ISbKmjAv58Ke62+J1OT8WlyE
         VIK+Eu48ODa45OAyExE68t9+fo+83y64XN0nbR8JtldKCqcJAfGwlFBPtmw76q9w/2Nv
         AIgOoyXQe8WrWPOmyZGs78I9faaUJ5WY/CWbPtM5jqxPJT7BzuAJSa2374bAgM1LHj9W
         VgvhYaa17JEy/Mrnn7Q3ELshWteKTwWvbNNdgxmtaXQlUkb1z6vGEYqPscYwcuMzRSuw
         1O/A==
X-Gm-Message-State: AOJu0YzcVUTR79x79UFFo2QmpvRXRTuRTUJ+CuGCoi1iL+sv932555VR
	8w+SM1ifojU2zSJHo4ayCAP2uiogFOSvkIaCgetqZRSQ70J/P06qjXHQGw13RWzQIi8=
X-Gm-Gg: AZuq6aL1dFVY6QIqxH7TRE1dAKwFgG7oCZVOG6UGA7GkFONbX6qmB8P9CXfg2xJy3oX
	zMbS805ftY++7TQZortdWf3fCTWqmZkzfN7K1uVrFIT0GfJlpgwiVI256SMxF/tRo4/Jm/gSmHm
	vHlylmzt5/36WRDh+0ZAfqp3seuSTPNNQasjPI2i4rCczvCx3C87fYajTvMn0HC4+uFvplnpxI9
	LtUOZuVoYGA1bLiaTwwFcyQ8RupdhPAyTkGZJ1L5EoD11Rm/dZ2zAHfeDpxrV1XJSYXd54Fw4nh
	OT5Ypjrx0mAOYP37E5RO8OH9U5I289QOX4r3f+QmhrE1qAnmmY+bDGGfrHt61OU9IRq8WBFKyM1
	SC2bPtF4I1NlhKC3chObk61sVFh657Yn7YxHYgA0+PW7/IUn0/i82q2NlmrCLZnaSqWfMjYQjkQ
	cQqxilswNdcEgnsFfHfyGNSOMUXW6LATXM+pN39B5eRN3BNiuCSyU+zhi11w==
X-Received: by 2002:a17:90b:1cc6:b0:352:c9c9:75b8 with SMTP id 98e67ed59e1d1-356aadbee66mr12302310a91.36.1771349457156;
        Tue, 17 Feb 2026 09:30:57 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:a392:d36:fa44:db83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f8cd1esm24135222a91.15.2026.02.17.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 09:30:56 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 2/3] wt-status: replace uses of the_repository with local repository instances
Date: Tue, 17 Feb 2026 22:59:47 +0530
Message-ID: <20260217173037.63438-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260217173037.63438-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wt-status.c uses the global the_repository in several places even when
a repository instance is already available via struct wt_status *s or
struct repository *r.

Replace these uses of the_repository with the repository available
in the local context (i.e. s->repo or r).

The replacements of all the_repository with s->repo are mostly
to cases where a repository instance is already available via
struct wt_status *s and struct repository *r, all functions operating on
struct wt_status *s are only used after s is initialized by wt_status_prepare(),
which sets s->repo from the repository provided by the caller.
As a result, s->repo is guaranteed to be available and consistent whenever
these functions are invoked.

This reduces reliance on global state and keeps wt-status consistent,
though many functions operating on struct wt_status *s
are called via commit.c and it still relies on the_repository,
but within wt-status.c the local repository pointer
refers to the same underlying repository object.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 wt-status.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index e10565f495..b44b8377e5 100644
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
@@ -987,7 +987,7 @@ static int stash_count_refs(const char *refname UNUSED,
 static int count_stash_entries(struct repository *r)
 {
 	int n = 0;
-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+	refs_for_each_reflog_ent(get_main_ref_store(r),
 				 "refs/stash", stash_count_refs, &n);
 	return n;
 }
@@ -1146,7 +1146,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
-	opt.def = s->is_initial ? empty_tree_oid_hex(the_repository->hash_algo) : s->reference;
+	opt.def = s->is_initial ? empty_tree_oid_hex(s->repo->hash_algo) : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
@@ -1290,7 +1290,7 @@ static void show_am_in_progress(struct wt_status *s,
 static char *read_line_from_git_path(struct repository *r, const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
 						      "%s", filename), "r");
 
 	if (!fp) {
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
@@ -1362,7 +1362,7 @@ static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 		return;
 
 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
+	    !repo_get_oid(r, split.items[1].string, &oid)) {
 		strbuf_reset(line);
 		strbuf_addf(line, "%s ", split.items[0].string);
 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
@@ -1375,7 +1375,7 @@ static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
 static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
 	int ret;
 
 	if (!f) {
@@ -1384,7 +1384,7 @@ static int read_rebase_todolist(struct repository *r, const char *fname, struct
 			goto out;
 		}
 		die_errno("Could not open file %s for reading",
-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
+			  repo_git_path_replace(r, &buf, "%s", fname));
 	}
 	while (!strbuf_getline_lf(&buf, f)) {
 		if (starts_with(buf.buf, comment_line_str))
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
