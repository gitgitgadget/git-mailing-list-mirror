Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF44C004D4
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 14:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjASOVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 09:21:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230293AbjASOVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 09:21:16 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC041BF9
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 06:21:15 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hw16so6005972ejc.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 06:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VjrYR4TmumUbwM6NbVHp90Fmg3lViKfFhIYRSEar2j0=;
        b=XgzV4g6onUg9Xkv7OKOPjgvMdJR2N05XaG4oBOoFsEt2oGGulYpLTiv8VGL22Ehsu8
         z4TN6RLo+PRjzbMVSO4GFraoSTyGSSaEIroWtseUQWN2TwwzbENr24m2cAnQyWDZA4sa
         DlVrPbSEgs0sQD2C4zkISZTrBO8ECoez8LO8or5UP2KNlrbVAxLok1fqLcaQuQTmQko+
         xhvxQSt7a6z7nY796thNqxna0zi9q3oegTf+It81FbVsSlWmhlzTvuPEW3dQ7crGhfdN
         t2bnHv6pa+CBh1FiX2MvYUkGRUDcdK/ZUlRsyAi+42dJae+9nhpVxD+xwKt1oUrUVVVh
         VVGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjrYR4TmumUbwM6NbVHp90Fmg3lViKfFhIYRSEar2j0=;
        b=IgRXOVkjyAC397fiSiVHahCQLH9bSyTQApAJ4iInV812myF3rcP3gH1jhRqSpk0oib
         poKI8DmeiO9/sZJhYN6MDJE90Ab3kMnFjg+5owKOTDg9b6mReKZN4gY564lARVh1HTTO
         2ChcKno2goRK0FmQ8RryVfX9kQ2u/pq1Ev1M6Hier0PV+/JjHJmKA50vNdH4wKTYsRdm
         dylozDSJaJTRpmKe7k/ltnZyX5yvESYfdMamDcas0BwRnYpDFAr+VjvdAberrZCiREEf
         ONFuDOJrkNqlnpsTPCsyu8FqKjuKxz2SmCWT0ZBmN3Zk/COCkmBS+GR24GgYhr4bzawo
         PPCQ==
X-Gm-Message-State: AFqh2krWHcb/3kTyJDF/j+rm5trOIWYoRyv03kp3Ltti1WOUEcP/+ekH
        TtcmjScxwrcypDhN0yzefptVf2TZE1g=
X-Google-Smtp-Source: AMrXdXvXSe3cN/aFb220o2ln/HJUo/VxTM3X65JpxN2FdCFqMLAbOuR3QZe1BZxpvBF83NuirL0PEg==
X-Received: by 2002:a17:906:1112:b0:84d:28d6:3179 with SMTP id h18-20020a170906111200b0084d28d63179mr11217214eja.0.1674138073879;
        Thu, 19 Jan 2023 06:21:13 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id la19-20020a170907781300b007aee7ca1199sm16531312ejc.10.2023.01.19.06.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:21:13 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6a0499d4-ad6e-56b7-de72-0f8a3697b534@dunelm.org.uk>
Date:   Thu, 19 Jan 2023 14:21:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] checkout/switch: disallow checking out same branch in
 multiple worktrees
Content-Language: en-US
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20230118061527.76218-1-carenas@gmail.com>
 <20230119055325.1013-1-carenas@gmail.com>
In-Reply-To: <20230119055325.1013-1-carenas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

Thanks for working on this

On 19/01/2023 05:53, Carlo Marcelo Arenas Belón wrote:
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
> check whether the branch in question is already checked out elsewhere
> by expanding on the existing checks that are being used by their non
> force variants.
 >
> Unlike what it is done for `git switch` and `git checkout`, that have
> an historical exception to ignore other workspaces if the branch to
> check is the current one (as required when called as part of other
> tools), the logic implemented is more strict and will require the user
> to invoke the command with `--ignore-other-worktrees` to explicitly
> indicate they want the risky behaviour.

> This matches the current behaviour of `git branch -f` and is safer, for
> more details see the tests in t2400.

I think it would be helpful to spell out the behavior of

	git checkout $current_branch
	git checkout -B $current_branch [<commit>]
	git checkout -B $current_branch --ignore-other-worktrees [<commit>]

when the current branch is and is not checked out in another worktree 
as the tests are hard to follow because they rely on worktrees set up 
previous tests.

> Reported-by: Jinwook Jeong <vustthat@gmail.com>
> Helped-by: Rubén Justo <rjusto@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
> @@ -1818,10 +1831,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
>   		strbuf_release(&buf);
>   	}
>   
> -	if (opts->patch_mode || opts->pathspec.nr)
> +	if (opts->patch_mode || opts->pathspec.nr) {
> +		free(check_branch_path);
>   		return checkout_paths(opts, new_branch_info);
> +	}
>   	else
> -		return checkout_branch(opts, new_branch_info);
> +		return checkout_branch(opts, new_branch_info, check_branch_path);
>   }

I found the ownership of check_branch_path confusing here. I think it 
would be clearer to do

	if (opts->patch_mode || opts->pathspec.nr)
		ret = checkout_path(...);
	else
		ret = checkout_branch(...);
	free(check_branch_path);
	return ret;

 > [...]
> +test_expect_success 'but die if using force without --ignore-other-worktrees' '

I'm not sure from the title what this test is checking. Having added 
"git worktree list" and run it is checking that when the current branch 
is checked out elsewhere we require --ignore-other-worktrees when 
resetting the current branch.

> +	(
> +		cd there &&
> +		test_must_fail git checkout -B newmain &&
> +		test_must_fail git switch -C newmain &&
> +		git checkout --ignore-other-worktrees -B newmain &&
> +		git switch --ignore-other-worktrees -C newmaain >   	)

I tried running

	git switch -C main newbranch

from the main worktree (which is the only worktree that has branch 
'main' checked out) to check that we did not error out when the branch 
is not checked out elsewhere and was surprised it failed with

	fatal: 'newbranch' is already checked out at '/dev/shm/trash 
directory.t2400-worktree-add/short-hand'

It works as expected without this patch so it looks like there is a bug 
somewhere.

Best Wishes

Phillip
