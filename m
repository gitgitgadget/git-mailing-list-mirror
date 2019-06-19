Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4945A1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 18:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfFSSmR (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 14:42:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:44374 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726109AbfFSSmR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 14:42:17 -0400
Received: (qmail 11580 invoked by uid 109); 19 Jun 2019 18:39:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 18:39:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8175 invoked by uid 111); 19 Jun 2019 18:43:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 14:43:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 14:42:14 -0400
Date:   Wed, 19 Jun 2019 14:42:14 -0400
From:   Jeff King <peff@peff.net>
To:     "LI, BO XUAN" <liboxuan@connect.hku.hk>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] userdiff: ship built-in driver config file
Message-ID: <20190619184214.GB28145@sigill.intra.peff.net>
References: <20190617165450.81916-1-liboxuan@connect.hku.hk>
 <20190619035857.GB515@sigill.intra.peff.net>
 <CALM0=-=4b4j1brRN=Jnq4N+f+_vJXrL-JBAOxaLw0FgugNqX5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALM0=-=4b4j1brRN=Jnq4N+f+_vJXrL-JBAOxaLw0FgugNqX5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 11:32:19PM +0800, LI, BO XUAN wrote:

> >   [diff "foo"]
> >   xfuncname = "the pattern starts here...
> >   and continues through newlines!"
> >
> 
> If I recall correctly, the above version wouldn't work, but the
> following version would:
> 
> [diff "foo"]
>     xfuncname = "The pattern starts here..."
> "and continues here! But the indentation looks ugly,"
> "and we lose the ability to add comments inline (within pattern)"

I don't think that works for our config files either (it does in C, of
course).

> Actually, at the very beginning, I was imaging some syntax like this:
> 
> [diff "foo"]
>     xfuncname = "The pattern starts here..."
>     ; using '+=' will continue the pattern above
>     xfuncname += "and continues here!"
>     ; a '=' symbol will start a new pattern
>     xfuncname = "This is another pattern.."
>     xfuncname += "and remember, last one always wins"
> 
> The existing config parser does not support "+=" though, which is a
> nice feature to have in my opinion. Maybe there is a reason?

There's no particular reason that feature isn't there, but in general
we've been very hesitant to add syntactic changes to the config files,
since there are many parsers in the wild. In general, today's files are
compatible with ones from 2005.

-Peff
