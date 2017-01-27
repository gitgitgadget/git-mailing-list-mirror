Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B26D91F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750886AbdA0SZD (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:25:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:45995 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbdA0SY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:24:56 -0500
Received: (qmail 14468 invoked by uid 109); 27 Jan 2017 17:58:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 17:58:10 +0000
Received: (qmail 20946 invoked by uid 111); 27 Jan 2017 17:58:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 27 Jan 2017 12:58:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 27 Jan 2017 12:58:07 -0500
Date:   Fri, 27 Jan 2017 12:58:07 -0500
From:   Jeff King <peff@peff.net>
To:     Lukas Fleischer <lfleischer@lfos.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/12] receive-pack: treat namespace .have lines like
 alternates
Message-ID: <20170127175807.4tjxpenu2gk77dhv@sigill.intra.peff.net>
References: <20170124003729.j4ygjcgypdq7hceg@sigill.intra.peff.net>
 <20170124004805.nu3w47isrb4bxgi5@sigill.intra.peff.net>
 <xmqqa8aec40a.fsf@gitster.mtv.corp.google.com>
 <148553912610.7898.1319453517642036857@typhoon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148553912610.7898.1319453517642036857@typhoon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2017 at 06:45:26PM +0100, Lukas Fleischer wrote:

> > This is an unrelated tangent, but there may want to be a knob to
> > make the code return here without even showing, to make the
> > advertisement even smaller and also to stop miniscule information
> > leakage?  If the namespaced multiple projects are totally unrelated
> > (i.e. "My sysadmin gave me a write access only to this single
> > directory, so I am using the namespace feature to host these three
> > projects that have nothing to do with each other"), showing objects
> > of other namespaces will buy us nothing and the user is better off
> > without this code showing these refs as ".have".
> 
> I think this is already possible using receive.hideRefs (which causes
> the ref_is_hidden() branch above to return if applicable).
> 
> Having support for suppressing .have lines corresponding to different
> namespaces was actually the reason I implemented 78a766ab6 (hideRefs:
> add support for matching full refs, 2015-11-03). We have been using
> namespaces for hosting the package Git repositories of the Arch Linux
> User Repository [1] with a shared object storage for several months now.
> See [2] for *some* technical details on how things are implemented; the
> last section explains how the hideRefs mechanism can be used to limit
> ref advertisement to the "active" namespace.

Thanks for the pointers. I think a "turn off namespace .have lines"
option would be easier for some cases, but what you've implemented is
much more flexible. So if people using namespaces are happy with it, I
don't see any need to add another way to do the same thing.

-Peff
