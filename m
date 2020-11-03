Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519A8C2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3CD2236F
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 16:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xz8tm/rF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgKCQKd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 11:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCQKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 11:10:32 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEF9C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 08:10:31 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 9so18871333oir.5
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jtkQzrmMdGI8iL00AN2BdkIjvsjqQ8f5elIfQA3+sEI=;
        b=Xz8tm/rFhJ9Maqly0mnW0roLV+dvn2VrehhYSsGgpkMKrilR5pPSdOTEu5TcO1wy5k
         AOFx7dViTkBEq+johPgnmt0NB8DN/4orsJqYF2mv24z8nCz3XIwMbkXPHz4K6BFHRH1w
         7B62qOCRthKtCp+yGCTIaPQgBwqHLn8JOJTpIvWPAlqwQW/81+DqcaV5pZoT7xXNPdon
         EQmhPcJTTvotdhecD7fFBU20ocv5JB/HGpRVnmcs9G2gyG0cD7nZQKIR+SceN1B6zykH
         ShXheQcGPOsKQAtOLhm7+6j8/Z9rG+nK8eTX5e0lr95W8LHlEb9xDaY0Xlr6h/IwV7pY
         UUmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jtkQzrmMdGI8iL00AN2BdkIjvsjqQ8f5elIfQA3+sEI=;
        b=Dqw7BRDg/qqzULPIDccH7MhcKI3u5HjjK7sQVHIA9mkDzysLMglfqk+iOCOiQK/l1R
         2FRnt41aGZt+yD39OVNO5zSY23ub2sGZqhrHP5RswvAWy7tCeE+kiPxbIVz3TZelO15c
         9uYqwfiI8faZbKSHS5H+eNw8YMBccdsiwLgdMbt7pgY1W3LfyzHnT/+kdeVd76lWshvx
         i4Rm9O9Dg2cKOlxzz97bmHzXLH0rfDkxq2d7bKqwg+COkjQS3sz2lHZdCJmLJIicwGmf
         SiqZkNFuZrPL8DbkMFWtwFpGHLEd2M1FQ219h7AlcUOdRhRWbt9/8acig9eB9yMMkmw4
         uWRg==
X-Gm-Message-State: AOAM531uO4PstoEdLyu/LP6qNMEHJaKVD8N7G6GHEgBGfAM+1adeDuyP
        NFqyBXoXeaXWzDI12YnIO4rw+p0zdZvEOVQxj0AFAkKdJOV0nw==
X-Google-Smtp-Source: ABdhPJwxPGnszZElIsUV1YGyHcDhRrwMh/hGjlVKg9g8vDnJpclnas88Sm3hLztfqXbk/kE1FepfKgg0xwJp1I1Ax5A=
X-Received: by 2002:aca:b4d7:: with SMTP id d206mr273786oif.39.1604419831084;
 Tue, 03 Nov 2020 08:10:31 -0800 (PST)
MIME-Version: 1.0
References: <CAMsWJsyPVQWV++gc2YJriEOEWBELa_xj2G0NWFMSgNYt47swiQ@mail.gmail.com>
 <20201102144321.GA3962443@coredump.intra.peff.net> <20201103101553.GH24813@szeder.dev>
 <CAP8UFD3SMCBdE8TOP7OKabYyOW4344nNAa=G2hCzxWnN-XjQrA@mail.gmail.com>
In-Reply-To: <CAP8UFD3SMCBdE8TOP7OKabYyOW4344nNAa=G2hCzxWnN-XjQrA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Nov 2020 08:10:19 -0800
Message-ID: <CABPp-BGdCOWCEMjXtJChW1oip2Ro1JhNr=pECcbhV8XWM2QBBw@mail.gmail.com>
Subject: Re: Segfault in git when using git logs
To:     Christian Couder <christian.couder@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>,
        Sathyajith Bhat <sathya@sathyasays.com>,
        git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Sangeeta Jain <sangunb09@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 3, 2020 at 3:21 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Tue, Nov 3, 2020 at 11:19 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> =
wrote:
> >
> > On Mon, Nov 02, 2020 at 09:43:21AM -0500, Jeff King wrote:
>
> > > but I'm not clear on how "--follow" and "-L" are supposed to interact=
.
> >
> > They shouldn't, I would say.  Though it would be great if their
> > rename-following logic would be unified.  In particular, line-level
> > log does a better job at rename following in some ways, notably it can
> > track multiple files at once, while '--follow' can only handle a
> > single file.  So I think the rename following logic should be
> > extracted from 'line-log.c' and made more generic, and it should be
> > used to implement '--follow', removing some restrictions of the
> > latter, not to mention removing the duplicated logic.
> >
> > (This might be a good GSoC project, though some of Linus' remarks in
> > 750f7b668f (Finally implement "git log --follow", 2007-06-19) like
> > "you did have to know and understand the internal git diff generation
> > machinery pretty well, and had to really be able to follow how commit
> > generation interacts with generating patches and generating the log"
> > and "this patch does seem to be firmly in the core "Linus or Junio"
> > territory" are worrying...)
>
> Thanks for the suggestion!
>
> For the Outreachy round starting next December, we have proposed a
> project to accelerate rename detection and range-diff based on:
>
> https://github.com/gitgitgadget/git/issues/519
>
> I am not sure how much it is related to this though.

As worded, the project is only tangentially related.  If someone were
to plumb better rename following through, then this Outreachy project
might make the underlying internals faster, but that's it.  However,
it's a certainly an interesting related project.

Also, I'll note that there is some code coming with merge-ort that
should help write an improved --follow implementation, and, in fact,
was specially added with that goal in mind.  merge-ort adds to
diffcore-rename.c the ability to limit rename detection to either
relevant_sources (e.g. only consider removed filenames matching these
paths for rename detection) or relevant_targets (e.g. only include
added files matching these paths for rename detection), or both.  The
relevant_targets was not useful within the merge-ort implementation,
but since I was adding relevant_sources it seemed like a natural
pairing; I added it for completeness and was specifically thinking how
it would be useful for log --follow when I did so.  (I also think the
strmap API will also make it a bit easier to implement an improved
--follow.)  One of my goals was to use the relevant_targets ability as
part of an improved log --follow implementation after getting the rest
of the merge-ort stuff done, but it might be a useful intern project
instead.
