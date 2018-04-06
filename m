Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2A1F1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 22:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752563AbeDFWHj (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 18:07:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:56636 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752529AbeDFWHi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 18:07:38 -0400
Received: (qmail 30828 invoked by uid 109); 6 Apr 2018 22:07:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 22:07:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30383 invoked by uid 111); 6 Apr 2018 22:08:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 18:08:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 18:07:36 -0400
Date:   Fri, 6 Apr 2018 18:07:36 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Primrose <jprimros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: FREAD_READS_DIRECTORIES test fails for the wrong reasons
Message-ID: <20180406220736.GH7870@sigill.intra.peff.net>
References: <82c91eac-9dc4-834b-4648-3c4ba45af80d@gmail.com>
 <20180406193301.GA11450@sigill.intra.peff.net>
 <8ed8491f-9410-c509-5ef7-77638aa74038@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8ed8491f-9410-c509-5ef7-77638aa74038@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 06, 2018 at 05:57:15PM -0400, Jonathan Primrose wrote:

> > Oops. This is due to my 3adf9fdecf (configure.ac: loosen
> > FREAD_READS_DIRECTORIES test program, 2017-06-14).
> > 
> > Neither I nor the original tester noticed, because we're on Linux, which
> > needs that set.
> 
> I'm also running Linux, but somehow I ended up needing to check
> config.log and saw the error. I don't remember why I had to check.
> (I've been fixing the problem locally for the last few releases,
> figuring someone else would notice. I also remove the 'rm configure'
> from the distclean target in Makefile, just in case I decide to
> rebuild later.)

I think you'll find that most of the developers don't actually use
autoconf themselves, so bugs tend to go unnoticed there for a while.
(The failure case for setting this flag accidentally is not bad, either;
it just incurs an extra fstat).

-Peff
