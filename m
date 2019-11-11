Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78FB91F4C0
	for <e@80x24.org>; Mon, 11 Nov 2019 14:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKO3F (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 09:29:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:44536 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726871AbfKKO3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 09:29:05 -0500
Received: (qmail 20611 invoked by uid 109); 11 Nov 2019 14:29:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Nov 2019 14:29:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7066 invoked by uid 111); 11 Nov 2019 14:32:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 11 Nov 2019 09:32:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 11 Nov 2019 09:29:04 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191111142904.GB1934@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <20191111090418.GB12545@sigill.intra.peff.net>
 <20191111141805.GK4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191111141805.GK4348@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 11, 2019 at 03:18:05PM +0100, SZEDER Gábor wrote:

> On Mon, Nov 11, 2019 at 04:04:18AM -0500, Jeff King wrote:
> > There's only a single caller left of sha1_to_hex(), since everybody now
> > uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
> > print a hex sha1 when we find a collision. This one will always be sha1,
> > regardless of the current hash algorithm, so we can't use oid_to_hex()
> 
> Nit: s/oid_to_hex/hash_to_hex/
> 
> We can't use oid_to_hex() because we don't have a 'struct object_id'
> in the first place, as sha1dc only ever deals with 20 unsigned chars.

Ah, you're right. I admit I am still getting up to speed on all of the
new hash-agnostic versions of the various functions.

-Peff
