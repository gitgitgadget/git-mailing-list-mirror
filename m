Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72C4F1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 05:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbeBOFkV (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 00:40:21 -0500
Received: from cloud.peff.net ([104.130.231.41]:53372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751074AbeBOFkU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 00:40:20 -0500
Received: (qmail 1730 invoked by uid 109); 15 Feb 2018 05:40:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 15 Feb 2018 05:40:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7264 invoked by uid 111); 15 Feb 2018 05:41:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 15 Feb 2018 00:41:05 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Feb 2018 00:40:18 -0500
Date:   Thu, 15 Feb 2018 00:40:18 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 09/23] cat-file: start use ref_array_item struct
Message-ID: <20180215054018.GI18780@sigill.intra.peff.net>
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
 <01020161890f435d-05435bc4-30da-41c4-8bb2-37dcccb4a413-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020161890f435d-05435bc4-30da-41c4-8bb2-37dcccb4a413-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 08:08:54AM +0000, Olga Telezhnaya wrote:

> Moving from using expand_data to ref_array_item structure.
> That helps us to reuse functions from ref-filter easier.

This one feels weird. The point of a ref_array_item is for the caller to
feed data into the ref-filter formatting code (usually that data comes
from an earlier call to filter_refs(), but in the new cat-file we'd
presumably feed single items).

But here we're adding a bunch of fields for items that we'd expect the
format code to compute itself.

-Peff
