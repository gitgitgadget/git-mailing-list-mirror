Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E3EC21F859
	for <e@80x24.org>; Tue,  6 Sep 2016 07:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932140AbcIFHPL (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 03:15:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:38669 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753926AbcIFHPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 03:15:10 -0400
Received: (qmail 13892 invoked by uid 109); 6 Sep 2016 07:15:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 07:15:09 +0000
Received: (qmail 25138 invoked by uid 111); 6 Sep 2016 07:15:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 06 Sep 2016 03:15:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Sep 2016 03:15:07 -0400
Date:   Tue, 6 Sep 2016 03:15:07 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t9903: fix broken && chain
Message-ID: <20160906071507.pmbpsjoo4me3o6za@sigill.intra.peff.net>
References: <61de943c-df93-58e9-ca48-c469a71a1d43@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61de943c-df93-58e9-ca48-c469a71a1d43@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 05, 2016 at 09:00:47PM +0200, Johannes Sixt wrote:

> We might wonder why our && chain check does not catch this case:
> The && chain check uses a strange exit code with the expectation that
> the second or later part of a broken && chain would not exit with this
> particular code.
> 
> This expectation does not work in this case because __git_ps1, being
> the first command in the second part of the broken && chain, records
> the current exit code, does its work, and finally returns to the caller
> with the recorded exit code. This fools our && chain check.

Wow. Good find. Patch itself is obviously correct.

-Peff
