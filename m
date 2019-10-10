Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 477C61F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 23:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfJJXGd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 19:06:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:45020 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726321AbfJJXGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 19:06:33 -0400
Received: (qmail 10565 invoked by uid 109); 10 Oct 2019 23:06:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Oct 2019 23:06:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28445 invoked by uid 111); 10 Oct 2019 23:09:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Oct 2019 19:09:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Oct 2019 19:06:32 -0400
From:   Jeff King <peff@peff.net>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled
 for DMARC purposes
Message-ID: <20191010230631.GB19475@sigill.intra.peff.net>
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
 <20191010225405.GA19475@sigill.intra.peff.net>
 <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 11, 2019 at 10:01:23AM +1100, Andrew Donnellan wrote:

> > This might provide an alternate solution (or vice versa). I kind of like
> > this one better in that it doesn't require the sender to do anything
> > differently (but it may be less robust, as it assumes the receiver
> > reliably de-mangling).
> 
> Yep, it's less robust - but OTOH there's always a long tail of users stuck
> on old versions of git for whatever reason and having some logic to detect
> DMARC munging may thus still be useful.

I think the two features would work together nicely out of the box: if
somebody has an in-body from, we'd respect that before looking at email
headers anyway. So senders who do the extra work will be covered, and
checking other email headers would just improve the fallback case.

-Peff
