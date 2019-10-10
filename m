Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A0271F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfJJWyH (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 18:54:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:44962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726358AbfJJWyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 18:54:07 -0400
Received: (qmail 10426 invoked by uid 109); 10 Oct 2019 22:54:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Oct 2019 22:54:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28319 invoked by uid 111); 10 Oct 2019 22:57:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Oct 2019 18:57:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Oct 2019 18:54:06 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>, patchwork@lists.ozlabs.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Eric Blake <eblake@redhat.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled
 for DMARC purposes
Message-ID: <20191010225405.GA19475@sigill.intra.peff.net>
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191010194132.GA191800@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 10, 2019 at 12:41:32PM -0700, Jonathan Nieder wrote:

> > Add support for using the X-Original-Sender or Reply-To headers, as used by
> > Google Groups and Mailman respectively, to unmangle the From header when
> > necessary.
> [...]
> Interesting!  I'm cc-ing the Git mailing list in case "git am" might
> wnat to learn the same support.

Neat. There was discussion on a similar issue recently in:

  https://public-inbox.org/git/305577c2-709a-b632-4056-6582771176ac@redhat.com/

where a possible solution was to get senders to use in-body From
headers even when sending their own patches.

This might provide an alternate solution (or vice versa). I kind of like
this one better in that it doesn't require the sender to do anything
differently (but it may be less robust, as it assumes the receiver
reliably de-mangling).

-Peff
