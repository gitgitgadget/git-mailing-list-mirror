Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CAC433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhLUKcj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 05:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhLUKci (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 05:32:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A78DC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 02:32:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id g26so12457845lfv.11
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 02:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TrTGyB40LmNLTj22eOjKfSH5Q6qeV5zfHM/fVrDNOJI=;
        b=K+q3n2zq1QHZ7BsrthkoiYtCMOOw3HZax8+08MmudrOMtNE2JBfCvsl3W6eFGBe/ix
         bqb1RP59uRnAGIwSBED9PbjYlbAAg8TNTEUm5BKsxeBu2Ms1qB8ZUcD/RMzanEwYdWIN
         EXV0nIMgJhFvNnA0FyxWFg0auWR63vSk5yNT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TrTGyB40LmNLTj22eOjKfSH5Q6qeV5zfHM/fVrDNOJI=;
        b=ffeNY7lCItWKpprthu+yq/z6yyG9euMZIXr63PvD+xF3lkIfsY7OqLVuXFFcjD4ZkK
         Ba/slHzZuc4J7VqVn4XyiN/IOjPQAehUU4+bffFP1Qsg0Y/lAUzvJ8/GYfmCDl9elddY
         /wTlYpIJzNzB/GEL7AXJwk2kXPnACxS6vKBR5STk2tZMR6BGDVB7pRd4si2ZuWgLsav/
         niMyAgNt2UhSTT2hU4gszxx/S3I4HhRvtaE6cSxS9uHHpA/lvYouMbj12dCXKRCTv2WP
         7XFkmN4HkR9ldcv76m5RnEN18Dz/5a5SLgcd2VAG4n1PLSHya2F/zUbC5Sb5E0gBzKiz
         kU4w==
X-Gm-Message-State: AOAM533RbB/mfetQnwZ9K3IagB7X9w/MUS+a7qnWkq3fst2FRCpbvx/b
        Q3jY/GftZoBTh3te2iPgh4ST7hFLdDjCf+Nf6fu8Ww==
X-Google-Smtp-Source: ABdhPJwS1BTSl8XhR4Va64KopcnAPo9lIvV9MvlhzKVtMb7fZpMDe8oxK19rqb2xWzcjUhyOaDDhi8+IM8p0QAzYEAU=
X-Received: by 2002:ac2:4f8e:: with SMTP id z14mr2438120lfs.316.1640082756298;
 Tue, 21 Dec 2021 02:32:36 -0800 (PST)
MIME-Version: 1.0
References: <20211217140547.2115095-1-jholdsworth@nvidia.com>
 <20211217140547.2115095-2-jholdsworth@nvidia.com> <xmqqh7b3vzgp.fsf@gitster.g>
In-Reply-To: <xmqqh7b3vzgp.fsf@gitster.g>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 21 Dec 2021 10:32:25 +0000
Message-ID: <CAE5ih78dLwqpHChkJ6JWmFYZh58Yca8tWke9Oa8JDzzOGi78AQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] git-p4: remove "delete" verb
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Joel Holdsworth <jholdsworth@nvidia.com>,
        Git Users <git@vger.kernel.org>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Dec 2021 at 19:38, Junio C Hamano <gitster@pobox.com> wrote:
>
> Joel Holdsworth <jholdsworth@nvidia.com> writes:
>
> > The git-p4 "delete" verb is described as "A tool to debug the output of
> > p4 -G". However, the implementation provided is of no useful benefit to
> > either users or developers.
>
> The same comment as 2/2 applies here, too.  This time, however, I
> think it would be much easier to give a proper analysis of what it
> is designed to do and what it does, to convince readers why it is
> too trivial to be worth having the code (compared to the PATCH 2/2).
>
> Also, this is not about the "delete" verb, but the "debug" verb, no?

I have never used the P4Debug subcommand for debugging git-p4, and I'm
not sure what I would use it for. Removing it seems sensible.

As noted by Junio, s/delete/debug/.

Luke
