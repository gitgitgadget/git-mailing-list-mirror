Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 241511F404
	for <e@80x24.org>; Wed, 14 Feb 2018 01:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966375AbeBNBiv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 20:38:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:51696 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966311AbeBNBiu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 20:38:50 -0500
Received: (qmail 11001 invoked by uid 109); 14 Feb 2018 01:38:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 01:38:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26198 invoked by uid 111); 14 Feb 2018 01:39:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 13 Feb 2018 20:39:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Feb 2018 20:38:48 -0500
Date:   Tue, 13 Feb 2018 20:38:48 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Leo Gaspard <leo@gaspard.io>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Fetch-hooks
Message-ID: <20180214013848.GB25188@sigill.intra.peff.net>
References: <87bmgzmbsk.fsf@evledraar.gmail.com>
 <fa470be4-75fb-76ed-ed93-5c10fcfb8842@gaspard.io>
 <87po5dbz1a.fsf@evledraar.gmail.com>
 <20180209223011.GA24578@sigill.intra.peff.net>
 <87e7c3b8-3b3c-1cb0-9b11-e4bf3044e539@gaspard.io>
 <20180210001317.GA26856@sigill.intra.peff.net>
 <3de8dec0-12c9-56e2-5902-97755f78ab50@gaspard.io>
 <20180210122131.GB21843@sigill.intra.peff.net>
 <5abf8565-1aa1-c101-83a7-90781682bc7a@gaspard.io>
 <20180212192327.GA209601@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180212192327.GA209601@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 12, 2018 at 11:23:27AM -0800, Brandon Williams wrote:

> Maybe this isn't helpful but you may be able to implement this by using
> a remote-helper.  The helper could perform any sort of caching it needed
> to prevent re-downloading large amounts of data that is potentially
> thrown away, while only sending through the relevant commits which
> satisfy some criteria (signed, etc.).

Interesting idea, though it would still be calling git-fetch under the
hood, right? So I guess we're just reimplementing this "quarantine"
concept, but in theory we'd have the flexibility to store that
quarantine in another one-off sub-repository (instead of a special ref
namespace, though I suppose you could use the special ref namespace,
too).

I suspect it could work, but there would probably be a lot of rough
edges.

-Peff
