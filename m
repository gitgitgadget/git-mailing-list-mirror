Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620C11F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 14:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbdAUOUy (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 09:20:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:42606 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751025AbdAUOUv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 09:20:51 -0500
Received: (qmail 2486 invoked by uid 109); 21 Jan 2017 14:20:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 14:20:50 +0000
Received: (qmail 22482 invoked by uid 111); 21 Jan 2017 14:21:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Jan 2017 09:21:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Jan 2017 09:20:48 -0500
Date:   Sat, 21 Jan 2017 09:20:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170121142048.ygbwc65un4whhtwn@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
 <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 10:08:46AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yes, I would think die_errno() is a no-brainer for translation, since
> > the strerror() will be translated.
> >
> >>     apply.c:                die(_("internal error"));
> >> 
> >> That is funny, too. I think we should substitute that with
> >> 
> >>     die("BUG: untranslated, but what went wrong instead")
> >
> > Yep. We did not consistently use "BUG:" in the early days. I would say
> > that "BUG" lines do not need to be translated. The point is that nobody
> > should ever see them, so it seems like there is little point in giving
> > extra work to translators.
> 
> In addition, "BUG: " is relatively recent introduction to our
> codebase.  Perhaps having a separate BUG(<string>) function help the
> distinction further?

Yes, I think so. I have often been tempted to dump core on BUGs for
further analysis. You can do that by string-matching "BUG:" from the
beginning of a die message, but it's kind of gross. :)

-Peff
