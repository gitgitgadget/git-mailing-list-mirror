Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F6826C3B0
	for <git@vger.kernel.org>; Mon, 19 May 2025 09:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645514; cv=none; b=rwbGZ/2piKYFJ0uB/QnrwIe5T0DBpaZHwFUxndbvumifoSlA/KT7m7t3WWSTbo/GeHg+VB0hoQYCXwIAG0isYofo3Y0K+vHAROGR3HoKKLL2OcO6nWvVCz+3EHxhzi+g89lAyhVSy1PhDo7m8ezWGOQI0MZp2Be14mXL3+ZKjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645514; c=relaxed/simple;
	bh=FCQdpP0sFc+64ZtweE4BuR3IzwDRTO92Z6vh9f1pqe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oyGkXqUNl+wTFE4PBgYmU9MSjvmmzcQemNP0NZFy3DtxYpl4MBUqxGMcH9JQ/HLmlk+IeJfihkSyIl3wmlD/tDxfgNEpTH3Kxc8m4I3xJG8iMGFiwqgRSg1m7JfxR7JR+M5Yrm56jIgvAcDaGjHN8JfTT+8RRpBElsOmTQzFMqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZuplWjW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZuplWjW"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so44923135e9.3
        for <git@vger.kernel.org>; Mon, 19 May 2025 02:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747645511; x=1748250311; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=izdLk8ugpf0SxQ9hpQU2U4+n+Z+VdqHoqx9zJKMje5E=;
        b=VZuplWjWoLzuzlll4LU93FphAOjfsyOaxE2D/Wpx5SE2s85gRgfjb34dCW0OBw7GWo
         SBpTU2Ou2q/MaQlKY6HAhMYvTm6/N2tVVasVK3L3fLokNUg7khEwln0Au7EDYqwbs3rP
         qzOeOJaGj98Y70C7L3zIkAlhISbYiuRBdCMVRzuVLCRaJFfdVZ4O3ullzPuvqIgxK53k
         J3ybtHc6cjUDMOKtrnPNqB7NpwKZNxHqoI46ggskfe72wAUFvLo6fbKIAaCjLRp+/O4t
         Uicdswp4MkottsmAsKwaOrQgcPMXLCD/AIbwENCNiDvHpV0o4umlGnJiMv9olGctDjAo
         aOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645511; x=1748250311;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=izdLk8ugpf0SxQ9hpQU2U4+n+Z+VdqHoqx9zJKMje5E=;
        b=LT50qQ1H8gxMekVjoms7xNnIK+Po7M67U7OZIpOOvPJ6l1SlZr95fFi2szDY5tQ2HN
         lqSOgQcCevDRHIJD7UB+vubmQDDF5Gw1LjrwpVA0cypp5AApK5JSBr48nFG5YcoEtxMz
         QooX0ULMMxw3TRyfn8JddUpWn5y/GTbi0ApAVLghU7JtF+lzom7ImlFMnCpLqXY8cfF7
         bzWcFDPnx2jxnAiEY1dXjM/MIxwvBYstLLTLJoigbWhzcWS/BdmVmHnI/jq+HfAWVXwN
         38cKH52LXMgqb66rUEPI93TJpgVev7PaPnzOyUxxCK9ewQYbBh1yDw6DMz6zWXwsx6px
         Uwig==
X-Forwarded-Encrypted: i=1; AJvYcCXykDcVnhvQGSgNyPn7UycogGlpOnG6T9BvEA2hOI+wFcig/0K3uzHWisg3670KOkGsFco=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTl9jHURhrMUonzXOLL0opbR+Ubkx++5ea3tX/TcjZb3/V+Mel
	x2QI2W9TQSVCiaihi44EnPkZVv0iTOj+g5PlTPmqZK59PlafoO2IyBIW
X-Gm-Gg: ASbGnctxcYfEel7BfellA2Nlo0U4cm2FA0f/J88WU3IUaIPvt+H14ej8AYPBI7EdnoN
	1ocvulw0hxAHcpuSwod6ydLOxDolw+wpLoiYe3IoRanfLZtpe9ft300NL8cDaIZS1OrGNWLhsaE
	6eVN3XiqzVb8n/mn+IzIvRp/r55coxn85MUBrXD1Jme1ha9McA+N6j+97nqlRETDAmbmzXV747D
	T+S73rB1Jh5DZdqvBB9eVSDL1ds+UjX4qSyjEG3YNAOKvnxhgasAtgVeepnqnB0ic7VdSLCSL8n
	QFLLOJbmkcB/wmb7mdMe0gSc0s4on+HXIu6ZMAnXzXw6tBqa58W9N3Y0Pex7efe10Aktcd+zLHv
	u8RKEaaHn8e+D/k0UJYLrUSOeVHw=
X-Google-Smtp-Source: AGHT+IHJQ3bMravhtCRF9TqzHH8CIPqpg9InOK/a218+FpO/uyfINK3FLZyqXrCPPj8bVmnugEKUtw==
X-Received: by 2002:a05:600c:3e10:b0:43d:3df:42d8 with SMTP id 5b1f17b1804b1-442fefd780fmr92334465e9.6.1747645510360;
        Mon, 19 May 2025 02:05:10 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca5bd8asm12264984f8f.33.2025.05.19.02.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 02:05:09 -0700 (PDT)
Message-ID: <74bc8741-0a52-45d7-be2f-cc10b641c704@gmail.com>
Date: Mon, 19 May 2025 10:05:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/2] merge-tree: add new --quiet option
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
 <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Elijah

On 16/05/2025 21:04, Elijah Newren via GitGitGadget wrote:
> Changes since v3:
> 
>   * Renamed --dry-run -> --quiet . Any further naming suggestions?

Thanks for re-rolling this version looks good to me.

Thanks

Phillip

> Changes since v2:
> 
>   * Converted locations missed in v1 in changing --mergeability-only ->
>     --dry-run
> 
> Changes since v1:
> 
>   * Renamed --mergeability-only flag to --dry-run, as per suggestion from
>     Junio
>   * added some commit message clarifications
> 
> This adds a new flag, --dry-run, to git merge-tree, which suppresses all
> output and leaves only the exit status (reflecting successful merge or
> conflict). This is useful for Git Forges in cases where they are only
> interested in whether two branches can be merged, without needing the actual
> merge result or conflict details.
> 
> The advantage of the flag is two fold:
> 
>   * The merge machinery can exit once it detects a conflict, instead of
>     continuing to compute merge result information
>   * The merge machinery can avoid writing merged blobs and trees to the
>     object store when in the outer layer of the merging process (more details
>     in the first commit message).
> 
> Elijah Newren (2):
>    merge-ort: add a new mergeability_only option
>    merge-tree: add a new --quiet flag
> 
>   Documentation/git-merge-tree.adoc |  6 +++++
>   builtin/merge-tree.c              | 18 +++++++++++++++
>   merge-ort.c                       | 38 +++++++++++++++++++++++++------
>   merge-ort.h                       |  1 +
>   t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
>   5 files changed, 94 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 6c0bd1fc70efaf053abe4e57c976afdc72d15377
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1920%2Fnewren%2Fmergeability-only-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1920/newren/mergeability-only-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1920
> 
> Range-diff vs v3:
> 
>   1:  4757c4810d3 = 1:  4757c4810d3 merge-ort: add a new mergeability_only option
>   2:  f11824317a8 ! 2:  7c40d3c9216 merge-tree: add a new --dry-run flag
>       @@ Metadata
>        Author: Elijah Newren <newren@gmail.com>
>        
>         ## Commit message ##
>       -    merge-tree: add a new --dry-run flag
>       +    merge-tree: add a new --quiet flag
>        
>            Git Forges may be interested in whether two branches can be merged while
>            not being interested in what the resulting merge tree is nor which files
>       -    conflicted.  For such cases, add a new --dry-run flag which
>       +    conflicted.  For such cases, add a new --quiet flag which
>            will make use of the new mergeability_only flag added to merge-ort in
>            the previous commit.  This option allows the merge machinery to, in the
>            outer layer of the merge:
>       @@ Documentation/git-merge-tree.adoc: OPTIONS
>         	default is to include these messages if there are merge
>         	conflicts, and to omit them otherwise.
>         
>       -+--dry-run::
>       ++--quiet::
>        +	Disable all output from the program.  Useful when you are only
>        +	interested in the exit status.  Allows merge-tree to exit
>        +	early when it finds a conflict, and allows it to avoid writing
>       @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
>         	int original_argc;
>         	const char *merge_base = NULL;
>         	int ret;
>       -+	int dry_run = 0;
>       ++	int quiet = 0;
>         
>         	const char * const merge_tree_usage[] = {
>         		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
>       @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
>         			    N_("do a trivial merge only"), MODE_TRIVIAL),
>         		OPT_BOOL(0, "messages", &o.show_messages,
>         			 N_("also show informational/conflict messages")),
>       -+		OPT_BOOL_F(0, "dry-run",
>       -+			   &dry_run,
>       ++		OPT_BOOL_F(0, "quiet",
>       ++			   &quiet,
>        +			   N_("suppress all output; only exit status wanted"),
>        +			   PARSE_OPT_NONEG),
>         		OPT_SET_INT('z', NULL, &line_termination,
>       @@ builtin/merge-tree.c: int cmd_merge_tree(int argc,
>         	argc = parse_options(argc, argv, prefix, mt_options,
>         			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
>         
>       -+	if (dry_run && o.show_messages == -1)
>       ++	if (quiet && o.show_messages == -1)
>        +		o.show_messages = 0;
>       -+	o.merge_options.mergeability_only = dry_run;
>       -+	die_for_incompatible_opt2(dry_run, "--dry-run",
>       -+				  o.show_messages, "--messages");
>       -+	die_for_incompatible_opt2(dry_run, "--dry-run",
>       -+				  o.name_only, "--name-only");
>       -+	die_for_incompatible_opt2(dry_run, "--dry-run",
>       -+				  o.use_stdin, "--stdin");
>       -+	die_for_incompatible_opt2(dry_run, "--dry-run",
>       -+				  !line_termination, "-z");
>       ++	o.merge_options.mergeability_only = quiet;
>       ++	die_for_incompatible_opt2(quiet, "--quiet", o.show_messages, "--messages");
>       ++	die_for_incompatible_opt2(quiet, "--quiet", o.name_only, "--name-only");
>       ++	die_for_incompatible_opt2(quiet, "--quiet", o.use_stdin, "--stdin");
>       ++	die_for_incompatible_opt2(quiet, "--quiet", !line_termination, "-z");
>        +
>         	if (xopts.nr && o.mode == MODE_TRIVIAL)
>         		die(_("--trivial-merge is incompatible with all other options"));
>       @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
>         	git commit -m first-commit
>         '
>         
>       -+test_expect_success '--dry-run on clean merge' '
>       ++test_expect_success '--quiet on clean merge' '
>        +	# Get rid of loose objects to start with
>        +	git gc &&
>        +	echo "0 objects, 0 kilobytes" >expect &&
>       @@ t/t4301-merge-tree-write-tree.sh: test_expect_success setup '
>        +	test_cmp expect actual &&
>        +
>        +	# Ensure merge is successful (exit code of 0)
>       -+	git merge-tree --write-tree --dry-run side1 side3 >output &&
>       ++	git merge-tree --write-tree --quiet side1 side3 >output &&
>        +
>        +	# Ensure there is no output
>        +	test_must_be_empty output &&
>       @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Failed merge without rena
>         	grep "CONFLICT (modify/delete): numbers deleted" out
>         '
>         
>       -+test_expect_success  '--dry-run on conflicted merge' '
>       ++test_expect_success  '--quiet on conflicted merge' '
>        +	# Get rid of loose objects to start with
>        +	git gc &&
>        +	echo "0 objects, 0 kilobytes" >expect &&
>       @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'Failed merge without rena
>        +	test_cmp expect actual &&
>        +
>        +	# Ensure merge has conflict
>       -+	test_expect_code 1 git merge-tree --write-tree --dry-run side1 side2 >output &&
>       ++	test_expect_code 1 git merge-tree --write-tree --quiet side1 side2 >output &&
>        +
>        +	# Ensure there is no output
>        +	test_must_be_empty output &&
> 

