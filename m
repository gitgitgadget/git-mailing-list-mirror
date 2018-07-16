Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6431E1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbeGPWE3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:04:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:48602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728413AbeGPWE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:04:29 -0400
Received: (qmail 17140 invoked by uid 109); 16 Jul 2018 21:35:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:35:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15995 invoked by uid 111); 16 Jul 2018 21:35:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:35:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:35:11 -0400
Date:   Mon, 16 Jul 2018 17:35:11 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Henning Schild <henning.schild@siemens.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 7/9] gpg-interface: introduce new config to select per
 gpg format program
Message-ID: <20180716213510.GJ25189@sigill.intra.peff.net>
References: <cover.1531208187.git.henning.schild@siemens.com>
 <4905c1907a866c0fd1a4dac978dd6ca3e468ac43.1531208187.git.henning.schild@siemens.com>
 <20180710165412.GE23624@sigill.intra.peff.net>
 <20180710165638.GF23624@sigill.intra.peff.net>
 <20180714181347.GE1042117@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180714181347.GE1042117@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 14, 2018 at 06:13:47PM +0000, brian m. carlson wrote:

> On Tue, Jul 10, 2018 at 12:56:38PM -0400, Jeff King wrote:
> > On Tue, Jul 10, 2018 at 12:54:13PM -0400, Jeff King wrote:
> > 
> > > Should we allow:
> > > 
> > >   [gpg "OpenPGP"]
> > >   program = whatever
> > > 
> > > given that we allow:
> > > 
> > >   [gpg]
> > >   format = OpenPGP
> > > 
> > > ? I think just using strcasecmp() here would be sufficient. But I wonder
> > > if it is a symptom of using the wrong tool (subsections) when we don't
> > > need it.
> > 
> > I did just read the discussion in response to v1, where everybody told
> > you the opposite. ;)
> > 
> > So I guess my question/points are more for brian and Junio.
> 
> I'm okay with us forcing "openpgp".  That seems sane enough for now, and
> if people scream loudly, we can loosen it.

Well, I specifically meant "are you sure subsections like this are a
good idea". But it seems like people think so?

If so, then I think the best route is just dictating that yes,
gpg.format is case-sensitive because it is referencing
gpg.<format>.program, which is itself case-sensitive (and "openpgp" is
the right spelling).

-Peff
