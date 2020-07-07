Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB36C433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0E3A20758
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 06:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdWTSmaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgGGGTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGGTT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 02:19:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2C8C061755
        for <git@vger.kernel.org>; Mon,  6 Jul 2020 23:19:19 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a8so36185546edy.1
        for <git@vger.kernel.org>; Mon, 06 Jul 2020 23:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jv4W+V4XKQBzCNL4qk2df/oWYLQ+wxWFCv9lCXdJUw=;
        b=gdWTSmaBv3hmWcxkuLFGUNNK6YGqu7NxCjUbSMjQEvJe8ZrEzmn+2fMv0f7fp/x5Cd
         cZ6W1T3AB/0MShk5yZ9OmNNbWsDq2oY+L/GhySgnsH7A9sBJ0L5UIRqZEejrLp9olUbo
         hNX7dUmgTrG4Fle9F036mfGATmwrXgEb72HmuVf05/V7iwEBBobX4VRwMv6YgoTdAkZu
         PrwNfTeIa/9h+peybnBWa+wvWL0upu03j+sWBu9SlxDEzDDuHRo7lqAwxkKc6V3HQaF1
         q7CdvnXxOodRskxSiTiFWucEuD4j5lL5JJcyaYiHeP0ZXY48VmSmuJJQUuEwN2WKdbuJ
         B+Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jv4W+V4XKQBzCNL4qk2df/oWYLQ+wxWFCv9lCXdJUw=;
        b=djO4vdN9AGio3r4KjEnGm8QwOzNMzabaj5IWbgqHt9S4z2wBBXS20ig3x01arvitSq
         KmrEuRSgmMnHi9aRGKqhhyBzFPS8aCLJe5819NNjWnTGlj1pzQr6CpUPcbabCMLndB2p
         52njpstrRmGS2jKyKhYQMYbevHRmQHnkXQK/di/M8Nu1nx6NehZc2y5N48LQe0rUUR0C
         nG7RxUZcThehyNMLgTHoH+EM4gyXrTN2oqhBQN19cPKaSW0nBzcft1tEBuCnV6ZTokD8
         0rwobzGgPMdDOv5YwQIP47VM0g9lZASt88+YAPwYv/O1AnnEwaFHWlR73N5POTNcIFUL
         U/2w==
X-Gm-Message-State: AOAM530Y5LwH2KQJVIgWZW+evuKJrLDmjMxvzugYc2VH/tWakciPBhtD
        Sjtlg21cPUtMomFB6FFQcZV1yIaHrZpRph2ZhVA=
X-Google-Smtp-Source: ABdhPJzeMQXExM4HJ53OGMlRU0Er52Xx0RBc7Efe1wmcuUGxRfDLt78U6PoeGsF0YRuoGfla4aWOhVd3Ik7NsrNlXrs=
X-Received: by 2002:a50:9e02:: with SMTP id z2mr57630426ede.87.1594102757670;
 Mon, 06 Jul 2020 23:19:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200702140845.24945-1-chriscool@tuxfamily.org> <20200707050247.GA105016@coredump.intra.peff.net>
In-Reply-To: <20200707050247.GA105016@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 7 Jul 2020 08:19:06 +0200
Message-ID: <CAP8UFD0gUK4TGUA7JZ_V7hFe4LSDAP7DfPyz4gqy1RjLXJPF2w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add support for %(contents:size) in ref-filter
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 7, 2020 at 7:02 AM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jul 02, 2020 at 04:08:43PM +0200, Christian Couder wrote:

> > The other difference with V1 is that there are more tests in patch
> > 2/2. These new tests required a small helper function to be
> > introduced.
>
> I'm still not sure why %(objectsize) isn't sufficient here. Is there
> some use case that's served by %(contents:size) that it wouldn't work
> for? Or are we just trying to make it more discoverable when you're
> looking at the contents already?

%(objectsize) is the size of the whole commit or tag object, while
%(contents:size) is the size of the complete message (the whole commit
message or tag message, including trailers and signatures).

$ git for-each-ref --format='refname: %(refname)%0a%09objectsize:
%(objectsize)%0a%09contents:size: %(contents:size)'
refs/heads/{master,next,seen} refs/tags/v2.2{5,6,7}.0
refname: refs/heads/master
        objectsize: 285
        contents:size: 69
refname: refs/heads/next
        objectsize: 281
        contents:size: 17
refname: refs/heads/seen
        objectsize: 589
        contents:size: 325
refname: refs/tags/v2.25.0
        objectsize: 974
        contents:size: 842
refname: refs/tags/v2.26.0
        objectsize: 974
        contents:size: 842
refname: refs/tags/v2.27.0
        objectsize: 974
        contents:size: 842

When sending only the complete message, not the whole object, through
a protocol, it might be interesting to easily get the length of the
complete message. For example one could use "Content-Length:
%(contents:size)%0a" when sending a complete message over HTTP.
