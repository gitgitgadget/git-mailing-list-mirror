Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66237C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483B620747
	for <git@archiver.kernel.org>; Wed,  6 May 2020 18:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aGaLI7ZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEFSEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727872AbgEFSEE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 14:04:04 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99308C061A0F
        for <git@vger.kernel.org>; Wed,  6 May 2020 11:04:04 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id a5so1612300vsm.7
        for <git@vger.kernel.org>; Wed, 06 May 2020 11:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ppXl21xXv1h5ClKkI74Df+x4Z11Zve9UWdswAB78mMA=;
        b=aGaLI7ZVsT7oG2Xpj8oHU5KnFSsQnJy6iZS7/QAZbA+3igWpn8zPzi0ielfHGrKbUu
         DS98eTMUPQFtAU/mBcmLhWzVzYZlGf1+YhOoF+P6FyOcEpGJgks/0gXSgYn41mrzcnLf
         ly66cmpxCNnfddihCPc/Wy1LlQ1OQJMZfF3vMMvn2lsEKyHPJyjx6iDq8GCWowu3nFxr
         X7+ZrnEWVG+LM5h+3ufpHfYER/NLCnhriXxSt4Oie9jRLGGsnK8F8wWuH9mggwOErh6W
         0nbsag6TkV/8M5XIq7If4cZFPkJPWkeGqas+l2/GF0dGz0fKJ1WQFkUd6Doftuz1XBev
         ihIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ppXl21xXv1h5ClKkI74Df+x4Z11Zve9UWdswAB78mMA=;
        b=IyWta8TU6c9bemWaScLfl8QCIBGt0sznmLaWPV1Kez51bF1TflLh0MPTX9qjlAus4Y
         spIOBupA/kBrkfAo4FKevhZ1o159ZXSgzvAw3Uak/SJaGazj6z56Nnkv3EvqnmyDNPdz
         X4vEzq3LYaBl5y8rX7/Ryj0q1tnAcYptaruTbQSEnQagDd0ZLmwQRIXer7uWPFFo5+zG
         IipdsU2Fq3Dqov9oaQbLGJShtHM5Et9soaa2b8OdOvhF8xanfgY32q1s1NZCDXBKW1rU
         Y+EaASQlOD+Tw0hUgEUzMHey5Ka5b4BAVUiR2Tkfn7AZ6jmtEdt+w10jZN9wJAgpwrpc
         L9bw==
X-Gm-Message-State: AGi0Pubk8CEwh5IxRrJhmyMp+6nNKBn6RADuUa/oRjvPPKz58H6LBAhZ
        lcPhPLlh2tYUUWMTgvNVQbMM8DtanP6r0uOrRmzbjM2R
X-Google-Smtp-Source: APiQypKkbOE1mFzDbfN+E5DoLGdPahLVfqBsnNW07++cYBi9YCYpZrj0V39C5gTL2IInFzt4mPWLrhzGWStyMV1nbpk=
X-Received: by 2002:a67:edce:: with SMTP id e14mr9652013vsp.235.1588788243735;
 Wed, 06 May 2020 11:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com>
 <20200504154343.GA12842@coredump.intra.peff.net>
In-Reply-To: <20200504154343.GA12842@coredump.intra.peff.net>
From:   clime <clime7@gmail.com>
Date:   Wed, 6 May 2020 20:03:52 +0200
Message-ID: <CAGqZTUs+xCPjQdeQVfU6EWARmZdjcgcHeSNxkKaTf316rX+8pg@mail.gmail.com>
Subject: Re: :format:%s for date fields seems to be shifted by timezone
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 4 May 2020 at 17:43, Jeff King <peff@peff.net> wrote:
>
> On Sun, May 03, 2020 at 12:15:14PM +0200, clime wrote:
>
> > my current timezone is UTC+0200.
> >
> > I create a test repo, add one commit and create a tag:
> >
> > Now:
> >
> > $  git for-each-ref --format="%(taggerdate:format:%s)" refs/tags
> > 1588504146
> >
> > $ date +"%s"
> > 1588500585
> >
> > $  git for-each-ref --format="%(taggerdate:raw)" refs/tags
> > 1588500546 +0200
> >
> > Somehow %(taggerdate:format:%s) gives a Unix timestamp which is one
> > hour in future and it is different than what ` date +"%s"` gives
> > around approximately the same time the tag was created.
>
> It's caused by strftime() being clever with DST. Try this:
>
>   git commit --date=@1559361600 --allow-empty -m summer
>   git commit --date=@1577854800 --allow-empty -m winter
>   git log --format=%ad --date=unix >unix
>   git log --format=%ad --date=format:%s >strftime
>   diff -u unix strftime
>
> We get the winter time right, but the summer time wrong.
>
> The issue is that strftime() takes a broken-down "struct tm", not a unix
> time_t. We have all of the right values for hour/minute/etc there, so
> using "format:%H:%M:%S" prints what you'd expect. But we never set the
> "isdst" field, so when it tries to convert back to unix time, it applies
> a one-hour offset (if it's "summer" in your local timezone).
>
> Unfortunately I don't think we can solve this easily. If we were
> operating completely in your local timezone, then we would have gotten
> that "struct tm" from localtime(), and its isdst field would be set
> properly. And indeed, if you use "--date=format-local:%s", the problem
> goes away.
>
> But when we're formatting in the original author's timezone, which is
> the default, we have no idea if they were in dst then or not. We only
> know their offset-to-gmt, so we munge the time_t ourselves and use
> gmtime().
>
> So there are a few reasons I think this is the best we can do:
>
>  - the full timezone information literally isn't there in Git; we might
>    know the author was in +0200, but we don't know if they were
>    observing DST, or if they were simply in a timezone further east.
>
>  - even if we had a zone, there's no system function to convert a time_t
>    to a tm in an arbitrary timezone (hence the gmtime() hack above;
>    we've tried playing games with $TZ and tzset(), but it's awkward and
>    unportable)
>
>  - likewise, strftime() is doing the reverse conversion using the local
>    timezone anyway, which would be wrong.
>
> So my advice is not to use "%s" (which isn't portable anyway). Use
> "--date=unix" or "%(taggerdate:unix)".

Hello Jeff,

what about just printing the raw timestamp from either commit or tag,
i.e. avoiding any conversion for format:%s?

Best regards!
clime

>
> -Peff
