Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E3339A8
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 11:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771067029; cv=none; b=h206EhUaSZBXHmQNFKy1EpNulHweI8usjVxgj++BpJMetMEofCt7WqiahwXZjuacmqIRCUS61QzeiDQUGrM/Izh9AJCDbHrm6lT1d4c/+WGgwshqarO5eovBZtmb2rAVN7VALO6hZNJfYqdZWcPByjhFqiI13vYJTX+r0wEeilk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771067029; c=relaxed/simple;
	bh=SRlRqtnNRmjvmD2LvUNNJ0jAyrd9/ClLJeZlatQkGpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TAeK51z9AU0kRt2f1I/o5VGnPT6aV/niQh+KI+0vIsG8tzt640xiX+zhg09iDw0ilhKJbDBEA+HoovgdN8Czy5YWd3DVnhIWZAcPTU44HxE8II50vwO3SWAIgTTDidy5U+KQiQuXP10J13l+9juG0rv56szUbI4AYqH3CgeIOog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IkMCTsaD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IkMCTsaD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4362c635319so1697935f8f.2
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 03:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771067026; x=1771671826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Af4yhvswVMqigNXcQEsTJq6Cx+qhUlST9WRnqcbh4sg=;
        b=IkMCTsaDmwJTNv1ubySqY8p2+BZ7aEfxwKm9+Bw6QT6qoISiTVKrL5MYBAaGK0oAJG
         MrD+2FhIuJ8MxP6Rz3913kRKBMTNV1T5gvBL8AtFzvsF1SVWfSCnLxh5bPwjalqISIWy
         us7s2cWZI1dqt67bv7ycGA20UAdhFKD+g0FKK21/3Vr9pHaXiExDA+RbM9npooBK/xBG
         IQCwNx/CSJtxSNGN4D/Pekjnri00/SpdIEROxt2sje4uHoqZ7lFRY1TrU/WmzbmsHrfQ
         szwBvjIpSto260pzTq4sMDPl4HZr2RJCkYvxMNjFsJ+PXfl7LUpi5Nwtev1OtKYHRa6s
         ebiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771067026; x=1771671826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Af4yhvswVMqigNXcQEsTJq6Cx+qhUlST9WRnqcbh4sg=;
        b=HknP0Hbhila3jMbtX9RQJ9cnPyFuPiiOEzg4zF4XHHt/Wmwy9k1czICsF33Qgeq6F2
         2kH3WumOp/MnXEjgRSHArl2gl59NG29s1tFvlCcoHPMaExdY3opWmPZ6K9lLou/HiYvQ
         ir7es4kRkcOnTYXbnJrMl0lFkhCNHPN0jvqi5AQfoV4FBWll8cNmtHWIzjc8B8dnulry
         nHvjHEpVJPRlPqce1RTVruBlrYbMvMvK28IJ1JyoaSXxNp7K87drrF6OR6beFwG7DJMm
         RSUtvCOm1qgfym8pfzr0fM3IW3Jn8QDD+b8y6QKMDWHI6VEoRi6rBpkAzXISN3KkrE0U
         daIg==
X-Gm-Message-State: AOJu0YxzBAC/WpTuKTwO5i3HHyysW4agBUehtGTC8FdgTOmTLvCbd3OH
	f+SICWNBYfxMIMkdVkjN8V4EnaSyt1InkwarSwnVGqmBM4PH/lnw2q97Ay6DDMa3
X-Gm-Gg: AZuq6aLj1UkUmvhnqKDNFzq5yF1u9OUeUDAf5wyJ4J1asU3vE4X+XjeISPmNE3V9fPJ
	sIaheW6sIcLANGufQlUsfCSh1I1uGGixCW4meY6T+ulIHMMpMTbNgmC4B+SeKH+9QiuIlTDMgrw
	FvGic688NRtYrh/RSCiZP85ISYKk0oTTZBCL56guGvzdcmY8sDC2O5/WGHbrkOWzD7+YIYotfzW
	ykIG/a1H5tIMXS0QvaghbKhXdvS/O/q07n9eMk5DetPwCS4p619lvM0na/ow99Q2gXZJjhWtIwA
	MD/mOksm0pf6wMH5D7wJUWAdSrwol5vjY9y0fzsF4ZLPLgE0rxAkcSlpEVL/hsEK9HeBfVdarVx
	ycJ/B/cjNZqMGVxwOJ14SoBnYp3UAt2YhuSzro/jKggwVB2n1snXC1Aa8dGuY9hQTNPYSV64CQP
	tlUZLEYT72TEEtvxJjw/O+9VZMRWqXMg==
X-Received: by 2002:a5d:5d87:0:b0:436:3563:499b with SMTP id ffacd0b85a97d-437978c75f7mr7339121f8f.2.1771067026141;
        Sat, 14 Feb 2026 03:03:46 -0800 (PST)
Received: from localhost ([102.88.77.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8209sm12639677f8f.30.2026.02.14.03.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 03:03:45 -0800 (PST)
Date: Sat, 14 Feb 2026 12:03:54 +0100
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
Subject: [PATCH v5 1/4] interactive -p: add new `--auto-advance` flag
Message-ID: <1a201beef9704ce3a1e2fefbc5cb5c82ab820c51.1771066252.git.abrahamadekunle50@gmail.com>
References: <cover.1771066252.git.abrahamadekunle50@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771066252.git.abrahamadekunle50@gmail.com>

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
 add-interactive.c     | 2 ++
 add-interactive.h     | 4 +++-
 builtin/add.c         | 4 ++++
 builtin/checkout.c    | 7 +++++++
 builtin/reset.c       | 4 ++++
 builtin/stash.c       | 8 ++++++++
 t/t9902-completion.sh | 1 +
 7 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 95ec5a89f8..1580639682 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -64,6 +64,7 @@ void init_add_i_state(struct add_i_state *s, struct repository *r,
 	s->r = r;
 	s->context = -1;
 	s->interhunkcontext = -1;
+	s->auto_advance = add_p_opt->auto_advance;
 
 	s->use_color_interactive = check_color_config(r, "color.interactive");
 
@@ -1017,6 +1018,7 @@ static int run_patch(struct add_i_state *s, const struct pathspec *ps,
 		struct add_p_opt add_p_opt = {
 			.context = s->context,
 			.interhunkcontext = s->interhunkcontext,
+			.auto_advance = s->auto_advance
 		};
 		struct strvec args = STRVEC_INIT;
 		struct pathspec ps_selected = { 0 };
diff --git a/add-interactive.h b/add-interactive.h
index da49502b76..7843397775 100644
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
@@ -29,6 +30,7 @@ struct add_i_state {
 	int use_single_key;
 	char *interactive_diff_filter, *interactive_diff_algorithm;
 	int context, interhunkcontext;
+	int auto_advance;
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

