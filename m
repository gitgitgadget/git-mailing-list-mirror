Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C7DC433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7287764FBA
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 06:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbhCKGhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 01:37:37 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:46670 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhCKGhe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 01:37:34 -0500
Received: by mail-ed1-f45.google.com with SMTP id h10so1033787edt.13
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 22:37:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ylnPfyDFGTx9mfPV56AwUlaQ3+4QJ5piN18Xkw4HYYw=;
        b=p6ssbNOJYCic7fY44j2mtg6uWC+ajvOZZxbn0vekgconl7T7wZuFA3NY38bILNuMWq
         Rxyt0dLJJRZjF4+5zRXD97VkXbUf4+wkEcW+Jfdjebj373VNz+jB+Lnn67sHBFXvpcXB
         I2oLSGmbSRZfxQzfjnypRBts/LZQFHTljTvGTowxyHjEkaLcGUv/9u9BSpZnuwxGSqJK
         qW4yTW9ZIIoP0Vm39WUMjpUNFwZOYV/+ngbtUCJdpiS3kteBun1UofF+iuXbBnbs9xZi
         5z8m2f+Yb9WR4LH1Wwk0nmnwi+Q//8tF6JdrB916S3YpyKWFd+fSE9ysSwOlHZWJE5x1
         7kfw==
X-Gm-Message-State: AOAM530eBg6ovkC4tnpTv0e1Z6lxYK93vA/m1iSTW9o/Un4armd3FL4H
        pdS7FVuNQWSzc+Z6v8Ld0qeYWaoqouTbsZxT/Azr+z/ug9s=
X-Google-Smtp-Source: ABdhPJyllUl7dGGaNjMDktVXLUH6j3ac+jp0vfEl2WVNHsjl+69jw/O3vOuN9b+ggm8ztlhiwsu2YlMxzm3U8Fjh2zw=
X-Received: by 2002:aa7:c551:: with SMTP id s17mr6924983edr.291.1615444653715;
 Wed, 10 Mar 2021 22:37:33 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210310194306.32565-4-charvi077@gmail.com>
 <xmqqpn06h6os.fsf@gitster.g> <CAPSFM5dqRbuoCvEFcHQPSQt+EK1_pBVQ--f42jR+GNqCFd_SOg@mail.gmail.com>
 <xmqqa6rafdyg.fsf@gitster.g>
In-Reply-To: <xmqqa6rafdyg.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 Mar 2021 01:37:22 -0500
Message-ID: <CAPig+cQYx+mqMSe=+7RFh0Ft3Sx110n+QzDKMZaOGJoc+R0H5w@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] commit: add a reword suboption to --fixup
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Charvi Mendiratta <charvi077@gmail.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 11, 2021 at 12:37 AM Junio C Hamano <gitster@pobox.com> wrote:
> My suggestion primarily started a reaction to that "As `amend`..."
> which was not gramatically complete sentence, and I ended up
> rewriting everything after "As `amend`..."
>
> But re-reading what is in the paragraph before, I tend to think that
> it places too much stress on 'colon' and should be removed.
>
> The comment is about what is being parsed, so
>
>          We limit --fixup's suboptions to only alpha characters.  If
>          the first character after a run of alpha is colon, then the
>          part before the colon may be a known suboption name like
>          `amend` or `reword`, or a misspelt suboption name.  In
>          either case, we treat it as --fixup=<suboption>:<arg>
>
>          Otherwise, we are dealing with --fixup=<commit>.

I suggested a different way to rewrite this comment[1] in my review of
patch [2/6] before I was aware that you two were discussing rewrites
here in [3/6].

[1]: https://lore.kernel.org/git/CAPig+cRxZFV7DDtnYOxRqEYU4PwXK8gb2HSehDyGorqdgsmoNQ@mail.gmail.com/
