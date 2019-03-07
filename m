Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BAAF20248
	for <e@80x24.org>; Thu,  7 Mar 2019 19:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfCGTPg (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 14:15:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:42944 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726279AbfCGTPg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 14:15:36 -0500
Received: (qmail 5632 invoked by uid 109); 7 Mar 2019 19:15:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 19:15:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26735 invoked by uid 111); 7 Mar 2019 19:15:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 14:15:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 14:15:34 -0500
Date:   Thu, 7 Mar 2019 14:15:34 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>
Subject: Re: [PATCH v13 12/27] stash: convert drop and clear to builtin
Message-ID: <20190307191533.GA29221@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
 <20190225231631.30507-13-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190225231631.30507-13-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 11:16:16PM +0000, Thomas Gummerer wrote:

> +static int do_drop_stash(const char *prefix, struct stash_info *info, int quiet)

This series hit next recently, so I started building it merged with my
-Wunused-parameters series. This "prefix" parameter is not ever used.
Skimming through the function, I don't see anything that _should_ be
using it, so I think it's just cruft, and not indicative of a bug.

The same is true of create_stash() elsewhere in the series. But there it
might be worth keeping for consistency with the other top-level action
functions. The other ones pass "prefix" to parse_options(), but
create_stash() doesn't actually parse any options (and intentionally so,
since even "--help" should be taken as part of the stash message).

-Peff
