Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8AEC433E6
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1586D600EF
	for <git@archiver.kernel.org>; Wed, 17 Feb 2021 23:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbhBQXbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 18:31:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:36740 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232032AbhBQXbu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 18:31:50 -0500
Received: (qmail 20826 invoked by uid 109); 17 Feb 2021 23:31:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Feb 2021 23:31:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10666 invoked by uid 111); 17 Feb 2021 23:31:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Feb 2021 18:31:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Feb 2021 18:31:07 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org, Kyle Meyer <kyle@kyleam.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 0/2] rev-list --disk-usage example docs
Message-ID: <YC2nOxPP3SAY2g1I@coredump.intra.peff.net>
References: <YBHlGPBSJC++CnPy@coredump.intra.peff.net>
 <YCJpbPIlSpCAKSBF@coredump.intra.peff.net>
 <xmqqh7mkycno.fsf@gitster.c.googlers.com>
 <YCOu70m5SKU7L4CS@coredump.intra.peff.net>
 <xmqq1rdn51gz.fsf@gitster.c.googlers.com>
 <YCREYmBsnv2wgvXZ@coredump.intra.peff.net>
 <YCRpBCNJ2yNTbc2i@nand.local>
 <YCUOSmnsJ4LLPFgK@coredump.intra.peff.net>
 <875z2ydd4l.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875z2ydd4l.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 11, 2021 at 01:04:26PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > I think this is the "narrowly scoped" bit from Junio's response above.
> > It would be a bit weird to have an examples section for rev-list that
> > only mentions this rather obscure feature.
> 
> I don't think the lack of an EXAMPLES section or the relative obscurity
> of the switch should preclude us from adding useful documentation.
> 
> Yes it would feel a bit out of place, but we can always have a
> sub-section of EXAMPLES, and we've got to start somewhere.

Fair enough. Here are some patches (to go on top of jk/rev-list-disk-usage,
though obviously the first one could be applied independently).

> In this case I don't see why it couldn't be added to OPTIONS, we've got
> some very long discussion there already, and as long as there's a clear
> separation in prose from an initial brief discussion of the switch and
> further prose it won't be confusing for readers, they can just page past
> the details.

It's already big and scary enough that I prefer starting an EXAMPLES
section. :)

By the way, there's one other finishing touch we might consider:
enabling --use-bitmap-index automatically when bitmaps are present, for
requests that produce the identical answer (so _not_ a regular
traversal, because the output order and presence of pathnames are
different there). I'd prefer to do that as a separate series, though,
since there are multiple arguments that might benefit (like --count).

  [1/2]: docs/rev-list: add an examples section
  [2/2]: docs/rev-list: add some examples of --disk-usage

 Documentation/git-rev-list.txt | 93 ++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

-Peff
