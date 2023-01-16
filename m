Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B8DC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 10:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjAPKw3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 05:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAPKw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 05:52:26 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038095597
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 02:52:25 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b7so1063929wrt.3
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 02:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9ChC7ta4TNmBXuVY1YUDn8lL0sjlfevftcBEcR+PvHk=;
        b=qxaCj9llAdrgATj3EtgSO1h7VNxebcG8oK2hREeK9pMrS5mJMLgW8tZ+qv/FAaUycQ
         +slqP0ThH+XhogJZx+1CVtnE8xlZdq0qRxWfkdC43GlOOmyhmZ74cq2zSftsJNBX69ul
         FnZl8THZ2xGuEHA2Dk0NBrBcdLIJUrqhSLpgVkC0v6uZx133L+2S0bulDAhvhf5+WU+E
         KxzzziZmLQmoEzblLlYLdwsEJ/nsWelUA50yLbaunSLSPgzrg2IK9jwBPnxNWoIHCu4j
         jrCk0aIWQl5QRCgXs/jWF/t34kAZw4ipcUrNZ8cyqw4qUFGxTx/jW5doy7fSZX0xOQZ5
         scBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ChC7ta4TNmBXuVY1YUDn8lL0sjlfevftcBEcR+PvHk=;
        b=bfqLtd/x2f/6AtXZ/0Q5QRFr/FqMR+swNyHc1tQygWdVm6FbMJAc8wDeu0LW/S7/4d
         gRuQXi9UtGLDzM7RqxZjvONIZ3bbevyu5kO/BHI7R5BPw4lhr8mI60cKSIhsbz8d84Km
         oCubcaa1GRT2o6r27IEvrJWUIZJO4ddC4+/+U9qUkRncxR81j99xqMr6CpDpA1RY/QZM
         IU9U9YSbZT5OHevoG0sCqyHYr5EQzEIBJF4ftaGMO133MQurgZVeMHclqxlaQPtpqY2l
         RZLpusm+vLq+81Upis0SpMuUW3KiB/UzO0vGWYELAkMiwKh/1VCStLn2vkJf4pP0G61x
         M0Gg==
X-Gm-Message-State: AFqh2koDgyKjtj8FwkeYZTo9mDZkdOteNSNV05vNAbwxY+Bp/Lq1fc9J
        2wEjYfwg1TlqsZUeBwB8CiE=
X-Google-Smtp-Source: AMrXdXvtDxQEzRyJJQjyREyLu3SfYqQoTBZw0786hdztySnlMF71OLB99drAQfGWmIEuSiqzK/LiRw==
X-Received: by 2002:adf:a4de:0:b0:2a9:89e:2b53 with SMTP id h30-20020adfa4de000000b002a9089e2b53mr29108456wrb.45.1673866343472;
        Mon, 16 Jan 2023 02:52:23 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id by12-20020a056000098c00b002bdd8f12effsm10600171wrb.30.2023.01.16.02.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 02:52:23 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <cddc6987-3b58-4688-65f8-3da0fbd1cc51@dunelm.org.uk>
Date:   Mon, 16 Jan 2023 10:52:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] worktree add: introduce basic DWYM for --orphan
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
References: <20230114224956.24801-1-jacobabel@nullpo.dev>
In-Reply-To: <20230114224956.24801-1-jacobabel@nullpo.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

On 14/01/2023 22:50, Jacob Abel wrote:
> Introduces a DWYM shorthand of --orphan for when the worktree directory
> and the to-be-created branch share the same name.
> 
> Current Behavior:
>      % git worktree list
>      /path/to/git/repo        a38d39a4c5 [main]
>      % git worktree add --orphan new_branch ../new_branch/
>      Preparing worktree (new branch 'new_branch')
>      % git worktree add --orphan ../new_branch2/
>      usage: git worktree add [<options>] <path> [<commit-ish>]
>         or: git worktree list [<options>]
>      [...]
>      %
> 
> New Behavior:
> 
>      % git worktree list
>      /path/to/git/repo        a38d39a4c5 [main]
>      % git worktree add --orphan new_branch ../new_branch/
>      Preparing worktree (new branch 'new_branch')
>      % git worktree list
>      /path/to/git/repo        a38d39a4c5 [main]
>      /path/to/git/new_branch  a38d39a4c5 [new_branch]
>      % git worktree add --orphan ../new_branch2/
>      Preparing worktree (new branch 'new_branch2')
>      % git worktree list
>      /path/to/git/repo        a38d39a4c5 [main]
>      /path/to/git/new_branch  a38d39a4c5 [new_branch]
>      /path/to/git/new_branch2 a38d39a4c5 [new_branch2]
>      %

Thanks for working on this. As I said in my previous mail I think it 
would be easier to use OPT_BOOL() for --orphan from the start. By using 
OPT_STRING() you'll run into problems with "git worktree add --orphan 
--lock <directory>"

Best Wishes

Phillip

> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>   Documentation/git-worktree.txt | 13 +++++++++----
>   builtin/worktree.c             | 21 +++++++++++++++------
>   t/t2400-worktree-add.sh        | 10 ++++++++++
>   3 files changed, 34 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index d78460c29c..a56ddb0185 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -12,7 +12,7 @@ SYNOPSIS
>   'git worktree add' [-f] [--detach] [--checkout] [--lock [--reason <string>]]
>   		   [(-b | -B) <new-branch>] <path> [<commit-ish>]
>   'git worktree add' [-f] [--lock [--reason <string>]]
> -		   --orphan <new-branch> <path>
> +		   --orphan [<new-branch>] <path>
>   'git worktree list' [-v | --porcelain [-z]]
>   'git worktree lock' [--reason <string>] <worktree>
>   'git worktree move' <worktree> <new-path>
> @@ -99,13 +99,16 @@ in the new worktree, if it's not checked out anywhere else, otherwise the
>   command will refuse to create the worktree (unless `--force` is used).
>   +
>   ------------
> -$ git worktree add --orphan <branch> <path>
> +$ git worktree add --orphan [<branch>] <path>
>   ------------
>   +
>   Create a worktree containing no files, with an empty index, and associated
>   with a new orphan branch named `<branch>`. The first commit made on this new
>   branch will have no parents and will be the root of a new history disconnected
>   from any other branches.
> ++
> +If a branch name `<branch>` is not supplied, the name is derived from the
> +supplied path `<path>`.
> 
>   list::
> 
> @@ -233,9 +236,11 @@ This can also be set up as the default behaviour by using the
>   	With `prune`, do not remove anything; just report what it would
>   	remove.
> 
> ---orphan <new-branch>::
> +--orphan [<new-branch>]::
>   	With `add`, make the new worktree and index empty, associating
> -	the worktree with a new orphan branch named `<new-branch>`.
> +	the worktree with a new orphan branch named `<new-branch>`. If
> +	`<new-branch>` is not supplied, the new branch name is derived
> +	from `<path>`.
> 
>   --porcelain::
>   	With `list`, output in an easy-to-parse format for scripts.
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index d975628353..481f895075 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -19,7 +19,7 @@
>   	N_("git worktree add [-f] [--detach] [--checkout] [--lock [--reason <string>]]\n" \
>   	   "                 [(-b | -B) <new-branch>] <path> [<commit-ish>]"), \
>   	N_("git worktree add [-f] [--lock [--reason <string>]]\n" \
> -	   "                 --orphan <new-branch> <path>")
> +	   "                 --orphan [<new-branch>] <path>")
> 
>   #define BUILTIN_WORKTREE_LIST_USAGE \
>   	N_("git worktree list [-v | --porcelain [-z]]")
> @@ -681,10 +681,13 @@ static int add(int ac, const char **av, const char *prefix)
>   	else if (keep_locked)
>   		opts.keep_locked = _("added with --lock");
> 
> -	if (ac < 1 || ac > 2)
> +	if (ac < 1 && opts.orphan) {
> +		path = prefix_filename(prefix, orphan_branch);
> +	} else if (ac >= 1 && ac <= 2) {
> +		path = prefix_filename(prefix, av[0]);
> +	} else {
>   		usage_with_options(git_worktree_add_usage, options);
> -
> -	path = prefix_filename(prefix, av[0]);
> +	}
>   	branch = ac < 2 ? "HEAD" : av[1];
> 
>   	if (!strcmp(branch, "-"))
> @@ -702,14 +705,20 @@ static int add(int ac, const char **av, const char *prefix)
>   		strbuf_release(&symref);
>   	}
> 
> -	if (opts.orphan) {
> -		new_branch = orphan_branch;
> +	if (ac < 1 && opts.orphan) {
> +		const char *s = dwim_branch(path, &orphan_branch);
> +		if (s)
> +			orphan_branch = s;
>   	} else if (ac < 2 && !new_branch && !opts.detach) {
>   		const char *s = dwim_branch(path, &new_branch);
>   		if (s)
>   			branch = s;
>   	}
> 
> +	if (opts.orphan) {
> +		new_branch = orphan_branch;
> +	}
> +
>   	if (ac == 2 && !new_branch && !opts.detach) {
>   		struct object_id oid;
>   		struct commit *commit;
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 1bf8d619e2..c3de277738 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -354,6 +354,16 @@ test_expect_success '"add --orphan" fails if the branch already exists' '
>   	test_path_is_missing orphandir2
>   '
> 
> +test_expect_success '"add --orphan" with basic DWYM' '
> +	test_when_finished "rm -rf empty_repo" &&
> +	echo refs/heads/worktreedir >expected &&
> +	GIT_DIR="empty_repo" git init --bare &&
> +	# Use non-trivial path to verify it DWYMs properly.
> +	git -C empty_repo worktree add --orphan ../empty_repo/worktreedir &&
> +	git -C empty_repo/worktreedir symbolic-ref HEAD >actual &&
> +	test_cmp expected actual
> +'
> +
>   test_expect_success '"add --orphan" with empty repository' '
>   	test_when_finished "rm -rf empty_repo" &&
>   	echo refs/heads/newbranch >expected &&
> --
> 2.38.2
> 
> 
