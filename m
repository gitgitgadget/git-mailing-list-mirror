Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6700473526
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710435914; cv=none; b=aQk4ukUt2hxqa0l4joSLjx1/RyEM5p99ipyHQnf8zD8HL704YOzFQb9zM9mxRqtg7FjwoPA8wuu4zdU6vhXQqZCzkxjT+MMcsWQbk0dTwRPPsWr2dl2Fomdzr2BPa1+FiwnOXNOaSjLE6QVnF7ejm9lSqpm/CwtB2r5rUQ2Bnvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710435914; c=relaxed/simple;
	bh=15fQxFFObLLpaKkOk8EHG04yz5BMnpW6jrHBy0GjEPI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=AUuNoHidqN8UwGNIvpQ7sWPbNfi6J/ZZXKMhmv1Fn32F9mdHyYcKZ9xI+BCVQ9fg5tbhPmu3jIDmzacJOZ2qd0Z0XXVWMdaHsdmO6rFOSjko9hDxCvLICRw2aQFF5sbwOmEq23pdiY0YVzft9WMF+jeP+D9gnzGftCmtfP79VQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0CeVtGV; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0CeVtGV"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33e570ef661so489434f8f.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710435910; x=1711040710; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3O+zAFdOY3fCdzwlC+O99zth0Qs1jpNiW5uVHuVh3fs=;
        b=j0CeVtGV+R6Sfg/f7/OtOAvdFwa7TmrHoRYvGQWOVdfNgPo9mTIiPYWVo4tPbF+dkD
         +WoGL40fN6Ex+tEM8rCrW2k+FwSdbWhwkv1I25TCiqO0xwA6fcFSeEcxlrgDyC+0AJAD
         Zy0pxALij08ajeNBkrRPHQtIjS0mI5SpVL4C2Rc1fMQr9MyTm0BHG2+ricvKYMUJEeyQ
         rnhKi3ZY8RIaSaqIHWMviUeUtKMMk/jteDuiDsdaMjBQt9V3nw1bARJcXnTYKYD87vNY
         F6utjpF+5TL7tUdGFGC4xxUnCVY5EaQyqIjl/37XC/2EJnGR4dePywKTRxcy5eDfTvh+
         wPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710435910; x=1711040710;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3O+zAFdOY3fCdzwlC+O99zth0Qs1jpNiW5uVHuVh3fs=;
        b=wpR381089c2UTXTfwAKeBB+i4l+rzSiceTwOdwKXm04UpLI7dmwq1iE0s9x5Q4m/1S
         ikvAPC3AozhWftXBV4fPfa81wVcfuLqLZdipTuhY7ZZLiMjI/ZGXzhub0+NR+oKX/KpA
         kffFEUJ97ay7SUgutUy2MUMjjs9czT8gz4t8Ro8ribC4tH4u1YbI2kZj4750gz3S1mnl
         0RfZ56517dCka5tIX3H+jiRANd7w34aQRC44+FVqIEU9PXaUPkRO/ARBl1KXTTLJHZcX
         BwdeRX0L0c78UfZOK+YtT+mJO/z20oHdfAnXyXpDuvt+lFw3VhxVGKyXT6ImI9RQrSJf
         d7vQ==
X-Gm-Message-State: AOJu0Yx57aowm2vqykS3TZKUXfk+lhKI8L2gPLfJpEFNMK0U6iffYcgY
	SGGRRwGp0yS0OZDzIg3pbh65OOePTrP9YXwMV1SMVektwx0ayYNvnhHwWTcs
X-Google-Smtp-Source: AGHT+IHj/SEue7kL9V6JW/LqZQComQAN8nlNMRSxIcQzKaesSVMfJ6/RPGetbiRNvmBhzbvLmTe9VA==
X-Received: by 2002:adf:a35d:0:b0:33d:3098:c1c with SMTP id d29-20020adfa35d000000b0033d30980c1cmr1834539wrb.5.1710435909617;
        Thu, 14 Mar 2024 10:05:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d4389000000b0033e75e5f280sm1140891wrq.113.2024.03.14.10.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 10:05:09 -0700 (PDT)
Message-ID: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 14 Mar 2024 17:05:02 +0000
Subject: [PATCH v2 0/5] checkout: cleanup --conflict=
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
Cc: Elijah Newren <newren@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

Phillip Wood (5):
  xdiff-interface: refactor parsing of merge.conflictstyle
  merge-ll: introduce LL_MERGE_OPTIONS_INIT
  merge options: add a conflict style member
  checkout: cleanup --conflict=<style> parsing
  checkout: fix interaction between --conflict and --merge

 builtin/checkout.c | 60 +++++++++++++++++++++++++----------------
 merge-ll.c         |  6 +++--
 merge-ll.h         |  5 ++++
 merge-ort.c        |  3 ++-
 merge-recursive.c  |  5 +++-
 merge-recursive.h  |  1 +
 t/t7201-co.sh      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
 xdiff-interface.c  | 29 ++++++++++++--------
 xdiff-interface.h  |  1 +
 9 files changed, 139 insertions(+), 37 deletions(-)


base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1684%2Fphillipwood%2Frefactor-conflict-style-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1684/phillipwood/refactor-conflict-style-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1684

Range-diff vs v1:

 1:  0263d001634 ! 1:  629e577879c xdiff-interface: refactor parsing of merge.conflictstyle
     @@ xdiff-interface.c: int xdiff_compare_lines(const char *l1, long s1,
       	return xdl_recmatch(l1, s1, l2, s2, flags);
       }
       
     -+int parse_conflict_style(const char *value)
     ++int parse_conflict_style_name(const char *value)
      +{
      +	if (!strcmp(value, "diff3"))
      +		return XDL_MERGE_DIFF3;
     @@ xdiff-interface.c: int git_xmerge_config(const char *var, const char *value,
      -		 * git-completion.bash when you add new merge config
      -		 */
      -		else
     -+		git_xmerge_style = parse_conflict_style(value);
     ++		git_xmerge_style = parse_conflict_style_name(value);
      +		if (git_xmerge_style == -1)
       			return error(_("unknown style '%s' given for '%s'"),
       				     value, var);
     @@ xdiff-interface.h: int buffer_is_binary(const char *ptr, unsigned long size);
       void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
       void xdiff_clear_find_func(xdemitconf_t *xecfg);
       struct config_context;
     -+int parse_conflict_style(const char *value);
     ++int parse_conflict_style_name(const char *value);
       int git_xmerge_config(const char *var, const char *value,
       		      const struct config_context *ctx, void *cb);
       extern int git_xmerge_style;
 2:  4e05bc156bc = 2:  46e0f5a0af7 merge-ll: introduce LL_MERGE_OPTIONS_INIT
 3:  c0d7bafd438 = 3:  47d0ec28a55 merge options: add a conflict style member
 4:  317bb7a70d0 ! 4:  511e03d3db2 checkout: cleanup --conflict=<style> parsing
     @@ Commit message
          the option given on the command line. This happens because the
          implementation calls git_xmerge_config() to set the conflict style
          using the value given on the command line. Use the newly added
     -    parse_conflict_style() instead and pass the value down the call chain
     -    to override the config setting. This also means we can avoid setting
     -    up a struct config_context required for calling git_xmerge_config().
     +    parse_conflict_style_name() instead and pass the value down the call
     +    chain to override the config setting. This also means we can avoid
     +    setting up a struct config_context required for calling
     +    git_xmerge_config().
     +
     +    The option is now parsed in a callback to avoid having to store the
     +    option name. This is a change in behavior as now
     +
     +        git checkout --conflict=bad --conflict=diff3
     +
     +    will error out when parsing "--conflict=bad" whereas before this change
     +    it would succeed because it would only try to parse the value of the
     +    last "--conflict" option given on the command line.
      
          Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
      
     @@ builtin/checkout.c: struct checkout_opts {
       	enum branch_track track;
       	struct diff_options diff_options;
      -	char *conflict_style;
     -+	char *conflict_style_name;
      +	int conflict_style;
       
       	int branch_exists;
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
       			ret = merge_trees(&o,
       					  new_tree,
       					  work,
     +@@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
     + 	return switch_branches(opts, new_branch_info);
     + }
     + 
     ++static int parse_opt_conflict(const struct option *o, const char *arg, int unset)
     ++{
     ++	struct checkout_opts *opts = o->value;
     ++
     ++	if (unset) {
     ++		opts->conflict_style = -1;
     ++		return 0;
     ++	}
     ++	opts->conflict_style = parse_conflict_style_name(arg);
     ++	if (opts->conflict_style < 0)
     ++		return error(_("unknown conflict style '%s'"), arg);
     ++
     ++	return 0;
     ++}
     ++
     + static struct option *add_common_options(struct checkout_opts *opts,
     + 					 struct option *prevopts)
     + {
      @@ builtin/checkout.c: static struct option *add_common_options(struct checkout_opts *opts,
       			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
       		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
       		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
      -		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
     -+		OPT_STRING(0, "conflict", &opts->conflict_style_name, N_("style"),
     - 			   N_("conflict style (merge, diff3, or zdiff3)")),
     +-			   N_("conflict style (merge, diff3, or zdiff3)")),
     ++		OPT_CALLBACK(0, "conflict", opts, N_("style"),
     ++			     N_("conflict style (merge, diff3, or zdiff3)"),
     ++			     parse_opt_conflict),
       		OPT_END()
       	};
     + 	struct option *newopts = parse_options_concat(prevopts, options);
      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
       			opts->show_progress = isatty(2);
       	}
     @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
      -		struct config_context ctx = {
      -			.kvi = &kvi,
      -		};
     -+	if (opts->conflict_style_name) {
     ++	if (opts->conflict_style >= 0)
       		opts->merge = 1; /* implied */
      -		git_xmerge_config("merge.conflictstyle", opts->conflict_style,
      -				  &ctx, NULL);
     -+		opts->conflict_style =
     -+			parse_conflict_style(opts->conflict_style_name);
     -+		if (opts->conflict_style < 0)
     -+			die(_("unknown conflict style '%s'"),
     -+			    opts->conflict_style_name);
     - 	}
     +-	}
     ++
       	if (opts->force) {
       		opts->discard_changes = 1;
     + 		opts->ignore_unmerged_opt = "--force";
      @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
       
       int cmd_checkout(int argc, const char **argv, const char *prefix)
     @@ t/t7201-co.sh: test_expect_success 'checkout --conflict=diff3' '
       
      +test_expect_success 'checkout with invalid conflict style' '
      +	test_must_fail git checkout --conflict=bad 2>actual -- file &&
     -+	echo "fatal: unknown conflict style ${SQ}bad${SQ}" >expect &&
     ++	echo "error: unknown conflict style ${SQ}bad${SQ}" >expect &&
      +	test_cmp expect actual
      +'
      +
 -:  ----------- > 5:  b771b29e45a checkout: fix interaction between --conflict and --merge

-- 
gitgitgadget
