Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33599C35263
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD37C20770
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgIPUpV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:45:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:58412 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgIPRD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 13:03:26 -0400
Received: (qmail 24817 invoked by uid 109); 16 Sep 2020 16:36:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 16:36:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29564 invoked by uid 111); 16 Sep 2020 16:36:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 12:36:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 12:36:17 -0400
From:   Jeff King <peff@peff.net>
To:     Sean Barag <sean@barag.org>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de, stolee@gmail.com
Subject: Re: [PATCH 1/4] clone: add tests for --template and some disallowed
 option pairs
Message-ID: <20200916163617.GC17726@coredump.intra.peff.net>
References: <20200911195622.GB2697399@coredump.intra.peff.net>
 <20200915160943.1253867-1-sean@barag.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915160943.1253867-1-sean@barag.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 15, 2020 at 09:09:44AM -0700, Sean Barag wrote:

> On Fri, 11 Sep 2020 15:56:22 -0400, Jeff King wrote:
>  > do we really care about code 128, or just failure? test_must_fail
>    might be a better choice
> 
> Good point - `test_must_fail` is probably fine here.  I went with an
> explicit error code so this test wouldn't pass in the event of an
> outright crash, but I'm happy to adjust for v2.

That's good thinking, but test_must_fail already has you covered; it
will complain about any death-by-signal. It wouldn't distinguish
between, say exit codes 128 and 1, but 128 is the code used by our die()
function, so expecting it isn't very specific anyway. :)

-Peff
