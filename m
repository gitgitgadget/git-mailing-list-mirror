Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42FAE1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 21:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750786AbeAOVoW (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 16:44:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:44440 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750732AbeAOVoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 16:44:21 -0500
Received: (qmail 14233 invoked by uid 109); 15 Jan 2018 21:44:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Jan 2018 21:44:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20101 invoked by uid 111); 15 Jan 2018 21:44:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Jan 2018 16:44:56 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jan 2018 16:44:19 -0500
Date:   Mon, 15 Jan 2018 16:44:19 -0500
From:   Jeff King <peff@peff.net>
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 04/18] cat-file: move struct expand_data into
 ref-filter
Message-ID: <20180115214419.GE4778@sigill.intra.peff.net>
References: <01020160df6dc499-0e6d11ec-1dcd-4a71-997b-ea231f33fae4-000000@eu-west-1.amazonses.com>
 <01020160df6dc532-75f3ef78-26cb-4751-9ded-eb0e8d23833b-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01020160df6dc532-75f3ef78-26cb-4751-9ded-eb0e8d23833b-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 10, 2018 at 09:36:41AM +0000, Olga Telezhnaya wrote:

> Need that for further reusing of formatting logic in cat-file.
> Have plans to get rid of using expand_data in cat-file at all,
> and use it only in ref-filter for collecting, formatting and printing
> needed data.

I think some of these will want to remain in cat-file.c. For instance,
split_on_whitespace is not something that ref-filter.c itself would care
about. I'd expect in the endgame for cat-file to keep its own
split_on_whitespace flag, and to set it based on the presence of the
%(rest) flag, which it can check by seeing if the "rest" atom is in the
"used_atom" list after parsing the format.

-Peff
