Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8B2C433E6
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF8B64E9A
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 03:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbhBBDGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 22:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhBBDGC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 22:06:02 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF04C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 19:05:22 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id f6so18459116ots.9
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 19:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaInVFQqT5YbNpom9QvorBIow5aydvH4vBEFD53YTmQ=;
        b=fIPA/Ub/D38ZdpooOsfE3XZlY6xs37KzK8yOm4iqdkbFqHUPv7LU6HcpWg3ta4KT+6
         PGhrU7GUb+X3GtU4ETj6FbfG93hNHA1jgzEyZvRG3+yAU7A7OK8/i70uqu35Wmychz2L
         rg3zvveWRhfAII9UGR6xkAmMDR7PeBM5fHDLjY0PiNmEc3FQxGmmT1U/bE58vlXysSmD
         6WhmYR6jayj5oHsghuZBDj2QWBFHcXGjc82+QXb+APcaD1fBtcq89VfvocKS5Ct7Rm6g
         GZXOuQ8UaU/KuVArBlVFL16H3LKUnpPQfF7WbjkwGl+Yd2Vz4U63YxyCFLphOPbpw/Pm
         766w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaInVFQqT5YbNpom9QvorBIow5aydvH4vBEFD53YTmQ=;
        b=kjItiE5NP/qZz5OlGHmNiQOOswuhCe7fTQfaNTI/OSBTd13OYkxLrnsYbQJdFtyG8u
         XLxI2SxyeAf+Zr1avs180dA+FU2hS9oZCA7lXjWluLBvufEayxnDAyhDBnj8GTTMCqll
         QeZ3MwHZxnOLPaD9YrxLJe8ceS41KjM8pORGuzIZKG+het55vJuDWo/p2IsXO2Lks0GK
         LqJRzyrE9JKjLr75zabbGzF9/adKgBuyeA+j97hVQgdsAewMS2Sq1scgJHi8qVKsfhZ5
         s+LoYL7ds6PPEi+qWmYO0NxyTEIDnDZudhDydWGFwNv4G17XcIgWSM+Fwzm/jzhfZyrl
         fRRw==
X-Gm-Message-State: AOAM532OyAv0KKoRdo+G2w+andRUQlrCGMro30RnlRSTSNxHy53McTQB
        ZlH1p/0aKpZVsI3bgi9cNH2+95XnQgUXQIraK1c=
X-Google-Smtp-Source: ABdhPJy6VbMk+GhNlIai5aLRC1mJmmKTDpaxHGojyGLXXJ5IV6jJBoMpfouatZ+jYC9qHth75JjL+N5ODpCENxswRT8=
X-Received: by 2002:a9d:1c9a:: with SMTP id l26mr13833351ota.316.1612235121411;
 Mon, 01 Feb 2021 19:05:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com>
 <05e7548b780da6b2bf2342d91d8757568df0a6b8.1611596534.git.gitgitgadget@gmail.com>
 <CABPp-BGtF+p7D8x0xvSwMz7XveqVcBWhr20iHQ4=Vrxw6LEoKw@mail.gmail.com> <37c90f69-2f0f-2ac1-09e8-6ce670dd18ba@gmail.com>
In-Reply-To: <37c90f69-2f0f-2ac1-09e8-6ce670dd18ba@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 19:05:10 -0800
Message-ID: <CABPp-BGerQ+puOGsajELFWCMVp0_=FaWY3m7zdCM06rmB1xvyg@mail.gmail.com>
Subject: Re: [PATCH 27/27] cache-tree: integrate with sparse directory entries
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 1, 2021 at 6:41 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/1/2021 6:54 PM, Elijah Newren wrote:
> > On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> >> In this test, I also used "echo >>README.md" to append a line to the
> >> README.md file, so the 'git add .' command is doing _something_ other
> >> than a no-op. Without this edit (and FS Monitor enabled) the small
> >> tree case again gains about 30ms on the sparse index case.
> >
> > Meaning the small tree is 30 ms faster than reported here, or 30 ms
> > slower, or that both sparse index and small tree are faster but the
> > small tree decreases its time more than the sparse index one does?
> >
> > Sorry, I don't mean to be dense, I'm just struggling with
> > understanding words today it seems.  (Also, it seems like there's a
> > joke in there about me being "dense" in a review of a "sparse"
> > feature...but I'm not quite coming up with it.)
>
> I don't blame you! This is a lot to digest, and I appreciate you
> pushing through to the end of it.
>
> Clearly, I was getting a bit inexact near the end. My excitement
> to share this RFC clearly overshadowed my attention to grammatical
> detail. I'll go through your feedback more carefully soon and
> hopefully clarify these and many other questions.

I can't blame you for being excited; this series is awesome.  I've
thought we should do something along this direction for years[1].
Sure I found lots of little nitpicks here and there in your series,
but that's just attempting to help find any issues so it can be made
even better; overall I'm super excited about it.

[1] See "crazy idea" paragraph at
https://lore.kernel.org/git/CABPp-BGir_5xyqEfwytDog0rZDydPHXjuqXCpNKk67dVPXjUjA@mail.gmail.com/
