Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8150DEB64DC
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 05:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjGCFPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 01:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjGCFPG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 01:15:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938E2A7
        for <git@vger.kernel.org>; Sun,  2 Jul 2023 22:15:05 -0700 (PDT)
Received: (qmail 4845 invoked by uid 109); 3 Jul 2023 05:15:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 05:15:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1998 invoked by uid 111); 3 Jul 2023 05:15:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 01:15:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 01:15:04 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 02/16] ref-filter.h: provide `REF_FILTER_INIT`
Message-ID: <20230703051504.GB3502534@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <7ce82b6a5a451ff183ba8d35fc0f50acccee8972.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ce82b6a5a451ff183ba8d35fc0f50acccee8972.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 10:21:06AM -0400, Taylor Blau wrote:

> From: Jeff King <peff@peff.net>
> 
> Provide a sane initialization value for `struct ref_filter`, which in a
> subsequent patch will be used to initialize a new field.
> 
> In the meantime, fix a case in test-reach.c where its `ref_filter` is
> not even zero-initialized.

This test-reach case scared me, but it happens to work now because
commit_contains() only looks at the one field that we set. So we're not
fixing a bug, but more like a bug waiting to happen. :)

-Peff
