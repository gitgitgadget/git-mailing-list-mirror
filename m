Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C744BC433DB
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6BA64EA4
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 23:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhBHXUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Feb 2021 18:20:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbhBHXUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Feb 2021 18:20:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FD4C061786
        for <git@vger.kernel.org>; Mon,  8 Feb 2021 15:19:29 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id q2so18113295eds.11
        for <git@vger.kernel.org>; Mon, 08 Feb 2021 15:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GRT9znMOjQ/eF3rnWZMUfWUSvZiIAu+tomkn+2otHQc=;
        b=Jk9kN8u2RgLrUU0ZhWT5z/VjADlT3lEVpNxo61maasolnL2puoA3pEGWaLJxxILcsD
         FBksxM96o7t1Me9BFUKe2W5ca+XHWFz2i4Jn/M7/pwwfkfvR/y6bpViGTNN9I70EWrs8
         rOALr9pc5VL24FRvVENNJaTH9yeaUMbLirBoIk5esc2Yi9AU/n3Q3Urc0IqxaN0mGzaF
         97SVuf4tZRVT0KnywhjNYkrscMqNMWVzUE1SEm/+tXqhQr/fzPltX6LIGY+7iBl8Ge69
         PEdC/Ahs/IhB/NnFTm5yz7E8wUyfyp3liiIiDXIzUWlHrSXL0ULmlB5zZQd1orzTYD7s
         JlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GRT9znMOjQ/eF3rnWZMUfWUSvZiIAu+tomkn+2otHQc=;
        b=fjBVm3zGERL8c19kJ9MHiccpDusQup/uSwVHzuiYT2UJb5uC24m8BwLigmqjhTajeb
         uhFW5Oup4ROgijk8JU22M8mrFvOsp00H2WZGDltgm75dU189goTkqeCZUnfgKKDaZC05
         P4Zw2y3CxeAC8YS62/7xkdGwm38N0SWXkNAPCEl+aNXx6Cf/Mj40VKLLVqu03euuKcZ/
         KhnW655GqC9RR+FmIPfdnIFNPEAI3t5zt/SmOvs9qhHooA+u/5CGBo+yt9UhzQ/YPgHl
         xLx/80d7nA3TRgC/qSCzU957kTNt5Vr4T01PTN3qPjEhJTb9UwcfPBQRaYea3emkI7EJ
         bbJQ==
X-Gm-Message-State: AOAM5309DFh467kW5Lfl8W2+jw4sXy18+UMtHAvP+gls4srzWe7OxwwE
        vDyo+9/6XlLcMCHzFOfBcxKjdOhLmOLMgCdiQZCB2DHxLpqrvw==
X-Google-Smtp-Source: ABdhPJxvSieMhd+vmv3KzGiQHx+TCXtyD0kIzcKiq7GaEeDw+V2bpbPUO+cWbu9xAxvxeopS12qDKkbydgID5+0mpZU=
X-Received: by 2002:a05:6402:1d39:: with SMTP id dh25mr11330861edb.142.1612826368453;
 Mon, 08 Feb 2021 15:19:28 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210208192528.21399-5-charvi077@gmail.com>
 <xmqq1rdq5jis.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq1rdq5jis.fsf@gitster.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 9 Feb 2021 00:19:17 +0100
Message-ID: <CAP8UFD1GV2s4SjB3YaT5qiW+E12-hikMEiFoU_LV81aK14g8bA@mail.gmail.com>
Subject: Re: [PATCH v2 04/11] t/lib-rebase: change the implementation of
 commands with options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 8, 2021 at 10:36 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > However, "fixup" is very different from "exec". Its arguments are not
> > arbitrary at all, so there isn't a good reason to mirror the choice of
> > "_" to represent a space, which leads to rather unsightly tokens such
> > as "fixup_-C". Let's replace it with simpler tokens such as "fixup-C"
> > and "fixup-c".
>
> Sadly, I have to say that this change may be making the developer
> experience worse.
>
> To use the original, test writers only need to remember a single
> rule: "when a single command needs to embed a SP, replace it with
> underscore" regardless of which insn they are listing in FAKE_LINES.
>
> Now they need to remember that rule only applies to exec, and merge
> and fixup uses a different rule, namely, a SP immediately before a
> dash must be removed.

I agree with that, and discussed it with Eric. See:

https://lore.kernel.org/git/CAPig+cSBVG0AdyqXH2mZp6Ohrcb8_ec1Mm_vGbQM4zWT_7yYxQ@mail.gmail.com/

The discussion was:

-----------------------

> > > However, "fixup" is a very different beast. Its arguments are not
> > > arbitrary at all, so there isn't a good reason to mirror the choice of
> > > "_" to represent a space, which leads to rather unsightly tokens such
> > > as "fixup_-C". It would work just as well to use simpler tokens such
> > > as "fixup-C" and "fixup-c", in which case t/lib-rebase.sh might parse
> > > them like this (note that I also dropped `g` from the `sed` action):
> > >
> > >     fixup-*)
> > >         action=$(echo "$line" | sed 's/-/ -/');;
> >
> > I agree that "fixup" arguments are not arbitrary at all, but I think
> > it makes things simpler to just use one way to encode spaces instead
> > of many different ways.
>
> Is that the intention here, though? Is the idea that some day `fixup`
> will accept arbitrary arguments thus needs to encode spaces? If not,
> then mirroring the treatment given to `exec` confuses readers into
> thinking that it will/should accept arbitrary arguments. I brought
> this up in my review specifically because it was confusing to a person
> (me) new to this topic and reading the patches for the first time. The
> more specific and exact the code can be, the less likely it will
> confuse readers in the future.

-----------------------

> So, if I didn't know you folks have invested enough hours in this
> patch, I would have said not to do this, but it is such a small
> change, its effect isolated to only those who would be writing tests
> for "rebase -i", it may be OK to let them endure a bit additional
> burden to remember an extra rule with this patch.  I dunno.

I would be ok with dropping this patch. It might be a good idea to
improve the documentation before the function though.
