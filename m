Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C2420756
	for <e@80x24.org>; Fri, 20 Jan 2017 14:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752574AbdATOcs (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 09:32:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:42153 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752340AbdATOco (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 09:32:44 -0500
Received: (qmail 18050 invoked by uid 109); 20 Jan 2017 14:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 14:32:32 +0000
Received: (qmail 3418 invoked by uid 111); 20 Jan 2017 14:33:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Jan 2017 09:33:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Jan 2017 09:32:30 -0500
Date:   Fri, 20 Jan 2017 09:32:30 -0500
From:   Jeff King <peff@peff.net>
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC 0/2] grep: make output consistent with revision syntax
Message-ID: <20170120143230.t4wwzp3ubigwupgq@sigill.intra.peff.net>
References: <20170119150347.3484-1-stefanha@redhat.com>
 <20170119165958.xtotlvdta7udqllb@sigill.intra.peff.net>
 <20170120141832.GE17499@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170120141832.GE17499@stefanha-x1.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 02:18:32PM +0000, Stefan Hajnoczi wrote:

> > Are there cases you know that aren't covered by your patches?
> 
> From Patch 2/2:
> 
>   This patch does not cope with @{1979-02-26 18:30:00} syntax and treats
>   it as a path because it contains colons.
> 
> If we use obj->type instead of re-parsing the name then that problem is
> solved.

Ah, right. I somehow totally missed that, and blindly assumed your colon
search was only at the end. But of course that wouldn't work at all (it
would miss "v2.9.3:t").

So yes, definitely it should be checking the object type.

-Peff
