Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDC511F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 13:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbeGKNvG (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 09:51:06 -0400
Received: from lizzard.sbs.de ([194.138.37.39]:46712 "EHLO lizzard.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388122AbeGKNvG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 09:51:06 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id w6BDkKu9025682
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jul 2018 15:46:20 +0200
Received: from md1pvb1c.ad001.siemens.net (md1pvb1c.ad001.siemens.net [139.25.68.40])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id w6BDkK0C004057;
        Wed, 11 Jul 2018 15:46:20 +0200
Date:   Wed, 11 Jul 2018 15:46:19 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     <git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        Martin =?UTF-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 6/9] gpg-interface: do not hardcode the key string
 len anymore
Message-ID: <20180711154619.7b574dff@md1pvb1c.ad001.siemens.net>
In-Reply-To: <20180711123425.GB23835@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
        <7300c85a1c6d484c781cc80b307b5e7f085ac226.1531208187.git.henning.schild@siemens.com>
        <20180710154931.GA23624@sigill.intra.peff.net>
        <20180711105459.57ed99cc@md1pvb1c.ad001.siemens.net>
        <20180711123425.GB23835@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Wed, 11 Jul 2018 08:34:25 -0400
schrieb Jeff King <peff@peff.net>:

> On Wed, Jul 11, 2018 at 10:54:59AM +0200, Henning Schild wrote:
> 
> > > In the general case you need:
> > > 
> > >   found = *next ? next + 1 : next;
> > > 
> > > or similar. In this case, you can actually do:
> > > 
> > >   found = next;
> > > 
> > > because we know that it's OK to search over the literal space
> > > again. But that's pretty subtle, so we're probably better off
> > > just doing the conditional above.
> > > 
> > > (And yes, looking at the existing code, I think it's even worse,
> > > as there does not seem to be a guarantee that we even have 16
> > > characters in the string).  
> > 
> > The existing code works only on expected output and the same is true
> > for the version after this patch. Making the parser robust against
> > random input would imho be a sort of cleanup patch on top of my
> > series. .. or before, in which case i would become responsible for
> > making sure that still works after my modification.
> > This argument is twofold. I do not really want to fix that as well
> > and it might be a good idea to separate concerns anyways.  
> 
> I think it's worth addressing in the near term, if only because this
> kind of off-by-one is quite subtle, and I don't want to forget to deal
> with it. Whether that happens as part of this patch, or as a cleanup
> before or after, I'm not picky. :)

I get that and if anyone is willing to write that code, i will base my
patches on it. What i want to avoid is taking responsibility for
problems i did not introduce, just because i happen to work on that
code at the moment. Keeping track of that (not forgetting) is also not
for the random contributor like myself.

Henning

> -Peff

