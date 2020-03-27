Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484ECC43331
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 19:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B2A52071B
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 19:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNVUAEZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgC0TCK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Mar 2020 15:02:10 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37413 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgC0TCK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Mar 2020 15:02:10 -0400
Received: by mail-oi1-f196.google.com with SMTP id u20so4991657oic.4
        for <git@vger.kernel.org>; Fri, 27 Mar 2020 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HWUbXt+ORhXpxZDYzcQibFtb0g5BWel8RBuj8wAfN04=;
        b=QNVUAEZlaDwcm0rEhEa+1rAqjM50hKXPBo9/pcHpljz0LE7RKCGNDr+l6/NE/UfIUx
         N2K7CAqnsDLRTw1EayTZAGpGOZaylsKzmi7++aDzVYYMTk61EP8JLh7mK4bRQ+OTdhZJ
         diSejegIZ0yrnDnHwyE8B3cUFEOarJ8ZkOEgulzVWz/vK7wdRtLmkZ2z3QVi8JSu9mjw
         bdAikd/7aPf8cOtRMX7EexxKNpdnaSDWO8jRMpduvQDv2lqVOINBzbZ1MRGlw1WMDbC9
         BF/CE+Ticm4H/CA0MySI86NxirXjEqUZ5AMYpJa5EvBAh5U4ZlalLY9mwb3Z6M8j5OlC
         EyCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HWUbXt+ORhXpxZDYzcQibFtb0g5BWel8RBuj8wAfN04=;
        b=mtmvRz9fFLSSi0DcrJ0Sd/B+9y7CIRnfOSJ8tTP8rJ9KqgTj1ryGXMMp8xmZlroPvA
         d4ba3VdeonrcwIqOOo1A40x1KxEkiJMrSoMpEu0u1mn7FxlsqCm19xvgBywitNqFwZLN
         65aL23S28FuTaVUDk08DEE4YTVl6SkDZD9XmIPRlfz6P8HH9QWGmPu6FXvvQlunSvF+c
         rQkKUwJrojYymsIqbTFYNyef+MCdUL98fD+ROieC2FmbjRsWGhpxMCleLMCKczHJMYOU
         2e26YwaHuffIj/gedtLQa74KaEHVKqxjBaIITEH8QGat7KRHBerP/ONmWmATp2UAf0xD
         vHvg==
X-Gm-Message-State: ANhLgQ05Wp8lyGUVGHtH9ON3Jz3ifbL7v6TyAQCnam8XNGTAgASB4VR/
        DFz9eVF//hjhY+qgUDt0K3I1NpEh4DapkJUW30Y=
X-Google-Smtp-Source: ADFU+vs1nCqeLzYmyKZxCoTY0dnyVs6X5Uhys+Rj/an9vwDwLcC9iDTKexnMBslaZGgnYfo7NeHti/Av7Ik/4t+OiD8=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr245502oig.39.1585335728749;
 Fri, 27 Mar 2020 12:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com>
 <CAHd-oW6ANf_iNmYkgXt4jo1seB-AEx1TSH384v+oh1bicG8RDA@mail.gmail.com>
 <CABPp-BGVO3QdbfE84uF_3QDF0-y2iHHh6G5FAFzNRfeRitkuHw@mail.gmail.com> <xmqq369tiyo8.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq369tiyo8.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 27 Mar 2020 12:01:57 -0700
Message-ID: <CABPp-BG+Wohx4idoh1KSVZvuQ6aUJ6OKACRMi=gkvQjzd2sWUw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 27, 2020 at 8:51 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Sometimes, code that wasn't meant to be used together accidentally is
> > used together or the docs suggest they can be used together.  ...
> > ... but that's the
> > type of accident that is easy to have in the implementation or docs
> > because it doesn't even occur to people who understand the design and
> > the data structures why anyone would attempt that.
>
> The above is not limited to "git grep", but you said so clearly what
> I have felt, without being able to express myself in a satisfactory
> manner, for the last 10 years.
>
> > ... (Side note: I think this kind of
> > issues occurs fairly frequently, so I'm unlikely to assume options
> > were meant to be supported together based solely on a lack of logic
> > that would throw an error when both are specified.
>
> Amen to that.
>
> By the way, and I am so sorry to making the main issue of the
> discussion into a mere "by the way" point, but if I understand your
> message correctly, the primary conclusion in there is that a file
> that is not in the working tree, if the sparsity pattern tells us
> that it should not be checked out to the working tree, should not be
> sought in the index instead.  I think I agree with that conclusion.

Cool.

> I however have some disagreement on a minor point, though.
>
> "git grep -e '<pattern>' master" looks for the pattern in the commit
> at the tip of the master branch.  "git grep -e '<pattern>' master
> pu" does so in these two commits.  I do not think it is conceptually
> wrong to allow "git grep -e '<pattern>' --cached master pu" to look
> for three "commits", i.e. those two commits that already exist, plus
> the one you would be creating if you were to "git commit" right now.
> Similarly, I do not see a reason why we should forbid looking for
> the same pattern in the tracked files in the working tree at the
> same time we check tree object(s) and/or the index.
>
> At least in principle.
>
> There are two practical issues that makes these combinations
> problematic, but I do not think they are insurmountable.
>
>  - Once you give an object on the command line, there is no syntax
>    to let you say "oh, by the way, I want the working tree as well".
>    If you are looking in the index, the working tree, and optionally
>    in some objects, "--index" instead of "--cached" would be the
>    standard way to tell the command "I want to affect both the index
>    and the working tree", but there is no way to say "I want only
>    tracked files in the working tree and these objects searched".
>    We'd need a new syntax to express it if we wanted to allow the
>    combination.
>
>  - The lines found in the working tree and in the index are prefixed
>    by the filename, while they are prefixed by the tree's name and a
>    colon.  When output for the working tree and the index are
>    combined, we cannot tell where each hit came from.  We need to
>    change the output to allow us to tell them apart, by
>    e.g. prefixing "<worktree>:" and "<index>:" in a way similar to
>    we use "<revision>:".
>
> Thanks.

Ah, so you're saying that even though --cached and REVISION are
incompatible today, that's not fundamental and we could conceivably
let them or even more options be used together in the future and you
even highlight how it could be made to sensibly work.  I agree with
what you say here: _if_ there is a way for users to explicitly specify
that they want to search multiple versions (whether that is revisions
or the index or the working tree), _and_ we have a way to distinguish
which version we found the results from, then (and only then) it'd
make sense to search the complete set of files from each of those
versions and show the results for the matches we found.

That differs in multiple important ways from the SKIP_WORKTREE
behavior I was railing against, and I think what you propose as a
possibility in contrast would make sense.
