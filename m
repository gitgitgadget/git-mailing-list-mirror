Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1926C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 828896115B
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 10:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhFOKnQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbhFOKnQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 06:43:16 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B65C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:41:11 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id t140so17717146oih.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 03:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1z1iatiDde4j+Lq8UiD1Zgw1m5Jj2hjnfvjRJapN9Q4=;
        b=DnnrOS7PnKZ0Blk879mu9J0eN5SfQg16nQu/i++Z4PARS4qKy9gY01oLVHfjnrg9zG
         UQZkY8bgBM8/TYnKNFAQU9vzRZvMFEzQfLlCur1SckB4y/ZIgPM/faJKiOfsEjZsCpSJ
         FcEuVqomqLLWhKMg/HyNMeIhSqdorq5jS/QiYMV2GnQGVHvNBUDDwiFjQq2uL2xUVCLO
         b+JumThDyMIdzJDurMA9kwc6VmrJCrxJ1nnziW+UheCNkfI8ZQPSObh7ChA1tKQo9N4I
         9QqSDii2dN5QdbMDjfdhCDUJc+/IeLU6t2JJ+Lvzu/70jzH1rr5QU8QlD5o7AaL6xz27
         f5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1z1iatiDde4j+Lq8UiD1Zgw1m5Jj2hjnfvjRJapN9Q4=;
        b=ilta0JMwipF9yTIuYKwCRCn/uFCTYCoxSD9BBrJSZERoLFXQHyLAQSb46fSlxyAU82
         z6hzLNwkBhb+SrR1DLhafiYzll3Pr6a8elabrb+JB894gUFnIMjb9q3x5guICHq8h3HW
         ZGY+JvXSD5fOauLjFOCYFYpIF1lz/NfV3JMSr+EvwYDpx5glqKwhTZFBLnnv11f1ul5A
         fUNPojj14k25e96ywgEt9dRM1aPpfECG9ZStl9fU3SgrqwyPGCLhS1BGZV1mMkFK7Mqt
         Zf4ORQNOceQ2++4mD+FBugGdZpyWS/Nhh2CqTVaL1WNXe/hik2sytnLZoX8nO+8AaA8D
         +2jA==
X-Gm-Message-State: AOAM533CHxQ8xfBhwC3xzF3ix20CFaS4HtbWwdpN6HqT+E7Fj4PnnB39
        B66355pZJ9n5JVW0PhVDero=
X-Google-Smtp-Source: ABdhPJy+LVDwbhLafae0YXom11v0PabjIxfw+Z9N6rQeS0neE9D95M1gKxPRhlzDTRpxF3j+X2kX9w==
X-Received: by 2002:a54:458a:: with SMTP id z10mr14360794oib.64.1623753671316;
        Tue, 15 Jun 2021 03:41:11 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id y17sm3607504oih.54.2021.06.15.03.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:41:10 -0700 (PDT)
Date:   Tue, 15 Jun 2021 05:41:09 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Message-ID: <60c883c5baf07_e63320830@natae.notmuch>
In-Reply-To: <CABPp-BFEc2aQV_kTTiDh3WV5oBwr4tOzO6LOGnMAHudZdXVo6Q@mail.gmail.com>
References: <20210613045949.255090-1-felipe.contreras@gmail.com>
 <CABPp-BFEc2aQV_kTTiDh3WV5oBwr4tOzO6LOGnMAHudZdXVo6Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] pull: obvious fixes
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Sat, Jun 12, 2021 at 9:59 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > These are obvious fixes that I sent many times in series like [1], but
> > for some reason they were never merged.
> >
> > There's absolutely no reason not to merge these.
> >
> > [1] https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/
> 
> I was really surprised to see the Reviewed-by on patch 1, and did not
> remember what review I had done.  Unfortunately, since your new patch
> series aren't posted as responses to old ones (see
> https://lore.kernel.org/git/CABPp-BEEiPP7AEk4Wexw4_MDHcin2n8xkMowO=OXTn9pNPaG0A@mail.gmail.com/T/#u
> for an example of what I mean), and since the cover letter you linked
> to didn't reference previous series,

But my cover letter did reference a previous series:

  https://lore.kernel.org/git/20201218211026.1937168-1-felipe.contreras@gmail.com/

See patch 3, 4, and 5.

The problem is that these patches (along with many others) were part of
different series, that I reordered, split, and joined in order to make it
clear why all of them were needed. When I split them people didn't
understand the context, and when I joined them, suddenly there were too
many.

> there's no trace of where it came from.  I had to go digging to try to
> find it.  Any chance you could tweak your posts in the future to help
> reviewers follow how things have evolved?

I always do that, including this series.

In order to properly dig through all the versions of these particualr 3
patches it would probably take me an hour, and I don't know how much
value that would provide. I just picked the latest one I could find that
contained them.

-- 
Felipe Contreras
