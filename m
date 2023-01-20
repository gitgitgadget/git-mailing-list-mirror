Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB90C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 15:08:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjATPIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:08:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjATPIK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 10:08:10 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14795F394
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:08:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id y11so7025504edd.6
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 07:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pltJQ3TvEfTOhVnIWFiX61svpvW0QtANBN1RPSPcanc=;
        b=SXUxLR5O0Uy6kTC4e8MPUj4vE9BnCYMlcvwJFBKcRkm+6D6EYrWLNA+OtBsB0LfWnU
         0gLH6M7qJ4YCoRQ7rtmiGaz+yX+NUcbro3SYus8NoYOggjAcbU6KfJbDptIkGDZV163B
         GukDxWkYQKfAFnU2/XqjWC7DxSnHOK0BkOco9O/Ua7iM96V5SOAPmnMOXhgecg+C/Y+k
         Rb3izwFIScBWlf7UINHcIP6PuWu99ge+Qct7E9p9U+eT9BJ/MjP6lIgIfbr9WRbzaoX6
         z0FpXCs1jKVu0GN8b6L8Mml6Hb32oTyMOxUqNlzJkxmx5CgEm+8AkFnTNNQT5mKcKfRT
         UU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pltJQ3TvEfTOhVnIWFiX61svpvW0QtANBN1RPSPcanc=;
        b=XGPoIymvCW2TfyD6cNqG7xMQSEiQSSHRGNeN2YCFYzLB+vCnREBCKfvEwWKHZm1hvj
         aZTUus9DevT6DpeFw4zojav+46izZFeW5pScjZemBDkoGAcAJjBpuUMYcgC0qfzyR6Oc
         r07Ke7lyXv0j9ADJSZZGcMlIg0QKc9j6fR/2O/BMIR+JkNMiQGb5ZhBb2EeX9C56t/r7
         ANlcDf7LIzPVroz4nEnKbXdWkuR6lRUqrx5AktPJ2x1eSoLrTnrT8gjDqK9x5uo5KXOL
         yH4LEk2qWRPWfEs75h7RjoTo7pAwwVvyuRj9rrwnvIa7Bb7MmM5HhJC1umY1uGgPO3wv
         mh1g==
X-Gm-Message-State: AFqh2kquSu9zEO5EVMcl+6TdKqt8QZ2KpiIzTfZFnkRm3wLT8Hha2jeo
        HkxcsbwIOy1KoWW9xaNPHScMNhbhxk8=
X-Google-Smtp-Source: AMrXdXuWvYQ8r7Z8Cr0xG5neYvHKOZnevXRagmuBpWUXgXyeN60+4CZisVt+7rovDO7+37UqgiNCqw==
X-Received: by 2002:aa7:cacd:0:b0:49e:20f9:4ade with SMTP id l13-20020aa7cacd000000b0049e20f94ademr14986062edt.10.1674227283775;
        Fri, 20 Jan 2023 07:08:03 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7c6d4000000b004610899742asm17424583eds.13.2023.01.20.07.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 07:08:03 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8f24fc3c-c30f-dc70-5a94-5ee4ed3de102@dunelm.org.uk>
Date:   Fri, 20 Jan 2023 15:08:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] checkout/switch: disallow checking out same branch in
 multiple worktrees
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20230119055325.1013-1-carenas@gmail.com>
 <20230120113553.24655-1-carenas@gmail.com>
In-Reply-To: <20230120113553.24655-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

On 20/01/2023 11:35, Carlo Marcelo Arenas Belón wrote:
> Commands `git switch -C` and `git checkout -B` neglect to check whether
> the provided branch is already checked out in some other worktree, as
> shown by the following:
> 
>    $ git worktree list
>    .../foo    beefb00f [main]
>    $ git worktree add ../other
>    Preparing worktree (new branch 'other')
>    HEAD is now at beefb00f first
>    $ cd ../other
>    $ git switch -C main
>    Switched to and reset branch 'main'
>    $ git worktree list
>    .../foo    beefb00f [main]
>    .../other  beefb00f [main]
> 
> Fix this problem by teaching `git switch -C` and `git checkout -B` to
> check whether the branch in question is already checked out elsewhere.
> 
> Unlike what it is done for `git switch` and `git checkout`, that have
> an historical exception to ignore other worktrees if the branch to
> check is the current one (as required when called as part of other
> tools), the logic implemented is more strict and will require the user
> to invoke the command with `--ignore-other-worktrees` to explicitly
> indicate they want the risky behaviour.
> 
> This matches the current behaviour of `git branch -f` and is safer; for
> more details see the tests in t2400.

As I said before, it would be much easier for everyone else to 
understand the changes if you wrote out what they were rather than 
saying "look at the tests". I do appreciate the improved test 
descriptions though - thanks for that.

> Reported-by: Jinwook Jeong <vustthat@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Rubén Justo <rjusto@gmail.com>
> Helped-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> Changes since v3
> * Code and Tests improvements as suggested by Phillip
> * Disable unreliable test that triggers a known bug
> 
> Changes since v2
> * A leak free implementation
> * More details in commit as suggested by Junio
> 
> Changes since v1
> * A much better commit message
> * Changes to the tests as suggested by Eric
> * Changes to the logic as suggested by Rubén
> 
> 
>   builtin/checkout.c      | 32 ++++++++++++++++++++++++--------
>   t/t2400-worktree-add.sh | 34 +++++++++++++++++++++++++++-------
>   2 files changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 3fa29a08ee..0688652f99 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1474,7 +1474,8 @@ static void die_if_some_operation_in_progress(void)
>   }
>   
>   static int checkout_branch(struct checkout_opts *opts,
> -			   struct branch_info *new_branch_info)
> +			   struct branch_info *new_branch_info,
> +			   char *check_branch_path)
>   {
>   	if (opts->pathspec.nr)
>   		die(_("paths cannot be used with switching branches"));
> @@ -1533,13 +1534,13 @@ static int checkout_branch(struct checkout_opts *opts,
>   	if (!opts->can_switch_when_in_progress)
>   		die_if_some_operation_in_progress();
>   
> -	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
> -	    !opts->ignore_other_worktrees) {
> +	if (!opts->ignore_other_worktrees && !opts->force_detach &&
> +	    check_branch_path && ref_exists(check_branch_path)) {

I think check_branch_path is NULL if opts->ignore_other_worktrees is set 
so we could maybe lose "!opts->ignore_other_worktrees" here (or possibly 
below where you set check_branch_path).

>   		int flag;
>   		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
> -		if (head_ref &&
> -		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
> -			die_if_checked_out(new_branch_info->path, 1);
> +		if (opts->new_branch_force || (head_ref &&
> +		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_path))))
> +			die_if_checked_out(check_branch_path, 1);

I don't think it is worth a re-roll but the reformatting here is 
unfortunate. If you add the new condition at the end it is clearer what 
is being changed.

		if ((head_ref &&
		    (!(flag & REF_IS_YMREF) || strcmp(head_ref, check_branch_path))) ||
		    opts->new_branch_force)

preserves the original code structure so one can see we've added a new 
condition and done s/new_branch_info->path/check_branch_path/

>   		free(head_ref);
>   	}
>   
> @@ -1627,7 +1628,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   			 const char * const usagestr[],
>   			 struct branch_info *new_branch_info)
>   {
> +	int ret;
>   	int parseopt_flags = 0;
> +	char *check_branch_path = NULL;
>   
>   	opts->overwrite_ignore = 1;
>   	opts->prefix = prefix;
> @@ -1717,6 +1720,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   		opts->new_branch = argv0 + 1;
>   	}
>   
> +	if (opts->new_branch && !opts->ignore_other_worktrees) {
> +		struct strbuf buf = STRBUF_INIT;
> +
> +		strbuf_branchname(&buf, opts->new_branch, INTERPRET_BRANCH_LOCAL);
> +		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
> +		check_branch_path = strbuf_detach(&buf, NULL);
> +	}

This block will run whenever -b/-B is given which is good

>   	/*
>   	 * Extract branch name from command line arguments, so
>   	 * all that is left is pathspecs.
> @@ -1741,6 +1751,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   					     new_branch_info, opts, &rev);
>   		argv += n;
>   		argc -= n;
> +
> +		if (!opts->ignore_other_worktrees && !check_branch_path && new_branch_info->path)
> +			check_branch_path = xstrdup(new_branch_info->path);

I'm a bit confused what this is doing.

>   	} else if (!opts->accept_ref && opts->from_treeish) {
>   		struct object_id rev;
>   
> @@ -1817,9 +1830,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   	}
>   
>   	if (opts->patch_mode || opts->pathspec.nr)
> -		return checkout_paths(opts, new_branch_info);
> +		ret = checkout_paths(opts, new_branch_info);
>   	else
> -		return checkout_branch(opts, new_branch_info);
> +		ret = checkout_branch(opts, new_branch_info, check_branch_path);
> +
> +	free(check_branch_path);
> +	return ret;

This is clearer now - thanks

>   }
>   
>   int cmd_checkout(int argc, const char **argv, const char *prefix)
> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> index d587e0b20d..7ab7e87440 100755
> --- a/t/t2400-worktree-add.sh
> +++ b/t/t2400-worktree-add.sh
> @@ -118,14 +118,17 @@ test_expect_success '"add" worktree creating new branch' '
>   	)
>   '
>   
> -test_expect_success 'die the same branch is already checked out' '
> +test_expect_success 'die if the same branch is already checked out' '
>   	(
>   		cd here &&
> -		test_must_fail git checkout newmain
> +		test_must_fail git checkout newmain &&
> +		test_must_fail git checkout -B newmain &&
> +		test_must_fail git switch newmain &&
> +		test_must_fail git switch -C newmain
>   	)
>   '
>   
> -test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
> +test_expect_success SYMLINKS 'die if the same branch is already checked out (symlink)' '
>   	head=$(git -C there rev-parse --git-path HEAD) &&
>   	ref=$(git -C there symbolic-ref HEAD) &&
>   	rm "$head" &&
> @@ -133,17 +136,34 @@ test_expect_success SYMLINKS 'die the same branch is already checked out (symlin
>   	test_must_fail git -C here checkout newmain
>   '
>   
> -test_expect_success 'not die the same branch is already checked out' '
> +test_expect_success 'allow creating multiple worktrees for same branch with force' '
> +	git worktree add --force anothernewmain newmain
> +'
> +
> +test_expect_success 'allow checkout/reset from the conflicted branch' '

I'm not sure what "the conflicted branch" means (it reminds we of merge 
conflicts). Is this just testing that "checkout -b/B <branch> 
<start-point>" works?

>   	(
>   		cd here &&
> -		git worktree add --force anothernewmain newmain
> +		git checkout -b conflictedmain newmain &&
> +		git checkout -B conflictedmain newmain &&
> +		git switch -C conflictedmain newmain
> +	)
> +'
> +
> +test_expect_success 'and not die on re-checking out current branch even if conflicted' '

I think 'allow re-checking out ...' would be clearer, again I'm not sure 
what's conflicted here.

> +	(
> +		cd there &&
> +		git checkout newmain &&
> +		git switch newmain
>   	)
>   '
>   
> -test_expect_success 'not die on re-checking out current branch' '
> +test_expect_failure 'unless using force without --ignore-other-worktrees' '

This test passes for me - what's the reason for changing from 
test_expect_success to test_expect_failure?

Thanks for working on this

Phillip

>   	(
>   		cd there &&
> -		git checkout newmain
> +		test_must_fail git checkout -B newmain &&
> +		test_must_fail git switch -C newmain &&
> +		git checkout --ignore-other-worktrees -B newmain &&
> +		git switch --ignore-other-worktrees -C newmain
>   	)
>   '
>   
