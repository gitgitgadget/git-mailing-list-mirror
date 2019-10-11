Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7CE1F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 15:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbfJKPvx (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 11:51:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:45800 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728086AbfJKPvx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 11:51:53 -0400
Received: (qmail 15461 invoked by uid 109); 11 Oct 2019 15:51:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 11 Oct 2019 15:51:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2326 invoked by uid 111); 11 Oct 2019 15:54:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2019 11:54:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Oct 2019 11:51:51 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Andrew Donnellan <ajd@linux.ibm.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christian Schoenebeck <qemu_oss@crudebyte.com>,
        patchwork@lists.ozlabs.org, Eric Blake <eblake@redhat.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] parser: Unmangle From: headers that have been mangled
 for DMARC purposes
Message-ID: <20191011155151.GA19395@sigill.intra.peff.net>
References: <20191010062047.21549-1-ajd@linux.ibm.com>
 <20191010194132.GA191800@google.com>
 <20191010225405.GA19475@sigill.intra.peff.net>
 <06541640-7eca-bc40-5c4b-9aa682d774a8@linux.ibm.com>
 <87pnj3thja.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pnj3thja.fsf@dja-thinkpad.axtens.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 12, 2019 at 02:42:49AM +1100, Daniel Axtens wrote:

> >> where a possible solution was to get senders to use in-body From
> >> headers even when sending their own patches.
> [...]
> I'm not sure this solution is correct.
> 
> If I take a patch from Andrew, backport it, and send to the list, Andrew
> will be listed in the in-body From. However, he shouldn't be the sender
> from the Patchwork point of view: he shouldn't get the patch status
> notification emails - I should. We don't want to spam an original author
> if their patch is backported to several different releases, or picked up
> and resent in someone else's series, etc etc. So unless I've
> misunderstood something, we can't rely on the in-body from matching
> Patchwork's understanding of the sender.

Yeah, it may be that patchwork and git have two different priorities
here. From my perspective, the problem is getting the patch into a git
repo with the right author name. But patchwork may want to make the
distinction between author and sender.

-Peff
