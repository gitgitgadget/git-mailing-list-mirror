Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 475AB2047F
	for <e@80x24.org>; Tue, 19 Sep 2017 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbdISVqM (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 17:46:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751370AbdISVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 17:46:11 -0400
Received: (qmail 17120 invoked by uid 109); 19 Sep 2017 21:46:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 21:46:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8647 invoked by uid 111); 19 Sep 2017 21:46:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Sep 2017 17:46:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Sep 2017 17:46:09 -0400
Date:   Tue, 19 Sep 2017 17:46:09 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH for jk/leak-checkers] git-compat-util: make UNLEAK less
 error-prone
Message-ID: <20170919214609.beair2zraemibai2@sigill.intra.peff.net>
References: <20170919210300.cbrdjqor6xuwd7bs@sigill.intra.peff.net>
 <20170919213456.13983-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170919213456.13983-1-jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 02:34:56PM -0700, Jonathan Tan wrote:

> Commit 0e5bba5 ("add UNLEAK annotation for reducing leak false
> positives", 2017-09-08) introduced an UNLEAK macro to be used as
> "UNLEAK(var);", but its existing definitions make it possible to be
> invoked as "UNLEAK(var)" (without the trailing semicolon) too.
> 
> Therefore, modify its definitions to cause a compile-time error if
> invoked without the trailing semicolon.

The patch itself looks good, but I think your commit message dances
around the real motivation: some parsers may complain about doubled
semicolons, or semicolons without an associated line of code (which is
really just a doubled semicolon, too, I guess).

-Peff
