Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A2CC01F453
	for <e@80x24.org>; Wed, 17 Oct 2018 18:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeJRCoX (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 22:44:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:43782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727435AbeJRCoX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 22:44:23 -0400
Received: (qmail 8395 invoked by uid 109); 17 Oct 2018 18:47:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Oct 2018 18:47:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22353 invoked by uid 111); 17 Oct 2018 18:46:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 17 Oct 2018 14:46:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Oct 2018 14:47:21 -0400
Date:   Wed, 17 Oct 2018 14:47:21 -0400
From:   Jeff King <peff@peff.net>
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: Sort output of diff --stat?
Message-ID: <20181017184720.GF28326@sigill.intra.peff.net>
References: <CAHd499BSVRytaFKOUhE=A4Zv+MMx=uKrWKUcT13QwzOCZWhEtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHd499BSVRytaFKOUhE=A4Zv+MMx=uKrWKUcT13QwzOCZWhEtg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 17, 2018 at 01:15:18PM -0500, Robert Dailey wrote:

> I'd like to sort the output of `git diff --stat` such that files are
> listed in descending order based on number of lines changed. The
> closest solution I've found online[1] has several readability issues.
> I'd rather see a built-in solution in git, if one exists. Can anyone
> recommend a solution?

Hmm, I feel like another person asked for this recently, but I can't
seem to find the thread.

Anyway, no, I don't think there's a solution short of parsing the output
(you could parse --numstat, which is at least sane, but then you'd have
to generate your own visual diffstat, which has a lot of corner cases).

We have --orderfile, but that's about a static order based on filename.
It seems reasonable to me for "--stat" to learn an option to sort (that
would not affect, say, the total diff order, since sorting by line count
makes very little sense for most other formats).

-Peff
