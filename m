Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 034F31F404
	for <e@80x24.org>; Fri, 19 Jan 2018 20:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932362AbeASUM7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 15:12:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:49950 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932219AbeASUM6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 15:12:58 -0500
Received: (qmail 21214 invoked by uid 109); 19 Jan 2018 20:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jan 2018 20:12:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24051 invoked by uid 111); 19 Jan 2018 20:13:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jan 2018 15:13:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jan 2018 15:12:56 -0500
Date:   Fri, 19 Jan 2018 15:12:56 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v2 03/18] ref-filter: make valid_atom as function
 parameter
Message-ID: <20180119201256.GB10197@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc529-fae54bd6-e595-44fa-9f9a-c44cb3a5a1a8-000000@eu-west-1.amazonses.com>
 <20180115214208.GD4778@sigill.intra.peff.net>
 <CAL21Bm=+uPrKECcCq2_rfJRuCpsOjZ41NfiyY3d1UA0b8YKj1w@mail.gmail.com>
 <20180117214354.GA13128@sigill.intra.peff.net>
 <CAP8UFD0PtOqX5c4ovRbYDWejQ55iUwtnPv-zGXS2GFAajhXqtA@mail.gmail.com>
 <CAL21BmnKd0qamJWJbrAzg_ZX1GkhCTPO_5zOiFNMBeF-xjDTiQ@mail.gmail.com>
 <CAP8UFD1dcwEA9z+oQKFV=aFoKn73mtP4qkLGovW2XTu6N=N4dA@mail.gmail.com>
 <20180119172353.GA5752@sigill.intra.peff.net>
 <xmqq4lnhr8gy.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4lnhr8gy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 10:47:57AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I also think %(deltabase) does make sense for anything that points to an
> > object. I suspect it's not all that _useful_ for for-each-ref, but that
> > doesn't mean we can't return the sensible thing if somebody asks for it.
> 
> This may not be a new issue (or any issue at all), but is the
> ability to learn deltabase make any sense in the first place?
> 
> What should the code do when an object has three copies in the
> repo, i.e. one as a base object (or a loose one), another as a
> delta against an object, and the third one as a delta against
> a different object?

This was a known issue when I introduced %(deltabase). The documentation
explicitly calls this out and makes no promises about which copy we
describe.

The %(objectsize:disk) atom has the same issue, too. See the CAVEATS
section of git-cat-file(1).

-Peff
