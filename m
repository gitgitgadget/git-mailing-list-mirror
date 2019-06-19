Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674B31F462
	for <e@80x24.org>; Wed, 19 Jun 2019 22:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfFSWJ2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 18:09:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:44852 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726230AbfFSWJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 18:09:27 -0400
Received: (qmail 13053 invoked by uid 109); 19 Jun 2019 22:06:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 19 Jun 2019 22:06:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10254 invoked by uid 111); 19 Jun 2019 22:10:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 19 Jun 2019 18:10:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Jun 2019 18:09:25 -0400
Date:   Wed, 19 Jun 2019 18:09:25 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 0/4] Test oidmap
Message-ID: <20190619220925.GF6571@sigill.intra.peff.net>
References: <20190615100702.20762-1-chriscool@tuxfamily.org>
 <20190619214212.GE6571@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190619214212.GE6571@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 19, 2019 at 05:42:13PM -0400, Jeff King wrote:

> I do think that sha1hash() will eventually go away in favor of
> oidhash(), but we can approach that separately, and convert oidmap along
> with everyone else.
> 
> It looks like we are close to being able to do that now. Grepping for
> sha1hash shows just about everybody dereferencing an oid object, except
> for the call in pack-objects.c. And skimming the callers there,
> they all appear to have an oid object, too.

Actually, it does get a little tangled, as our khash implementation also
uses sha1hash (though IMHO that should become oidhash, too). There's
also some preparatory work needed in pack-objects, which I've pushed up
to:

  https://github.com/peff/git jk/drop-sha1hash

I got interrupted and may try to resume this cleanup later; mostly I
wanted to post something now so you did not duplicate what I'd already
done.

-Peff
