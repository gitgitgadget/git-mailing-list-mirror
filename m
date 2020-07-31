Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3E7C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8614B2087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 17:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733243AbgGaRps (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:45:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:43872 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729018AbgGaRps (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 13:45:48 -0400
Received: (qmail 23313 invoked by uid 109); 31 Jul 2020 17:45:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 17:45:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28619 invoked by uid 111); 31 Jul 2020 17:45:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 13:45:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 13:45:47 -0400
From:   Jeff King <peff@peff.net>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 3/3] ref-filter: add support for %(contents:size)
Message-ID: <20200731174547.GC843002@coredump.intra.peff.net>
References: <20200710164739.6616-1-chriscool@tuxfamily.org>
 <20200716121940.21041-1-chriscool@tuxfamily.org>
 <20200716121940.21041-4-chriscool@tuxfamily.org>
 <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 07:37:22PM +0200, Alban Gruin wrote:

> > +		# Leave $expect unquoted to lose possible leading whitespaces
> > +		echo $expect >expected
> > +		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
> 
> There is a typo here, and $expect is written to `expected', but
> `test_cmp' wants `expect'.  Fixing those mistakes does not reveal any
> broken tests.

I thought at first you meant that the typo was s/expected/expect, and
wondered how this could possibly have passed. But the typo is
s/sucess/success/, so we were in fact not running the test at all (and
were generating "test_expect_sucess: not found" messages to stderr, but
outside of any test block. Yikes.

Thanks for spotting.

-Peff
