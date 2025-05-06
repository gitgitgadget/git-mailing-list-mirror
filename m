Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E793727FB3A
	for <git@vger.kernel.org>; Tue,  6 May 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746536302; cv=pass; b=VlUCCGgYsBuE3ImuUQ1go0KWbS94njh5ziEjWo1NbSEAvsPSpY46GkUaCZZlOTc+LrQ9Ei80Cg5Sn+bxtV9L5xNzy3+FnrguJ2ZjwNWoZ+2vFRyt9mfco+qw+moXZJtK1tYC/I/iE0VWlJgvO9uHaIAQ0pAKan2E2h+2YZ2KNl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746536302; c=relaxed/simple;
	bh=HP7dfoBLYdVldRbxdVISKy0kc1t7ExlAvg29uVPuzjA=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KZn0LEs0JCT0lUjJOz6NXdFms0mxiXDAs/4mAB1NuaGMKcYxK54TIzHr90GAB+9kBuaFDMy+TUusJW1dWmxkrbJuAX1+7gamP6Z5/GPD4UarUdXT0vBvlgX0d+Lw53l4VXnNYgxj4lgkkxNIHASX+RozUhgRVi/Vku/Mcy28q9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=S4pQyB1a; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="S4pQyB1a"
ARC-Seal: i=1; a=rsa-sha256; t=1746536297; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CX1XVSab5gC3sr7QoGSi76aaW45Qw4PFhmqDFHGPi4vhfxBGDJmv4McHoijjXTe4/xiTH2+c9h5b9RsROghVA/K4JzhQst6ncBIkwO9FpnLY07a0IKgcTSeoc62neJeF+ebK0na5z9mdxoJ9qg+lQC+S5A7ly2eJ8iB/2Zg/Rv4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746536297; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Bzk/VjjnzNysTBIsqcolGrOkKdYSRZ4niBppJ/viTZc=; 
	b=nxPCaTgvO784dYtEyYE8pOK81XbDi+TzDbkxfQiOIWFoCwdXOjCpC1BpgjcDea3GBvF7D7HsmlaTirGfrjqQMsCaHKmrwhfvH8NlFR1jX6xe3E3nz2LSeVB6HAeSnXkiC0/No0eeji3k2GekevZR026doMLO6s2eNdkHAlJB0uk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746536297;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=Bzk/VjjnzNysTBIsqcolGrOkKdYSRZ4niBppJ/viTZc=;
	b=S4pQyB1adSZ/JLvI3eycaZbvFasfRYeTI949Co2u5n5YdA0KlsrOJE2IbaccXdya
	SicLAKSaQIDBC5a24ifrJ6Bpx3XLMNghPHtqt8Towgi5lzoDN/zPji5hyjdgZTljukE
	kpzYKQk1M7xtC8s32gw0kEHEYudZMyA6u8+cmvmI=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1746536295203245.3470162776821; Tue, 6 May 2025 05:58:15 -0700 (PDT)
Date: Tue, 06 May 2025 20:58:15 +0800
From: Li Chen <me@linux.beauty>
To: "git" <git@vger.kernel.org>
Message-ID: <196a5aceb00.fdc2d9ff187843.3547183335386278718@linux.beauty>
In-Reply-To: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
References: <196a5ac1393.f5b4db7d187309.2451613571977217927@linux.beauty>
Subject: [RFC PATCH 1/2] rebase, am: add --reviewby option
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

From: Li Chen <chenl311@chinatelecom.cn>

Introduce a new `--reviewby` flag to `git rebase` and `git am` that appends a
`Reviewed-by: name <email>` trailer to each rebased or applied commit, analogous
to the existing `--signoff` behavior.

especially useful for backporting patches and reviewing new patches.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Reviewed-by: Li Chen <chenl311@chinatelecom.cn>
---
 Documentation/git-am.adoc     |   6 +-
 Documentation/git-rebase.adoc |   4 +
 builtin/am.c                  |  31 ++++++++
 builtin/rebase.c              |  14 ++++
 builtin/revert.c              |   4 +-
 sequencer.c                   |  87 ++++++++++++++++++++-
 sequencer.h                   |  10 +++
 t/meson.build                 |   1 +
 t/t3439-rebase-reviewby.sh    | 138 ++++++++++++++++++++++++++++++++++
 t/t4150-am.sh                 |  75 ++++++++++++++++++
 10 files changed, 366 insertions(+), 4 deletions(-)
 create mode 100755 t/t3439-rebase-reviewby.sh

diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index 221070de48..1d408f2bab 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -9,7 +9,7 @@ git-am - Apply a series of patches from a mailbox
 SYNOPSIS
 --------
 [verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-verify]
+'git am' [--signoff] [--reviewby] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--no-verify]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<action>] [-C<n>] [-p<n>] [--directory=<dir>]
@@ -40,7 +40,9 @@ OPTIONS
 	Add a `Signed-off-by` trailer to the commit message, using
 	the committer identity of yourself.
 	See the signoff option in linkgit:git-commit[1] for more information.
-
+--reviewby::
+	Add a `Reviewed-by` trailer to the commit message, using
+	the committer identity of yourself.
 -k::
 --keep::
 	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5..1f3d152035 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -521,6 +521,10 @@ See also INCOMPATIBLE OPTIONS below.
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
 +
+--review-by::
+	Append a `Reviewed-by:` trailer whose value is taken from the
+	current committer identity, exactly like `--signoff` appends a
+	Signed-off-by:` trailer.
 See also INCOMPATIBLE OPTIONS below.
 
 -i::
diff --git a/builtin/am.c b/builtin/am.c
index 4afb519830..f8fe95e15d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -89,6 +89,12 @@ enum signoff_type {
 	SIGNOFF_EXPLICIT /* --signoff was set on the command-line */
 };
 
+enum reviewby_type {
+	REVIEWBY_FALSE = 0,
+	REVIEWBY_TRUE = 1,
+	REVIEWBY_EXPLICIT /* --reviewby was set on the command-line */
+};
+
 enum resume_type {
 	RESUME_FALSE = 0,
 	RESUME_APPLY,
@@ -134,6 +140,7 @@ struct am_state {
 	int threeway;
 	int quiet;
 	int signoff; /* enum signoff_type */
+	int reviewby; /* enum reviewby_type */
 	int utf8;
 	int keep; /* enum keep_type */
 	int message_id;
@@ -422,6 +429,9 @@ static void am_load(struct am_state *state)
 	read_state_file(&sb, state, "sign", 1);
 	state->signoff = !strcmp(sb.buf, "t");
 
+	read_state_file(&sb, state, "review", 1);
+	state->reviewby = !strcmp(sb.buf, "t");
+
 	read_state_file(&sb, state, "utf8", 1);
 	state->utf8 = !strcmp(sb.buf, "t");
 
@@ -1017,6 +1027,7 @@ static void am_setup(struct am_state *state, enum patch_format patch_format,
 	write_state_bool(state, "threeway", state->threeway);
 	write_state_bool(state, "quiet", state->quiet);
 	write_state_bool(state, "sign", state->signoff);
+	write_state_bool(state, "review", state->reviewby);
 	write_state_bool(state, "utf8", state->utf8);
 
 	if (state->allow_rerere_autoupdate)
@@ -1191,6 +1202,18 @@ static void am_append_signoff(struct am_state *state)
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
+/**
+ * Appends reviewby to the "msg" field of the am_state.
+ */
+static void am_append_reviewby(struct am_state *state)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
+	append_reviewby(&sb, 0, 0);
+	state->msg = strbuf_detach(&sb, &state->msg_len);
+}
+
 /**
  * Parses `mail` using git-mailinfo, extracting its patch and authorship info.
  * state->msg will be set to the patch message. state->author_name,
@@ -1849,6 +1872,9 @@ static void am_run(struct am_state *state, int resume)
 			if (state->signoff)
 				am_append_signoff(state);
 
+			if (state->reviewby)
+				am_append_reviewby(state);
+
 			write_author_script(state);
 			write_commit_msg(state);
 		}
@@ -2337,6 +2363,9 @@ int cmd_am(int argc,
 		OPT_SET_INT('s', "signoff", &state.signoff,
 			N_("add a Signed-off-by trailer to the commit message"),
 			SIGNOFF_EXPLICIT),
+		OPT_SET_INT(0, "reviewby", &state.reviewby,
+			N_("add a Reviewed-by trailer to the commit message"),
+			REVIEWBY_EXPLICIT),
 		OPT_BOOL('u', "utf8", &state.utf8,
 			N_("recode into utf8 (default)")),
 		OPT_SET_INT('k', "keep", &state.keep,
@@ -2483,6 +2512,8 @@ int cmd_am(int argc,
 
 		if (state.signoff == SIGNOFF_EXPLICIT)
 			am_append_signoff(&state);
+		if (state.reviewby == REVIEWBY_EXPLICIT)
+			am_append_reviewby(&state);
 	} else {
 		struct strvec paths = STRVEC_INIT;
 		int i;
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e8c4ee678..b288aedfb1 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -113,6 +113,7 @@ struct rebase_options {
 	enum action action;
 	char *reflog_action;
 	int signoff;
+	int reviewby;
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
@@ -177,6 +178,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
+	replay.reviewby = opts->reviewby;
 	replay.allow_ff = !(opts->flags & REBASE_FORCE);
 	if (opts->allow_rerere_autoupdate)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
@@ -477,6 +479,10 @@ static int read_basic_state(struct rebase_options *opts)
 		opts->signoff = 1;
 		opts->flags |= REBASE_FORCE;
 	}
+	if (file_exists(state_dir_path("reviewby", opts))) {
+		opts->reviewby = 1;
+		opts->flags |= REBASE_FORCE;
+	}
 
 	if (file_exists(state_dir_path("allow_rerere_autoupdate", opts))) {
 		strbuf_reset(&buf);
@@ -528,6 +534,8 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 			   opts->gpg_sign_opt);
 	if (opts->signoff)
 		write_file(state_dir_path("signoff", opts), "--signoff");
+	if (opts->reviewby)
+		write_file(state_dir_path("reviewby", opts), "--reviewby");
 
 	return 0;
 }
@@ -1134,6 +1142,8 @@ int cmd_rebase(int argc,
 		},
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by trailer to each commit")),
+		OPT_BOOL(0, "reviewby", &options.reviewby,
+			 N_("add a Reviewed-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
@@ -1618,6 +1628,10 @@ int cmd_rebase(int argc,
 		strvec_push(&options.git_am_opts, "--signoff");
 		options.flags |= REBASE_FORCE;
 	}
+	if (options.reviewby) {
+		strvec_push(&options.git_am_opts, "--reviewby");
+		options.flags |= REBASE_FORCE;
+	}
 
 	if (!options.root) {
 		if (argc < 1) {
diff --git a/builtin/revert.c b/builtin/revert.c
index e07c2217fe..c73a773c9d 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -124,7 +124,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		OPT_CLEANUP(&cleanup_arg),
 		OPT_BOOL('n', "no-commit", &opts->no_commit, N_("don't automatically commit")),
 		OPT_BOOL('e', "edit", &opts->edit, N_("edit the commit message")),
-		OPT_NOOP_NOARG('r', NULL),
+		OPT_BOOL('r', "reviewby", &opts->reviewby, N_("add a Reviewed-by trailer")),
 		OPT_BOOL('s', "signoff", &opts->signoff, N_("add a Signed-off-by trailer")),
 		OPT_CALLBACK('m', "mainline", opts, N_("parent-number"),
 			     N_("select mainline parent"), option_parse_m),
@@ -206,6 +206,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 		verify_opt_compatible(me, this_operation,
 				"--no-commit", opts->no_commit,
 				"--signoff", opts->signoff,
+				"--reviewby", opts->reviewby,
 				"--mainline", opts->mainline,
 				"--strategy", opts->strategy ? 1 : 0,
 				"--strategy-option", opts->xopts.nr ? 1 : 0,
@@ -226,6 +227,7 @@ static int run_sequencer(int argc, const char **argv, const char *prefix,
 	if (opts->allow_ff)
 		verify_opt_compatible(me, "--ff",
 				"--signoff", opts->signoff,
+				"--reviewby", opts->reviewby,
 				"--no-commit", opts->no_commit,
 				"-x", opts->record_origin,
 				"--edit", opts->edit > 0,
diff --git a/sequencer.c b/sequencer.c
index b5c4043757..01933882ed 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -61,6 +61,7 @@
 #define GIT_MAX_LABEL_LENGTH ((NAME_MAX) - (LOCK_SUFFIX_LEN) - 16)
 
 static const char sign_off_header[] = "Signed-off-by: ";
+static const char review_by_header[] = "Reviewed-by: ";
 static const char cherry_picked_prefix[] = "(cherry picked from commit ";
 
 GIT_PATH_FUNC(git_path_commit_editmsg, "COMMIT_EDITMSG")
@@ -199,6 +200,7 @@ static GIT_PATH_FUNC(rebase_path_orig_head, "rebase-merge/orig-head")
 static GIT_PATH_FUNC(rebase_path_verbose, "rebase-merge/verbose")
 static GIT_PATH_FUNC(rebase_path_quiet, "rebase-merge/quiet")
 static GIT_PATH_FUNC(rebase_path_signoff, "rebase-merge/signoff")
+static GIT_PATH_FUNC(rebase_path_reviewby, "rebase-merge/reviewby")
 static GIT_PATH_FUNC(rebase_path_head_name, "rebase-merge/head-name")
 static GIT_PATH_FUNC(rebase_path_onto, "rebase-merge/onto")
 static GIT_PATH_FUNC(rebase_path_autostash, "rebase-merge/autostash")
@@ -1179,6 +1181,10 @@ static int run_git_commit(const char *defmsg,
 		 !opts->signoff && !opts->record_origin &&
 		 !opts->explicit_cleanup)
 		strvec_push(&cmd.args, "--cleanup=verbatim");
+	else if (!(flags & CLEANUP_MSG) &&
+		 !opts->reviewby && !opts->record_origin &&
+		 !opts->explicit_cleanup)
+		strvec_push(&cmd.args, "--cleanup=verbatim");
 
 	if ((flags & ALLOW_EMPTY))
 		strvec_push(&cmd.args, "--allow-empty");
@@ -1628,6 +1634,9 @@ static int try_to_commit(struct repository *r,
 	else if ((opts->signoff || opts->record_origin) &&
 		 !opts->explicit_cleanup)
 		cleanup = COMMIT_MSG_CLEANUP_SPACE;
+	else if ((opts->reviewby || opts->record_origin) &&
+		 !opts->explicit_cleanup)
+		cleanup = COMMIT_MSG_CLEANUP_SPACE;
 	else
 		cleanup = opts->default_msg_cleanup;
 
@@ -2039,6 +2048,8 @@ static int append_squash_message(struct strbuf *buf, const char *body,
 		 */
 		if (opts->signoff)
 			append_signoff(buf, 0, 0);
+		if (opts->reviewby)
+			append_reviewby(buf, 0, 0);
 
 		if ((command == TODO_FIXUP) &&
 		    (flag & TODO_REPLACE_FIXUP_MSG) &&
@@ -2418,6 +2429,9 @@ static int do_pick_commit(struct repository *r,
 	if (opts->signoff && !is_fixup(command))
 		append_signoff(&ctx->message, 0, 0);
 
+	if (opts->reviewby && !is_fixup(command))
+		append_reviewby(&ctx->message, 0, 0);
+
 	if (is_rebase_i(opts) && write_author_script(msg.message) < 0)
 		res = -1;
 	else if (!opts->strategy ||
@@ -3079,6 +3093,8 @@ static int populate_opts_cb(const char *key, const char *value,
 			git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.signoff"))
 		opts->signoff = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
+	else if (!strcmp(key, "options.reviewby"))
+		opts->reviewby = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.record-origin"))
 		opts->record_origin = git_config_bool_or_int(key, value, ctx->kvi, &error_flag);
 	else if (!strcmp(key, "options.allow-ff"))
@@ -3180,6 +3196,10 @@ static int read_populate_opts(struct replay_opts *opts)
 			opts->allow_ff = 0;
 			opts->signoff = 1;
 		}
+		if (file_exists(rebase_path_reviewby())) {
+			opts->allow_ff = 0;
+			opts->reviewby = 1;
+		}
 
 		if (file_exists(rebase_path_cdate_is_adate())) {
 			opts->allow_ff = 0;
@@ -3286,6 +3306,8 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_gpg_sign_opt(), "-S%s\n", opts->gpg_sign);
 	if (opts->signoff)
 		write_file(rebase_path_signoff(), "--signoff\n");
+	if (opts->reviewby)
+		write_file(rebase_path_reviewby(), "--reviewby\n");
 	if (opts->drop_redundant_commits)
 		write_file(rebase_path_drop_redundant_commits(), "%s", "");
 	if (opts->keep_redundant_commits)
@@ -3629,6 +3651,9 @@ static int save_opts(struct replay_opts *opts)
 	if (opts->signoff)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.signoff", NULL, "true");
+	if (opts->reviewby)
+		res |= git_config_set_in_file_gently(opts_file,
+					"options.reviewby", NULL, "true");
 	if (opts->record_origin)
 		res |= git_config_set_in_file_gently(opts_file,
 					"options.record-origin", NULL, "true");
@@ -4949,7 +4974,7 @@ static int pick_commits(struct repository *r,
 
 	ctx->reflog_message = sequencer_reflog_action(opts);
 	if (opts->allow_ff)
-		ASSERT(!(opts->signoff || opts->no_commit ||
+		ASSERT(!(opts->signoff || opts->reviewby || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
 			 opts->committer_date_is_author_date ||
 			 opts->ignore_date));
@@ -5581,6 +5606,66 @@ int sequencer_pick_revisions(struct repository *r,
 	return res;
 }
 
+void append_reviewby(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
+{
+	unsigned no_dup_rb = flag & APPEND_REVIEWBY_DEDUP;
+	struct strbuf rb = STRBUF_INIT;
+	int has_footer;
+
+	strbuf_addstr(&rb, review_by_header);
+	strbuf_addstr(&rb, fmt_name(WANT_COMMITTER_IDENT));
+	strbuf_addch(&rb, '\n');
+
+	if (!ignore_footer)
+		strbuf_complete_line(msgbuf);
+
+	/*
+	 * If the whole message buffer is equal to the rb, pretend that we
+	 * found a conforming footer with a matching rb
+	 */
+	if (msgbuf->len - ignore_footer == rb.len &&
+	    !strncmp(msgbuf->buf, rb.buf, rb.len))
+		has_footer = 3;
+	else
+		has_footer = has_conforming_footer(msgbuf, &rb, ignore_footer);
+
+	if (!has_footer) {
+		const char *append_newlines = NULL;
+		size_t len = msgbuf->len - ignore_footer;
+
+		if (!len) {
+			/*
+			 * The buffer is completely empty.  Leave foom for
+			 * the title and body to be filled in by the user.
+			 */
+			append_newlines = "\n\n";
+		} else if (len == 1) {
+			/*
+			 * Buffer contains a single newline.  Add another
+			 * so that we leave room for the title and body.
+			 */
+			append_newlines = "\n";
+		} else if (msgbuf->buf[len - 2] != '\n') {
+			/*
+			 * Buffer ends with a single newline.  Add another
+			 * so that there is an empty line between the message
+			 * body and the rb.
+			 */
+			append_newlines = "\n";
+		} /* else, the buffer already ends with two newlines. */
+
+		if (append_newlines)
+			strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				append_newlines, strlen(append_newlines));
+	}
+
+	if (has_footer != 3 && (!no_dup_rb || has_footer != 2))
+		strbuf_splice(msgbuf, msgbuf->len - ignore_footer, 0,
+				rb.buf, rb.len);
+
+	strbuf_release(&rb);
+}
+
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag)
 {
 	unsigned no_dup_sob = flag & APPEND_SIGNOFF_DEDUP;
diff --git a/sequencer.h b/sequencer.h
index 304ba4b4d3..82b79fd1e8 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -17,6 +17,7 @@ const char *rebase_path_dropped(void);
 extern const char *rebase_resolvemsg;
 
 #define APPEND_SIGNOFF_DEDUP (1u << 0)
+#define APPEND_REVIEWBY_DEDUP (1u << 1)
 
 enum replay_action {
 	REPLAY_REVERT,
@@ -44,6 +45,7 @@ struct replay_opts {
 	int record_origin;
 	int no_commit;
 	int signoff;
+	int reviewby;
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
@@ -205,6 +207,14 @@ int todo_list_rearrange_squash(struct todo_list *todo_list);
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
+/*
+ * Append a reviewby to the commit message in "msgbuf". The ignore_footer
+ * parameter specifies the number of bytes at the end of msgbuf that should
+ * not be considered at all. I.e., they are not checked for existing trailers,
+ * and the new reviewby will be spliced into the buffer before those bytes.
+ */
+void append_reviewby(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
+
 void append_conflicts_hint(struct index_state *istate,
 		struct strbuf *msgbuf, enum commit_msg_cleanup_mode cleanup_mode);
 enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
diff --git a/t/meson.build b/t/meson.build
index bfb744e886..327fa461fd 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -392,6 +392,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3439-rebase-reviewby.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3439-rebase-reviewby.sh b/t/t3439-rebase-reviewby.sh
new file mode 100755
index 0000000000..ca7299fbdb
--- /dev/null
+++ b/t/t3439-rebase-reviewby.sh
@@ -0,0 +1,138 @@
+#!/bin/sh
+
+test_description='git rebase --reviewby
+
+This test runs git rebase --reviewby and make sure that it works.
+'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success 'setup' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	test_commit first file a &&
+	test_commit second file &&
+	git checkout -b conflict-branch first &&
+	test_commit file-2 file-2 &&
+	test_commit conflict file &&
+	test_commit third file &&
+
+	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
+
+	# Expected commit message for initial commit after rebase --reviewby
+	cat >expected-initial-reviewed <<-EOF &&
+	Initial empty commit
+
+	Reviewed-by: $ident
+	EOF
+
+	# Expected commit message after rebase --reviewby
+	cat >expected-reviewed <<-EOF &&
+	first
+
+	Reviewed-by: $ident
+	EOF
+
+	# Expected commit message after conflict resolution for rebase --reviewby
+	cat >expected-reviewed-conflict <<-EOF &&
+	third
+
+	Reviewed-by: $ident
+
+	conflict
+
+	Reviewed-by: $ident
+
+	file-2
+
+	Reviewed-by: $ident
+
+	EOF
+
+	# Expected commit message after rebase without --reviewby (or with --no-reviewby)
+	cat >expected-unreviewed <<-EOF &&
+	first
+	EOF
+
+	git config alias.rbr "rebase --reviewby"
+'
+
+test_expect_success 'rebase --apply --reviewby adds a Reviewed-by line' '
+	test_must_fail git rbr --apply second third &&
+	git checkout --theirs file &&
+	git add file &&
+	git rebase --continue &&
+	git log --format=%B -n3 >actual &&
+	test_cmp expected-reviewed-conflict actual
+'
+
+test_expect_success 'rebase --no-reviewby does not add a Reviewed-by line' '
+	git commit --amend -m "first" &&
+	git rbr --no-reviewby HEAD^ &&
+	test_commit_message HEAD expected-unreviewed
+'
+
+test_expect_success 'rebase --exec --reviewby adds a Reviewed-by line' '
+	test_when_finished "rm exec" &&
+	git rebase --exec "touch exec" --reviewby first^ first &&
+	test_path_is_file exec &&
+	test_commit_message HEAD expected-reviewed
+'
+
+test_expect_success 'rebase --root --reviewby adds a Reviewed-by line' '
+	git checkout first &&
+	git rebase --root --keep-empty --reviewby &&
+	test_commit_message HEAD^ expected-initial-reviewed &&
+	test_commit_message HEAD expected-reviewed
+'
+
+test_expect_success 'rebase -m --reviewby adds a Reviewed-by line' '
+	test_must_fail git rebase -m --reviewby second third &&
+	git checkout --theirs file &&
+	git add file &&
+	GIT_EDITOR="sed -n /Conflicts:/,/^\\\$/p >actual" \
+		git rebase --continue &&
+	cat >expect <<-\EOF &&
+	# Conflicts:
+	#	file
+
+	EOF
+	test_cmp expect actual &&
+	git log --format=%B -n3 >actual &&
+	test_cmp expected-reviewed-conflict actual
+'
+
+test_expect_success 'rebase -i --reviewby adds a Reviewed-by line when editing commit' '
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 edit 3 edit 2" \
+			git rebase -i --reviewby first third
+	) &&
+	echo a >a &&
+	git add a &&
+	test_must_fail git rebase --continue &&
+	git checkout --ours file &&
+	echo b >a &&
+	git add a file &&
+	git rebase --continue &&
+	echo c >a &&
+	git add a &&
+	git log --format=%B -n3 >actual &&
+	cat >expect <<-EOF &&
+	conflict
+
+	Reviewed-by: $ident
+
+	third
+
+	Reviewed-by: $ident
+
+	file-2
+
+	Reviewed-by: $ident
+
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2ae93d3c96..40d6a2f43a 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -491,6 +491,7 @@ test_expect_success 'am changes committer and keeps author' '
 	     "$(git log -1 --pretty=format:"%cn <%ce>" HEAD)"
 '
 
+########################## signoff begin ##########################
 test_expect_success 'am --signoff adds Signed-off-by: line' '
 	rm -fr .git/rebase-apply &&
 	git reset --hard &&
@@ -572,6 +573,80 @@ test_expect_success 'am without --keep removes Re: and [PATCH] stuff' '
 	git rev-parse topic_2 >actual &&
 	test_cmp expected actual
 '
+########################## signoff end ##########################
+
+########################## review begin ##########################
+test_expect_success 'am --review adds Reviewed-by: line' '
+	rm -fr .git/rebase-apply &&
+	git reset --hard &&
+	git checkout -b topic_3 first &&
+	git am --reviewby <patch2 &&
+	{
+		printf "third\n\nReviewed-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
+		cat msg &&
+		printf "Reviewed-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expected-log &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+test_expect_success 'am stays in branch' '
+	echo refs/heads/topic_3 >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'am --reviewby does not add Reviewed-by: line if already there' '
+	git format-patch --stdout first >patch3 &&
+	git reset --hard first &&
+	git am --reviewby <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+
+test_expect_success 'am --reviewby adds Reviewed-by: if another author is preset' '
+	NAME="A N Other" &&
+	EMAIL="a.n.other@example.com" &&
+	{
+		printf "third\n\nReviewed-by: %s <%s>\nReviewed-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" &&
+		cat msg &&
+		printf "Reviewed-by: %s <%s>\nReviewed-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL"
+	} >expected-log &&
+	git reset --hard first &&
+	GIT_COMMITTER_NAME="$NAME" GIT_COMMITTER_EMAIL="$EMAIL" \
+		git am --reviewby <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+
+test_expect_success 'am --reviewby duplicates Reviewed-by: if it is not the last one' '
+	NAME="A N Other" &&
+	EMAIL="a.n.other@example.com" &&
+	{
+		printf "third\n\nReviewed-by: %s <%s>\n\
+Reviewed-by: %s <%s>\nReviewed-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" &&
+		cat msg &&
+		printf "Reviewed-by: %s <%s>\nReviewed-by: %s <%s>\n\
+Reviewed-by: %s <%s>\n\n" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL" \
+			"$NAME" "$EMAIL" \
+			"$GIT_COMMITTER_NAME" "$GIT_COMMITTER_EMAIL"
+	} >expected-log &&
+	git format-patch --stdout first >patch3 &&
+	git reset --hard first &&
+	git am --reviewby <patch3 &&
+	git log --pretty=%B -2 HEAD >actual &&
+	test_cmp expected-log actual
+'
+########################## review end ##########################
 
 test_expect_success 'am --keep really keeps the subject' '
 	rm -fr .git/rebase-apply &&
-- 
2.49.0


