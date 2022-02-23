Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C03C433FE
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiBWXan (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 18:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiBWXam (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 18:30:42 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303A31201
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:30:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m14so965549lfu.4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rYYRPhnH8CS2uVIi+FxLk/ojKnWd2zkFQzZiD13ZcFU=;
        b=Wbo1qIScbhQFC5F+1VNqW+DGebqZetzXJY9Jp9SDFIFUMa+7SRC/xedO0h0Y/rFTRv
         AOwAYIcyUs1SeuP4KySQfdDogRTsz6/6pMp7XJ6u1JBXco6A3yPDwpswE99uxavo2UOP
         4plSsa5WMULvo00r8hQPooIRQM7cImsB9wXwYSzrT5V5Vngr4k+rZsExaO62jH2+1e15
         lu2tOx/Aj3SQ5vDSPtnfSeObRyx9FKHnypSyX0q1hpTrvU6BQlaN27p3b2EayRl+jdD3
         ZgxHOSpKtsZWOyXfzMG5bDrivX6JsRevj6lRFnGmghy2cirLdgpzLx3BXv0eT3Ez/Yjj
         N6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rYYRPhnH8CS2uVIi+FxLk/ojKnWd2zkFQzZiD13ZcFU=;
        b=yMm4xU3hcR5ovl/xv3vSaEPZWIZ48i9Yjwq/g1V+is7saPEsUzvPIF00RcTXcUZCO1
         oZAG/E8Y+UkqXri+LDr5VFygMzKVQWcMcUqSrezZb2WA3DE44+5Iucv6atTMsGyu2xen
         gxvbuiNFz5d9XV8Bqq0PRX0WuuZD9l1+v6HWcRlS+MyXUzWjF8m/UPKwps8fp0zzK1oQ
         OqRRTKZE8wauY31+uv4speLQ2JkhkaaESOXwhG+3kOD6wMev+Q+nBEVhgpuqW1AUq3RX
         BknmQUEk9Hm15eTAhfyY3ZShx+2JlnORcS75/bECWXHxXuoaICKd7cAtFicDPdPoACdd
         whpg==
X-Gm-Message-State: AOAM531hgm7hurCXI82HrMEvT+Dp7OKVgdF0mlqRhL2qEVBtTRBSi+/K
        ahYjDm/ptWyNHTYWVrkyP20/VsloQzYTSVUunRo=
X-Google-Smtp-Source: ABdhPJxoII3GqGdx0VGJrJwEoYOKZyYeHXz64RPG5sop1PSnSULCf9BC4P1mqZ5TfUWol7xHqnNi36woLZq5JYnSItY=
X-Received: by 2002:a05:6512:3f94:b0:443:5d1d:55a2 with SMTP id
 x20-20020a0565123f9400b004435d1d55a2mr63994lfa.213.1645659011625; Wed, 23 Feb
 2022 15:30:11 -0800 (PST)
MIME-Version: 1.0
References: <20220223073125.640133-1-alexhenrie24@gmail.com> <xmqqwnhlp4h1.fsf@gitster.g>
In-Reply-To: <xmqqwnhlp4h1.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 23 Feb 2022 16:30:00 -0700
Message-ID: <CAMMLpeQWjs0C4VwfpzOhZvY0Tm2YTnC74tyUeBG9bBzsNA42_w@mail.gmail.com>
Subject: Re: [PATCH] switch: mention the --detach option when dying due to
 lack of a branch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 4:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Alex Henrie <alexhenrie24@gmail.com> writes:
>
> > Users who are accustomed to doing `git checkout <tag>` assume that
> > `git switch <tag>` will do the same thing. Inform them of the --detach
> > option so they aren't left wondering why `git switch` doesn't work but
> > `git checkout` does.
>
> An error message certainly would help over showing
>
>         fatal: a branch is expected, got tag 'abc'
>
> but I have to wonder why we shouldn't DWIM and detach the HEAD at
> the commit the user wanted to.  That would also solve the issue of
> leaving them wondering why switch is broken and checkout is not, no?
>
> If the advice for detached HEAD state is enabled, then the user will
> be reminded that they are not on any branch the usual way when the
> HEAD is detached at the named commit.  And if the advice is not
> enabled, then they will not be helped by this new advise() message
> we add here.

Before commit 7968bef06b "switch: only allow explicit detached HEAD",
`git switch` did not require --detach to enter a detached HEAD state.
The justification in the commit message is worth reading, but I don't
have an opinion on whether or not it was a change for the better.

> > +     if (advice_enabled(ADVICE_DETACHED_HEAD))
> > +             advise(_("The specified commit is not a local branch.\n"
> > +                      "If you want to enter detached head mode, try again with the --detach option."));
> > +
>
> "detached HEAD" is a state, and not a mode.
>
> s/enter detached head mode/detach HEAD at the commit/ perhaps.

Sure. I'll send a v2 tonight.

-Alex
