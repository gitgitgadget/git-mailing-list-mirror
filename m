Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14766C433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71986140D
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 19:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbhKPTgW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 14:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhKPTgP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 14:36:15 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F598C061746
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:33:17 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m9so61823iop.0
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 11:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xeqOffGMLWRD2rqGSDQYr/ZnNEkbTrzkGfUq2J6bFJM=;
        b=fV8hDFD1GUJQG+tUvRakIgwT2N/UYH7uVkn2rt4Sfgko/6HRC/K8v6YxCiKRVL7vnc
         n3o4Zejlegk1OtqICVoTE9jaaZ98JbGxDMNKr4AOQjCukk6uOqL5gMQznpWQ5pvySX0G
         ZiIeP5pYC7g5neWQSUqpw2nA7MCAKRcW8UzovyjkBPkk+q4TrqDTOzY8+W7jNTSaJYPL
         QiRsPW29NSh3M2QbAB9o2V4JoMoMlNxrPCa7TeCnTc67ShZOP4/LphtrtM66WOhN2tDA
         6WwbdNn/SZxa/35tnvqpwhImQ9NIFoRGAe8hB7B49v8l1J1g/n99SMgW0V7Ws+MZ+m7I
         nuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xeqOffGMLWRD2rqGSDQYr/ZnNEkbTrzkGfUq2J6bFJM=;
        b=lvI0jLAseA0/yAIGPk7hhTkVQNKpTOq5vmuV6qezP6W6dmBn7IRy6cjRtQA+IRXYUc
         qlv+bevn9FXQCoZRE2iYZKhohUwd40XaUFUNnPag174EQ6AApLHHFSZUxfXuNTGxGm/c
         BxUqR82TSCygnFD2e119nSX9iHWHvMm4zMS6UgZFXMANx7B1mACDaN6GGxh+SImF/v1a
         lzweviHBD87qqoYNDdB/SCdbtkwlUkprDV6y22kMHVTqM5DYz4eNzZ1/g5JGFnKvcd77
         Z/6NfaDVgueBO6M4ODOWz0ZTO3HS/dx40r/jZSSRATUJyHpAU8jyaxO9YuvougtZrUQ0
         UwEw==
X-Gm-Message-State: AOAM531oDQt5hdx7mv0j7R+cF96giet9MWLvZuMubDFaOYeEuIuaNFhc
        BNsnbLR1uy+p6cXaq6Th6yWfbg==
X-Google-Smtp-Source: ABdhPJxAceEotIzO6Fe36+bVgTldfyp81HWLdwvohT6CwXaFzR8o3cHhtCOe1w9kh8BJQFym9Nitiw==
X-Received: by 2002:a05:6638:d08:: with SMTP id q8mr7873526jaj.38.1637091196377;
        Tue, 16 Nov 2021 11:33:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n39sm802966ioz.7.2021.11.16.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:33:16 -0800 (PST)
Date:   Tue, 16 Nov 2021 14:33:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] wrapper: use a CSPRNG to generate random file names
Message-ID: <YZQHe+TXPFbafP/o@nand.local>
References: <20211116033542.3247094-1-sandals@crustytoothpaste.net>
 <20211116033542.3247094-3-sandals@crustytoothpaste.net>
 <YZPQE+SKVXjexXMT@coredump.intra.peff.net>
 <YZP4XDtF7O7Sxh17@nand.local>
 <xmqqtugc9bdz.fsf@gitster.g>
 <YZQEsjidbBUgvhfu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YZQEsjidbBUgvhfu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 02:21:22PM -0500, Jeff King wrote:
> On Tue, Nov 16, 2021 at 10:57:28AM -0800, Junio C Hamano wrote:
>
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > >> I actually wonder if we should simply die() in such a case. That's not
> > >> very friendly from a libification stand-point, but we really can't
> > >> progress on much without being able to generate random bytes.
> > >
> > > Alternatively, we could fall back to the existing code paths. This is
> > > somewhat connected to my suggestion to Randall earlier in the thread.
> > > But I would rather see that fallback done at compile-time for platforms
> > > that don't give us an easy-to-use CSPRNG, and avoid masking legitimate
> > > errors caused from trying to use a CSPRNG that should exist.
> >
> > Yeah, I do not think we are doing this because the current code is
> > completely broken and everybody needs to move to CSPRNG that makes
> > it absoletely safe---rather this is still just making it safer than
> > the current code, when system support is available.  So a fallback
> > to the current code would be a good (and easy) thing to have, I
> > would think.
>
> One challenge for any fallback is that there are security implications.
> In particular:
>
>   - the fallback probably needs to be specific to the mktemp code; we
>     don't have any callers yet of csprng_bytes(), but anybody using it
>     for, say, actual cryptography would be very unhappy if it quietly
>     fell back to insecure bytes.
>
>     (I don't have any plans to use it and we don't do very much actual
>     crypto ourselves, but one place that _could_ use it is the
>     generation of the push-cert nonce seed).
>
>   - I'm not sure if we should fallback for runtime errors or not. E.g.,
>     if we try to open /dev/urandom and it isn't there, is it OK to fall
>     back to the older, less-secure tempfile method? That's convenient in
>     some sense; Git continues to work inside a chroot for which you
>     haven't set up /dev/urandom. But it may also be surprising, and
>     erring on the side of doing the less secure thing is probably a bad
>     idea.
>
>     So the mktemp code probably needs to be aware of the difference
>     between "we have no CSPRNG source" and "we were compiled with
>     support for a source, but it didn't work".

My opinion is that we should probably not fallback for runtime errors
where we do have a CSPRNG and any errors trying to use it are
legitimate.

I would probably have csprng_bytes() itself only be compiled where we
know we have a CSPRNG. And then I think our implementation of
git_mkstemps_mode() would depend on whether csprng_bytes() was compiled
or not. If it was, then any errors returned by it are propagated to the
caller (or we call die()). If not, then we use the existing, insecure
implementation.

And I think that basically addresses both of your points, namely that
the fallback is specific to the mktemp code, and provides one opinion on
the matter of runtime errors.

Thanks,
Taylor
