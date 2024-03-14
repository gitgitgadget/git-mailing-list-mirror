Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E277351C
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436038; cv=none; b=p5TK4dycsrmMr9n+81dZ+97lmjTHEV9i+yBqEmwXKZ2kZ4xMTFjKXpaCQqjUZZlk6j5bJLOCLGL7SbA91OBuK+3JMs4uKJEToQXtI+PlOK3LdAg6vamTJg0rDtdWXnorcWyG1l41BTuSOnimxW0ck2Xc6wc2czwmZMuHDVmxE3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436038; c=relaxed/simple;
	bh=6kC5o/pPy5qPdJ9SZ7gzKoqKAGrR1EdJmGnLUNa6sHo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fXrPNFMEPAxeReWPICbmiB5ckSiahtWoWSV0aXlm0qAog6GQ3NfAi2dUkazfHYsRKd69QWvWSnkjHJrlbucyWz92TprSTDX5nnsFartQLubYTv9KNUUKNAL2C3nTb/fkT+M05W/TgOeIuG2FmHYCoqJeNG05GPENFQ+WKb2DIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hadJ7woG; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hadJ7woG"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-413f936a17cso3380095e9.1
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 10:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710436035; x=1711040835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4b70tix13wc/dX3Z2k+k59FACS3oMQ5ZwhVEslSzUd4=;
        b=hadJ7woG4rl0qCJBeGEvTd19hLoYOd0QJMIM00VWw7CzxRw2LFgx0BGQXvq4jWJ9Ir
         RMx4e8K1MZQUSTF8XiHP5q3AoBxhyICdGzOquE1QzSaDGdQ7vqcjQA/TuWexdN1h7p++
         0he75pJPg3A3cqK0F2yKdetQgWiIM4XF683nqFAXcOY4JPZ0PIAzxif8dq9JxijDFcHe
         8XJWVQDB1oKg1xjkuTPKGuqz5PVnM56WLEoJnJ/FWBYSz7RwEKemPTbhRi6hieTI4JcZ
         1GYafmYe3FfaPhtnLKrp4zuhQdj2PyN+pcS5htUJNuI8ubTAjjIhlwXZR2RdCQunmgXP
         8vCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710436035; x=1711040835;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4b70tix13wc/dX3Z2k+k59FACS3oMQ5ZwhVEslSzUd4=;
        b=U5V0HqwP5SvUSQ+Qx8lWBkvbTxkIZu0EJ3ZtvZWYq/0WYS7hh/FJdZ+qYLxY6CmmJR
         yhNopArhrSDvjvkdSE4vnIcvkCXQbZnQ4nvPnide8U+4CtTSGqo5kjoehutgJidxY3Uf
         xwHlbweBDegaTfPdLmaZ1RNrQ8QOigVGZhvujM4RDKLEcBg4l46Z783aHea8jMcj3RsU
         84C+8cK9PJy0CXjNmb89OkmGBItBe1HRTwmbE8xK/Q2LHCoU1zkUofFWGG3stkfFbVNZ
         xxElB2h8UXMiiQJ/FfxiEE/DiG/5GLS2kw/HFtCnM8MgGbXr4piw4JmV4vuGcFFf4BUI
         3NkA==
X-Forwarded-Encrypted: i=1; AJvYcCXG0satVbjmw/iC8lccTygDSDNSyvPi5KukaBBztA4TIXueJI0RaFmfVIvZi4VcM5uriMXzAZ6CFN7swrQ4ZzZXvoOC
X-Gm-Message-State: AOJu0YyJ5Mck9Fpxf9crAmB3BxqbJr/eCbyud3byZ7CPpAjmTCBs423i
	1owrqJeyHP288OUF+zZh3IsBs4zBPPlSylTT8+o295MYgLxW2LRt
X-Google-Smtp-Source: AGHT+IGE7oHhDlBHo5bN5ev1/qTmNIQAWUExt9AYIIPbN+mob0rpgcHdrK2a7UPO8JD9k37EGV1VEg==
X-Received: by 2002:a05:600c:19c6:b0:412:e2c3:4b6 with SMTP id u6-20020a05600c19c600b00412e2c304b6mr1993903wmq.20.1710436034735;
        Thu, 14 Mar 2024 10:07:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443? ([2a0a:ef40:6a5:fd01:2d60:4cd4:e8ec:b443])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c1d9600b00413ea933aafsm2990296wms.26.2024.03.14.10.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 10:07:14 -0700 (PDT)
Message-ID: <329d3570-8aca-4f12-9843-d351133eff15@gmail.com>
Date: Thu, 14 Mar 2024 17:07:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/5] checkout: cleanup --conflict=
Content-Language: en-US
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1684.git.1709907270.gitgitgadget@gmail.com>
 <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1684.v2.git.1710435907.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2024 17:05, Phillip Wood via GitGitGadget wrote:

Here is the cover letter - I don't know why GGG keeps omitting it

Passing an invalid conflict style name such as "--conflict=bad" to "git 
checkout" gives the error message

     error: unknown style 'bad' given for 'merge.conflictstyle'

which is unfortunate as it talks about a config setting rather than the 
option given on the command line. This series refactors the 
implementation to pass the conflict style down the call chain to the 
merge machinery rather than abusing the config setting.

Thanks to Junio for his comments on v1, the changes in v2 are:
  - renamed parse_conflict_style() to parse_conflict_style_name()
  - parse --conflict using OPT_CALLBACK to avoid storing the string argument
  - added a new patch to fix the interaction of --conflict with --no-merge


> Phillip Wood (5):
>    xdiff-interface: refactor parsing of merge.conflictstyle
>    merge-ll: introduce LL_MERGE_OPTIONS_INIT
>    merge options: add a conflict style member
>    checkout: cleanup --conflict=<style> parsing
>    checkout: fix interaction between --conflict and --merge
> 
>   builtin/checkout.c | 60 +++++++++++++++++++++++++----------------
>   merge-ll.c         |  6 +++--
>   merge-ll.h         |  5 ++++
>   merge-ort.c        |  3 ++-
>   merge-recursive.c  |  5 +++-
>   merge-recursive.h  |  1 +
>   t/t7201-co.sh      | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>   xdiff-interface.c  | 29 ++++++++++++--------
>   xdiff-interface.h  |  1 +
>   9 files changed, 139 insertions(+), 37 deletions(-)
> 
> 
> base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1684%2Fphillipwood%2Frefactor-conflict-style-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1684/phillipwood/refactor-conflict-style-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1684
> 
> Range-diff vs v1:
> 
>   1:  0263d001634 ! 1:  629e577879c xdiff-interface: refactor parsing of merge.conflictstyle
>       @@ xdiff-interface.c: int xdiff_compare_lines(const char *l1, long s1,
>         	return xdl_recmatch(l1, s1, l2, s2, flags);
>         }
>         
>       -+int parse_conflict_style(const char *value)
>       ++int parse_conflict_style_name(const char *value)
>        +{
>        +	if (!strcmp(value, "diff3"))
>        +		return XDL_MERGE_DIFF3;
>       @@ xdiff-interface.c: int git_xmerge_config(const char *var, const char *value,
>        -		 * git-completion.bash when you add new merge config
>        -		 */
>        -		else
>       -+		git_xmerge_style = parse_conflict_style(value);
>       ++		git_xmerge_style = parse_conflict_style_name(value);
>        +		if (git_xmerge_style == -1)
>         			return error(_("unknown style '%s' given for '%s'"),
>         				     value, var);
>       @@ xdiff-interface.h: int buffer_is_binary(const char *ptr, unsigned long size);
>         void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
>         void xdiff_clear_find_func(xdemitconf_t *xecfg);
>         struct config_context;
>       -+int parse_conflict_style(const char *value);
>       ++int parse_conflict_style_name(const char *value);
>         int git_xmerge_config(const char *var, const char *value,
>         		      const struct config_context *ctx, void *cb);
>         extern int git_xmerge_style;
>   2:  4e05bc156bc = 2:  46e0f5a0af7 merge-ll: introduce LL_MERGE_OPTIONS_INIT
>   3:  c0d7bafd438 = 3:  47d0ec28a55 merge options: add a conflict style member
>   4:  317bb7a70d0 ! 4:  511e03d3db2 checkout: cleanup --conflict=<style> parsing
>       @@ Commit message
>            the option given on the command line. This happens because the
>            implementation calls git_xmerge_config() to set the conflict style
>            using the value given on the command line. Use the newly added
>       -    parse_conflict_style() instead and pass the value down the call chain
>       -    to override the config setting. This also means we can avoid setting
>       -    up a struct config_context required for calling git_xmerge_config().
>       +    parse_conflict_style_name() instead and pass the value down the call
>       +    chain to override the config setting. This also means we can avoid
>       +    setting up a struct config_context required for calling
>       +    git_xmerge_config().
>       +
>       +    The option is now parsed in a callback to avoid having to store the
>       +    option name. This is a change in behavior as now
>       +
>       +        git checkout --conflict=bad --conflict=diff3
>       +
>       +    will error out when parsing "--conflict=bad" whereas before this change
>       +    it would succeed because it would only try to parse the value of the
>       +    last "--conflict" option given on the command line.
>        
>            Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>        
>       @@ builtin/checkout.c: struct checkout_opts {
>         	enum branch_track track;
>         	struct diff_options diff_options;
>        -	char *conflict_style;
>       -+	char *conflict_style_name;
>        +	int conflict_style;
>         
>         	int branch_exists;
>       @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
>         			ret = merge_trees(&o,
>         					  new_tree,
>         					  work,
>       +@@ builtin/checkout.c: static int checkout_branch(struct checkout_opts *opts,
>       + 	return switch_branches(opts, new_branch_info);
>       + }
>       +
>       ++static int parse_opt_conflict(const struct option *o, const char *arg, int unset)
>       ++{
>       ++	struct checkout_opts *opts = o->value;
>       ++
>       ++	if (unset) {
>       ++		opts->conflict_style = -1;
>       ++		return 0;
>       ++	}
>       ++	opts->conflict_style = parse_conflict_style_name(arg);
>       ++	if (opts->conflict_style < 0)
>       ++		return error(_("unknown conflict style '%s'"), arg);
>       ++
>       ++	return 0;
>       ++}
>       ++
>       + static struct option *add_common_options(struct checkout_opts *opts,
>       + 					 struct option *prevopts)
>       + {
>        @@ builtin/checkout.c: static struct option *add_common_options(struct checkout_opts *opts,
>         			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater),
>         		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
>         		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
>        -		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
>       -+		OPT_STRING(0, "conflict", &opts->conflict_style_name, N_("style"),
>       - 			   N_("conflict style (merge, diff3, or zdiff3)")),
>       +-			   N_("conflict style (merge, diff3, or zdiff3)")),
>       ++		OPT_CALLBACK(0, "conflict", opts, N_("style"),
>       ++			     N_("conflict style (merge, diff3, or zdiff3)"),
>       ++			     parse_opt_conflict),
>         		OPT_END()
>         	};
>       + 	struct option *newopts = parse_options_concat(prevopts, options);
>        @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
>         			opts->show_progress = isatty(2);
>         	}
>       @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const
>        -		struct config_context ctx = {
>        -			.kvi = &kvi,
>        -		};
>       -+	if (opts->conflict_style_name) {
>       ++	if (opts->conflict_style >= 0)
>         		opts->merge = 1; /* implied */
>        -		git_xmerge_config("merge.conflictstyle", opts->conflict_style,
>        -				  &ctx, NULL);
>       -+		opts->conflict_style =
>       -+			parse_conflict_style(opts->conflict_style_name);
>       -+		if (opts->conflict_style < 0)
>       -+			die(_("unknown conflict style '%s'"),
>       -+			    opts->conflict_style_name);
>       - 	}
>       +-	}
>       ++
>         	if (opts->force) {
>         		opts->discard_changes = 1;
>       + 		opts->ignore_unmerged_opt = "--force";
>        @@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
>         
>         int cmd_checkout(int argc, const char **argv, const char *prefix)
>       @@ t/t7201-co.sh: test_expect_success 'checkout --conflict=diff3' '
>         
>        +test_expect_success 'checkout with invalid conflict style' '
>        +	test_must_fail git checkout --conflict=bad 2>actual -- file &&
>       -+	echo "fatal: unknown conflict style ${SQ}bad${SQ}" >expect &&
>       ++	echo "error: unknown conflict style ${SQ}bad${SQ}" >expect &&
>        +	test_cmp expect actual
>        +'
>        +
>   -:  ----------- > 5:  b771b29e45a checkout: fix interaction between --conflict and --merge
> 
