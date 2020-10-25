Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF702C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D94521734
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqRTLR4d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763105AbgJYDqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728502AbgJYDqc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:46:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DBBC0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:46:32 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s9so8286331wro.8
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ndIhhKx1x5FaH4QOt5Tx5BmUW3eaBVhw52q8N0iOQAk=;
        b=oqRTLR4d/R/uw5GBSNByxJJAdQfQ9cpKAfTghenBhbKiv3w6HtDeJkHNR49wIeZUs6
         wqb1/c/PInjyfWFGmudqrkgOzWLckujf3+xmjmifzL228jcZ26cvF+VADjOWNdZ89cIA
         rIHDrYijQHdpkRBixbIy/pod6xUdpvrZXfcCbzgkFsTO9osFEXCjLLU+Uj4OS8A+6bs+
         bzYuGdz3ClMTmMN3DWt/5klROGxJPvcYpzgNZ+2pk3YRVspbq3KEceR9Bw8v11JdSf60
         wTuHy1c4aUYiTv+EqnGtAB6Bk568aEjShKvZTlnx7fI0oZnv52zY08JdKm2yQXT3DChV
         JkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ndIhhKx1x5FaH4QOt5Tx5BmUW3eaBVhw52q8N0iOQAk=;
        b=HMbfPszj0VYOMalBCHeVmmq+TfhsVZ6GuPrbA5sCuIQQUzfbf8JuJj892GfdFUSHvg
         Gfn6Irhp4g+7dvSVApcAnxEYoq7krcioolE7mJtNKNP0tREwlzfnG9jioa/4QhWliK9T
         QUXbZJgh4ctmCwJl3DbRm/fvVmhX8GxpUMw/5Flvxqgz0TsPvPCLNXxw7w8vRYblb2wO
         TJA6B+obJe9hqarI/O6PvBMklllwMPrBqpOIbyCpZ+/EUey+bkNM/7Uydrsk1kvRlnfp
         XsFRyQvZXcKx/XY4+rtjQacFoHfSkEtOIdJyJd54N5fWgmqtaOu0qLl4YiEEg9u2E/mD
         ic9g==
X-Gm-Message-State: AOAM533Y1QQvZp66A/SCCCF7sXS1vyIORbWEwDJ9euHYfQM4uWVypTjs
        t0MIzDVeLCMm6CjpqnWupqy11p0bm9G0S2aWA0M=
X-Google-Smtp-Source: ABdhPJx7kGqMfaYU9PuKK5dkge6SXlnDnG7QesLzDrvbmJXGt6tRxuZZLVYjHiqLJeOYWKK60zQn15t4aU7Vc2GiFJ8=
X-Received: by 2002:adf:e885:: with SMTP id d5mr10721545wrm.100.1603597590736;
 Sat, 24 Oct 2020 20:46:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190621223107.8022-1-felipe.contreras@gmail.com> <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1cz0zz1.fsf@gitster-ct.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 24 Oct 2020 22:46:19 -0500
Message-ID: <CAMP44s3wqxTmgQpMgk2cM33EvtwrvvXYv4_90GKGmHb8yJHAKg@mail.gmail.com>
Subject: Re: [PATCH 00/14] completion: a bunch of updates
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 3, 2019 at 12:50 PM Junio C Hamano <gitster@pobox.com> wrote:

> But we haven't seen any response to the earlier zsh specific
> patches.  Does it mean that nobody other than Felipe cares about
> having a working Git completion for zsh?  Or does it mean that all
> users other than Felipe are happy with the current Git completion
> for zsh and it works very well for them already?  Or somewhere in
> between?

The answer is obvious: the set of zsh users and the set of git
developers don't overlap.

> What I am trying to get at is if we would want to keep the earlier
> zsh parts of the series, but with nobody seemingly interested in, it
> is hard for me to justify queuing them.

You are asking in the wrong forum.

I would gladly point you to *dozens* of issues reported in Stack
Overflow and Oh-My-Zsh if you don't believe me.

Or you could just install zsh and see the issues for yourself.

-- 
Felipe Contreras
