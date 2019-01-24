Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05CC5211B5
	for <e@80x24.org>; Thu, 24 Jan 2019 21:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfAXVtz (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:49:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726173AbfAXVtz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:49:55 -0500
Received: (qmail 16629 invoked by uid 109); 24 Jan 2019 21:49:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 21:49:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 460 invoked by uid 111); 24 Jan 2019 21:49:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 16:49:59 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 16:49:53 -0500
Date:   Thu, 24 Jan 2019 16:49:53 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Sven van Haastregt <svenvh@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-submodule.sh: shorten submodule SHA-1s using
 rev-parse
Message-ID: <20190124214953.GA19668@sigill.intra.peff.net>
References: <20190120204653.3224-1-svenvh@gmail.com>
 <nycvar.QRO.7.76.6.1901221623370.41@tvgsbejvaqbjf.bet>
 <xmqqbm48fnl0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbm48fnl0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 22, 2019 at 12:23:55PM -0800, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> +		sha1_abbr_src=$(GIT_DIR="$name/.git" git rev-parse --short $sha1_src)
> >
> > How about `git -C "$name" rev-parse --short`? That would less likely run
> > over 80 columns/line, either.
> 
> That would be a separate patch, either as a preliminary or a
> follow-up.  The existing code has too many of the same construct.

It's also not the same; if $GIT_DIR is already set in the environment,
that will override auto-discovery done after the chdir() triggered by
"-C". It would need to be "git --git-dir".

Sincerely,
Somebody who has been bit by the distinction many times
