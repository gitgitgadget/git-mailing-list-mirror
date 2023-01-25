Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BC2C54E94
	for <git@archiver.kernel.org>; Wed, 25 Jan 2023 14:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbjAYOQM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Jan 2023 09:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbjAYOPe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2023 09:15:34 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E267559767
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 06:14:56 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k16so13865697wms.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2023 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQJDYn6pPnikwsJpvg0neUHXE39i1WhfoPVCXoSNwKQ=;
        b=C7EofGadApDF4Oqf2Ww5xW6bLOM5hgHprUQqiKW3aYXjpHevu3K49XgUvAPraMyTjn
         dabHBK9rZHzoprNMVJf2zSulzaxryzuklT7OsaEMkAk4LypJf+z+WOqEMl+5jbpzLqmq
         qj8zviFLSofvT0BcEi8TcUQkE0duHw0CfJtXbZKvOWLLgKNvjjtF5lDPPryJLLsnTUqQ
         kpJicA50knERZxk0F2y8d9yQJVtHjP9ELrfYdu1HkvDaxmcPg2LDF6O0rdf4UJVh8vxo
         SbmemzimGVwEbZfBjw9zdGnQlS6cWvCcMnpWqmelp2F4a8JPTzMzG7B6jokMauOfkOfe
         kB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQJDYn6pPnikwsJpvg0neUHXE39i1WhfoPVCXoSNwKQ=;
        b=vFkBh/tk8c36XrWoElo4+9YQaMgIPkg6Y5p531WFRA15IBhtMwCMRFwtQyubIPO5Dq
         qP960NSpx/QCgwxP4r50WdGQwQpEz2clx1BVrpbOVnP7yjrAULWFE2luxWMTqwTdy/on
         1rZdD1nTUc72jFXERFIXY36K1o8d+gLPl/xUhRtHv/WFOXTC42InIJE8jszHn5I4rbh0
         vytMFjumFuqV73kDhEf+9lFQkR8ppsbWQqdUlnBImYpbHpzuRNqzH9i9skCcXz8dKmv1
         TgeSEHaTTuQFA6B7T9QZhuVna+V7mYW3wkIJVav1vnhESarzroNGW9ICTzhbHGH5OSVE
         J7ww==
X-Gm-Message-State: AFqh2kooak+aRZTAvbm5bhJ7r3ZG0TC3R8TFKpePrZtIxMWH5YcKeK+u
        4+RaL9k6M+xxhbgHi82SS+E=
X-Google-Smtp-Source: AMrXdXuJ4lFn6uBm/61+YlOCvRpxFKngoSjlCo5Mnie8hp6UoLY42JgHz3w+QPxihfk1HFfB42CDwQ==
X-Received: by 2002:a05:600c:80f:b0:3d2:3d7b:6118 with SMTP id k15-20020a05600c080f00b003d23d7b6118mr32172357wmp.24.1674656095061;
        Wed, 25 Jan 2023 06:14:55 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id g26-20020a7bc4da000000b003d96efd09b7sm1987858wmk.19.2023.01.25.06.14.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 06:14:54 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <94deff87-a4a0-e937-7549-3e5348361a12@dunelm.org.uk>
Date:   Wed, 25 Jan 2023 14:14:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 05/10] rebase: fix incompatiblity checks for
 --[no-]reapply-cherry-picks
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <pull.1466.v5.git.1674619434.gitgitgadget@gmail.com>
 <3a8429f3d2b72d59d0a071d83f6fd9effe6824ed.1674619434.git.gitgitgadget@gmail.com>
In-Reply-To: <3a8429f3d2b72d59d0a071d83f6fd9effe6824ed.1674619434.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 25/01/2023 04:03, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> --[no-]reapply-cherry-picks was traditionally only supported by the
> sequencer.  Support was added for the apply backend, when --keep-base is
> also specified, in commit ce5238a690 ("rebase --keep-base: imply
> --reapply-cherry-picks", 2022-10-17).  Make the code error out when
> --[no-]reapply-cherry-picks is specified AND the apply backend is used
> AND --keep-base is not specified.  Also, clarify a number of comments
> surrounding the interaction of these flags.

This looks great to me. Sorry it took me so long to realize that the 
apply backend should be erroring out on --no-reapply-cherry-picks 
without --keep-base. Thanks for taking the time to update the comments, 
hopefully they'll be more helpful to future readers that the current 
ones have proved to be.

Best Wishes

Phillip

> Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>   Documentation/git-rebase.txt           |  2 +-
>   builtin/rebase.c                       | 34 ++++++++++++++++----------
>   t/t3422-rebase-incompatible-options.sh | 10 ++++++++
>   3 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 846aeed1b69..8a09f12d897 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -650,7 +650,7 @@ are incompatible with the following options:
>    * --exec
>    * --no-keep-empty
>    * --empty=
> - * --reapply-cherry-picks
> + * --[no-]reapply-cherry-picks when used without --keep-base
>    * --edit-todo
>    * --update-refs
>    * --root when used without --onto
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index b742cc8fb5c..05b130bfae5 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1224,13 +1224,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		if (options.fork_point < 0)
>   			options.fork_point = 0;
>   	}
> -	/*
> -	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
> -	 * commits when using this option.
> -	 */
> -	if (options.reapply_cherry_picks < 0)
> -		options.reapply_cherry_picks = keep_base;
> -
>   	if (options.root && options.fork_point > 0)
>   		die(_("options '%s' and '%s' cannot be used together"), "--root", "--fork-point");
>   
> @@ -1406,12 +1399,27 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.empty != EMPTY_UNSPECIFIED)
>   		imply_merge(&options, "--empty");
>   
> -	/*
> -	 * --keep-base implements --reapply-cherry-picks by altering upstream so
> -	 * it works with both backends.
> -	 */
> -	if (options.reapply_cherry_picks && !keep_base)
> -		imply_merge(&options, "--reapply-cherry-picks");
> +	if (options.reapply_cherry_picks < 0)
> +		/*
> +		 * We default to --no-reapply-cherry-picks unless
> +		 * --keep-base is given; when --keep-base is given, we want
> +		 * to default to --reapply-cherry-picks.
> +		 */
> +		options.reapply_cherry_picks = keep_base;
> +	else if (!keep_base)
> +		/*
> +		 * The apply backend always searches for and drops cherry
> +		 * picks.  This is often not wanted with --keep-base, so
> +		 * --keep-base allows --reapply-cherry-picks to be
> +		 * simulated by altering the upstream such that
> +		 * cherry-picks cannot be detected and thus all commits are
> +		 * reapplied.  Thus, --[no-]reapply-cherry-picks is
> +		 * supported when --keep-base is specified, but not when
> +		 * --keep-base is left out.
> +		 */
> +		imply_merge(&options, options.reapply_cherry_picks ?
> +					  "--reapply-cherry-picks" :
> +					  "--no-reapply-cherry-picks");
>   
>   	if (gpg_sign)
>   		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index f86274990b0..826f3b94ae6 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -60,6 +60,16 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --exec 'true' A
>   	"
>   
> +	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --no-reapply-cherry-picks A
> +	"
> +
> +	test_expect_success "$opt incompatible with --reapply-cherry-picks" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --reapply-cherry-picks A
> +	"
> +
>   	test_expect_success "$opt incompatible with --update-refs" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --update-refs A
