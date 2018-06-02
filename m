Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243391F491
	for <e@80x24.org>; Sat,  2 Jun 2018 08:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750927AbeFBIKv (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 04:10:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:60008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750869AbeFBIKr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 04:10:47 -0400
Received: (qmail 1871 invoked by uid 109); 2 Jun 2018 08:10:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Jun 2018 08:10:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30968 invoked by uid 111); 2 Jun 2018 08:10:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 02 Jun 2018 04:10:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2018 04:10:45 -0400
Date:   Sat, 2 Jun 2018 04:10:45 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
Message-ID: <20180602081044.GA699@sigill.intra.peff.net>
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
 <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
 <87fu2qbojy.fsf@evledraar.gmail.com>
 <20180517133601.GC17548@sigill.intra.peff.net>
 <1527174618.10589.4.camel@gmail.com>
 <20180524192214.GA21535@sigill.intra.peff.net>
 <20180524193105.GB21535@sigill.intra.peff.net>
 <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
 <20180525024002.GA1998@sigill.intra.peff.net>
 <CACsJy8AfCiJad8GD2xAWFp7WVFXZtZrqtE91awe0VS5Ni71rSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AfCiJad8GD2xAWFp7WVFXZtZrqtE91awe0VS5Ni71rSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 02, 2018 at 06:46:31AM +0200, Duy Nguyen wrote:

> >         if (used_deprecated_reflog_option) {
> > -               warning("the '-l' alias for '--create-reflog' is deprecated;");
> > -               warning("it will be removed in a future version of Git");
> > +               if (list) {
> > +                       warning("the '-l' option is an alias for '--create-reflog' and");
> > +                       warning("has no effect in list mode. This option will soon be");
> > +                       warning("removed and you should omit it (or use '--list' instead).");
> > +               } else {
> > +                       warning("the '-l' alias for '--create-reflog' is deprecated;");
> > +                       warning("it will be removed in a future version of Git");
> > +               }
> 
> This is already in 'next', but could you do a follow up patch to mark
> these strings for translation? While at there, concatenating them into
> full sentences would also help translators.

Already being discussed elsewhere on the thread; we're hoping for a
warning() that will auto-prefix each one.

That said, I think I'm going to re-roll this in the direction discussed
elsewhere in the thread (skipping the warning for list-mode).

-Peff
