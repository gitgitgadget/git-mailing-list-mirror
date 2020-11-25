Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1519BC5519F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABDF0206F8
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 03:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYokjQVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgKYDsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 22:48:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgKYDsH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Nov 2020 22:48:07 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30868C0613D4
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:48:07 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id x22so765375wmc.5
        for <git@vger.kernel.org>; Tue, 24 Nov 2020 19:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leodxb0vi4LG+4AXPsKyLh7PXhg4sfs3P2rCSwmm2nk=;
        b=TYokjQVMHy1istbL7iefNs8C83yRf2txAmPP078abvc4Tix50XNOdgEVS5/iiYJYYT
         e4QJNAAzVK10Mi5u5cTX7JIHS9m+17E2aeVJA/myOWz+rIk1RvlKhTR53OKLJThcPR+r
         ASk5zYsAhxr7hiN1++cstjlSvwzWpQHj2vqwFWnGzlL29yPmVlXC+SrVb7CYPMi06EqP
         ox9aXRQXnI7puj9r1dYTaqRl/JXDXyOsbqPsgl7YF+kZ9t+MF3nkgR3+6vrf8+EV1LDX
         gUE1mpJNRfaZ51tVdZlf4Pn45RSfYKgENvsVl+8b0pxknKKKWBWZUa+CKoxiL5099Oaj
         FOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leodxb0vi4LG+4AXPsKyLh7PXhg4sfs3P2rCSwmm2nk=;
        b=o1UfAXrXw4zfFMxltaWmFMSnyVk9dTG0JUHvic5eK4QoQeL+IBqhO+cy+6hF4SgW5/
         DWknwQFMr9T/GJIrJJdWYmpmjEPtDf3ZVlTIgej5Ys1Y5DnVaU6AiXKpgW/f2EETvP1r
         Q0nb7wsSmKrrcywez/e7FZ2i56wEFy8DulEL/HpcaR93vHqQBd0vTi5wzKQ+7QH2hDze
         xPe4sNChlkrUTuSCzuy7qdMj945OYIT1LG2PfUsfJnnksvADFsXxeXBKjH3UHPSd5H8t
         bh1lO6Z4xapLeR4tV83RDFCctoxI/rq+YSvo9fWoRELEwy2ZEJIVuwkMbeHOQHPTtRHR
         AHTQ==
X-Gm-Message-State: AOAM532pJ6rCU3BzVPvJlUrDBeZHqGRZAiNDpKwe6RY2ZyQNx5QdtvQ4
        YVHjhzN8kh0EEhcq4tvUwXgu/Pn7pciW6DAfap0=
X-Google-Smtp-Source: ABdhPJzFL4gjgIDRdS+YDFY/2PM3juaNrG6JMPpOj0RcQzo6NZn1lLLxse6RFPhaKWnbwtEye5JZTbPE30Twe3mLyUw=
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr1483814wmj.37.1606276086005;
 Tue, 24 Nov 2020 19:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
 <20201125020931.248427-2-alexhenrie24@gmail.com> <CAMP44s18Sd=DWMhFWCSDyGEz74ZKVF2kukr_=Exe1CjnPULCoA@mail.gmail.com>
In-Reply-To: <CAMP44s18Sd=DWMhFWCSDyGEz74ZKVF2kukr_=Exe1CjnPULCoA@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 24 Nov 2020 21:47:55 -0600
Message-ID: <CAMP44s3-fJ=mrYjGTW3AUACBmEhyrdD0dRktdaKHK9b1MTbk2A@mail.gmail.com>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is not
 set either
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        "Raymond E. Pasco" <ray@ameretat.dev>, Jeff King <peff@peff.net>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 24, 2020 at 9:45 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Tue, Nov 24, 2020 at 8:14 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> Before making this the default we need a solution *right now* that is
> a sane default.

This mail was sent by mistake. I was going to say:

We need a warning like:

  The pull was not fast-forward, please either merge or rebase.

When the default (pull.ff=only) is set.

It is the current status that is more urgent to fix.

-- 
Felipe Contreras
