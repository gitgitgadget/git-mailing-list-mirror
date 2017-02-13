Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8D021FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 21:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752857AbdBMVvK (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 16:51:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:54530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752492AbdBMVvK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 16:51:10 -0500
Received: (qmail 8719 invoked by uid 109); 13 Feb 2017 21:51:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 21:51:10 +0000
Received: (qmail 27741 invoked by uid 111); 13 Feb 2017 21:51:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Feb 2017 16:51:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Feb 2017 16:51:07 -0500
Date:   Mon, 13 Feb 2017 16:51:07 -0500
From:   Jeff King <peff@peff.net>
To:     hIpPy <hippy2981@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Incorrect pipe for git log graph when using --name-status option
Message-ID: <20170213215107.7msmycclyslknpr2@sigill.intra.peff.net>
References: <CAM_JFCwYAKCWrHqCtcwid27V1HvhuSmp4QpbNpgyMzrzWUNYog@mail.gmail.com>
 <xmqqa89pevw0.fsf@gitster.mtv.corp.google.com>
 <CAM_JFCwN+o54mJ1XJ3rSKnXgPx3wt_i=fd8ZSGpcL-fSegQ=Ow@mail.gmail.com>
 <20170213211653.x3huwmzprvmm3yxj@sigill.intra.peff.net>
 <xmqq37fhdc27.fsf@gitster.mtv.corp.google.com>
 <20170213212734.howisucqqhusbglc@sigill.intra.peff.net>
 <CAM_JFCzniePuqJTFOy-odLfuKcBjssh0zk3PFBsVcm6Ww6iW5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM_JFCzniePuqJTFOy-odLfuKcBjssh0zk3PFBsVcm6Ww6iW5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 01:43:45PM -0800, hIpPy wrote:

> With --name-status: I'm sorry if I nitpick here but I think the
> --name-status items should either be preceeded and followed by
> blank line OR not (as in oneline) but not just preceded (example
> below).

Yeah, I agree the output is a bit ugly.

I don't think there is a way to do what you want currently. The
--oneline code path has some internal magic that suppresses some of the
newlines.

I think it is a good goal that anything that can be expressed via one of
the regular formats (like --oneline) can be expressed via custom
formats. I don't know offhand how hard it would be to make this
particular case work. If somebody is interested in tackling this, they'd
probably need to dig around in pretty.c to see where the ONELINE code
path diverge from the USER_FORMAT one, and then figure out how a user
can specify that they want the ONELINE-ish semantics for their format.

-Peff
