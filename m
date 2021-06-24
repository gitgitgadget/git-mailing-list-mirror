Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6C4C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63CF960232
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhFXTo5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:44:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:60046 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232178AbhFXToz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:44:55 -0400
Received: (qmail 13151 invoked by uid 109); 24 Jun 2021 19:42:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Jun 2021 19:42:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16108 invoked by uid 111); 24 Jun 2021 19:42:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 24 Jun 2021 15:42:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 24 Jun 2021 15:42:35 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
Subject: Re: [PATCH 2/4] commit-graph: rewrite to use checksum_valid()
Message-ID: <YNTgK+ekHZnqACzN@coredump.intra.peff.net>
References: <cover.1624473543.git.me@ttaylorr.com>
 <64aa0aecbd977a6915c271b9c3c1da3c5043e01d.1624473543.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64aa0aecbd977a6915c271b9c3c1da3c5043e01d.1624473543.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 23, 2021 at 02:39:09PM -0400, Taylor Blau wrote:

> Rewrite an existing caller in `git commit-graph verify` to take
> advantage of checksum_valid().
> 
> Note that the replacement isn't a verbatim cut-and-paste, since the new
> function avoids using hashfile at all and instead talks to the_hash_algo
> directly, but it is functionally equivalent.

Yay. IMHO the result is much nicer, as we do not have to wonder about
open() returning an error.

-Peff
