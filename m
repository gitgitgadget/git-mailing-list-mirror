Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFC5C433DB
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 15:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B00FC619B9
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 15:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhCWPSb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 11:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbhCWPR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 11:17:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05996C061574
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 08:17:59 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id bx7so23872390edb.12
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDYhq587FBtv1gsiuHWy8HhKMxpTvcXpHFWuWrT7zO4=;
        b=FoRbHImBwA+C2m9SOGG0atq1gfnT8/s/s1wDFn40PoQQSe/c0zoLio8lPOwh2OYWax
         Ge96fCCbsFG9WYs7XLdYpBz1sqHMUg6zt08PFA+2K9zR7anjUrtIJ6iHMZ7W5/irESov
         lvHuPKCwyFEmurVgKBWj6L9Lv0/pWMrUDtyFUPlcih9QRNOvcfQyV1JSfOmBJYvOdDmj
         zZO0FmbrNWOM/tm8GE7B2ltrFqMZH4591H2swRjHjgR0NWtbPiTGHyM1pajz6+JWMEwU
         gBZx8l8Ho/rqIpmBuwULNwlDhSwPuC36FkBxbUVoZbmT+dSAFKoLEq3B8L05OE8NDEh1
         MKhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDYhq587FBtv1gsiuHWy8HhKMxpTvcXpHFWuWrT7zO4=;
        b=d1bVqK8r5cTq5XR+Z5ZTkFf/Pw+09hpzlJDW49iu88uxwThgbla8ZaZ1vy6QkDRG1v
         T0LPnTCV0plzPU55ldNsZ0Q0Ibsgh3RPozGO3+oT6TqlSbUy/NsyijpOWDLp+U7Z8kC0
         0JbL0ol+G7bY1R8b2LEbnA+BiVdnBSAGr1RphiX12EC/I4VDxICB6wstttXLDY4qZhcD
         HJ/UoGkvnssZYPeOuWwRez+prki2VhRnbJCixd3bmLB0XSqRTpQpitefSoZ/x+vsit6d
         2NyP3U0rTVoxfg4nF4CX0lufGlnM+WbU1J6FhnaWWiVgsEM1p/TRFjcYOxY1O2JbNfZc
         qeBg==
X-Gm-Message-State: AOAM533ATN6L7jLcAPlT8VL5EY77xTNUZiuDHVRzmkxob0fupEiaxtZZ
        gA++Z7U3VReRDjfeVLt+8hygkekI9++aRdObvFVZX8wsL2dL0A==
X-Google-Smtp-Source: ABdhPJxW8MVXHhW0u76gNlX0/iH+hHYLLRjaB9u4qIPZWFrcSaLtYS3sU3aFGPS3pKnox5gzEUGFy9M1j+c7gzlPCks=
X-Received: by 2002:aa7:d503:: with SMTP id y3mr5084986edq.142.1616512677689;
 Tue, 23 Mar 2021 08:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <CALz+XyW+XU++58eEYm5=jxTckK-VuuPoA-ecj4QCZw1o44JFUQ@mail.gmail.com>
 <xmqqczx0sq1o.fsf@gitster.c.googlers.com> <YCwJ8tORQg2Air4r@nand.local>
 <xmqqmtw3pzu3.fsf@gitster.c.googlers.com> <YCwhPG6RaAhU9ljg@nand.local>
In-Reply-To: <YCwhPG6RaAhU9ljg@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 23 Mar 2021 16:17:46 +0100
Message-ID: <CAP8UFD1QG_b6ax-HodLRRcdLKgWJhPDghjLfjnyan1Zi80en7A@mail.gmail.com>
Subject: Re: Bug Report: Multi-line trailers containing empty lines break parsing
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Matthias Buehlmann <Matthias.Buehlmann@mabulous.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 8:47 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Tue, Feb 16, 2021 at 11:39:00AM -0800, Junio C Hamano wrote:
> > A few comments (not pointing out bugs, but just sharing
> > observations).
> >
> >  - if the line before "trailer: single" were not an empty line but a
> >    line with a single SP on it (which is is_blank_line()), would the
> >    new logic get confused?
>
> Oof. That breaks the new test, but it makes me worried about whether
> this can be parsed without ambiguity. I think not, but here I'd defer to
> Christian or Jonathan Tan.

Sorry for the late answer on this. It looks like this fell into my
email reading cracks.

My opinion, when I worked on this, was that it's very difficult to
avoid ambiguity, so it's better if `git interpret-trailers` is strict
by default, which could be relaxed later in special cases where there
is not much risk of ambiguity.

It's especially ambiguous because many commit message subjects or even
bodies can be of the form "area: change" which can look like a
trailer. And some people might want to process whole commit messages,
while others might want to process templates that might contain only
trailers.

So I thought that blank lines should not appear in the trailers. And
if any appears, it means that the trailers should start after the last
blank line. This might actually have been already relaxed a bit.

> >  - if the second "multi:" trailer did not have the funny blank line
> >    before "_two", the expected output would still be "multi:"
> >    followed by "one two three", iow, the line after the second
> >    "multi: one" is a total no-op?  If we added many more " \n" lines
> >    there, they are all absorbed and ignored?  It somehow feels wrong
>
> That's definitely the outcome of this patch, but I agree it feels wrong.
> I'm not sure that we define the behavior that strictly in
> git-interpret-trailers(1), so we have some wiggle room, I guess.

Any patch to relax how blank lines and other aspects of trailers
parsing in my opinion should come with some documentation change to
explain what we now accept and what we don't accept, and also tests to
enforce that.
