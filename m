Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FEAC4708D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 14:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAFOTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 09:19:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjAFOTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 09:19:17 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E88D7BDF6
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 06:19:16 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id m7so1379706wrn.10
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 06:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KOuqG5aZf3NOYcdMvpHas/tFRy7twm8XPejdkVLXnNo=;
        b=ZBolVhChAuPN4tBNOibyg3T7S0P9RspXOo5nzBs4vtyhs9dP51tJ4pD38i07tU3Fmp
         5xe2AHVmCnEshjC5CiT3XzhKkTJJp7i+ChKLkFxIpjxrTCYk2rhM1/j5jJxutL1NbeTv
         LiTapFWUp3Ru++iqh4D/cwsm8FEHsAuEHUYUq8jasqCjaXqQSqWLPgBuC8Y8m4FAGcjM
         GN2YwI84FnKbbXvLLzg6GTNOOUzR9+m1VgQTfC2sugCUp/EmSQr2LWAu7u0XQGyJs04U
         su7QGObEdE48RKn5e9oaq5qfgntfaJX+bdAwxlv26/iapP90HL+zUzQYAZ3PxFCmaLG7
         fHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOuqG5aZf3NOYcdMvpHas/tFRy7twm8XPejdkVLXnNo=;
        b=mqhU+kq5/OWeuky4m/8l1GtYE//Au9+lGf6lcYM8M6qbNDJCugTyJkdf/C+6QAzIlW
         wwE6kyQCtROakG/VPZiGaAU8oVg53rVn9bIu97OklZ71W1Yjp6S/7H0TPmriKVht9sBm
         3FJQhEnjjOI/1ZDOAyq1zSiJ2eaCEWH/3T6z+LgCRB8cDhRcU9vRq7/RAGYOFtjyf7Ka
         sEd8ILnpV2pAb9nUi11l+HRns5lmf2kEmdK8B27oTzWv6yLy9H0ilTvYM9AAxfs6eEyv
         ntHB4g4SVXFrWm5pvq9WVsB7t5JyQFf1xF25mRZwUmEA24nkFcn05n+IlohbpDRgW6Y9
         /e5g==
X-Gm-Message-State: AFqh2kooPf0MU0oZ1rwB41EmghPijT5hsLOsBH19JiMaQpRVGwFEAPSe
        GIC+9Nxx1aWPx+MwPzkbDsyib3IQYNg=
X-Google-Smtp-Source: AMrXdXvs+Bx+GWvT3f5uVlTlCcxQfPdhia0SnipnslVBMG+MYlLxSjkwvo13TxokV8/AaMZ+Z7ZXeA==
X-Received: by 2002:adf:f34c:0:b0:28f:e8ef:5b21 with SMTP id e12-20020adff34c000000b0028fe8ef5b21mr15314120wrp.62.1673014754823;
        Fri, 06 Jan 2023 06:19:14 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6a52000000b0029c5e06516bsm1307406wrw.14.2023.01.06.06.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 06:19:14 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <952bd500-1a4c-068b-0b44-df0f16e04f6f@dunelm.org.uk>
Date:   Fri, 6 Jan 2023 14:19:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/4] worktree add: add hint to direct users towards
 --orphan
Content-Language: en-US
To:     Jacob Abel <jacobabel@nullpo.dev>, git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
References: <20221104010242.11555-1-jacobabel@nullpo.dev>
 <20221104213401.17393-1-jacobabel@nullpo.dev>
 <20221110233137.10414-1-jacobabel@nullpo.dev>
 <20221212014003.20290-1-jacobabel@nullpo.dev>
 <20221220023637.29042-1-jacobabel@nullpo.dev>
 <20221228061539.13740-1-jacobabel@nullpo.dev>
 <20221228061539.13740-5-jacobabel@nullpo.dev>
In-Reply-To: <20221228061539.13740-5-jacobabel@nullpo.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jacob

On 28/12/2022 06:17, Jacob Abel wrote:
> Adds a new advice/hint in `git worktree add` for when the user
> tries to create a new worktree from a reference that doesn't exist.

I was concerned that this description meant that

	git worktree add wt ref-that-does-not-exist

would print a hint rather than just error out but having tested it 
that's not the case. We only print the hint if the user does not give an 
explicit branch name. The implementation looks fine to me and the test 
looks sensible apart from save_param_arr which I think you're already 
planning to address.

Best Wishes

Phillip

> Current Behavior:
> 
> % git init --bare foo.git
> Initialized empty Git repository in /path/to/foo.git/
> % git -C foo.git worktree add main/
> Preparing worktree (new branch 'main')
> fatal: invalid reference: HEAD
> %
> 
> New Behavior:
> 
> % git init --bare foo.git
> Initialized empty Git repository in /path/to/foo.git/
> % git -C foo.git worktree add main/
> Preparing worktree (new branch 'main')
> hint: If you meant to create a worktree containing a new orphan branch
> hint: (branch with no commits) for this repository, you can do so
> hint: using the --orphan option:
> hint:
> hint:   git worktree add --orphan main ./main
> hint:
> hint: Disable this message with "git config advice.worktreeAddOrphan false"
> fatal: invalid reference: HEAD
> %
> 
> Signed-off-by: Jacob Abel <jacobabel@nullpo.dev>
> ---
>   Documentation/config/advice.txt |  4 ++++
>   advice.c                        |  1 +
>   advice.h                        |  1 +
>   builtin/worktree.c              |  6 ++++++
>   t/t2400-worktree-add.sh         | 17 +++++++++++++++++
>   5 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/config/advice.txt b/Documentation/config/advice.txt
> index a00d0100a8..3e58521613 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -136,4 +136,8 @@ advice.*::
>   		Advice shown when either linkgit:git-add[1] or linkgit:git-rm[1]
>   		is asked to update index entries outside the current sparse
>   		checkout.
> +	worktreeAddOrphan::
> +		Advice shown when a user tries to create a worktree from an
> +		invalid reference, to instruct how to create a new orphan
> +		branch instead.
>   --
> diff --git a/advice.c b/advice.c
> index fd18968943..53e91fdb85 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -75,6 +75,7 @@ static struct {
>   	[ADVICE_SUBMODULES_NOT_UPDATED] 		= { "submodulesNotUpdated", 1 },
>   	[ADVICE_UPDATE_SPARSE_PATH]			= { "updateSparsePath", 1 },
>   	[ADVICE_WAITING_FOR_EDITOR]			= { "waitingForEditor", 1 },
> +	[ADVICE_WORKTREE_ADD_ORPHAN]			= { "worktreeAddOrphan", 1 },
>   };
> 
>   static const char turn_off_instructions[] =
> diff --git a/advice.h b/advice.h
> index 07e0f76833..919d8c0064 100644
> --- a/advice.h
> +++ b/advice.h
> @@ -50,6 +50,7 @@ struct string_list;
>   	ADVICE_UPDATE_SPARSE_PATH,
>   	ADVICE_WAITING_FOR_EDITOR,
>   	ADVICE_SKIPPED_CHERRY_PICKS,
> +	ADVICE_WORKTREE_ADD_ORPHAN,
>   };
> 
>   int git_default_advice_config(const char *var, const char *value);
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index ac82c5feda..d975628353 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -730,6 +730,12 @@ static int add(int ac, const char **av, const char *prefix)
>   	if (opts.orphan) {
>   		branch = new_branch;
>   	} else if (!lookup_commit_reference_by_name(branch)) {
> +		advise_if_enabled(ADVICE_WORKTREE_ADD_ORPHAN,
> +			_("If you meant to create a worktree containing a new orphan branch\n"
> +			"(branch with no commits) for this repository, you can do so\n"
> +			"using the --orphan option:\n"
> +			"\n"
> +			"	git worktree add --orphan %s %s\n"), new_branch, path);
>   		die(_("invalid reference: %s"), branch);
>   	} else if (new_branch) {
>   		struct child_process cp = CHILD_PROCESS_INIT;
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index 43c95e6426..f43de59117 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -397,6 +397,23 @@ test_expect_success '"add" worktree with orphan branch, lock, and reason' '
>   	test_cmp expect .git/worktrees/orphan-with-lock-reason/locked
>   '
> 
> +test_wt_add_empty_repo_orphan_hint () {
> +	local context="$1"
> +	shift
> +	local arr=$(save_param_arr "$@")
> +	test_expect_success "'worktree add' show orphan hint in empty repo w/ $context" '
> +		eval "set -- $arr" &&
> +		test_when_finished "rm -rf empty_repo" &&
> +		GIT_DIR="empty_repo" git init --bare &&
> +		test_must_fail git -C empty_repo worktree add "$@" foobar/ 2> actual &&
> +		grep "hint: If you meant to create a worktree containing a new orphan branch" actual
> +	'
> +}
> +
> +test_wt_add_empty_repo_orphan_hint 'DWIM'
> +test_wt_add_empty_repo_orphan_hint '-b' -b foobar_branch
> +test_wt_add_empty_repo_orphan_hint '-B' -B foobar_branch
> +
>   test_expect_success 'local clone from linked checkout' '
>   	git clone --local here here-clone &&
>   	( cd here-clone && git fsck )
> --
> 2.38.2
> 
> 
