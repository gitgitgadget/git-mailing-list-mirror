Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F74B202AB
	for <e@80x24.org>; Wed,  5 Jul 2017 09:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbdGEJAG (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 05:00:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:59878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751744AbdGEJAF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 05:00:05 -0400
Received: (qmail 24076 invoked by uid 109); 5 Jul 2017 09:00:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 09:00:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6082 invoked by uid 111); 5 Jul 2017 09:00:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Jul 2017 05:00:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jul 2017 05:00:03 -0400
Date:   Wed, 5 Jul 2017 05:00:03 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCHv3 2/3] patch-ids.c: use hashmap correctly
Message-ID: <20170705090003.ervwwantjliim3az@sigill.intra.peff.net>
References: <20170629235336.28460-1-sbeller@google.com>
 <20170630191407.5381-1-sbeller@google.com>
 <20170630191407.5381-3-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170630191407.5381-3-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 30, 2017 at 12:14:06PM -0700, Stefan Beller wrote:

> As eluded to in the previous patch, the code in patch-ids.c is using
> the hashmaps API wrong.
> 
> Luckily we do not have a bug, as all hashmap functionality that we use
> here (hashmap_get) passes through the keydata.  If hashmap_get_next were
> to be used, a bug would occur as that passes NULL for the key_data.
> 
> So instead use the hashmap API correctly and provide the caller required
> data in the compare function via the first argument that always gets
> passed and was setup via the hashmap_init function.

Reviewing this a bit late, but it looks good to me. And I think the
explanation above nicely covers what is going on (and why it isn't a
bug).

-Peff

PS I think you meant "alluded" in the first sentence, unless you really
   were trying to escape the previous patch. :)
