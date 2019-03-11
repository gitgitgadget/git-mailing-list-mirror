Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 379BA20248
	for <e@80x24.org>; Mon, 11 Mar 2019 07:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfCKH1L (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 03:27:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36270 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfCKH1K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 03:27:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id j125so3165129wmj.1
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 00:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=L/tdN/lJQseUNSlDeOUSYnxk5kz+mymTfYMZDhrPbYg=;
        b=oo/6PZrvq9Z4O3wlLraLi53ZE1Ka0qpVgLbL+dbageoUTuTNN83cDKetHN2DnI5R0E
         3pCUpw71Sm3wjSWxBKT+9q3V7KFtPAoGXsS06XUhUGGsHQtaDpGMQZxD/Jy7jKtZHhhg
         d92X/6+NQXxUgq31M+qPjwm//+TTU5Vftdr1uX5aMyZwhFR2LFOltZJOGPPT8Lko73gf
         DLdXVKrmH7fZUbHLMNqfzpLBFNu4sp3IjRodGALB0jRWe5aT95jDeLXeRRl2KHN1+rCH
         r/hDxS55wcBRw0D1iwzBC1dgRKxrojpx3I4XONQAM7Q4kM3rxyFaswp8zO8/AGmHB3xL
         aFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=L/tdN/lJQseUNSlDeOUSYnxk5kz+mymTfYMZDhrPbYg=;
        b=Gs/oSKf7FlmAlAm1QzKza5hE3kU4zgfSSqH70IgS0lKdc1nnY56YX4oaRd1q3VZyVn
         R8EHuSxKD10vX+ag4Iq2erUVhaxBVlVK4btRojnHvqpb8CfX22AtTQM5Kd7D4v5xyArl
         PIn2bE80ZC3dy9XktsOtnWBjQobxR39m68r87Zizik5bH2CEYJd58a45S85LqdXb5hJe
         r2K6yCQ8ooXYiIJASHfcC2GxqcJetPmtPDGRyAlk6evirD5QqD/KnZ9V8Pe4OZH9VHOH
         oAeu+dxw2NqydY6CK4M2By8aKd5FncIeOmCe3G05rBu5sdmyoHqIl1eNjQhwtf8aIj54
         H65Q==
X-Gm-Message-State: APjAAAUzcXhlmFmThpn/X9TMy0fvgk1Rxemu8FwVWdyB54EnHXL360c+
        B5ljlH2K34Yuq6DH5wUanKM=
X-Google-Smtp-Source: APXvYqwTFCndJNwXXZMhADWsDJ3rO+tJhsb+lhAdkXPJOw4RLoAdg2xokQXeFqdnrzygUrv57g/kfg==
X-Received: by 2002:a1c:4406:: with SMTP id r6mr15921423wma.114.1552289228263;
        Mon, 11 Mar 2019 00:27:08 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id j17sm2622795wrw.67.2019.03.11.00.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 00:27:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/2] legacy stash: fix "rudimentary backport of -q"
References: <pull.159.git.gitgitgadget@gmail.com>
        <f76c7cb66c43a6c4bf712516949a867b09710103.1551972571.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Mar 2019 16:27:06 +0900
In-Reply-To: <f76c7cb66c43a6c4bf712516949a867b09710103.1551972571.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 07 Mar 2019
        07:29:32 -0800 (PST)")
Message-ID: <xmqqlg1lkh11.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This can be seen very clearly when passing arguments with special
> characters, like
>
> 	git stash -- ':(glob)**/*.txt'
>
> Since this is exactly what we want to test in the next commit (where we
> fix this very incantation with the built-in stash), let's fix the legacy
> scripted version of `git stash` first.

Thanks.  I agree that these eval are evaluating one iteration too
much.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git-legacy-stash.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
> index 8a8c4a9270..f60e9b3e87 100755
> --- a/git-legacy-stash.sh
> +++ b/git-legacy-stash.sh
> @@ -86,17 +86,17 @@ maybe_quiet () {
>  		shift
>  		if test -n "$GIT_QUIET"
>  		then
> -			eval "$@" 2>/dev/null
> +			"$@" 2>/dev/null
>  		else
> -			eval "$@"
> +			"$@"
>  		fi
>  		;;
>  	*)
>  		if test -n "$GIT_QUIET"
>  		then
> -			eval "$@" >/dev/null 2>&1
> +			"$@" >/dev/null 2>&1
>  		else
> -			eval "$@"
> +			"$@"
>  		fi
>  		;;
>  	esac
