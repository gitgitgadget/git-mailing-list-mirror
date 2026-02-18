Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EC238C29
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437430; cv=none; b=A8b8G3him8xAdiaYH0mqgaRO/GbNknLNE21/7g5hsqZ+j+SXr2t9338+Eu13XFuPid1FA4swb1OKSJGGYYXiDuUniLp0R1zEpnyU99+ymnG/P7meCIa6WJTrUnOF7/7HaGQKuUWRMb2ouLfT4n8J9Hm9eKg8Vc+ecs37Fjbspj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437430; c=relaxed/simple;
	bh=6hJL3sHt852IY6qYtvevye+YKO/dmb8cyoKyTSgU/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sH7e7u64VXJhhlObRvbDvBq6ncFbOtZE47kB0rBA2Ai1+P1R9CjEWwSTUYiODMCwkXucju5P3yMG5VUJsi+zl2tKFWuPNcPx9rzzLLyiZE298y0YY+aK9125P695Cp8kFjt0yaxHelHDzx+ZWOGPApKaTQi9YWBlOv3xaRzeSW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhzuQVKO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhzuQVKO"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-824abe734afso42613b3a.0
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771437429; x=1772042229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78Wx8HXdZp8aUsPmGWlqekxbJICsA0weo0LXa39LwGA=;
        b=DhzuQVKOqpPVDHgamBq/7lMFPOaMazg3Utvj2MslKUBIzX/nK2I/7teDHdlHfB5T03
         IwxVEHyEIhhNVSOgIbLAt8OPHYiiO+0YsvW5qToq2QT3aKFdGLdAt3iZ9K+Ys+t0tgSI
         7PKSmO+IsIk3pjYJheRX5SLVq96nHf3Veqmd4K5DTjX4yY2immbBHYbD4pRHYIcHrMII
         7GhE7SthZVHzxrif0TrG5LnH2Tc/P0IKvVKEgAes6X0ajKRJqSctNxqK4iYO0JD5XI+p
         yLKGVsD7gkNyIScQ3CJST3dWKxGIFFhUSpPCnYgahAmGZUOXU127dDLyc2M5p6e4cKrR
         ptyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771437429; x=1772042229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78Wx8HXdZp8aUsPmGWlqekxbJICsA0weo0LXa39LwGA=;
        b=EYCvi6ynklhHHDYvguSyeydmmSWoKuAIvw/ppux6m8TttNnggsLHauBXk7RzjKDCuA
         +4kyie9iIIa1ZWFfBl8Kiggz4qIrD4rlcIJC8oGjJ3yVGdJOCgbJPnBqxGni1N13Sx9T
         jA4rPpXZ7W4yiGwmB5VFrzXT26xxph6xK2m6QgdSluSzpJpcNA48Vrr4TUtFFyUVPSMH
         W30fjULBkg+cMZX6BC1AdVWJUBeOQ1Y4LnvGJ7EQsOKgK2wU80fXqHe4ny7cCs1ro3Y0
         cvM40iYMo2P3OAQPhEacIIJNBkQ5hkmmeDCZ1AeUXZNv1tU6cUc9kADYPqFrnPYuHkoM
         EAAA==
X-Gm-Message-State: AOJu0YxJzffY44hW5SDhzhm63G8KlbmWIFE8skNMCCxgvzuDQHO3DCU6
	go0qIC7UWjsPFqPcKL5NQQnK01a3mEN2N0h9N9CELpV7IkzXBC5lJdLNlrJMZQ==
X-Gm-Gg: AZuq6aJqT1/J6K5oMzi1dp7VJwdterhx99PZknyaN2ouz6ydUUrZoB1cd0Eha/As/nv
	LQ3PATzB+7x+DBCisZOYHU11l4ckYjoySjdrlOpl9EOLUNcLgjuAU9FoOGUYQmorIQaQEFI6qnR
	lEZr57Kn9skdeE9s0LCKWqLhJGk81e2umu2i0AGR7qaluKxIQr/HQfY+Zfq2bYCB7mxnJTEF+iw
	jedMA4zij/0bLOuibDId7uwV84XHMZV9UYPFBBT726RYUkIQTZ3GeYn+WpqLk3KjvurgyOVlbuy
	zDk9MwMqTAlZJ2asKObvz0ixOAzQm1PsFtcnSOnIpwdBxzPaOo/YJ8RzXQe151WPUU1EkKg/wVE
	2cVI/Mu8epgHzIC0tBEl+Sz9Awq2vB2kDWBVgTkVO9I8Vn4Jo4wcdNIMH1oSJudQmQTq32RZj3S
	KkSxQM1LrI+BTub51lavlUHN8BX7KDxfORDYOR9EALvfV1dNDu22sX0W6ziA==
X-Received: by 2002:a05:6a21:66c9:b0:394:f5a8:5136 with SMTP id adf61e73a8af0-394f5a85e6cmr2218591637.74.1771437428545;
        Wed, 18 Feb 2026 09:57:08 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:181:cb2d:52e8:2ca0])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e531e6c51sm13440957a12.16.2026.02.18.09.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 09:57:08 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 0/3] wt-status: reduce reliance on global state
Date: Wed, 18 Feb 2026 23:23:39 +0530
Message-ID: <20260218175654.66004-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260131190106.389289-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In wt-status.c code still relies on some global variables, including
the_repository and the_hash_algo, even in cases where a repository instance
is already available via struct wt_status or struct repository.

In patch 1/3, update function parameters and callers to pass and use struct
repository instead of the_repository where no local repository access was
available.

In patch 2/3, replace direct uses of the_repository with repository
instances already available in local structs.

In patch 3/3, replace remaining uses of the global the_hash_algo with the
hash algorithm stored in the respective repository instance.

These changes remove uses of the_repository and the_hash_algo from
wt-status.c and reduce its dependence on global state.

The 'USE_THE_REPOSITORY_VARIABLE' macro cannot yet be removed, since these
patches only eliminate some uses of the_repository and the_hash_algo, while
some global variables are still referenced.

In particular wt-status.c still relies on the following globals,

* the_repository, this is still used in functions like worktree_git_path()
  and wt_status_check_bisect/rebase() which are dependant on the worktree
  API and they are being handled in a seperate patch series[1].

* core_apply_sparse_checkout, this is already being addressed in an ongoing
  patch series [2].

* comment_line_str and DEFAULT_ABBREV, these both still are used in
  wt-status.c but they dont have any equivalent local instances.

[1]- https://lore.kernel.org/git/20260213120529.15475-1-shreyanshpaliwalcmsmn@gmail.com/T/#mf664ad751faaf2eaca138302b1cc9d3856c9fec3
[2]- https://lore.kernel.org/git/5e56e1cc4172cfff9e917a068184e102aa70bf1d.1769256839.git.belkid98@gmail.com/t/#u

Shreyansh Paliwal (3):
  wt-status: pass struct repository through function parameters
  wt-status: replace uses of the_repository with local repository
    instances
  wt-status: use hash_algo from local repository instead of global
    the_hash_algo

 wt-status.c | 62 ++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

---
Changes in v5:
 - Added the usage of struct repository *r in addition to adding it as a parameter to the functions,
    in patch 1/3 instead of doing that in 2/3.

Range-diff against v4:
1:  a3683a5e17 ! 1:  620cf8832b wt-status: pass struct repository through function parameters
    @@ Commit message
         wt-status: pass struct repository through function parameters

         Some functions in wt-status.c (count_stash_entries(),
    -    read_line_from_git_path(), abbrev_oid_in_line(), read_rebase_todolist())
    -    do not have access to a local repository instance and rely on the_repository.
    +    read_line_from_git_path(), abbrev_oid_in_line(), and
    +    read_rebase_todolist()) rely on the_repository as they do not have access
    +    to a local repository instance.

    -    Add a struct repository *r parameter to these functions, and pass the local
    -    repository through the callers where already they can access a local repository
    -    instance either directly by struct repository *r or
    -    by struct wt_state *s (s->repo).
    +    Add a struct repository *r parameter to these functions and pass the local
    +    repository instance through the callers, which already have access to it
    +    either directly by struct repository *r or indirectly by struct wt_state
    +    *s (s->repo).
    +
    +    Replace uses of the_repository in these functions with the passed parameter.

         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

    @@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
     +static int count_stash_entries(struct repository *r)
      {
      	int n = 0;
    - 	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
    -@@ wt-status.c: static int count_stash_entries(void)
    +-	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
    ++	refs_for_each_reflog_ent(get_main_ref_store(r),
    + 				 "refs/stash", stash_count_refs, &n);
    + 	return n;
    + }

      static void wt_longstatus_print_stash_summary(struct wt_status *s)
      {
    @@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
     +static char *read_line_from_git_path(struct repository *r, const char *filename)
      {
      	struct strbuf buf = STRBUF_INIT;
    - 	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
    +-	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
    ++	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
    + 						      "%s", filename), "r");
    +
    + 	if (!fp) {
     @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
      		return 0;
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      {
      	struct string_list split = STRING_LIST_INIT_DUP;
      	struct object_id oid;
    +@@ wt-status.c: static void abbrev_oid_in_line(struct strbuf *line)
    + 		return;
    +
    + 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
    +-	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
    ++	    !repo_get_oid(r, split.items[1].string, &oid)) {
    + 		strbuf_reset(line);
    + 		strbuf_addf(line, "%s ", split.items[0].string);
    + 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
     @@ wt-status.c: static void abbrev_oid_in_line(struct strbuf *line)
      	string_list_clear(&split, 0);
      }
    @@ wt-status.c: static void abbrev_oid_in_line(struct strbuf *line)
     +static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
      {
      	struct strbuf buf = STRBUF_INIT;
    - 	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
    +-	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
    ++	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
    + 	int ret;
    +
    + 	if (!f) {
    +@@ wt-status.c: static int read_rebase_todolist(const char *fname, struct string_list *lines)
    + 			goto out;
    + 		}
    + 		die_errno("Could not open file %s for reading",
    +-			  repo_git_path_replace(the_repository, &buf, "%s", fname));
    ++			  repo_git_path_replace(r, &buf, "%s", fname));
    + 	}
    + 	while (!strbuf_getline_lf(&buf, f)) {
    + 		if (starts_with(buf.buf, comment_line_str))
     @@ wt-status.c: static int read_rebase_todolist(const char *fname, struct string_list *lines)
      		strbuf_trim(&buf);
      		if (!buf.len)
2:  f3b4c3e972 ! 2:  13e0c5bcd7 wt-status: replace uses of the_repository with local repository instances
    @@ Metadata
      ## Commit message ##
         wt-status: replace uses of the_repository with local repository instances

    -    wt-status.c uses the global the_repository in several places even when
    -    a repository instance is already available via struct wt_status *s or
    -    struct repository *r.
    +    wt-status.c uses the global the_repository in several places even when a
    +    repository instance is already available via struct wt_status *s or struct
    +    repository *r.

    -    Replace these uses of the_repository with the repository available
    -    in the local context (i.e. s->repo or r).
    +    Replace these uses of the_repository with the repository available in the
    +    local context (i.e. s->repo or r).

    -    The replacements of all the_repository with s->repo are mostly
    -    to cases where a repository instance is already available via
    -    struct wt_status *s and struct repository *r, all functions operating on
    -    struct wt_status *s are only used after s is initialized by wt_status_prepare(),
    -    which sets s->repo from the repository provided by the caller.
    -    As a result, s->repo is guaranteed to be available and consistent whenever
    -    these functions are invoked.
    +    The replacements of all the_repository with s->repo are mostly to cases
    +    where a repository instance is already available via struct wt_status *s
    +    and struct repository *r, all functions operating on struct wt_status *s
    +    are only used after s is initialized by wt_status_prepare(), which sets
    +    s->repo from the repository provided by the caller. As a result, s->repo is
    +    guaranteed to be available and consistent whenever these functions are
    +    invoked.

         This reduces reliance on global state and keeps wt-status consistent,
    -    though many functions operating on struct wt_status *s
    -    are called via commit.c and it still relies on the_repository,
    -    but within wt-status.c the local repository pointer
    -    refers to the same underlying repository object.
    +    though many functions operating on struct wt_status *s are called via
    +    commit.c and it still relies on the_repository, but within wt-status.c the
    +    local repository pointer refers to the same underlying repository object.

         Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>

    @@ wt-status.c: static void wt_status_collect_changes_index(struct wt_status *s)
      	setup_revisions(0, NULL, &rev, &opt);

      	rev.diffopt.flags.override_submodule_config = 1;
    -@@ wt-status.c: static int stash_count_refs(const char *refname UNUSED,
    - static int count_stash_entries(struct repository *r)
    - {
    - 	int n = 0;
    --	refs_for_each_reflog_ent(get_main_ref_store(the_repository),
    -+	refs_for_each_reflog_ent(get_main_ref_store(r),
    - 				 "refs/stash", stash_count_refs, &n);
    - 	return n;
    - }
     @@ wt-status.c: static void wt_longstatus_print_verbose(struct wt_status *s)
      	rev.diffopt.ita_invisible_in_index = 1;

    @@ wt-status.c: static void wt_longstatus_print_verbose(struct wt_status *s)
      	setup_revisions(0, NULL, &rev, &opt);

      	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
    -@@ wt-status.c: static void show_am_in_progress(struct wt_status *s,
    - static char *read_line_from_git_path(struct repository *r, const char *filename)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
    --	FILE *fp = fopen_or_warn(repo_git_path_append(the_repository, &buf,
    -+	FILE *fp = fopen_or_warn(repo_git_path_append(r, &buf,
    - 						      "%s", filename), "r");
    -
    - 	if (!fp) {
     @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      	    !s->branch || strcmp(s->branch, "HEAD"))
      		return 0;
    @@ wt-status.c: static int split_commit_in_progress(struct wt_status *s)
      			       &orig_head_oid, &orig_head_flags))
      		return 0;
      	if (head_flags & REF_ISSYMREF || orig_head_flags & REF_ISSYMREF)
    -@@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
    - 		return;
    -
    - 	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
    --	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
    -+	    !repo_get_oid(r, split.items[1].string, &oid)) {
    - 		strbuf_reset(line);
    - 		strbuf_addf(line, "%s ", split.items[0].string);
    - 		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
    -@@ wt-status.c: static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
    - static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
    --	FILE *f = fopen(repo_git_path_append(the_repository, &buf, "%s", fname), "r");
    -+	FILE *f = fopen(repo_git_path_append(r, &buf, "%s", fname), "r");
    - 	int ret;
    -
    - 	if (!f) {
    -@@ wt-status.c: static int read_rebase_todolist(struct repository *r, const char *fname, struct
    - 			goto out;
    - 		}
    - 		die_errno("Could not open file %s for reading",
    --			  repo_git_path_replace(the_repository, &buf, "%s", fname));
    -+			  repo_git_path_replace(r, &buf, "%s", fname));
    - 	}
    - 	while (!strbuf_getline_lf(&buf, f)) {
    - 		if (starts_with(buf.buf, comment_line_str))
     @@ wt-status.c: static void show_rebase_information(struct wt_status *s,
      				i++)
      				status_printf_ln(s, color, "   %s", have_done.items[i].string);
3:  7efaf6b3fb = 3:  2bf22dd925 wt-status: use hash_algo from local repository instead of global the_hash_algo
--
2.53.0

