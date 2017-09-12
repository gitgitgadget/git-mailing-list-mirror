Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A35771FADE
	for <e@80x24.org>; Tue, 12 Sep 2017 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbdILPd6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Sep 2017 11:33:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:35706 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751423AbdILPd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2017 11:33:57 -0400
Received: (qmail 21534 invoked by uid 109); 12 Sep 2017 15:33:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 15:33:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5437 invoked by uid 111); 12 Sep 2017 15:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Sep 2017 11:34:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Sep 2017 11:33:55 -0400
Date:   Tue, 12 Sep 2017 11:33:55 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Buffered value should be shown when requesting username for
 remote authentication
Message-ID: <20170912153355.mbsybuy3kqtfvmtd@sigill.intra.peff.net>
References: <1505220449.27800.23.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505220449.27800.23.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 12, 2017 at 06:17:29PM +0530, Kaartic Sivaraam wrote:

> I noted a little issue with the interaction to a remote git repository.
> The issue occurs when the network used for remote communication is a
> bit sluggish. The main issue is illustrated by the following shell
> interaction,
> 
>     $ git push -u fork 
>     sivaraamUsername for '    https://github.com'    : sivaraam
>     Password for '    https://sivaraamsivaraam@github.com':     
> 
>     It's a little odd that the (buffered) input found before the request
>     for 'Username' is also appended to the input found after the request.
>     This might not be obvious to the user and he has to retype the
>     'Username' in the next try.

If I understand right, you typed "sivaraam" once, then the network
lagged, then you typed "sivaraam" again.

That isn't really something that Git can fix reliably. Reading those
characters and echoing them back to the terminal is handled by your
terminal driver (and potentially other things like ssh).  Git may have
received "sivaraamsivaraam" all at once, depending on where the lag is.

-Peff
