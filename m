Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE18DC4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82E5F22D6F
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 00:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731047AbgLEA6p (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 19:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbgLEA6m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 19:58:42 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0AC0613D1
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 16:58:11 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id t205so8260653oib.12
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 16:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ylJSlscM2HhikR6JdB1ShkQ9Lr2hJd2vijNBGTwbl/c=;
        b=qW87az1n9rzOZ4w16OsNy6c6PWDQncF11MehyDIcR5n9x6tSGwydZn2ofEvFptIWjM
         QaPjVdMj7ezS8LznjwWI0cmUSq3/aPSuDaD24hlZiNfL4f/bxBp24Zk9bxfOAlJGhvHC
         axvOr61XB8AOG/OFLsYqK2JwKaFR4DEjurIuYcJxp88j8FbCzGnBxn76Ovij9dvYv2HP
         fcomzfCzlDW7zlvEo8B0IRzSU/RTCZviddf/3NlD8cLZQjIOgsX70SYMK2GVORN8LNhC
         dRR4ut3fgiiVcCopI9NVpZUTm5D63T4JlAvmy/HxUXRYhig410pFzHHtL0JJwGqAUgI0
         QlOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylJSlscM2HhikR6JdB1ShkQ9Lr2hJd2vijNBGTwbl/c=;
        b=sJGWHzeDt8T7nVZP7sgdetvesIAhj6ACfUUZ9HHbKR6/XBQXw/ozjyZcgLLy0cz9FK
         RbFyA8Xi21sku3qI7tPtnPtdCPvt0E6PhXAfA1xhonXhR33xjtYu/h7uxmTeFrj9g6/q
         +dbrW6UbRRnUXaneC9iHkCUq4YVtEUXNBOl2R7R78G2luRzxuZZYOcxumPcrJ1DK6xtp
         +ju6swUZm2EN0p4JJKLOESMDGTIxXF4VucT7OoIBWD2nn36SuD2Q6mShAr9IJ5IKV33B
         o0yPbKGcPrbMmsh3gGldT1JhPw0lNuhFlQO2Lhnc/PzAOld87OI21RVF2SOCPY+hvvGS
         Hjxg==
X-Gm-Message-State: AOAM532euZ3phTWr7vd70Fyk7RCpeEerYpilbRqBwr+hNEzPFJQKJ9HR
        iQRKZTo8oxPipJlI7vu6Q90Gc9YB0Bk+QSczp84=
X-Google-Smtp-Source: ABdhPJxqaJHW6k8XoBfmhb5/mjoQCywH4rdnyURYpPkO8L9zW3/kNtvBK6aO062XrkiqM1qozPPgAfNsejcs6kxnHz8=
X-Received: by 2002:aca:49d5:: with SMTP id w204mr4953977oia.167.1607129890406;
 Fri, 04 Dec 2020 16:58:10 -0800 (PST)
MIME-Version: 1.0
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
 <20201204061623.1170745-5-felipe.contreras@gmail.com> <CABPp-BHjzzhqQW8YY5podav+TU8Eixhp7g-VrQ-tva-0ztAtvA@mail.gmail.com>
 <CAMP44s0D42s=q8TJqxwswOHb4PO-NW6SEUt-LwfvqiGgvkre9A@mail.gmail.com>
In-Reply-To: <CAMP44s0D42s=q8TJqxwswOHb4PO-NW6SEUt-LwfvqiGgvkre9A@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Dec 2020 16:57:59 -0800
Message-ID: <CABPp-BEsQWsHMAmwc3gmJnXcS+aR-FtoMJxBRQ=BpARP49-L-Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/14] pull: cleanup autostash check
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 4:47 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Fri, Dec 4, 2020 at 5:07 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Thu, Dec 3, 2020 at 10:16 PM Felipe Contreras
> > <felipe.contreras@gmail.com> wrote:
> > >
> > > This essentially reverts commit f15e7cf5cc.
> > >
> > > Once commit d9f15d37f1 introduced the autostash option for the merge
> > > mode, it's not necessary to skip the fast-forward run_merge() when
> > > autostash is set.
> >
> > It helps reviewers and future code readers if you provide a little
> > context when referring to commits, making use of git log's
> > --pretty=reference option to get the output.
>
> Yes, I actually have this alias:
>
>   short = show --quiet --format='%C(auto)%h (%s)%C(reset)'
>
> Which shows almost the same thing. I've updated it to
> --format=reference. Thanks for the suggestion.
>
> And I usually add those descriptions.
>
> > So, for example, here
> > your commit would read:
> >
> > """
> > This essentially reverts commit f15e7cf5cc (pull: ff --rebase
> > --autostash works in dirty repo, 2017-06-01).
> >
> > Once commit d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)
> > introduced the autostash option for the merge
> > mode, it's not necessary to skip the fast-forward run_merge() when
> > autostash is set.
> > """
> >
> > I still found it slightly hard to follow the explanation even with the
> > added summaries, though.
>
> And that's the reason I didn't add them. You need to look at both the
> commits to understand why one cancels the other. In my opinion in this
> particular case the description only makes the text harder to read.
>
> Probably some better $subjects like f15e7cf5cc (pull: skip ff merge
> shortcut on --rebase --autostash) would have helped.
>
> > An extra sentence at the end of the second
> > paragraph to make it clear what is being changed ("So, change the code
> > to fast-forward even when autostash is set.") seems to help.
>
> OK. That's implied by "it's not necessary to skip the fast-forward"
> but it's better to be explicit.
>
> How about this:
>
> Currently "git pull --rebase" takes a shortcut in the case a
> fast-forward merge is possible; run_merge() is called with --ff-only.
>
> However, "git merge" didn't have an --autostash option, so, when "git
> pull --rebase --autostash" was called *and* the fast-forward merge
> shortcut was taken, then the pull failed.
>
> This was fixed in commit f15e7cf5cc (pull: ff --rebase --autostash
> works in dirty repo, 2017-06-01) by simply skipping the fast-forward
> merge shortcut.
>
> Later on "git merge" learned the --autostash option [a03b55530a
> (merge: teach --autostash option, 2020-04-07)], and so did "git pull"
> [d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)].
>
> Therefore it's not necessary to skip the fast-forward merge shortcut
> anymore when called with --rebase --autostash.
>
> Let's always take the fast-forward merge shortcut by essentially
> reverting f15e7cf5cc.

Yes, very nice!  Thanks.

Elijah
