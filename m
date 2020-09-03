Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579F7C433E2
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 00:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BFAB20773
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 00:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlG2G57I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgICAGp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgICAGo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 20:06:44 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222EFC061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 17:06:43 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k15so581788pji.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 17:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kZUzv3JciSePhtstXwuCPpTBoFHrEljDF+gBCBZ17H0=;
        b=AlG2G57II2J5D+hD1dW2ktyII5PyF/fFEdwRaU+E10PMWfv8/ATE1dKAOQ+s3GZC1k
         pCfy2dUTHPKW/PlBAaFxpGtTv7c5+wtx3T/+dcOrwvcFMLNTUFMq6ivk61imlHVcQQQc
         I1KBIsNG2dEVRrRkj71HmeJJEVsFbCMFbJZH8rUY9u0x/DzV2bUZ8GbajLzpVBQrgw/y
         Xmgh4yaDuq+2y5JRVqKF5yaZcqPkb2JGFv6YE4cBNv4i9cI7tRMQwcNBYvaQyRA8LHS6
         mPYMofK19UsUVvY4uzha1+kphv9nfS1Aep/IaidHfDIctWAiRlNId5Br7CI4bWLV8jgC
         OHCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kZUzv3JciSePhtstXwuCPpTBoFHrEljDF+gBCBZ17H0=;
        b=eKlXL/pbAwtxWKhpXEdXa75Dh4FBjJtFtGmGEyzKTf8wu27eB9FdxBMauIXB9fdfLn
         SQY2kzM+FFbwv6+YoW7vFrG5cmszXOJv0tg8elb6uIh97FJe3CeNefksxnHBBc9qiEIi
         e1R/3tOivbxem/noimNi5P+6hJV8swZl5O51MCCOOon7pAh74wx6VVFgVq8OzVsi6ivA
         kCX04AGaZ4fiN+pv3FPlgwZsFX6YpgpJnzyUZWGS5K3R32mJ9nE5zs8wADfWGu0oI4Dp
         oWHnBqEGdSagfG9QDr/3vcfGaNjgzOAjj6w/bI3S13qV1UFvT7MoWEpVgjmFRO1fwfmy
         foug==
X-Gm-Message-State: AOAM531jPVnmbbq3YheMsB/qYjYRpmYAk8pEp3Fkp1wZSAbFDLch7Gmh
        ZCFB28zlN6RyglE5RiW07oM=
X-Google-Smtp-Source: ABdhPJwzq+HBYsnCLmK02876n32673VVo9bTYP+NsFsgROdOpMVAAZFZyK+rNkFzjnpwFKPSGRf39g==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr228823pjb.139.1599091602581;
        Wed, 02 Sep 2020 17:06:42 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id k28sm680270pfh.196.2020.09.02.17.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 17:06:41 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:06:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] vcbuild: fix library name for expat with make MSVC=1
Message-ID: <20200903000640.GD4035286@google.com>
References: <pull.722.git.1599077798953.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.722.git.1599077798953.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(cc-ing a couple of Windows experts)
Orgad Shaneh wrote:

> Subject: vcbuild: fix library name for expat with make MSVC=1

Do you have more details?  For example, what error message does the
build produce without this change?

> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-722%2Forgads%2Fvcbuild-expat-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-722/orgads/vcbuild-expat-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/722
>
>  compat/vcbuild/scripts/clink.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm ignorant enough about the platform-specific details involved that
I'd like an Ack from one of the Windows folks.

Thanks,
Jonathan

> diff --git a/compat/vcbuild/scripts/clink.pl b/compat/vcbuild/scripts/clink.pl
> index 61ad084a7b..df167d1e1a 100755
> --- a/compat/vcbuild/scripts/clink.pl
> +++ b/compat/vcbuild/scripts/clink.pl
> @@ -66,7 +66,7 @@
>  		}
>  		push(@args, $lib);
>  	} elsif ("$arg" eq "-lexpat") {
> -		push(@args, "expat.lib");
> +		push(@args, "libexpat.lib");
>  	} elsif ("$arg" =~ /^-L/ && "$arg" ne "-LTCG") {
>  		$arg =~ s/^-L/-LIBPATH:/;
>  		push(@lflags, $arg);
> 
> base-commit: e19713638985533ce461db072b49112da5bd2042
> -- 
> gitgitgadget
