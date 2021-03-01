Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6877DC433E9
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241AE64DE7
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 09:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbhCAJFb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 04:05:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:47818 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233846AbhCAJEa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 04:04:30 -0500
Received: (qmail 4414 invoked by uid 109); 1 Mar 2021 09:03:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Mar 2021 09:03:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21530 invoked by uid 111); 1 Mar 2021 09:03:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 01 Mar 2021 04:03:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 1 Mar 2021 04:03:38 -0500
From:   Jeff King <peff@peff.net>
To:     Yaron Wittenstein <yaron.wittenstein@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        git@vger.kernel.org
Subject: Re: [QUESTION] Tracking HEAD changes?
Message-ID: <YDyt6h3dphnG8kwk@coredump.intra.peff.net>
References: <CAGgn8PdU1GE_CZdGUpJWKzygd0O+Yn2BnAFGmPfKAxFpoVoqUA@mail.gmail.com>
 <YDROhhrM5qJti1ir@coredump.intra.peff.net>
 <YDVo0kGYODP0JjqT@coredump.intra.peff.net>
 <CAGgn8PcPtLNtZTmMqKKTmH3KOezkr-jY7aTEDA-0dvYWuzid9A@mail.gmail.com>
 <YDa/EupbrNa62r+D@coredump.intra.peff.net>
 <YDc3dinQ37FY8fhD@ncase>
 <YDiOXDbN/JtUWgWu@coredump.intra.peff.net>
 <CAGgn8PdYsfbSE2vRunOXO1JqXoM8LxoD+5Zn74jmb9vpqDXh+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGgn8PdYsfbSE2vRunOXO1JqXoM8LxoD+5Zn74jmb9vpqDXh+Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 26, 2021 at 10:58:37PM +0200, Yaron Wittenstein wrote:

> I'd like to make sure I understand the way things are right now:
> 
> 1. The reference-transaction hook as it's today doesn't intercept
> symbolic-references changes. It means that when HEAD changes due to
> branch-switching the hook won't
> get called.
> 
> Are there any other cases that today the transaction won't execute? (I
> couldn't think of one)

No, I don't think so.

> 2. The mechanisms that handle the changes to index and working-dir are
> isolated from the one that manages the refs updates.
> 
> A side-effect to that is the post-index-change hook running before the
> reference-transaction one.
> Future code changes to the way git operates could result in the
> reference-transaction hook running before the post-index-change one.
> 
> Is that correct?

Yes, that matches my understanding.

-Peff
