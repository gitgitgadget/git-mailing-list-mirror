Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85AF62022A
	for <e@80x24.org>; Wed, 26 Oct 2016 20:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935106AbcJZURZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:17:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:34505 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932948AbcJZURY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:17:24 -0400
Received: (qmail 30886 invoked by uid 109); 26 Oct 2016 20:17:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 20:17:23 +0000
Received: (qmail 13778 invoked by uid 111); 26 Oct 2016 20:17:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 16:17:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 16:17:21 -0400
Date:   Wed, 26 Oct 2016 16:17:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 2/3] sha1_file: open window into packfiles with
 O_CLOEXEC
Message-ID: <20161026201721.2pw4slsuyhxhcwxj@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1610251327050.3264@virtualbox>
 <20161025181621.4201-1-gitster@pobox.com>
 <20161025181621.4201-3-gitster@pobox.com>
 <20161026042555.neaxvnmggtcku5cc@sigill.intra.peff.net>
 <xmqqa8drcc5i.fsf@gitster.mtv.corp.google.com>
 <20161026164746.2fu57f4pji5qdtnh@sigill.intra.peff.net>
 <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpomnatg6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 10:52:41AM -0700, Junio C Hamano wrote:

> > I actually wonder if it is worth carrying around the O_NOATIME hack at
> > all.
> 
> Yes, I share the thought.  We no longer have too many loose objects
> to matter.
> 
> I do not mind flipping the order, but I'd prefer to cook the result
> even longer.  I am tempted to suggest we take two step route:
> 
>  - ship 2.11 with the "atime has been there and we won't regress it"
>    shape, while cooking the "cloexec is semantically more
>    important" version in 'next' during the feature freeze
> 
>  - immediately after 2.11 merge it to 'master' for 2.12 to make sure
>    there is no fallout.

That sounds reasonable, though I'd consider jumping straight to "NOATIME
is not worth it; drop it" as the patch for post-2.11.

-Peff
