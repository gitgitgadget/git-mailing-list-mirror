Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC7A20966
	for <e@80x24.org>; Sat,  1 Apr 2017 08:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750802AbdDAINC (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 04:13:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:55317 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750724AbdDAIM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 04:12:58 -0400
Received: (qmail 29700 invoked by uid 109); 1 Apr 2017 08:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 08:12:58 +0000
Received: (qmail 16264 invoked by uid 111); 1 Apr 2017 08:13:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Apr 2017 04:13:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Apr 2017 04:12:56 -0400
Date:   Sat, 1 Apr 2017 04:12:56 -0400
From:   Jeff King <peff@peff.net>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
Message-ID: <20170401081256.fupby6oo5yf7wqdz@sigill.intra.peff.net>
References: <cover.1483354746.git.git@drmicha.warpmail.net>
 <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
 <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
 <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
 <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
 <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
 <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
 <20170121142048.ygbwc65un4whhtwn@sigill.intra.peff.net>
 <76f61fea-3d24-ec55-0cbc-64ee3d030dcf@grubix.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76f61fea-3d24-ec55-0cbc-64ee3d030dcf@grubix.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 30, 2017 at 05:18:59PM +0200, Michael J Gruber wrote:

> Jeff King venit, vidit, dixit 21.01.2017 15:20:
> > On Wed, Jan 11, 2017 at 10:08:46AM -0800, Junio C Hamano wrote:
> > 
> >> Jeff King <peff@peff.net> writes:
> >>
> >>> Yes, I would think die_errno() is a no-brainer for translation, since
> >>> the strerror() will be translated.
> >>>
> >>>>     apply.c:                die(_("internal error"));
> >>>>
> >>>> That is funny, too. I think we should substitute that with
> >>>>
> >>>>     die("BUG: untranslated, but what went wrong instead")
> >>>
> >>> Yep. We did not consistently use "BUG:" in the early days. I would say
> >>> that "BUG" lines do not need to be translated. The point is that nobody
> >>> should ever see them, so it seems like there is little point in giving
> >>> extra work to translators.
> >>
> >> In addition, "BUG: " is relatively recent introduction to our
> >> codebase.  Perhaps having a separate BUG(<string>) function help the
> >> distinction further?
> > 
> > Yes, I think so. I have often been tempted to dump core on BUGs for
> > further analysis. You can do that by string-matching "BUG:" from the
> > beginning of a die message, but it's kind of gross. :)
> > 
> > -Peff
> 
> I read back the whole thread, and I'm still not sure if there's
> consensus and how to go forward. Should we let the topic die? I don't
> care too much personally, I just thought the mixed tranlations look
> "unprofessional".

I don't have a strong preference either way. I also don't care
personally about the output (as I do not localize at all). My main
concern was keeping the code simple for developers. But if consistent
translation is important for people in other languages, I'm OK with
whatever we need to do.

-Peff
