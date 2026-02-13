Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A7D3033F9
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 22:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771020583; cv=none; b=I8fhVq/IBkJfYeZbbHetr39EmcsO43uPc7+RQadzzkZJEKzWt8GrEJ33E6s4VQEEVSQ1FVTW8XutuQUhxB3TthQido4vYeGasM5KoODBH3nYv7YKHAr39VgVc8tDG7ZxzT8AaZvtFyG+Bbh84lzl02zplU43j+++ltJYBRgvT9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771020583; c=relaxed/simple;
	bh=dMttZYyYvula70NdiPdAGJyYq9lKArDnJNppLsgChGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8pCdNc1yykznDfov3GY91v3OH/s+vLke7dMm+2jK/u0gLkX+wn2F5EK5f0hVMoBPJ+d+umucGWDHTRSO0zTQhQwMOpKRhPMaY+JMpVRYC2sWUnHiPkZaYfDTWculJEzVsfG5TiMfdv1iFRyEVI3KU0dm55ByLt+KJ5ElLuIMqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QGpCWneK; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGpCWneK"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso8459355e9.0
        for <git@vger.kernel.org>; Fri, 13 Feb 2026 14:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771020580; x=1771625380; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlzZVdfzcawxLmuA/WRriLII1ESDEFHubGgCLBmEcQM=;
        b=QGpCWneKFf1CLa/Lu0aqXMCIbVUgxUT+Q9UA9O6s629Q1Kgtv25RTzAW0RNq7yi6WS
         hF9Ylsg9txHn7xs5n6nkgtj58rUQ1dZKrmtztRB25hXt+bOSNtc92WaYkq5iQB/j9J6e
         OSl+Ce2g8oKjpuivfx+gQ6OPZ3PNUkcjWakt/lWMI2N6wZKyrn2dcDUsREG3DCzplCwB
         iTolDSDLdf5pFfgXjSFQxj9s/7mhLD3XGcPYHvMzf1jWZmnja/LvAuG8uko1kqfKvhds
         P3IQF5M31Qi5f3gZpd6L62FSIwD9Z/y8nNlcIxR/GqT6n5RwmQ2mpZBkyMbdx1vGzbKu
         rHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771020580; x=1771625380;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlzZVdfzcawxLmuA/WRriLII1ESDEFHubGgCLBmEcQM=;
        b=MzoqoGv0jHd71looIzfgvhUSICNtv2oFnMbSzlt99eSBIs/IQmdD36KfmqEeOzgypv
         W5mcpT8FplUvOhCe85dRk1G63hnyJJdZQxgAVHV8flU41LpF7PiUgxegLS4a+2KfZ86t
         hzw54SCImx3zkSwhOtTWr1r+x8c2Lcgxe+bVv5367FRUiOPFPM8MRVYTW2CWxMDBPJi8
         TAHvXd6iHrFRntbtjnQ7QYyeBrVvr0xNkF9SBoqT5ik12lQwTcqwlJ1Iv273oYfzrK4B
         GZ4ZXGNCz8vN80ECZoK+1gQPX/AOstwUx3GVwJocmNn+dWW0KXb4MvVJDsX7/ps0Ck3s
         nNuw==
X-Gm-Message-State: AOJu0YzYTYRzLRxCVPiGIeB8mWbga01Mv2iug0TEfVluBpwUh1UYWna3
	WIofyQfypNIiFYwFy3CXEC8UJtwSeZU9Ynb1w5pqC2D5jXzS0h+Vk83+WNA8cZNM
X-Gm-Gg: AZuq6aII1Curpn9MrCQwWHHrmCc2a99F1Mg0ZHPquisHtvFEO6Hp4jZgDVEMfomV+ca
	AQuusIbdWrB79srA1mi3IDruyUPlwYY/1VQnhmWhs7Te5Y67AkQMnU4fm6Jwo9YcPMxYuNeEjZd
	wGebXQ8EQNupSsiy8+ev6br9q+0oLEQ7K65LPB8odqn0qiw4SDGzRsaetJwYSFYB1z6hytxLlvd
	HDOxjsIg4OXzU09vWTmlPHOQa8Vljg5lBQXVfqZA+w49s320CoIPYgkHpCg+/X7HxxM9MoKiR/x
	WjBYRg4Ig1P+GbHwGMdTZoXMKzbP+1gWrpVFASqjxQq/C7pL1jlUit2VUmDz3KigGN/YkdCsflI
	7VBYdja0hxNTBzbB3cdfl66twxEqGp+E++h7iLIj/EemfhGxzghK8T3Vp8kJ045FYCxaAWaZIDA
	ZP2pBjwfpZU9mYny7vTeTTS/+FBJxivw==
X-Received: by 2002:a05:600c:8183:b0:479:1348:c63e with SMTP id 5b1f17b1804b1-48378d9ccc7mr25774945e9.9.1771020579992;
        Fri, 13 Feb 2026 14:09:39 -0800 (PST)
Received: from localhost ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d5ebd1bsm319189345e9.6.2026.02.13.14.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 14:09:39 -0800 (PST)
Date: Fri, 13 Feb 2026 23:09:45 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: [PATCH v4 1/4] interactive -p: add new `--auto-advance` flag
Message-ID: <497ca5b43c84dc4d146a18899461cd02564c0268.1771015581.git.abrahamadekunle50@gmail.com>
References: <cover.1771015581.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771015581.git.abrahamadekunle50@gmail.com>

When using the interactive add, reset, stash or checkout machinery,
we do not have the option of reworking with a file when selecting
hunks, because the session automatically advances to the next file
or ends if we have just one file.

Introduce the flag `--auto-advance` which auto advances by default,
when interactively selecting patches with the '--patch' option.
However, the `--no-auto-advance` option does not auto advance, thereby
allowing users the option to rework with files.

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 add-interactive.c     | 4 ++++
 add-interactive.h     | 5 +++--
 builtin/add.c         | 4 ++++
 builtin/checkout.c    | 7 +++++++
 builtin/reset.c       | 4 ++++
 builtin/stash.c       | 8 ++++++++
 t/t9902-completion.sh | 1 +
 7 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 95ec5a89f8..c3a36cd11f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -64,6 +64,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 	s->r = r;
 	s->context = -1;
 	s->interhunkcontext = -1;
+	s->auto_advance = 1;
 
 	s->use_color_interactive = check_color_config(r, "color.interactive");
 
@@ -124,6 +125,8 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 			die(_("%s cannot be negative"), "--inter-hunk-context");
 		s->interhunkcontext = add_p_opt->interhunkcontext;
 	}
+	if (!add_p_opt->auto_advance)
+		s->auto_advance = 0;
 }
 
 void clear_add_i_state(struct add_i_state *s)
@@ -1017,6 +1020,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		struct add_p_opt add_p_opt = {
 			.context = s->context,
 			.interhunkcontext = s->interhunkcontext,
+			.auto_advance = s->auto_advance
 		};
 		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
diff --git a/add-interactive.h b/add-interactive.h
index da49502b76..cea29a6965 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -6,9 +6,10 @@
 struct add_p_opt {
 	int context;
 	int interhunkcontext;
+	int auto_advance;
 };
 
-#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
+#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1, .auto_advance = 1 }
 
 struct add_i_state {
 	struct repository *r;
@@ -28,7 +29,7 @@ struct add_i_state {
 
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
-	int context, interhunkcontext;
+	int context, interhunkcontext, auto_advance;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r,
diff --git a/builtin/add.c b/builtin/add.c
index 32709794b3..4357f87b7f 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -256,6 +256,8 @@ static struct option builtin_add_options[] = {
 	OPT_GROUP(""),
 	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
 	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
+	OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+		 N_("auto advance to the next file when selecting hunks interactively")),
 	OPT_DIFF_UNIFIED(&add_p_opt.context),
 	OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 	OPT_BOOL('e', "edit", &edit_interactive, N_("edit current diff and apply")),
@@ -418,6 +420,8 @@ int cmd_add(int argc,
 			die(_("the option '%s' requires '%s'"), "--unified", "--interactive/--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--interactive/--patch");
+		if (!add_p_opt.auto_advance)
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--interactive/--patch");
 	}
 
 	if (edit_interactive) {
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 0ba4f03f2e..fad35a9284 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -63,6 +63,7 @@ struct checkout_opts {
 	int patch_mode;
 	int patch_context;
 	int patch_interhunk_context;
+	int auto_advance;
 	int quiet;
 	int merge;
 	int force;
@@ -111,6 +112,7 @@ struct checkout_opts {
 	.merge = -1, \
 	.patch_context = -1, \
 	.patch_interhunk_context = -1, \
+	.auto_advance = 1, \
 }
 
 struct branch_info {
@@ -549,6 +551,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 		struct add_p_opt add_p_opt = {
 			.context = opts->patch_context,
 			.interhunkcontext = opts->patch_interhunk_context,
+			.auto_advance = opts->auto_advance
 		};
 		const char *rev = new_branch_info->name;
 		char rev_oid[GIT_MAX_HEXSZ + 1];
@@ -1803,6 +1806,8 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (opts->patch_interhunk_context != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (!opts->auto_advance)
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
 	if (opts->show_progress < 0) {
@@ -2001,6 +2006,8 @@ int cmd_checkout(int argc,
 		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
 			 N_("second guess 'git checkout <no-such-branch>' (default)")),
 		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode (default)")),
+		OPT_BOOL(0, "auto-advance", &opts.auto_advance,
+			 N_("auto advance to the next file when selecting hunks interactively")),
 		OPT_END()
 	};
 
diff --git a/builtin/reset.c b/builtin/reset.c
index c48d9845f8..88f95f9fc7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -371,6 +371,8 @@ int cmd_reset(int argc,
 			       PARSE_OPT_OPTARG,
 			       option_parse_recurse_submodules_worktree_updater),
 		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
+		OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+			 N_("auto advance to the next file when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&add_p_opt.context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT_BOOL('N', "intent-to-add", &intent_to_add,
@@ -443,6 +445,8 @@ int cmd_reset(int argc,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (!add_p_opt.auto_advance)
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
 	/* git reset tree [--] paths... can be used to
diff --git a/builtin/stash.c b/builtin/stash.c
index 193e3ea47a..f98487f4cd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1849,6 +1849,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+			 N_("auto advance to the next file when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&add_p_opt.context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1911,6 +1913,8 @@ static int push_stash(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (!add_p_opt.auto_advance)
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
 	if (add_p_opt.context < -1)
@@ -1952,6 +1956,8 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			 N_("stash staged changes only")),
 		OPT_BOOL('p', "patch", &patch_mode,
 			 N_("stash in patch mode")),
+		OPT_BOOL(0, "auto-advance", &add_p_opt.auto_advance,
+			 N_("auto advance to the next file when selecting hunks interactively")),
 		OPT_DIFF_UNIFIED(&add_p_opt.context),
 		OPT_DIFF_INTERHUNK_CONTEXT(&add_p_opt.interhunkcontext),
 		OPT__QUIET(&quiet, N_("quiet mode")),
@@ -1983,6 +1989,8 @@ static int save_stash(int argc, const char **argv, const char *prefix,
 			die(_("the option '%s' requires '%s'"), "--unified", "--patch");
 		if (add_p_opt.interhunkcontext != -1)
 			die(_("the option '%s' requires '%s'"), "--inter-hunk-context", "--patch");
+		if (!add_p_opt.auto_advance)
+			die(_("the option '%s' requires '%s'"), "--no-auto-advance", "--patch");
 	}
 
 	ret = do_push_stash(&ps, stash_msg, quiet, keep_index,
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index ffb9c8b522..2f9a597ec7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2601,6 +2601,7 @@ test_expect_success 'double dash "git checkout"' '
 	--ignore-skip-worktree-bits Z
 	--ignore-other-worktrees Z
 	--recurse-submodules Z
+	--auto-advance Z
 	--progress Z
 	--guess Z
 	--no-guess Z
-- 
2.39.5 (Apple Git-154)

