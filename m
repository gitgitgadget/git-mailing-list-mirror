Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCFB1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 18:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754590AbeGISqf (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 14:46:35 -0400
Received: from cloud.peff.net ([104.130.231.41]:52364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754517AbeGISqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 14:46:34 -0400
Received: (qmail 32118 invoked by uid 109); 9 Jul 2018 18:46:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 09 Jul 2018 18:46:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14093 invoked by uid 111); 9 Jul 2018 18:46:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 09 Jul 2018 14:46:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jul 2018 14:46:32 -0400
Date:   Mon, 9 Jul 2018 14:46:32 -0400
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [RFC PATCH 2/6] refs/refs-internal.h: avoid forward declaration
 of an enum
Message-ID: <20180709184632.GA9601@sigill.intra.peff.net>
References: <20180708144342.11922-1-dev+git@drbeat.li>
 <20180708144342.11922-3-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180708144342.11922-3-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 08, 2018 at 04:43:38PM +0200, Beat Bolli wrote:

> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index dd834314bd..a78b5cb803 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -1,6 +1,8 @@
>  #ifndef REFS_REFS_INTERNAL_H
>  #define REFS_REFS_INTERNAL_H
>  
> +#include "iterator.h"   /* for enum iterator_selection */

IMHO this kind of comment does more harm than good, because it is so
prone to going stale (nobody is going to bother updating it when they
add new dependencies on iterator.h). Anybody who is interested in the
original reason can use "git blame" to dig up your commit message. And
anybody who is thinking about deleting that line would need to dig into
whether anything had been added in the meantime that also requires the
include.

So at best it's redundant, and at worst it's slightly misleading. :)

Not worth a re-roll by itself, but it looked like you had a few other
bits in the other patches to address.

Other than this minor quibble, the whole series looks good to me, modulo
the existing review.

-Peff
