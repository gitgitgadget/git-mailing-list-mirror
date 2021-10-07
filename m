Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D180C433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 04:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB18C60F51
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 04:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhJGEJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 00:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhJGEJe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 00:09:34 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D77C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 21:07:41 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id q125so4745986qkd.12
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 21:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=17Joj3qzIwxbIb9FEXzINgU+Lmaw5nywiHQndt+4guI=;
        b=f4C6E3+r3tyfvzqv/+ciYw07j57yJ8dWLnb+N5nLo68gtEuHFYdiriQdL4DIfQrYkm
         TuNj+dDsVZUjXPN3NL8WJFov7Wo4DmyCzYpg5hDohzAhVWMiDryXBmBR4Ch/s71tLHZd
         RghMPtXWMw267AXzZkCGm0PNQv8fmsGA/Q/IoY/IKtXCNiRD4VFI0IEGbg0gAXITkuar
         w2JcZuDFxK24yeMInCNaGhiRTWFXadTiEGFTRuChhUGLBAcKI5JVJfuovTxANilRkdza
         uZlYnsvtKI4xS/Q3cdd8wRGoHRgfYUyeEEXYs4v5csWcZLTVlnePYUNTuMZNxjapzzpN
         hUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=17Joj3qzIwxbIb9FEXzINgU+Lmaw5nywiHQndt+4guI=;
        b=fYIrIKDm67HhKzCquY7XAcaPUQwbZogpen/ipLcE8n1U4pLmD7QDKHiyK2YD+fEc4f
         EYkcxoDIT+Px1sZKENrrVY4Za+sKMI4UiNgA2nC5VIvRTmmeZvzljmYFQi4j/WrKqDRV
         8c70XIT61lKPxKwFXoCxsCzIrc+ke2hpMJ7II6IEmVg+ySdGbSmHI4VjfdqkLCeSwr2P
         PxLm27rcWjmN95/oOfXZQdH4bMJNHz0w35eYexMtOk4MYY9q+oNI8xTK7l8VaFTzOTwk
         s6MvpBQ3f17QRx5gOjh4THMH6i8mCL5uFBQ3jE9LBJBJcAOpT1Td/VgGKcC+Wq7fUCiV
         S2oA==
X-Gm-Message-State: AOAM531oG8vB7YpZWdMALq7JpBpnuEYHe/JLDUowzPFTJIbsImKNy+37
        wx1q8BeCT0aBMyyQrgAaX31hkg==
X-Google-Smtp-Source: ABdhPJz/dQyu6OcqbgEEmYlphKNtRRH1El+9KhFJO7dD5rKqU8IGRIwnbADp2PPCLzLmUy/i0CAj4g==
X-Received: by 2002:a37:5d8:: with SMTP id 207mr1595340qkf.196.1633579660662;
        Wed, 06 Oct 2021 21:07:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b19sm2420266qto.46.2021.10.06.21.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 21:07:40 -0700 (PDT)
Date:   Thu, 7 Oct 2021 00:07:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Message-ID: <YV5yi+AejPGO9qOi@nand.local>
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
 <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV5dmkkuCqAY2qqG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 06, 2021 at 10:38:18PM -0400, Jeff King wrote:
> The reason for that is that I didn't find it by inspection; I've started
> running my personal builds through coverity. It wasn't too bad to set up
> with a GitHub Action, like so:
>
> [...]

It looks like this would never cause the build to fail, but is merely
responsible for sending any warnings off to Coverity's UI?

> Is there interest in having something like this in the main repo? We'd
> need to tweak some values:
>
>   - we have to send the project name (here peff/git); we can presumably
>     get this on the fly from the Actions environment

Yes; searching through [1] it looks like that is called $GITHUB_REPOSITORY.

[1]: https://docs.github.com/en/actions/learn-github-actions/environment-variables

>   - any repo which wants to use this has to set up the secret token
>     (COVERITY_SCAN_TOKEN here). That involves creating a coverity
>     account, and then setting the token in the GitHub web interface.
>     Presumably we'd just bail immediately if that token isn't set, so
>     forks aside from git/git would have to enable it independently.
>
>   - likewise it needs the email address for the coverity account. That
>     could probably be set in the environment, too.

These both seem reasonable to me, too.

> There are tons of existing warnings, many of which are false positives.
> But it keeps track of which problems are new, and emails out a summary
> of only the new ones (which is how I saw the leak here, which just hit
> next). I don't care all that much about leaks here (we have other
> techniques for finding them), but when Stefan used to do regular
> coverity builds in the past, it routinely found useful errors.

I'm generally pessimistic about tools like Coverity, but I share your
experience that Coverity warnings are actually pretty high quality. Or
at least they have a high enough signal-to-noise ratio that it makes
them worth looking through.

So I would be happy to have forks of GitHub have fewer barriers to use
this tool.

Thanks,
Taylor
