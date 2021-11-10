Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBE0C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04353611F2
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 00:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhKJAVG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 19:21:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhKJAVF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 19:21:05 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A48BC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 16:18:19 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id s14so574329ilv.10
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 16:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+AKUz6txRJZVwLyh2HRXBFJP0U6BaVc0z88p2rx0h3M=;
        b=Eo5r24p1IaRn9pPvoILIJvAsitZGescDwmXrmuYwIct+O034XLyn5luiMk7GXbULG5
         AEGcctKkKPYkr7XVWaUmP+wXRM7R31/5CxPjGIP9GsKkK1rdINp4LGvG+c8GiuDAkFMP
         nBLYdXcoKIm7VcXlkBbcMgOtuuCNyJo+F78C+HDLuNx/H5R/X6gisKQNNs6Mdr8odMh/
         OfxR10bwlN6EUR/VHVPe9ghEddKsSPQhFhd92YpsWnCxHY6SVdW6mhWIbGpyH3Dy3mmv
         nTHLoZ1kOa9joR+Rqlyl1JcOD4ArJbvRsn7oCZYMEpbIPcPLkMKpsKgGa7c0YG9f+icU
         rq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+AKUz6txRJZVwLyh2HRXBFJP0U6BaVc0z88p2rx0h3M=;
        b=r5Yc4ioxGweN8ONWqlLs0bl5Brtjg+F0sktBBddVadaRHlp7bEwO6lUbI0xb5rkd0U
         EYfWDPEuLTcHLIfHmvkOMxcLSKGy5ZbkvkmOroakyjK51QgGp4DR3GeERHla3DidV17g
         kC4NtqrqE2WKa8+iwB42vQqqtVrUSUM9V4iuh/te9avnNzdKTxEVkA7r5egzniHR8tSp
         XNxhDfLUMLrLbUycSaELdbki53cRHimIsLsx12cJVwmbagfhJJAy0R+r81OlcjpyE7Ow
         GemWPgupHfKCaZy3TjhDsAJ9rnpR82GdlpzURk2CyaFETGd6uPPPaYXG1eZRFn3Pig1R
         SUJg==
X-Gm-Message-State: AOAM533V7iJs+31LDPSGrJsJcAAyf7AcqMwXE4X9ITEMMoLy/4euDBrC
        xNOQA4oJAZAnYVRXuJR8qLR3Ng==
X-Google-Smtp-Source: ABdhPJzMzgd/KezNTy7cmhPOAMPyg84aSgk3P94IvR121u1RyL5kUecJ4fTMxGGY2XNgumlxijJAmg==
X-Received: by 2002:a92:cda2:: with SMTP id g2mr8101661ild.2.1636503498691;
        Tue, 09 Nov 2021 16:18:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i4sm12961948ilm.9.2021.11.09.16.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 16:18:18 -0800 (PST)
Date:   Tue, 9 Nov 2021 19:18:17 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        J Smith <dark.panda@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] grep API: call grep_config() after grep_init()
Message-ID: <YYsPySOHR8h+CYbl@nand.local>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
 <patch-6.8-933ac853bca-20211106T210711Z-avarab@gmail.com>
 <YYmbTOR+uk7prM8A@nand.local>
 <211109.86a6iedqpf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211109.86a6iedqpf.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 09, 2021 at 03:06:22AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> -/*
> >> - * Initialize one instance of grep_opt and copy the
> >> - * default values from the template we read the configuration
> >> - * information in an earlier call to git_config(grep_config).
> >> - */
> >>  void grep_init(struct grep_opt *opt, struct repository *repo)
> >>  {
> >> -	*opt = grep_defaults;
> >> +	struct grep_opt blank = GREP_OPT_INIT;
> >> +	memcpy(opt, &blank, sizeof(*opt));
> >
> > I'm nit-picking, but creating a throwaway struct for the convenience of
> > using designated initialization (at the cost of having to memcpy an
> > entire struct around) seems like overkill.
> >
> > Especially since we're just going to write into the other fields of the
> > the target struct anyway, I'd probably rather have seen everything
> > written out explicitly without the throwaway or memcpy.
>
> It's a widely used pattern in the codebase at this point, see
> 5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
> macro, 2021-07-01) (mine, but I stole it from Jeff King).
>
> As his linked-to compiler test shows the memcpy() is optimized away, so
> modern compilers will treat these idioms the same way.
>
> There was a suggestions somewhere that we should prorably move to that
> "*<x> = <y>" or whatever it was briefer C99 (I think) syntax across the
> board, it would be less verbose. But I haven't tested if it's as widely
> supported, so I've just been sticking with that blank/memcpy() pattern
> for "do init in terms of macro".

I do at least prefer memcpy() over *<x> = <y> when x and y are
structures. But I wasn't aware that this was common in our codebase.
Anyway, my suggestion was only along the lines of "you're already
writing individual fields below, so why not just do that throughout
instead of memcpy()-ing some of them via a macro which expands to a
designated initializer?"

But this is a cosmetic point, so whatever you feel fits in most with the
surrounding style (so long as the pattern we're propagating isn't
terrible, which is the case here) then I'm OK with it.

Thanks,
Taylor
