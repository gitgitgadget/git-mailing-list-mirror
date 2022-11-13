Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784DEC4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 04:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiKME4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 23:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiKME4T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 23:56:19 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8E111140
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:56:18 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id r81so6159069iod.2
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 20:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+tv6xxRTkehAKOrV4Yrgdfy0NOUVPcxmAea/PxZddUU=;
        b=g0sKBipXNRkzNXLOU0wAmRrPzlmPckP65r90jF20LR9I2A4Zz/NR2E14ElUdZW0ks1
         FuaP6Gu1Ri7AxVOo9YkcBsHBszw+RwdCVGYLk9LW3x8RDIo8vKPGT4Z4Q3yZ+uBlQa/+
         euW+2rbEhM+eIhPPB/1Xt7uvWWiZO44xYXf+bCtZsId5qsQDN3MsLyDO1lJiWIzRdIJQ
         cJuO8l1ctpkTwz9pmWVicueIoawOIH2MmC6xpEOuet3qR/lJFXj++dcThrsi9a8nWJJy
         j9KqJ6zD1T1fStnVlnNpp4/q16nq0euNrF5joC07jSt+f1LzFGEkoGzeWFtnmznBnrO1
         mJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tv6xxRTkehAKOrV4Yrgdfy0NOUVPcxmAea/PxZddUU=;
        b=n0xrCsnkpZUl83XQ80L0/9GSSi9Nstn+nWS2jDiwKHavgLzGybdqgBHqA30UThdOrr
         Q4xC7bqB27IMxR/kKYnbZg/cFbItESzXshMoC90wuteNdZnaCV4fF+Wr1R9e6h9aM6Tf
         Q/e+B1UFx6YVqkBSmdewORL6iFnr1aOg6FSuNcEfSuePCWf0foaffKNPG4yLCEjvc77m
         C/wc3N/c07/FOZaCJnCjeRdNP40yIScWJdsRWoVqr2SOJfd1wapg/yEEUkVxmfc1QPMB
         zd1HV1wdazf7P5AXyL6WCQvbqz79HgPaV76zFDAxCVaB64BbUWYcT/B7WigqK8DTks8Q
         qLKQ==
X-Gm-Message-State: ANoB5pnfvribbctXvPpS0hWVNH6Dd4renCY4Jx4rksdV+UkS5bGseUJq
        f2EKL9ontrCeumSxg6F2NLiSQJTkL+fXig==
X-Google-Smtp-Source: AA0mqf4X5YYNbNgFIrIXED4jIfA5PJOp75pgNjBLA6Wfu4wIRU61M4hP7OpZIyXWcjxnwRopECx9Lg==
X-Received: by 2002:a6b:f805:0:b0:6bc:1103:f36b with SMTP id o5-20020a6bf805000000b006bc1103f36bmr3484470ioh.205.1668315378358;
        Sat, 12 Nov 2022 20:56:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y11-20020a02ce8b000000b00363753f4730sm2290912jaq.91.2022.11.12.20.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 20:56:17 -0800 (PST)
Date:   Sat, 12 Nov 2022 23:56:16 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     M Hickford <mirth.hickford@gmail.com>,
        M Hickford via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify that credential discards unrecognised
 attributes
Message-ID: <Y3B48E04XfBiSz2V@nand.local>
References: <pull.1393.git.1666598268697.gitgitgadget@gmail.com>
 <Y1cm2a3qy9aowwNh@coredump.intra.peff.net>
 <CAGJzqsmH0DpEZDVZYU=6XpBO_vPfbirrK7KaWm2RmKG3aAk0oA@mail.gmail.com>
 <Y2/OIrSz+xrqkd+C@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2/OIrSz+xrqkd+C@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2022 at 11:47:30AM -0500, Jeff King wrote:
> On Sat, Nov 12, 2022 at 02:21:24AM +0000, M Hickford wrote:
>
> > On Tue, 25 Oct 2022 at 00:59, Jeff King <peff@peff.net> wrote:
> > >
> > > On Mon, Oct 24, 2022 at 07:57:48AM +0000, M Hickford via GitGitGadget wrote:
> > >
> > > > It was previously unclear how unrecognised attributes are handled.
> > >
> > > Yeah, this was always part of the intended behavior, but I agree we did
> > > not say it very explicitly (aside from an in-code comment!). Both the
> > > intent and content of your patch look good to me.
> >
> > Thanks. What happens next? I should look for this change in the seen
> > branch? https://git-scm.com/docs/MyFirstContribution#after-approval
>
> Usually the maintainer would pick it up, it would end up in seen, then
> eventually 'next', and then eventually 'master'. You can check the
> periodic "What's Cooking" messages from the maintainer to see more
> discussion of various topic branches.
>
> In this case, though, I don't see any indication that the maintainer
> picked saw it. It sometimes happens that a topic is simply overlooked,
> even if it received positive reviews.
>
> The usual thing to do is repost it, cc-ing the maintainer. I've also
> cc'd the interim maintainer here, so that may get things moving. :)

I think that Junio may have missed it when picking up topics. But it
happened before I start combing the list more finely, so I had already
purged it from my inbox without picking it up, either.

I'll take a look now and queue it to start merging down. Thanks for the
nudge.

Thanks,
Taylor
