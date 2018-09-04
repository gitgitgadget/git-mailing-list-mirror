Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D2C1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 19:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeIDXci (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 19:32:38 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35112 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726507AbeIDXch (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 19:32:37 -0400
Received: by mail-ed1-f68.google.com with SMTP id y20-v6so4148380edq.2
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 12:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L8f5aaCACRgmFQk3u9Zj351xKSpDm55p+NfvHT+XXi0=;
        b=rckn0TPrvL/GJ64GJ17ZtnGoOr+8VdZrtzwXRHf3jtHDWJpsc6mrTRbofNM78gh1qi
         598LJ1hmRFAj1CQPmX8AtmKs+wBy95eENsUKXiab/BqLCdKj1H4rjWyb1XprdFydcjUc
         fW91HCfKuiW/26KQG4YHPig6EVT7xL6hGhsFtSntqEq5kvDRSdi7TuOetaLfq/sjsVkB
         vZsFmy/oDIJ0iTLcXv5phpAexfd/kTbn7XtkToL+oT6bipJ3blitdZAYST2zXPORi7t0
         eL0anoLp8NGc1C7tEpE7VOsKsAU8mRHo7qL6TAG7XXmlB09EGruf5RTajwS/DvQl7Act
         XI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L8f5aaCACRgmFQk3u9Zj351xKSpDm55p+NfvHT+XXi0=;
        b=AkYJ4fuhdwmeX7fEsbL6cRx7tgCBu9zVWmnk46RdphqHL0v15bNoJMSNaOaYOuEhFL
         vv9KfxJNc3Thtrxs4eLaVyGn2eYBjSTBYt1mA1Gd3xbXhbpallb4d8bjczAP4N+g3pmW
         ZDPb0v/zuG1r8UzOjlD6mpq1bn0ZY4jvNjZ8amXITyuNiKrx1n3tKRM24VobllfAclLv
         G5fb6ITFdwhTjctsBv6gi2Z09X3k4jW/78ESw5nguf9o07kqAm/BCr19DG3wRmslli9y
         HdKmimeO3AE3SS5L4FABfoZ9FvN7OkjlOI0WzPSb3FOoYEoW67MGdQHxoM1uQNgnrWfN
         C3zg==
X-Gm-Message-State: APzg51DJ0T7yUYAiSL1I0BrmG4OgBan7ZDa7I6mE5VUmfc1kWm0B+X8p
        heQfwRPudI8E4/jTndUbv1c04/qc8ucykgZOxtN82g==
X-Google-Smtp-Source: ANB0VdZj1l+RNzU07E+jqzVzbsZlETmXdlnyXKl4aSqN3RaBq8BzUD6UHpSoJcsAExjEgZMCGMhyb8SsX9xkGl9wgSI=
X-Received: by 2002:a50:f5ae:: with SMTP id u43-v6mr38211619edm.75.1536087970053;
 Tue, 04 Sep 2018 12:06:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180901074145.GA24023@sigill.intra.peff.net> <20180901074813.GB25461@sigill.intra.peff.net>
 <20180901080316.GA25852@sigill.intra.peff.net>
In-Reply-To: <20180901080316.GA25852@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 12:05:58 -0700
Message-ID: <CAGZ79ka8e2-f4fYgy+=HUDdvugefvQ5TnDG0v8YmUn7kGhTdaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] t5310: test delta reuse with bitmaps
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 1, 2018 at 1:03 AM Jeff King <peff@peff.net> wrote:
>
> On Sat, Sep 01, 2018 at 03:48:13AM -0400, Jeff King wrote:
>
> > Commit 6a1e32d532 (pack-objects: reuse on-disk deltas for
> > thin "have" objects, 2018-08-21) taught pack-objects a new
> > optimization trick. Since this wasn't meant to change
> > user-visible behavior, but only produce smaller packs more
> > quickly, testing focused on t/perf/p5311.
> >
> > However, since people don't run perf tests very often, we
> > should make sure that the feature is exercised in the
> > regular test suite. This patch does so.
>
> This, by the way, is the crux of how such an obvious and severe bug made
> it to 'next'.
>
> The original series was tested quite extensively via t/perf and in
> production at GitHub. When I re-rolled v2, the only change was the
> addition of the assertion, so I didn't bother re-doing the perf tests,
> since they're slow and there wouldn't be a measurable impact.
>
> I did run the normal test suite (as I'm sure Junio did, too) as a
> double-check for correctness, but as we noticed, the code wasn't
> actually exercised there.
>
> Nor had I yet backported the revised series to the version we run at
> GitHub, so it hadn't been run there, either.
>
> And all of that coupled with the fact that it only triggers with
> bitmaps, so day-to-day use of the buggy Git (like Junio trying to push
> out the result ;) ) wouldn't show it.
>
> Anyway. Not that exciting, and kind of obviously dumb in retrospect. But
> I think it was worth analyzing to see what went wrong. If there's an
> immediate lesson, it is probably: add tests even for changes that aren't
> really user-visible to make sure the code is exercised.

Yeah, maybe we need to ask for more tests in the 'real' test suite, and not
just in some special corner (such as t/perf/ or any of the environment
variable proposals nearby).

I wonder if we can make use of git.git in the test suite for similar things,
e.g. after reading the thread about "index corruption with git commit -p" [1],
I thought that we only have these toy examples in the test suite. Toy examples
show that the new feature barely works, and doesn't show it is working at scale.

[1] https://public-inbox.org/git/20180901214157.hxlqmbz3fds7hsdl@ltop.local/

> There may be a larger lesson about tracking code coverage, but I don't
> know that most general code coverage tools would have helped (any
> overall percentage number would be too large to move). A tool that
> looked at the diff and said "of the N lines you added/touched, this
> percent is exercised in the test suite" might have been useful.

From some offline discussion, maybe we want to adapt a philosophy of

  Each patch needs to add a test, that fails when the patch
  is not applied, but succeeds when it is applied. This shows
  that _some_ code in the patch is exercised at least.

(and automatically/strongly enforce this going forwards; however
enforcing such a strict thing is hard, not sure how we'd do it.)

Stefan
