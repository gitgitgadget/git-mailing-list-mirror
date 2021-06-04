Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3B7C4743C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1FD2613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 19:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFDTqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 15:46:08 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39508 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDTqH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 15:46:07 -0400
Received: by mail-oi1-f170.google.com with SMTP id m137so6966707oig.6
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 12:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6HAPcamudPYnEXmuK3G+fK8XHQuW4gdXJarNdm4/+g=;
        b=N0/crgblfLiPKWicV9vvU9eu5ofn6PkPCJH/VCTSpc3H4XBAL2SltCFhS8AY2S7hyh
         xupHm+WBKN8rD0vmcMJ0wvZ5nyPeBrqQUFA9dII9AkmDg8v68f5CXl8uqCC3lZkSpFGg
         DH/kIsr6GHK/HPTIvN0MHUC9i7yfeC+Wy0TK1K02NNcaQ6T9G7nK8UL8OH9N6iUsbDgD
         EzFcy/4XnXj+ithafJ19fLYGrDOlJQDPf1yTZKLPgRqY/fs8c+8Qp+MWKoW/B95FfloY
         cY2fMKy3tr/I5qS4Ec7XfowNGnTnqpqcd4QpdSBb9fZwkKqIqN1kAf41RwdN5vWjztYN
         6ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6HAPcamudPYnEXmuK3G+fK8XHQuW4gdXJarNdm4/+g=;
        b=acYfeuPIt+mCRKu5Tepemj6vLnmReaj7eXJwedwguRobEn6HBV0x31wY+r9MGC025p
         1LnUBnXCJp3C/1Pujz/Z01adnt5xDL7OipYHBOb0YQ2KZEDB8sibqShih8TCvwJTLSLW
         Xx5ZnPFDomNhOAGO85UKrkjgzTlsUqCEgCvuLX0uAW2xWYefEGVSoSJBSrjMcRdeDvzv
         h9GyorK2Opyv8vycA8J/Wakv7qG87vhBcWv4ksnI2wt0bfr+xDZZ3NqkzQMZBxwYMSg2
         YACcMSo36hIlJUkojv1I2QL5Wimivhy06wio9Fn0p69V6Rv+P9C62NMprKgVHcw8TBdW
         idjg==
X-Gm-Message-State: AOAM532iXvwnl6pBjsdVMbKrhs1yau0dAsTquFZ4xEksx0MXfgTX2eB/
        ZOC0f/RMaiw0jgS2jtEBNVDtnLc/w/cav25gVwg=
X-Google-Smtp-Source: ABdhPJwqvxmSvUBiIY/kYS1dZbo7WMvrkdqq+5FLoLpFo77TE0ABd8wgzboXq5HhO+FfnQOkVN2VwV8euvv+h3rHf3E=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr4095441oiw.31.1622835800996;
 Fri, 04 Jun 2021 12:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com> <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
 <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
 <YLpWbLkaqVYqTrGL@coredump.intra.peff.net> <c9d596f3-cfc9-4bb7-1008-4873dafd8270@gmail.com>
In-Reply-To: <c9d596f3-cfc9-4bb7-1008-4873dafd8270@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Jun 2021 12:43:10 -0700
Message-ID: <CABPp-BH=UVvEyBpVG+8+V-7wNjXS1hsQoZoqYs-xnPKRg3SPBA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed stuff
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 11:42 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/4/2021 12:35 PM, Jeff King wrote:
> > On Fri, Jun 04, 2021 at 08:48:21AM -0700, Elijah Newren wrote:
> >
> >>>>           Signed-off-by: Elijah Newren <newren@gmail.com>
> >>>>      +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
> >>>
> >>> I believe the sign-off should always be the last thing in
> >>> the message. Perhaps Junio is willing to fix this without a
> >>> re-roll?
> >>
> >> Interesting, this is the first I've ever heard of such a requirement,
> >> and I've submitted patches this way numerous times and have seen
> >> others do it.  A quick search through git.git history says there are
> >> 5133 commits that place such trailers before the author's
> >> Signed-off-by, and 1175 that place them after.  While the former is
> >> clearly more common, and some of the latter could have been Junio
> >> adding trailers while applying the patches, there still seem like
> >> plenty of counter-examples suggesting that there is no rule here.
> >
> > I don't think there's a hard rule here. The usual advice (which I also
> > didn't find documented from a quick grep, but hopefully is kind of
> > intuitive) is that trailers should be chronological.
> >
> > So if you picked up a patch from person X who signed off, then you
> > modified and signed off the result, then Junio signed off after
> > applying, we'd expect that chain of custody to be represented by reading
> > top to bottom. And that's what happens if you use "am -s", "commit -s",
> > etc.
> >
> > Whether "Acked-by" happens after the author signs off or not is
> > debatable. Obviously it happens after the version of the patch that is
> > sent out. But if you re-send with an Acked-by, is the signoff your one
> > from before that happened first, or a new one that happened as you sent
> > out the patch? Perhaps a question for the philosophers. ;)
>
> I guess I was just interpreting that the "Acked-by" was part of
> the content you created, and hence it should be covered by the
> sign-off. I can imagine that if Junio added it, then it would be
> after your sign-off but before his.
>
> > Anyway, I think it is perfectly fine either way (as your numbers
> > indicate).
>
> I agree. I didn't mean to make a big deal of it.

Sorry, it was me who made a big deal out of it.  I was just really
surprised that I had missed another rule (you correctly caught one I
did miss on a recent other series I submitted), and so I thought it
was prudent to go digging and see how I had _also_ missed this rule
and refresh myself on the rules in general.  And once I did that,
although I felt this one probably didn't qualify, I thought it was
useful to share what I found and highlight what I thought needed
clarification if I was wrong.
