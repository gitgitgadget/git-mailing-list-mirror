Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB4481FAFB
	for <e@80x24.org>; Tue,  4 Apr 2017 02:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdDDCdd (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Apr 2017 22:33:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:56314 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbdDDCdd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2017 22:33:33 -0400
Received: (qmail 18399 invoked by uid 109); 4 Apr 2017 02:33:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Apr 2017 02:33:33 +0000
Received: (qmail 3217 invoked by uid 111); 4 Apr 2017 02:33:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Apr 2017 22:33:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Apr 2017 22:33:31 -0400
Date:   Mon, 3 Apr 2017 22:33:31 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     David Turner <dturner@twosigma.com>, git@vger.kernel.org,
        tboegi@web.de
Subject: Re: [PATCH v5] http.postbuffer: allow full range of ssize_t values
Message-ID: <20170404023331.dqdndazmmkb24uvt@sigill.intra.peff.net>
References: <20170403235308.30102-1-dturner@twosigma.com>
 <20170404013210.GD8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170404013210.GD8741@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 03, 2017 at 06:32:10PM -0700, Jonathan Nieder wrote:

> David Turner wrote:
> 
> > This means that we need to use CURLOPT_POSTFIELDSIZE_LARGE to set the
> > buffer size.
> 
> Neat.
> 
> For completeness, it's useful to know this was added in curl 7.11.1,
> which is old enough for us to be able to count on users having it (in
> fact it was released >10 years ago).

We have a number of LIBCURL_VERSION_NUM checks that are older than that.
I'm totally OK with declaring a 13-year old version of curl as obsolete,
but we should probably consider dropping some of those ancient ifdefs. I
wouldn't be surprised if some of them are buggy or even fail to compile
at this point.

-Peff
