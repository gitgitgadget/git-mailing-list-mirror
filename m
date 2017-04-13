Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 399B320960
	for <e@80x24.org>; Thu, 13 Apr 2017 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751332AbdDMVXr (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 17:23:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:33239 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751139AbdDMVXp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 17:23:45 -0400
Received: (qmail 11409 invoked by uid 109); 13 Apr 2017 21:23:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 21:23:45 +0000
Received: (qmail 27755 invoked by uid 111); 13 Apr 2017 21:24:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 17:24:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 17:23:41 -0400
Date:   Thu, 13 Apr 2017 17:23:41 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <dturner@twosigma.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] xgethostname: handle long hostnames
Message-ID: <20170413212341.cxsd3jzemuu6ec7h@sigill.intra.peff.net>
References: <20170413192335.20679-1-dturner@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170413192335.20679-1-dturner@twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 03:23:35PM -0400, David Turner wrote:

> If the full hostname doesn't fit in the buffer supplied to
> gethostname, POSIX does not specify whether the buffer will be
> null-terminated

Wow, TIL. What an utterly terrible and error-prone interface (I always
just assumed we'd get ENAMETOOLONG, which is what glibc does).

> so to be safe, we should do it ourselves.  Introduce
> new function, xgethostname, which ensures that there is always a \0
> at the end of the buffer.

Your patch looks good to me.

-Peff
