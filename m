Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5DA201B0
	for <e@80x24.org>; Thu, 23 Feb 2017 01:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933112AbdBWBiY (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 20:38:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:60410 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932667AbdBWBiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 20:38:23 -0500
Received: (qmail 8443 invoked by uid 109); 23 Feb 2017 01:37:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 01:37:49 +0000
Received: (qmail 6045 invoked by uid 111); 23 Feb 2017 01:37:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Feb 2017 20:37:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2017 20:37:46 -0500
Date:   Wed, 22 Feb 2017 20:37:46 -0500
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] http: add an "auto" mode for http.emptyauth
Message-ID: <20170223013746.lturqad7lnehedb4@sigill.intra.peff.net>
References: <20170222233333.dx5lknw4fpopu5hy@sigill.intra.peff.net>
 <20170222234059.iajn2zuwzkzjxit2@sigill.intra.peff.net>
 <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b5778a7988ad4dfa9adfc8d312432189@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 01:16:33AM +0000, David Turner wrote:

> I don't know enough about how libcurl handles authentication to know whether 
> these patches are a good idea, but I have a minor comment anyway.

As somebody who is using non-Basic auth, can you apply these patches and
show us the output of:

   GIT_TRACE_CURL=1 \
   git ls-remote https://your-server 2>&1 >/dev/null |
   egrep '(Send|Recv) header: (GET|HTTP|Auth)'

(without http.emptyauth turned on, obviously).

> > +		 * But only do so when this is _not_ our initial
> > +		 * request, as we would not then yet know what
> > +		 * methods are available.
> > +		 */
> 
> Eliminate double-negative:
> 
> "But only do this when this is our second or subsequent request, 
> as by then we know what methods are available."

Yeah, that is clearer.

-Peff
