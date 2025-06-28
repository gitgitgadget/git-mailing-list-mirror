Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1606424EA8D
	for <git@vger.kernel.org>; Sat, 28 Jun 2025 16:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751128497; cv=none; b=NZUI3z0wLSsl0iRlmNN9fazISutR0pnj15q49T2TrJCHwDiBLSnzFsn070ZTtlxsC5ffeOnpEOa1xNfgtDO9WpLWdSbT5zb6qxRaHNDmL58DkYTgSSK1SG415pZ+/PpMw/bd39OjfMyqRdmvoMSAngoIZVJcK972NBeGgXCvI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751128497; c=relaxed/simple;
	bh=EhWQn0xqa/Qo/r1XIt02UjSt3nx7AkZPg2KKaazE9II=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Y3TaqnqSyLkQOHzvToQcfur3qtxAyXH+TVNk4rOh203Fj7KMQK33Hv7hZ7mKyIVBw2wt7LFstKGtDeonNSTusnQGvQHIT3BFq4t8H49nAmCmt3KwvZcyGh1S9y2U89azuGdWlHONgjGRSnNO70gYBFec7cy8u7mbVPwb8+U3Oxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0H0vF7U; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0H0vF7U"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a510432236so596608f8f.0
        for <git@vger.kernel.org>; Sat, 28 Jun 2025 09:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751128493; x=1751733293; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dxJrJHv1hQNjH00v9GSbVvVf61Sy7siTOuwfasXcsVU=;
        b=j0H0vF7UZkhaCeTNLJBb3v5gJCNhdZrThUH/hOAy8qW25lODXpl/at5F+2+AetMBxX
         H3nd79jEZS+eRwMpJmH5HI+XsXg8m8XFMedBGGcTaFG8yJ7FNPvd40jlI/yLjcErP6xQ
         spbJzUPhTGVH14cHDgyygCb1gX7mgibPKQLIA4FUi1mKB+XFFXXAhcQW2rFAdnZTr07T
         m5F9QVi7yCElpH8h6S6Q6Gm2B2KFLBqEr4k0/9IcCSv28z6yMBuH+AnoVSTNts1Q87XB
         D9hp0Z7CWFdkcv5JJSmOuMua1/afBJYX2ZoUcOEp3b5fgTk1V9zk0cnUQ6d+2t01TbWi
         5tVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751128493; x=1751733293;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxJrJHv1hQNjH00v9GSbVvVf61Sy7siTOuwfasXcsVU=;
        b=LwnXCLDsFKJFrVhhnp2JpNpQQaR6dS7VqaEZLy1UUUicKZqfdqCcQoqpNy856/jPNl
         dp0ZWK9KUrO+CD0SEcmKOz1GqiWWfr3fhtjbzCLa01eZBtJG78LmRG11vyiBxroloQW+
         qyphmfHkzd11cVqoMDkA5m1Eql2eTT8b6bMlE2rRMAgoCKacbb3TmMY6HQpLxaifVmF6
         oA9uzRCkU4s8HYleGDezdTnVFHH3vC3720d7YvRCs1DSeHF7YQy0iXYLiUGXSlladP6u
         M6cg/sgikHqmcRcdzxofJSOWgvilhXQaEie+k49NNgZfT+fIaMJvjHXNREC5yihphLnn
         vdvw==
X-Gm-Message-State: AOJu0YwIGS/eoZfphDeSoNc3k4eSkXj2bLzpvj8LO5dVNQIRsEAIo7TO
	VDdtDhTPV/U375y0b3A5tbv5IUOGVTtriOxd9OaRGZjW+ahKdxOnk+3X0/ZhDw==
X-Gm-Gg: ASbGncttN+SXN1UyQIIawghRgyY2m4ZYz54JoJvvODOgsjqtK2l4YXWL8WnMDmjNi17
	i30o69tFpsYd9FLhd7+WJW9Txnr3rNi6U1JZoO/I1CR0Iy8+jpD9tAwyJBMPNogADJNamcvlj3o
	OCAckyj8pt2t0QGPbt9PUrKJgP4yB3ko0cPBZUDI9DUau8vr/nNS8juIoK3Mx1M4PxGlRaq4lWn
	mY/CEcHCcQFpJvXuUbMZOTBzjbSo3uggItBP+SXhhVzbscaS9cRPxw8kM8GimF6K7jmYkcfHaKr
	bPkMzieGUE177VEF05TtknHtIlbpJ6JvNq6JjYm11jFJ7qANToA7qTAFAnYP61k=
X-Google-Smtp-Source: AGHT+IEAJRngrBldE3BJth3vcjFwgRDyahvndcEP9qfTyhe2TlFtttMM4cuLaTyCMdPCMoxGCMkaIQ==
X-Received: by 2002:a05:6000:4404:b0:3a4:f8e9:cef2 with SMTP id ffacd0b85a97d-3a8fdff42bemr4216830f8f.36.1751128492679;
        Sat, 28 Jun 2025 09:34:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a407743sm83092655e9.33.2025.06.28.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:34:52 -0700 (PDT)
Message-Id: <b68c58b667c29c66433b4634ad44ee9ec5257e80.1751128487.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
References: <pull.1915.v2.git.1746884789.gitgitgadget@gmail.com>
	<pull.1915.v3.git.1751128486.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Jun 2025 16:34:46 +0000
Subject: [PATCH v3 4/4] add-patch: add diff.context command line overrides
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Christian Couder <christian.couder@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

This patch compliments the previous commit, where builtins that use
add-patch infrastructure now respect diff.context and
diff.interHunkContext file configurations.

In particular, this patch helps users who don't want to set persistent
context configurations or just want a way to override them on a one-time
basis, by allowing the relevant builtins to accept corresponding command
line options that override the file configurations.

This mimics commands such as diff and log, which allow for both context
file configuration and command line overrides.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 Documentation/diff-context-options.adoc | 10 +++++
 Documentation/git-add.adoc              |  2 +
 Documentation/git-checkout.adoc         |  2 +
 Documentation/git-commit.adoc           |  2 +
 Documentation/git-reset.adoc            |  2 +
 Documentation/git-restore.adoc          |  2 +
 Documentation/git-stash.adoc            |  2 +
 add-interactive.c                       | 36 ++++++++++++----
 add-interactive.h                       | 16 +++++--
 add-patch.c                             |  5 ++-
 builtin/add.c                           | 21 ++++++++--
 builtin/checkout.c                      | 31 ++++++++++++--
 builtin/commit.c                        | 16 ++++++-
 builtin/reset.c                         | 17 +++++++-
 builtin/stash.c                         | 56 ++++++++++++++++++++-----
 commit.h                                |  3 +-
 parse-options.h                         |  2 +
 t/t3701-add-interactive.sh              | 49 ++++++++++++++++++++++
 t/t4055-diff-context.sh                 | 30 +++++++++++++
 t/t9902-completion.sh                   |  2 +
 20 files changed, 271 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/diff-context-options.adoc

diff --git a/Documentation/diff-context-options.adoc b/Documentation/diff-context-options.adoc
new file mode 100644
index 000000000000..e161260358ff
--- /dev/null
+++ b/Documentation/diff-context-options.adoc
@@ -0,0 +1,10 @@
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset.
diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index eba0b419ce50..b7a735824d6c 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -104,6 +104,8 @@ This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
 
+include::diff-context-options.adoc[]
+
 `-e`::
 `--edit`::
 	Open the diff vs. the index in an editor and let the user
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index ee83b6d9ba9a..40e02cfd6562 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -289,6 +289,8 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 Note that this option uses the no overlay mode by default (see also
 `--overlay`), and currently doesn't support overlay mode.
 
+include::diff-context-options.adoc[]
+
 `--ignore-other-worktrees`::
 	`git checkout` refuses when the wanted branch is already checked
 	out or otherwise in use by another worktree. This option makes
diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index dc219025f1eb..ae988a883b5b 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -76,6 +76,8 @@ OPTIONS
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
+include::diff-context-options.adoc[]
+
 `-C <commit>`::
 `--reuse-message=<commit>`::
 	Take an existing _<commit>_ object, and reuse the log message
diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 53ab88c5451c..50e8a0ba6f66 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -125,6 +125,8 @@ OPTIONS
 	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
+include::diff-context-options.adoc[]
+
 `--`::
 	Do not interpret any more arguments as options.
 
diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
index 877b7772e667..1dcc2bb7aea3 100644
--- a/Documentation/git-restore.adoc
+++ b/Documentation/git-restore.adoc
@@ -52,6 +52,8 @@ leave out at most one of _<rev-A>__ and _<rev-B>_, in which case it defaults to
 	Mode" section of linkgit:git-add[1] to learn how to operate
 	the `--patch` mode.
 
+include::diff-context-options.adoc[]
+
 `-W`::
 `--worktree`::
 `-S`::
diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 1a5177f4986c..0578c619c410 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -208,6 +208,8 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+include::diff-context-options.adoc[]
+
 -S::
 --staged::
 	This option is only valid for `push` and `save` commands.
diff --git a/add-interactive.c b/add-interactive.c
index e0aafb8dd02a..c343568bf7ec 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -36,7 +36,8 @@ static void init_color(struct repository *r, struct add_i_state *s,
 	free(key);
 }
 
-void init_add_i_state(struct add_i_state *s, struct repository *r)
+void init_add_i_state(struct add_i_state *s, struct repository *r,
+		      struct add_p_opt *add_p_opt)
 {
 	const char *value;
 	int context;
@@ -98,6 +99,17 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
 	if (s->use_single_key)
 		setbuf(stdin, NULL);
+
+	if (add_p_opt->context != -1) {
+		if (add_p_opt->context < 0)
+			die(_("%s cannot be negative"), "--unified");
+		s->context = add_p_opt->context;
+	}
+	if (add_p_opt->interhunkcontext != -1) {
+		if (add_p_opt->interhunkcontext < 0)
+			die(_("%s cannot be negative"), "--inter-hunk-context");
+		s->interhunkcontext = add_p_opt->interhunkcontext;
+	}
 }
 
 void clear_add_i_state(struct add_i_state *s)
@@ -986,6 +998,10 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	opts->prompt = N_("Patch update");
 	count = list_and_choose(s, files, opts);
 	if (count > 0) {
+		struct add_p_opt add_p_opt = {
+			.context = s->context,
+			.interhunkcontext = s->interhunkcontext,
+		};
 		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
 
@@ -996,7 +1012,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.v);
-		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
+		res = run_add_p(s->r, ADD_P_ADD, &add_p_opt, NULL, &ps_selected);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
@@ -1031,10 +1047,13 @@ static int run_diff(struct add_i_state *s, const struct pathspec *ps,
 	if (count > 0) {
 		struct child_process cmd = CHILD_PROCESS_INIT;
 
-		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached",
-			     oid_to_hex(!is_initial ? &oid :
-					s->r->hash_algo->empty_tree),
-			     "--", NULL);
+		strvec_pushl(&cmd.args, "git", "diff", "-p", "--cached", NULL);
+		if (s->context != -1)
+			strvec_pushf(&cmd.args, "--unified=%i", s->context);
+		if (s->interhunkcontext != -1)
+			strvec_pushf(&cmd.args, "--inter-hunk-context=%i", s->interhunkcontext);
+		strvec_pushl(&cmd.args, oid_to_hex(!is_initial ? &oid :
+			     s->r->hash_algo->empty_tree), "--", NULL);
 		for (i = 0; i < files->items.nr; i++)
 			if (files->selected[i])
 				strvec_push(&cmd.args,
@@ -1127,7 +1146,8 @@ static void command_prompt_help(struct add_i_state *s)
 			 _("(empty) select nothing"));
 }
 
-int run_add_i(struct repository *r, const struct pathspec *ps)
+int run_add_i(struct repository *r, const struct pathspec *ps,
+	      struct add_p_opt *add_p_opt)
 {
 	struct add_i_state s = { NULL };
 	struct print_command_item_data data = { "[", "]" };
@@ -1170,7 +1190,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 			->util = util;
 	}
 
-	init_add_i_state(&s, r);
+	init_add_i_state(&s, r, add_p_opt);
 
 	/*
 	 * When color was asked for, use the prompt color for
diff --git a/add-interactive.h b/add-interactive.h
index c63f35b14be8..4213dcd67b9a 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -3,6 +3,13 @@
 
 #include "color.h"
 
+struct add_p_opt {
+	int context;
+	int interhunkcontext;
+};
+
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+
 struct add_i_state {
 	struct repository *r;
 	int use_color;
@@ -21,12 +28,14 @@ struct add_i_state {
 	int context, interhunkcontext;
 };
 
-void init_add_i_state(struct add_i_state *s, struct repository *r);
+void init_add_i_state(struct add_i_state *s, struct repository *r,
+		      struct add_p_opt *add_p_opt);
 void clear_add_i_state(struct add_i_state *s);
 
 struct repository;
 struct pathspec;
-int run_add_i(struct repository *r, const struct pathspec *ps);
+int run_add_i(struct repository *r, const struct pathspec *ps,
+	      struct add_p_opt *add_p_opt);
 
 enum add_p_mode {
 	ADD_P_ADD,
@@ -37,6 +46,7 @@ enum add_p_mode {
 };
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
-	      const char *revision, const struct pathspec *ps);
+	      struct add_p_opt *o, const char *revision,
+	      const struct pathspec *ps);
 
 #endif
diff --git a/add-patch.c b/add-patch.c
index b43ca1600738..c0d33820c558 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1766,14 +1766,15 @@ soft_increment:
 }
 
 int run_add_p(struct repository *r, enum add_p_mode mode,
-	      const char *revision, const struct pathspec *ps)
+	      struct add_p_opt *o, const char *revision,
+	      const struct pathspec *ps)
 {
 	struct add_p_state s = {
 		{ r }, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
 	size_t i, binary_count = 0;
 
-	init_add_i_state(&s.s, r);
+	init_add_i_state(&s.s, r, o);
 
 	if (mode == ADD_P_STASH)
 		s.mode = &patch_mode_stash;
diff --git a/builtin/add.c b/builtin/add.c
index 7c292ffdc6c2..a00dab9b8fa0 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -29,6 +29,7 @@ static const char * const builtin_add_usage[] = {
 	NULL
 };
 static int patch_interactive, add_interactive, edit_interactive;
+static struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 static int take_worktree_changes;
 static int add_renormalize;
 static int pathspec_file_nul;
@@ -157,7 +158,7 @@ static int refresh(struct repository *repo, int verbose, const struct pathspec *
 int interactive_add(struct repository *repo,
 		    const char **argv,
 		    const char *prefix,
-		    int patch)
+		    int patch, struct add_p_opt *add_p_opt)
 {
 	struct pathspec pathspec;
 	int ret;
@@ -169,9 +170,9 @@ int interactive_add(struct repository *repo,
 		       prefix, argv);
 
 	if (patch)
-		ret = !!run_add_p(repo, ADD_P_ADD, NULL, &pathspec);
+		ret = !!run_add_p(repo, ADD_P_ADD, add_p_opt, NULL, &pathspec);
 	else
-		ret = !!run_add_i(repo, &pathspec);
+		ret = !!run_add_i(repo, &pathspec, add_p_opt);
 
 	clear_pathspec(&pathspec);
 	return ret;
@@ -253,6 +254,8 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
+	OPT_DIFF_UNIFIED(&add_p_opt.context),
+	OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
@@ -394,6 +397,11 @@ int cmd_add(int argc,
 	prepare_repo_settings(repo);
 	repo->settings.command_requires_full_index = 0;
 
+	if (add_p_opt.context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (add_p_opt.interhunkcontext < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive) {
@@ -401,7 +409,12 @@ int cmd_add(int argc,
 			die(_("options '%s' and '%s' cannot be used together"), "--dry-run", "--interactive/--patch");
 		if (pathspec_from_file)
 			die(_("options '%s' and '%s' cannot be used together"), "--pathspec-from-file", "--interactive/--patch");
-		exit(interactive_add(repo, argv + 1, prefix, patch_interactive));
+		exit(interactive_add(repo, argv + 1, prefix, patch_interactive, &add_p_opt));
+	} else {
+		if (add_p_opt.context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
+		if (add_p_opt.interhunkcontext != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
 	}
 
 	if (edit_interactive) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 536192d3456c..3737ba4c3920 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -61,6 +61,8 @@ static const char * const restore_usage[] = {
 
 struct checkout_opts {
 	int patch_mode;
+	int patch_context;
+	int patch_interhunk_context;
 	int quiet;
 	int merge;
 	int force;
@@ -104,7 +106,12 @@ struct checkout_opts {
 	struct tree *source_tree;
 };
 
-#define CHECKOUT_OPTS_INIT { .conflict_style = -1, .merge = -1 }
+#define CHECKOUT_OPTS_INIT { \
+	.conflict_style = -1, \
+	.merge = -1, \
+	.patch_context = -1, \
+	.patch_interhunk_context = -1, \
+}
 
 struct branch_info {
 	char *name; /* The short name used */
@@ -539,6 +546,10 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	if (opts->patch_mode) {
 		enum add_p_mode patch_mode;
+		struct add_p_opt add_p_opt = {
+			.context = opts->patch_context,
+			.interhunkcontext = opts->patch_interhunk_context,
+		};
 		const char *rev = new_branch_info->name;
 		char rev_oid[GIT_MAX_HEXSZ + 1];
 
@@ -564,8 +575,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		else
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
-		return !!run_add_p(the_repository, patch_mode, rev,
-				   &opts->pathspec);
+		return !!run_add_p(the_repository, patch_mode, &add_p_opt,
+				   rev, &opts->pathspec);
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
@@ -1738,6 +1749,8 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
+		OPT_DIFF_UNIFIED(&opts->patch_context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&opts->patch_interhunk_context),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_PATHSPEC_FROM_FILE(&opts->pathspec_from_file),
@@ -1780,6 +1793,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	argc = parse_options(argc, argv, prefix, options,
 			     usagestr, parseopt_flags);
 
+	if (opts->patch_context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (opts->patch_interhunk_context < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
+	if (!opts->patch_mode) {
+		if (opts->patch_context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (opts->patch_interhunk_context != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+	}
+
 	if (opts->show_progress < 0) {
 		if (opts->quiet)
 			opts->show_progress = 0;
diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64a7..73673bc7db9f 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -19,6 +19,7 @@
 #include "environment.h"
 #include "diff.h"
 #include "commit.h"
+#include "add-interactive.h"
 #include "gettext.h"
 #include "revision.h"
 #include "wt-status.h"
@@ -122,6 +123,7 @@ static const char *edit_message, *use_message;
 static char *fixup_message, *fixup_commit, *squash_message;
 static const char *fixup_prefix;
 static int all, also, interactive, patch_interactive, only, amend, signoff;
+static struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
@@ -354,6 +356,11 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	const char *ret;
 	char *path = NULL;
 
+	if (add_p_opt.context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (add_p_opt.interhunkcontext < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
 	if (is_status)
 		refresh_flags |= REFRESH_UNMERGED;
 	parse_pathspec(&pathspec, 0,
@@ -400,7 +407,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-		if (interactive_add(the_repository, argv, prefix, patch_interactive) != 0)
+		if (interactive_add(the_repository, argv, prefix, patch_interactive, &add_p_opt) != 0)
 			die(_("interactive add failed"));
 
 		the_repository->index_file = old_repo_index_file;
@@ -424,6 +431,11 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		commit_style = COMMIT_NORMAL;
 		ret = get_lock_file_path(&index_lock);
 		goto out;
+	} else {
+		if (add_p_opt.context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
+		if (add_p_opt.interhunkcontext != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
 	}
 
 	/*
@@ -1722,6 +1734,8 @@ int cmd_commit(int argc,
 		OPT_BOOL('i', "include", &also, N_("add specified files to index for commit")),
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
+		OPT_DIFF_UNIFIED(&add_p_opt.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
 		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
diff --git a/builtin/reset.c b/builtin/reset.c
index dc50ffc1ac59..9fb32795c9c5 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -346,6 +346,7 @@ int cmd_reset(int argc,
 	struct object_id oid;
 	struct pathspec pathspec;
 	int intent_to_add = 0;
+	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 	const struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "no-refresh", &no_refresh,
@@ -370,6 +371,8 @@ int cmd_reset(int argc,
 			       PARSE_OPT_OPTARG,
 			       option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
+		OPT_DIFF_UNIFIED(&add_p_opt.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -420,6 +423,11 @@ int cmd_reset(int argc,
 		oidcpy(&oid, &tree->object.oid);
 	}
 
+	if (add_p_opt.context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (add_p_opt.interhunkcontext < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
 	prepare_repo_settings(the_repository);
 	the_repository->settings.command_requires_full_index = 0;
 
@@ -427,9 +435,14 @@ int cmd_reset(int argc,
 		if (reset_type != NONE)
 			die(_("options '%s' and '%s' cannot be used together"), "--patch", "--{hard,mixed,soft}");
 		trace2_cmd_mode("patch-interactive");
-		update_ref_status = !!run_add_p(the_repository, ADD_P_RESET, rev,
-				   &pathspec);
+		update_ref_status = !!run_add_p(the_repository, ADD_P_RESET,
+						&add_p_opt, rev, &pathspec);
 		goto cleanup;
+	} else {
+		if (add_p_opt.context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (add_p_opt.interhunkcontext != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
 	}
 
 	/* git reset tree [--] paths... can be used to
diff --git a/builtin/stash.c b/builtin/stash.c
index 7cd3ad8aa48e..6da162e5e69a 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1242,7 +1242,8 @@ done:
 }
 
 static int stash_patch(struct stash_info *info, const struct pathspec *ps,
-		       struct strbuf *out_patch, int quiet)
+		       struct strbuf *out_patch, int quiet,
+		       struct add_p_opt *add_p_opt)
 {
 	int ret = 0;
 	struct child_process cp_read_tree = CHILD_PROCESS_INIT;
@@ -1267,7 +1268,7 @@ static int stash_patch(struct stash_info *info, const struct pathspec *ps,
 	old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 	setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-	ret = !!run_add_p(the_repository, ADD_P_STASH, NULL, ps);
+	ret = !!run_add_p(the_repository, ADD_P_STASH, add_p_opt, NULL, ps);
 
 	the_repository->index_file = old_repo_index_file;
 	if (old_index_env && *old_index_env)
@@ -1362,8 +1363,8 @@ done:
 }
 
 static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_buf,
-			   int include_untracked, int patch_mode, int only_staged,
-			   struct stash_info *info, struct strbuf *patch,
+			   int include_untracked, int patch_mode, struct add_p_opt *add_p_opt,
+			   int only_staged, struct stash_info *info, struct strbuf *patch,
 			   int quiet)
 {
 	int ret = 0;
@@ -1444,7 +1445,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch, quiet);
+		ret = stash_patch(info, ps, patch, quiet, add_p_opt);
 		if (ret < 0) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
@@ -1519,7 +1520,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1530,7 +1531,8 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, int include_untracked, int only_staged)
+			 int keep_index, int patch_mode, struct add_p_opt *add_p_opt,
+			 int include_untracked, int only_staged)
 {
 	int ret = 0;
 	struct stash_info info = STASH_INFO_INIT;
@@ -1600,8 +1602,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode, only_staged,
-			    &info, &patch, quiet)) {
+	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
+			    add_p_opt, only_staged, &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
@@ -1774,6 +1776,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	const char *stash_msg = NULL;
 	char *pathspec_from_file = NULL;
 	struct pathspec ps;
+	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1781,6 +1784,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_DIFF_UNIFIED(&add_p_opt.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
@@ -1836,8 +1841,20 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
+	if (!patch_mode) {
+		if (add_p_opt.context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (add_p_opt.interhunkcontext != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+	}
+
+	if (add_p_opt.context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (add_p_opt.interhunkcontext < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			    include_untracked, only_staged);
+			    &add_p_opt, include_untracked, only_staged);
 
 	clear_pathspec(&ps);
 	free(pathspec_from_file);
@@ -1862,6 +1879,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 	const char *stash_msg = NULL;
 	struct pathspec ps;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1869,6 +1887,8 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_DIFF_UNIFIED(&add_p_opt.context),
+		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
@@ -1887,8 +1907,22 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
+
+	if (add_p_opt.context < -1)
+		die(_("'%s' cannot be negative"), "--unified");
+	if (add_p_opt.interhunkcontext < -1)
+		die(_("'%s' cannot be negative"), "--inter-hunk-context");
+
+	if (!patch_mode) {
+		if (add_p_opt.context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (add_p_opt.interhunkcontext != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+	}
+
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
-			    patch_mode, include_untracked, only_staged);
+			    patch_mode, &add_p_opt, include_untracked,
+			    only_staged);
 
 	strbuf_release(&stash_msg_buf);
 	return ret;
diff --git a/commit.h b/commit.h
index 70c870dae4d4..7a7fedbc2f14 100644
--- a/commit.h
+++ b/commit.h
@@ -2,6 +2,7 @@
 #define COMMIT_H
 
 #include "object.h"
+#include "add-interactive.h"
 
 struct signature_check;
 struct strbuf;
@@ -257,7 +258,7 @@ int for_each_commit_graft(each_commit_graft_fn, void *);
 int interactive_add(struct repository *repo,
 		    const char **argv,
 		    const char *prefix,
-		    int patch);
+		    int patch, struct add_p_opt *add_p_opt);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;
diff --git a/parse-options.h b/parse-options.h
index 91c3e3c29b3d..bdae8f116198 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -616,6 +616,8 @@ int parse_opt_tracking_mode(const struct option *, const char *, int);
 #define OPT_PATHSPEC_FROM_FILE(v) OPT_FILENAME(0, "pathspec-from-file", v, N_("read pathspec from file"))
 #define OPT_PATHSPEC_FILE_NUL(v)  OPT_BOOL(0, "pathspec-file-nul", v, N_("with --pathspec-from-file, pathspec elements are separated with NUL character"))
 #define OPT_AUTOSTASH(v) OPT_BOOL(0, "autostash", v, N_("automatically stash/stash pop before and after"))
+#define OPT_DIFF_UNIFIED(v) OPT_INTEGER_F('U', "unified", v, N_("generate diffs with <n> lines context"), PARSE_OPT_NONEG)
+#define OPT_DIFF_INTERHUNK_CONTEXT(v) OPT_INTEGER_F(0, "inter-hunk-context", v, N_("show context between diff hunks up to the specified number of lines"), PARSE_OPT_NONEG)
 
 #define OPT_IPVERSION(v) \
 	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 18dc329ea1f6..d08a87f9ec53 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1252,4 +1252,53 @@ test_expect_success 'add -p rejects negative diff.context' '
 	test_grep "diff.context cannot be negative" output
 '
 
+for cmd in add checkout restore 'commit -m file'
+do
+	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" "
+		test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
+		git add file &&
+		test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
+		echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
+			$cmd -p -U 4 --inter-hunk-context 2 >actual &&
+		test_grep \"@@ -2,20 +2,20 @@\" actual
+	"
+done
+
+test_expect_success 'reset accepts -U and --inter-hunk-context' '
+	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
+	git commit -m file file &&
+	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
+	git add file &&
+	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
+		reset -p -U 4 --inter-hunk-context 2 >actual &&
+	test_grep "@@ -2,20 +2,20 @@" actual
+'
+
+test_expect_success 'stash accepts -U and --inter-hunk-context' '
+	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
+	git commit -m file file &&
+	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
+	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
+		stash -p -U 4 --inter-hunk-context 2 >actual &&
+	test_grep "@@ -2,20 +2,20 @@" actual
+'
+
+for cmd in add checkout commit reset restore 'stash save' 'stash push'
+do
+	test_expect_success "$cmd rejects invalid context options" "
+		test_must_fail git $cmd -p -U -3 2>actual &&
+		cat actual | echo &&
+		test_grep -e \"'--unified' cannot be negative\" actual &&
+
+		test_must_fail git $cmd -p --inter-hunk-context -3 2>actual &&
+		test_grep -e \"'--inter-hunk-context' cannot be negative\" actual &&
+
+		test_must_fail git $cmd -U 7 2>actual &&
+		test_grep -E \"'--unified' requires '(--interactive/)?--patch'\" actual &&
+
+		test_must_fail git $cmd --inter-hunk-context 2 2>actual &&
+		test_grep -E \"'--inter-hunk-context' requires '(--interactive/)?--patch'\" actual
+	"
+done
+
 test_done
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 1384a8195705..0158fe6568cb 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -58,6 +58,36 @@ test_expect_success 'The -U option overrides diff.context' '
 	test_grep ! "^ firstline" output
 '
 
+test_expect_success 'The -U option overrides diff.context for "add"' '
+	test_config diff.context 8 &&
+	git add -U4 -p >output &&
+	test_grep ! "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "commit"' '
+	test_config diff.context 8 &&
+	! git commit -U4 -p >output &&
+	test_grep ! "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "checkout"' '
+	test_config diff.context 8 &&
+	git checkout -U4 -p >output &&
+	test_grep ! "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "stash"' '
+	test_config diff.context 8 &&
+	! git stash -U4 -p >output &&
+	test_grep ! "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "restore"' '
+	test_config diff.context 8 &&
+	git restore -U4 -p >output &&
+	test_grep ! "^ firstline" output
+'
+
 test_expect_success 'diff.context honored by "diff"' '
 	test_config diff.context 8 &&
 	git diff >output &&
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 343b8cd1912b..6650d33fba69 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2596,6 +2596,8 @@ test_expect_success 'double dash "git checkout"' '
 	--merge Z
 	--conflict=Z
 	--patch Z
+	--unified=Z
+	--inter-hunk-context=Z
 	--ignore-skip-worktree-bits Z
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
-- 
gitgitgadget
