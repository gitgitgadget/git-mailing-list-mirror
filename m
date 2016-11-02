Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E57920193
	for <e@80x24.org>; Wed,  2 Nov 2016 23:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757675AbcKBXI5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Nov 2016 19:08:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:37749 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756495AbcKBXI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2016 19:08:56 -0400
Received: (qmail 26017 invoked by uid 109); 2 Nov 2016 23:08:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 23:08:55 +0000
Received: (qmail 7487 invoked by uid 111); 2 Nov 2016 23:09:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 02 Nov 2016 19:09:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2016 19:08:53 -0400
Date:   Wed, 2 Nov 2016 19:08:53 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] transport: add core.allowProtocol config option
Message-ID: <20161102230853.3xdk6ksnzzote5ud@sigill.intra.peff.net>
References: <1478125247-62372-1-git-send-email-bmwill@google.com>
 <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161102230538.jx3jwa4hqgrrltno@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2016 at 07:05:39PM -0400, Jeff King wrote:

> > +core.allowProtocol::
> > +	Provide a colon-separated list of protocols which are allowed to be
> > +	used with fetch/push/clone. This is useful to restrict recursive
> > +	submodule initialization from an untrusted repository. Any protocol not
> > +	mentioned will be disallowed (i.e., this is a whitelist, not a
> > +	blacklist). If the variable is not set at all, all protocols are
> > +	enabled. If the `GIT_ALLOW_PROTOCOL` enviornment variable is set, it is
> > +	used as the protocol whitelist instead of this config option.
> 
> The "not set at all, all protocols are enabled" bit is not quite
> correct, is it? It is true for a top-level fetch, but not for submodule
> recursion (and especially since you are talking about submodule
> recursion immediately before, it is rather confusing).

Heh, just saw that you copied this straight from the discussion of
GIT_ALLOW_PROTOCOL. What idiot wrote the original? :)

It might be worth fixing both places (or possibly just fixing the
original and phrasing this one as "If GIT_ALLOW_PROTOCOL is not set, use
this as the default value; see git(1) for details").

-Peff
