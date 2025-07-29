Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B50292B3D
	for <git@vger.kernel.org>; Tue, 29 Jul 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802471; cv=none; b=mJVAKcUDGN+ITq7UcQtriEPKmhcjgjxwV9Qob6+MVyCekZBf3j1zMYHadmTxWaknlNwrRugi0fek/NzH4xOYn+uUOZ0rGnaRAgm4Ft9ffGiF94urN5DK6ckXwLDlAVd8Tkpw+yxdMCPEyQe6yv3bbvNDELY+/P6V4rITUSWv4oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802471; c=relaxed/simple;
	bh=+qTixT3qbZC6ruegznWDdg8og2AvgwB2eBr45eidk00=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Gv97nlL77S0E95TltVVf8A5NqtDyFG2I0wYk7Jl5jObeibcml8o3zUTKAi1NrtbX5CnUZo10FEGxpkBqGef/fYkbVYpgtS6JLjMvZIMut1a2cbhLEynrMSIwBw+MynaA1jsZT21dsHcdI6DshZnG9REU2+LiQbuuiLl+CQMd1E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0ZOifZW; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0ZOifZW"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3b783ea502eso888851f8f.1
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753802468; x=1754407268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n8ARrcx6eLwZ43G8BPtZkrn+/KIFpyxnL+Yc6N1fG5g=;
        b=i0ZOifZWVwnTZdVkKT7M2f0r2WV9ufv/8KcXa+nr2lXu3lQyvJ/wdb530ifr4R9OUX
         NYF051CkkPN6q+sXvUaI9LUF92oacAazdcLvNTstBDRewiQrPdRUnzazmFi8r1iJbk46
         PCRie8laRp8Gh8NklyGjhovuC2LGKSe2uBXg6zA4MJPUEtsLZHA+n6EYYN4WJvV0UJER
         oDo3ibt0l7Y1sKt/aiTwP1ZtfVoPnLutMqbcoYtb6gHbFSC/dpmmeEqD71NeswMDYyfE
         LLwTSsH7Qji/JPnOlYHm3ksJ9u6Wz/lib+vOEmanng+cwOLKdnIcgHbZGqzkpZ8ortAb
         ipSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753802468; x=1754407268;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8ARrcx6eLwZ43G8BPtZkrn+/KIFpyxnL+Yc6N1fG5g=;
        b=T+ulsP3y+Ogy0YuR8mzYIE3ObiPlkQtgU/UUoaod/5Ojh+n9XTZuzaw8xzzINDpnQW
         J5M6C+Am0XmJ0E7yBP/BJ3df2rJKkY11JI6DmKLKHJuefrg+DmZB4Rc9h5XcvWMNfaUF
         4QOBO8kLurOKVnsYohcUyhcadBzF4bUWPn9wQxR1rWzp76/v6tQQjuFUqvUUCUNBr/nY
         gvM1WbTteqz5784/niWRgBAumvwbIW+Pt64f194GShFfD9vKCaRaONMq8aQkOE56fnu+
         njXMbtQZZWHOPkCldHMr0CyUctrepmI94xkVOIFiZHDuXSPCcVMjinhCL2Mw4emrTGw6
         2ISg==
X-Forwarded-Encrypted: i=1; AJvYcCXXHMIgOxeXKIBvyHOadoYRYR0GmPX7NqZOBhvxkCHwosTdLMZAUMiNatqdUL1wWuwIbXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYvONQ+VGdGoIQgIQMqrVYaCdOuq94K42Dr2w7IsSn44hk8kcL
	FZCmroeLrbbOidH3ffEhMHhEnE+LCwQl01Q70p9HFkQswTuKwxQ/VkiX
X-Gm-Gg: ASbGnctJ/AJ2+S1VoEPj13Rx6PUJNWRyD+CeTOWgsFbJ1NWV57F4m2P5vKmGTgYTZlE
	S2ghWVhnAFBeLJVDOILPmL68nrWOESx0H9M43F/acUvKIR9tc9H4Wo2joKrrWjfY6NjQZWiM6T/
	EGjELToxKrYae9g6fXdVIL3sTioCuIdk51UAQ5z7ScnWH7zu90w7yZ/csS57rrKcr7nT8PzMAvV
	yHzJ5WmC3+puTYxS09u+Ne1/DhjnG6kum+WSjYm4zdLZjmte0/3Vjr21xrYI/zvx8COqTI/BOcF
	7oCKbZfmu6SGRmYWAqg8YhjiLWArNXXdz7yZaUMhGyPb9ajDGOYvETpANX/rdZMRJd9BANAu8ga
	5GIKvvLplgUZl7zwgd+EMlrtqzW0sxswx0fKGT+VUEidPdydwrtVVprskNzPtyfuW5+S+TfmL++
	tIGdStNk3EKqM=
X-Google-Smtp-Source: AGHT+IGSbYHmT8bsavVHSraFIaQ+CT4FMW/hrq8b6oupLf7ZV2D11wqjfPwWFvSmbzCbnAeZor0bpA==
X-Received: by 2002:a05:6000:2c02:b0:3b6:d0d:79c1 with SMTP id ffacd0b85a97d-3b78e4d2bbemr2658469f8f.10.1753802467773;
        Tue, 29 Jul 2025 08:21:07 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45888e48c6fsm80985265e9.1.2025.07.29.08.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jul 2025 08:21:07 -0700 (PDT)
Message-ID: <ec7481b5-5244-4a76-962f-d3bed9e4172a@gmail.com>
Date: Tue, 29 Jul 2025 16:21:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] Better support for customising context lines in
 --patch commands
To: Leon Michalak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>,
 Christian Couder <christian.couder@gmail.com>,
 Leon Michalak <leonmichalak6@gmail.com>
References: <pull.1915.v4.git.1752928113.gitgitgadget@gmail.com>
 <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.1915.v5.git.1753772511.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Leon

The range-diff below looks good to me. Thanks for working on this

Phillip

On 29/07/2025 08:01, Leon Michalak via GitGitGadget wrote:
> This series of patches attempt to give --interactive/--patch compatible
> builtins ("add", "commit", "checkout", "reset", "restore" and "stash")
> better support and nicer experience for configuring how many context lines
> are shown in diffs through a variety of ways.
> 
> Prior to these patches, the user could not choose how many context lines
> they saw in --patch commands (apart from one workaround by using
> GIT_DIFF_OPTS=-u<number> ..., however this isn't a good user experience or a
> persistent solution). Additionally, the behaviour around reading from the
> diff.context and diff.interHunkContext configs was also inconsistent with
> other diff generating commands such as "log -p".
> 
> The summarised changes below hopefully make this experience better and fix
> some inconsistencies:
> 
>   * diff.context and diff.interHunkContext configs are now respected by
>     --patch compatible commands
>   * --unified and --inter-hunk-context command line options have been added
>     to --patch compatible commands (which take prescendence over file
>     configs)
>   * "add" and "commit" in --interactive mode now expose a new "context"
>     subcommand which configures the amount of context lines you wish to see
>     in subsequent diffs generated from other subcommands such as "patch" or
>     "diff"
> 
> The original discussion for this can be read at:
> 
>   * https://lore.kernel.org/git/CAP9jKjGb-Rcr=RLJEzeFdtrekYM+qmHy+1T1fykU3n9cV4GhGw@mail.gmail.com/
> 
> Changes since v1:
> 
>   * Update commit descriptions
>   * Update tests to use the more modern and robust test_grep and test_config
>     utils
>   * Reword some documentation / user messages
>   * Ensure each commit is atomic and builds/passes tests on it's own
>   * Make new command line options DRY
>   * Add tests for interhunk context interaction
>   * Error if context config/command line options are negative
>   * Drop previous last commit to do with new subcommand for --interactive
>     add/commit. My motivations behind this patch series originally where
>     quite simple, just for add-patch commands to respect context configs.
>     This subcommand, after the discussion in v1, will require more thought
>     and a larger implementation that what I had anticipated. I would prefer
>     to leave this for another time as it's the least impactful but the most
>     time intensive and complicated idea.
> 
> Changes since v2:
> 
>   * Update tests to only test single command (following Philip's suggestion)
>   * Add negative option checks
>   * Minor commit re-wording
> 
> Changes since v3:
> 
>   * Update commit descriptions
>   * Read struct properties directly instead of assigning to variables first
>   * Simplify config setting / error checking
>   * Remove redundant tests in later commit as they were replaced with better
>     test(s)
>   * Change tests to use single quotes (this messes with the grep so was
>     unable to explicitly test single quotes in the error messages, so decided
>     to use regex . instead, which is what some other tests that have this
>     problem seem to use as well)
> 
> Changes since v4:
> 
>   * Add back tests to maintain good coverage and remove redundant tests
> 
> Leon Michalak (4):
>    t: use test_grep in t3701 and t4055
>    t: use test_config in t4055
>    add-patch: respect diff.context configuration
>    add-patch: add diff.context command line overrides
> 
>   Documentation/diff-context-options.adoc |  10 ++
>   Documentation/git-add.adoc              |   2 +
>   Documentation/git-checkout.adoc         |   2 +
>   Documentation/git-commit.adoc           |   2 +
>   Documentation/git-reset.adoc            |   2 +
>   Documentation/git-restore.adoc          |   2 +
>   Documentation/git-stash.adoc            |   2 +
>   add-interactive.c                       |  45 +++++++--
>   add-interactive.h                       |  17 +++-
>   add-patch.c                             |  14 ++-
>   builtin/add.c                           |  21 ++++-
>   builtin/checkout.c                      |  31 +++++-
>   builtin/commit.c                        |  16 +++-
>   builtin/reset.c                         |  17 +++-
>   builtin/stash.c                         |  56 ++++++++---
>   commit.h                                |   3 +-
>   parse-options.h                         |   2 +
>   t/t3701-add-interactive.sh              | 119 +++++++++++++++++++-----
>   t/t4055-diff-context.sh                 |  42 ++++-----
>   t/t9902-completion.sh                   |   2 +
>   20 files changed, 324 insertions(+), 83 deletions(-)
>   create mode 100644 Documentation/diff-context-options.adoc
> 
> 
> base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1915%2FNinjaInShade%2Finteractive-patch-context-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1915/NinjaInShade/interactive-patch-context-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1915
> 
> Range-diff vs v4:
> 
>   1:  bbb2bc7082b = 1:  bbb2bc7082b t: use test_grep in t3701 and t4055
>   2:  feace2d3676 = 2:  feace2d3676 t: use test_config in t4055
>   3:  994029d6602 = 3:  994029d6602 add-patch: respect diff.context configuration
>   4:  2774b930406 ! 4:  9731e5b76fb add-patch: add diff.context command line overrides
>       @@ parse-options.h: int parse_opt_tracking_mode(const struct option *, const char *
>         	OPT_SET_INT_F('4', "ipv4", (v), N_("use IPv4 addresses only"), \
>        
>         ## t/t3701-add-interactive.sh ##
>       -@@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
>       - 	test_cmp expect actual
>       +@@ t/t3701-add-interactive.sh: test_expect_success 'add -p rejects negative diff.context' '
>       + 	test_grep "diff.context cannot be negative" output
>         '
>         
>       --test_expect_success 'add -p respects diff.context' '
>       --	test_write_lines a b c d e f g h i j k l m >file &&
>        +for cmd in add checkout restore 'commit -m file'
>        +do
>        +	test_expect_success "${cmd%% *} accepts -U and --inter-hunk-context" '
>       @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.
>        +	test_write_lines a b c d e f g h i j k l m n o p q r s t u v >file &&
>        +	git commit -m file file &&
>        +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
>       - 	git add file &&
>       --	test_write_lines a b c d e f G h i j k l m >file &&
>       --	echo y | git -c diff.context=5 add -p >actual &&
>       --	test_grep "@@ -2,11 +2,11 @@" actual
>       ++	git add file &&
>        +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
>        +		reset -p -U 4 --inter-hunk-context 2 >actual &&
>        +	test_grep "@@ -2,20 +2,20 @@" actual
>       - '
>       -
>       --test_expect_success 'add -p respects diff.interHunkContext' '
>       --	test_write_lines a b c d e f g h i j k l m n o p q r s >file &&
>       --	git add file &&
>       --	test_write_lines a b c d E f g i i j k l m N o p q r s >file &&
>       --	echo y | git -c diff.interhunkcontext=2 add -p >actual &&
>       --	test_grep "@@ -2,16 +2,16 @@" actual
>       ++'
>       ++
>        +test_expect_success 'stash accepts -U and --inter-hunk-context' '
>        +	test_write_lines a b c d e F g h i j k l m n o p Q r s t u v >file &&
>        +	git commit -m file file &&
>       @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.
>        +	echo y | git -c diff.context=5 -c diff.interhunkcontext=1 \
>        +		stash -p -U 4 --inter-hunk-context 2 >actual &&
>        +	test_grep "@@ -2,20 +2,20 @@" actual
>       - '
>       -
>       --test_expect_success 'add -p rejects negative diff.context' '
>       --	test_config diff.context -1 &&
>       --	test_must_fail git add -p 2>output &&
>       --	test_grep "diff.context cannot be negative" output
>       --'
>       ++'
>       ++
>        +for cmd in add checkout commit reset restore "stash save" "stash push"
>        +do
>        +	test_expect_success "$cmd rejects invalid context options" '
>       @@ t/t3701-add-interactive.sh: test_expect_success 'hunk splitting works with diff.
>        +		test_grep -E ".--inter-hunk-context. requires .(--interactive/)?--patch." actual
>        +	'
>        +done
>       -
>       - test_done
>       -
>       - ## t/t4055-diff-context.sh ##
>       -@@ t/t4055-diff-context.sh: test_expect_success 'The -U option overrides diff.context' '
>       - 	test_grep ! "^ firstline" output
>       - '
>       -
>       -+test_expect_success 'The -U option overrides diff.context for "add"' '
>       -+	test_config diff.context 8 &&
>       -+	git add -U4 -p >output &&
>       -+	test_grep ! "^ firstline" output
>       -+'
>       -+
>       -+test_expect_success 'The -U option overrides diff.context for "commit"' '
>       -+	test_config diff.context 8 &&
>       -+	! git commit -U4 -p >output &&
>       -+	test_grep ! "^ firstline" output
>       -+'
>       -+
>       -+test_expect_success 'The -U option overrides diff.context for "checkout"' '
>       -+	test_config diff.context 8 &&
>       -+	git checkout -U4 -p >output &&
>       -+	test_grep ! "^ firstline" output
>       -+'
>        +
>       -+test_expect_success 'The -U option overrides diff.context for "stash"' '
>       -+	test_config diff.context 8 &&
>       -+	! git stash -U4 -p >output &&
>       -+	test_grep ! "^ firstline" output
>       -+'
>       -+
>       -+test_expect_success 'The -U option overrides diff.context for "restore"' '
>       -+	test_config diff.context 8 &&
>       -+	git restore -U4 -p >output &&
>       -+	test_grep ! "^ firstline" output
>       -+'
>       -+
>       - test_expect_success 'diff.context honored by "diff"' '
>       - 	test_config diff.context 8 &&
>       - 	git diff >output &&
>       + test_done
>        
>         ## t/t9902-completion.sh ##
>        @@ t/t9902-completion.sh: test_expect_success 'double dash "git checkout"' '
> 

