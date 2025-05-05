Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9F1C8619
	for <git@vger.kernel.org>; Mon,  5 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436727; cv=none; b=cGJtxhgffAzIoqjUbGEl1XimHDpYx9RwEdwXgIdbcCMMlwLEpx9OorQE5BavFRzLQ2vxPyvr/LK9jgeeMYKVVRjSCOyhNIqftIAKi+qZxKKpCJxcUncKTxO/06TsjjQFK7i06dv7VzggJypnk1HJhuS64Ud76nMtb/KlLaITy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436727; c=relaxed/simple;
	bh=KdL+DjwQIsQRwsL+4f1MafJr6o40Dn7K7X1HsYnOOHw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MWp993R0J0MK445hwIuJ6s80okNwSbVhDNO9YgNTF8TE1/C5ieRXVn1SXjNvfALFHj/qiC9Wr97KFDF9I0x0FnpqsVChqh6QrSR21bKZlBsr2jzErH9ygnTry4ehsn2TRSI49XwegDCEkskyiB4dHDzEav+AX5X1DC1jJRp2aW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KItnlssd; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KItnlssd"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso39514565e9.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436722; x=1747041522; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV/km/9QbM7nB/TNbaM7wWVQsaM24GBUUE2aZl+88AM=;
        b=KItnlssdWj2tELqgpWZirIAhiMEdhmhEf8rr7wuC8PWNO+AhX+GMbjUJfnoUGTZ3RG
         omlSxmS2BRc+SgAvgrRzFxwfCqUef2urdWcgkEK3kJSJ7JOxIS7FRXMo9DX0aS9mKol4
         tTZgczEN3FqhUXmUNWYmMHbuPpU5EAlNT/pF+/WUl9zfy/Ba84Z/IDVvwJ80mnLQiQP2
         EdAeG22bjJXjHBdAUP6Xoir1FU8X+hSdfiBIfmNwLzbvsTyKTHtBV/oKF2MRiRtnSlMg
         0vLLNbgSr+WS0UV/RIn6qGGowUeeG7KXCWIvwVcACuZ/sGC9XDQnRyhdohR3MO4tHZ6H
         1gHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436722; x=1747041522;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV/km/9QbM7nB/TNbaM7wWVQsaM24GBUUE2aZl+88AM=;
        b=NAeRss0x/QYi9hh7nUmMeg7sDz8ZfA4om8ro2r2s5jYyn6VwjcViqLH9sqTuSwe0Yq
         R+cgvg1YERSYQNhXifIEXzWeW2mVBxUpB/9ShXqHmA+w8uWQoOEuUAhuvBAJ7XiuaWID
         wM/o/95JURU/sZGXg66QMysh2FfrFNbRx75HhIRPOGEsPedISObTCcHDyggPXO3PZqrs
         +vZwjCkXbVaxiGXaujsLhWTquIQw9bUsTkki7q1DBEy36RI61Z3p7eSqQ2ISncK/NKq5
         FmkwqcA4uvxiY31QiPRln68nL/XahVxYwwh+uIGBdRlVc3aMkr83WM7GqVjUR+cucyzF
         Jbjw==
X-Gm-Message-State: AOJu0YyDWbR7D0s/EhpW90zxtkKK35ECDK0zzqbVffuBC2s2OSRyZPYz
	/heFCVQCD58ggtLF58fzZI/HDZEzlOxhiiQbc/l4vYrkcY6ZiD4ziyggyw==
X-Gm-Gg: ASbGncuQm6e74qHIPqy8fZsrYWH5CEdpdn/9SYe8cY4A8TaeqgIMHTeUhyWBvXWrCxO
	NurU+mAGCiMY0OLcWR83DjnnjWoIFjJ7TWsawxxUQ0pfGGCM4ex1vm2blCS48mca24M0F85L4Zh
	eH2/eXPdMYifmo609IfETNYEPzHBzjFqRxYygzZZD2lUUf6Xbpcu2b2QpFIH9JFzcKqaMQQHoOu
	6WbnCGgvyZmY2rk9dCesweXYtmOppdzowAzkr6DhUOxPCojWfnY52XhOrbQRrvKAUIxjcIsUKIN
	98kse8YYd7Y8+EWha0j+1iWT5/00DQBUxj+5ggFWlw==
X-Google-Smtp-Source: AGHT+IHRX3Gak5y//jKM3SjkMVZYS3pRHypp/TS+2Kg/Nq7lYlsLfhmHV94ajuS3eVMGbb5j9Nxq2A==
X-Received: by 2002:a5d:47c7:0:b0:39d:724f:a8ae with SMTP id ffacd0b85a97d-3a09fd9a77cmr4702139f8f.33.1746436722081;
        Mon, 05 May 2025 02:18:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b89edfc2sm125246075e9.20.2025.05.05.02.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:18:41 -0700 (PDT)
Message-Id: <7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
From: "Leon Michalak via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 05 May 2025 09:18:38 +0000
Subject: [PATCH 2/3] add-patch: add diff.context command line overrides
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
Cc: Leon Michalak <leonmichalak6@gmail.com>,
    Leon Michalak <leonmichalak6@gmail.com>

From: Leon Michalak <leonmichalak6@gmail.com>

This patch compliments `8b91eef812`, where builtins that accept
`--patch` options now respect `diff.context` and `diff.interHunkContext`
file configurations.

In particular, this patch helps users who don't want to set persistent
context configurations or just want a way to override them on a one-time
basis, by allowing the relevant builtins to accept corresponding command
line options that override the file configurations.

This mimics `diff` which allows for both context file configuration and
command line overrides.

Signed-off-by: Leon Michalak <leonmichalak6@gmail.com>
---
 Documentation/git-add.adoc      | 11 +++++++
 Documentation/git-checkout.adoc | 11 +++++++
 Documentation/git-commit.adoc   | 11 +++++++
 Documentation/git-reset.adoc    | 11 +++++++
 Documentation/git-restore.adoc  | 11 +++++++
 Documentation/git-stash.adoc    | 11 +++++++
 add-interactive.c               | 19 +++++++++---
 add-interactive.h               | 17 +++++++++--
 add-patch.c                     |  5 +--
 builtin/add.c                   | 21 ++++++++++---
 builtin/checkout.c              | 28 +++++++++++++++--
 builtin/commit.c                | 15 ++++++++-
 builtin/reset.c                 | 16 ++++++++--
 builtin/stash.c                 | 54 ++++++++++++++++++++++++++-------
 commit.h                        |  3 +-
 t/t4055-diff-context.sh         | 30 ++++++++++++++++++
 t/t9902-completion.sh           |  2 ++
 17 files changed, 245 insertions(+), 31 deletions(-)

diff --git a/Documentation/git-add.adoc b/Documentation/git-add.adoc
index eba0b419ce50..e3a50706acd5 100644
--- a/Documentation/git-add.adoc
+++ b/Documentation/git-add.adoc
@@ -104,6 +104,17 @@ This effectively runs `add --interactive`, but bypasses the
 initial command menu and directly jumps to the `patch` subcommand.
 See ``Interactive mode'' for details.
 
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset. Implies `--interactive/--patch`.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset. Implies `--interactive/--patch`.
+
 `-e`::
 `--edit`::
 	Open the diff vs. the index in an editor and let the user
diff --git a/Documentation/git-checkout.adoc b/Documentation/git-checkout.adoc
index a66c53a5cd1e..46286a6c8c9e 100644
--- a/Documentation/git-checkout.adoc
+++ b/Documentation/git-checkout.adoc
@@ -289,6 +289,17 @@ section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 Note that this option uses the no overlay mode by default (see also
 `--overlay`), and currently doesn't support overlay mode.
 
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset. Implies `--patch`.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset. Implies `--patch`.
+
 --ignore-other-worktrees::
 	`git checkout` refuses when the wanted branch is already checked
 	out or otherwise in use by another worktree. This option makes
diff --git a/Documentation/git-commit.adoc b/Documentation/git-commit.adoc
index dc219025f1eb..c0b206aee9c9 100644
--- a/Documentation/git-commit.adoc
+++ b/Documentation/git-commit.adoc
@@ -76,6 +76,17 @@ OPTIONS
 	which changes to commit. See linkgit:git-add[1] for
 	details.
 
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset. Implies `--interactive/--patch`.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset. Implies `--interactive/--patch`.
+
 `-C <commit>`::
 `--reuse-message=<commit>`::
 	Take an existing _<commit>_ object, and reuse the log message
diff --git a/Documentation/git-reset.adoc b/Documentation/git-reset.adoc
index 53ab88c5451c..6fcc86a3b960 100644
--- a/Documentation/git-reset.adoc
+++ b/Documentation/git-reset.adoc
@@ -125,6 +125,17 @@ OPTIONS
 	separated with _NUL_ character and all other characters are taken
 	literally (including newlines and quotes).
 
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset. Implies `--patch`.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset. Implies `--patch`.
+
 `--`::
 	Do not interpret any more arguments as options.
 
diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
index 877b7772e667..49d7e6b5a5c8 100644
--- a/Documentation/git-restore.adoc
+++ b/Documentation/git-restore.adoc
@@ -52,6 +52,17 @@ leave out at most one of _<rev-A>__ and _<rev-B>_, in which case it defaults to
 	Mode" section of linkgit:git-add[1] to learn how to operate
 	the `--patch` mode.
 
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset. Implies `--patch`.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset. Implies `--patch`.
+
 `-W`::
 `--worktree`::
 `-S`::
diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index 1a5177f4986c..24916fa0723e 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -208,6 +208,17 @@ to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+`-U<n>`::
+`--unified=<n>`::
+	Generate diffs with _<n>_ lines of context. Defaults to `diff.context`
+	or 3 if the config option is unset. Implies `--patch`.
+
+`--inter-hunk-context=<n>`::
+	Show the context between diff hunks, up to the specified _<number>_
+	of lines, thereby fusing hunks that are close to each other.
+	Defaults to `diff.interHunkContext` or 0 if the config option
+	is unset. Implies `--patch`.
+
 -S::
 --staged::
 	This option is only valid for `push` and `save` commands.
diff --git a/add-interactive.c b/add-interactive.c
index ad12dc416598..1ea8eb711a60 100644
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
 
@@ -86,6 +87,11 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	repo_config_get_bool(r, "interactive.singlekey", &s->use_single_key);
 	if (s->use_single_key)
 		setbuf(stdin, NULL);
+
+	if (add_p_opt->context != -1)
+		s->context = add_p_opt->context;
+	if (add_p_opt->interhunkcontext != -1)
+		s->interhunkcontext = add_p_opt->interhunkcontext;
 }
 
 void clear_add_i_state(struct add_i_state *s)
@@ -974,6 +980,10 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 	opts->prompt = N_("Patch update");
 	count = list_and_choose(s, files, opts);
 	if (count > 0) {
+		struct add_p_opt add_p_opt = {
+			.context = s->context,
+			.interhunkcontext = s->interhunkcontext,
+		};
 		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
 
@@ -984,7 +994,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		parse_pathspec(&ps_selected,
 			       PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL,
 			       PATHSPEC_LITERAL_PATH, "", args.v);
-		res = run_add_p(s->r, ADD_P_ADD, NULL, &ps_selected);
+		res = run_add_p(s->r, ADD_P_ADD, &add_p_opt, NULL, &ps_selected);
 		strvec_clear(&args);
 		clear_pathspec(&ps_selected);
 	}
@@ -1118,7 +1128,8 @@ static void command_prompt_help(struct add_i_state *s)
 			 _("(empty) select nothing"));
 }
 
-int run_add_i(struct repository *r, const struct pathspec *ps)
+int run_add_i(struct repository *r, const struct pathspec *ps,
+	      struct add_p_opt *add_p_opt)
 {
 	struct add_i_state s = { NULL };
 	struct print_command_item_data data = { "[", "]" };
@@ -1161,7 +1172,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 			->util = util;
 	}
 
-	init_add_i_state(&s, r);
+	init_add_i_state(&s, r, add_p_opt);
 
 	/*
 	 * When color was asked for, use the prompt color for
diff --git a/add-interactive.h b/add-interactive.h
index 693f125e8e4b..653f07a917b8 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -3,6 +3,13 @@
 
 #include "color.h"
 
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+
+struct add_p_opt {
+	int context;
+	int interhunkcontext;
+};
+
 struct add_i_state {
 	struct repository *r;
 	int use_color;
@@ -18,14 +25,17 @@ struct add_i_state {
 
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
+	int context, interhunkcontext;
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
@@ -36,6 +46,7 @@ enum add_p_mode {
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
index 78dfb2657767..9b4e618b3fe2 100644
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
@@ -169,9 +170,10 @@ int interactive_add(struct repository *repo,
 		       prefix, argv);
 
 	if (patch)
-		ret = !!run_add_p(repo, ADD_P_ADD, NULL, &pathspec);
+		ret = !!run_add_p(repo, ADD_P_ADD, add_p_opt, NULL,
+				  &pathspec);
 	else
-		ret = !!run_add_i(repo, &pathspec);
+		ret = !!run_add_i(repo, &pathspec, add_p_opt);
 
 	clear_pathspec(&pathspec);
 	return ret;
@@ -253,6 +255,12 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
+	OPT_INTEGER_F('U', "unified", &add_p_opt.context,
+		      N_("generate diffs with <n> lines context, implies --interactive/--patch"),
+		      PARSE_OPT_NONEG),
+	OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
+		      N_("show context between diff hunks up to the specified number of lines, implies --interactive/--patch"),
+		      PARSE_OPT_NONEG),
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
 	OPT__FORCE(&ignored_too, N_("allow adding otherwise ignored files"), 0),
 	OPT_BOOL('u', "update", &take_worktree_changes, N_("update tracked files")),
@@ -398,7 +406,12 @@ int cmd_add(int argc,
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
index d185982f3a63..22bd7b1d2b3b 100644
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
 
@@ -564,8 +575,13 @@ static int checkout_paths(const struct checkout_opts *opts,
 		else
 			BUG("either flag must have been set, worktree=%d, index=%d",
 			    opts->checkout_worktree, opts->checkout_index);
-		return !!run_add_p(the_repository, patch_mode, rev,
-				   &opts->pathspec);
+		return !!run_add_p(the_repository, patch_mode, &add_p_opt,
+				   rev, &opts->pathspec);
+	} else {
+		if (opts->patch_context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (opts->patch_interhunk_context != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
 	}
 
 	repo_hold_locked_index(the_repository, &lock_file, LOCK_DIE_ON_ERROR);
@@ -1738,6 +1754,12 @@ static struct option *add_checkout_path_options(struct checkout_opts *opts,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
 		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
+		OPT_INTEGER_F('U', "unified", &opts->patch_context,
+			N_("generate diffs with <n> lines context, implies --patch"),
+			PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "inter-hunk-context", &opts->patch_interhunk_context,
+			N_("show context between diff hunks up to the specified number of lines, implies --patch"),
+			PARSE_OPT_NONEG),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_PATHSPEC_FROM_FILE(&opts->pathspec_from_file),
diff --git a/builtin/commit.c b/builtin/commit.c
index 66bd91fd523d..5831fd019717 100644
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
@@ -400,7 +402,7 @@ static const char *prepare_index(const char **argv, const char *prefix,
 		old_index_env = xstrdup_or_null(getenv(INDEX_ENVIRONMENT));
 		setenv(INDEX_ENVIRONMENT, the_repository->index_file, 1);
 
-		if (interactive_add(the_repository, argv, prefix, patch_interactive) != 0)
+		if (interactive_add(the_repository, argv, prefix, patch_interactive, &add_p_opt) != 0)
 			die(_("interactive add failed"));
 
 		the_repository->index_file = old_repo_index_file;
@@ -424,6 +426,11 @@ static const char *prepare_index(const char **argv, const char *prefix,
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
@@ -1722,6 +1729,12 @@ int cmd_commit(int argc,
 		OPT_BOOL('i', "include", &also, N_("add specified files to index for commit")),
 		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
 		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
+			      N_("generate diffs with <n> lines context, implies --interactive/--patch"),
+			      PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
+			      N_("show context between diff hunks up to the specified number of lines, implies --interactive/--patch"),
+			      PARSE_OPT_NONEG),
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
 		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
diff --git a/builtin/reset.c b/builtin/reset.c
index 73b4537a9a56..ee39d6277381 100644
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
@@ -370,6 +371,12 @@ int cmd_reset(int argc,
 			       PARSE_OPT_OPTARG,
 			       option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
+			       N_("generate diffs with <n> lines context, implies --patch"),
+			       PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
+			       N_("show context between diff hunks up to the specified number of lines, implies --patch"),
+			       PARSE_OPT_NONEG),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
 				N_("record only the fact that removed paths will be added later")),
 		OPT_PATHSPEC_FROM_FILE(&pathspec_from_file),
@@ -424,9 +431,14 @@ int cmd_reset(int argc,
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
index cfbd92852a65..dc82bc34b762 100644
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
@@ -1439,7 +1440,7 @@ static int do_create_stash(const struct pathspec *ps, struct strbuf *stash_msg_b
 		untracked_commit_option = 1;
 	}
 	if (patch_mode) {
-		ret = stash_patch(info, ps, patch, quiet);
+		ret = stash_patch(info, ps, patch, quiet, add_p_opt);
 		if (ret < 0) {
 			if (!quiet)
 				fprintf_ln(stderr, _("Cannot save the current "
@@ -1513,7 +1514,7 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 	if (!check_changes_tracked_files(&ps))
 		return 0;
 
-	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, 0, &info,
+	ret = do_create_stash(&ps, &stash_msg_buf, 0, 0, NULL, 0, &info,
 			      NULL, 0);
 	if (!ret)
 		printf_ln("%s", oid_to_hex(&info.w_commit));
@@ -1524,7 +1525,8 @@ static int create_stash(int argc, const char **argv, const char *prefix UNUSED,
 }
 
 static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int quiet,
-			 int keep_index, int patch_mode, int include_untracked, int only_staged)
+			 int keep_index, int patch_mode, struct add_p_opt *add_p_opt,
+			 int include_untracked, int only_staged)
 {
 	int ret = 0;
 	struct stash_info info = STASH_INFO_INIT;
@@ -1594,8 +1596,8 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode, only_staged,
-			    &info, &patch, quiet)) {
+	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
+			    add_p_opt, only_staged, &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
 	}
@@ -1768,6 +1770,7 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 	const char *stash_msg = NULL;
 	char *pathspec_from_file = NULL;
 	struct pathspec ps;
+	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1775,6 +1778,12 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
+			      N_("generate diffs with <n> lines context, implies --patch"),
+			      PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
+			      N_("show context between diff hunks up to the specified number of lines, implies --patch"),
+			      PARSE_OPT_NONEG),
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
@@ -1826,8 +1835,15 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 		die(_("the option '%s' requires '%s'"), "--pathspec-file-nul", "--pathspec-from-file");
 	}
 
+	if (!patch_mode) {
+		if (add_p_opt.context != -1)
+			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
+		if (add_p_opt.interhunkcontext != -1)
+			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+	}
+
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index, patch_mode,
-			    include_untracked, only_staged);
+			    &add_p_opt, include_untracked, only_staged);
 
 	clear_pathspec(&ps);
 	free(pathspec_from_file);
@@ -1852,6 +1868,7 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 	const char *stash_msg = NULL;
 	struct pathspec ps;
 	struct strbuf stash_msg_buf = STRBUF_INIT;
+	struct add_p_opt add_p_opt = ADD_P_OPT_INIT;
 	struct option options[] = {
 		OPT_BOOL('k', "keep-index", &keep_index,
 			 N_("keep index")),
@@ -1859,6 +1876,12 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_INTEGER_F('U', "unified", &add_p_opt.context,
+			      N_("generate diffs with <n> lines context, implies --patch"),
+			      PARSE_OPT_NONEG),
+		OPT_INTEGER_F(0, "inter-hunk-context", &add_p_opt.interhunkcontext,
+			      N_("show context between diff hunks up to the specified number of lines, implies --patch"),
+			      PARSE_OPT_NONEG),
 		OPT__QUIET(&quiet, N_("quiet mode")),
 		OPT_BOOL('u', "include-untracked", &include_untracked,
 			 N_("include untracked files in stash")),
@@ -1877,8 +1900,17 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 		stash_msg = strbuf_join_argv(&stash_msg_buf, argc, argv, ' ');
 
 	memset(&ps, 0, sizeof(ps));
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
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 9c024200ade7..1c1e62b434ec 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -104,6 +104,36 @@ test_expect_success 'The -U option overrides diff.context' '
 	! grep "^ firstline" output
 '
 
+test_expect_success 'The -U option overrides diff.context for "add"' '
+	git config diff.context 8 &&
+	git add -U4 -p >output &&
+	! grep "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "commit"' '
+	git config diff.context 8 &&
+	! git commit -U4 -p >output &&
+	! grep "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "checkout"' '
+	git config diff.context 8 &&
+	git checkout -U4 -p >output &&
+	! grep "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "stash"' '
+	git config diff.context 8 &&
+	! git stash -U4 -p >output &&
+	! grep "^ firstline" output
+'
+
+test_expect_success 'The -U option overrides diff.context for "restore"' '
+	git config diff.context 8 &&
+	git restore -U4 -p >output &&
+	! grep "^ firstline" output
+'
+
 test_expect_success 'diff.context honored by "diff"' '
 	git config diff.context 8 &&
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

