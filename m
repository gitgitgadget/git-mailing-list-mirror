Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68CD9202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 08:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbdIHIdL (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 04:33:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:60700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754328AbdIHIdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 04:33:08 -0400
Received: (qmail 26890 invoked by uid 109); 8 Sep 2017 08:33:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 08:33:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6959 invoked by uid 111); 8 Sep 2017 08:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 04:33:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 04:33:06 -0400
Date:   Fri, 8 Sep 2017 04:33:06 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 02/10] struct ref_transaction: add a place for backends
 to store data
Message-ID: <20170908083305.hjcsa4ejlujwvj4h@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <5b8c8f9ab0ccd5f85eb43a7a1535af89b0af85e3.1503993268.git.mhagger@alum.mit.edu>
 <20170908070205.3hwa7tjgok7kgknc@sigill.intra.peff.net>
 <6c4cf1eb-7991-1a39-a298-7839872ed3f5@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6c4cf1eb-7991-1a39-a298-7839872ed3f5@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 08, 2017 at 10:19:48AM +0200, Michael Haggerty wrote:

> > This is just one pointer. Once we start layering ref backends (and
> > already we're moving towards a "files" layer which sits atop loose and
> > packed backends, right?), how do we avoid backends stomping on each
> > other (or worse, dereferencing somebody else's data as their own
> > struct)?
> 
> My conception is that layered backends would be separated as much as
> possible, and if the "top" layer needs to modify the "bottom" layer, it
> would do so via a separate reference transaction on the bottom layer.
> That transaction would be owned by the bottom layer, which would be able
> to use the corresponding `backend_data` pointers however it likes.
>
> You can see an example of this construct in patch 08.

OK, that makes sense.

-Peff
