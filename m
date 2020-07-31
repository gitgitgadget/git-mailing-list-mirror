Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341AAC433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A4C2087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGaUaG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:30:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:44288 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgGaUaF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:30:05 -0400
Received: (qmail 24529 invoked by uid 109); 31 Jul 2020 20:30:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 20:30:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30915 invoked by uid 111); 31 Jul 2020 20:30:05 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 Jul 2020 16:30:05 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 31 Jul 2020 16:30:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1] t6300: fix issues related to %(contents:size)
Message-ID: <20200731203004.GA1440843@coredump.intra.peff.net>
References: <21bb2dad-5845-8cee-8f6a-1089ef7cae3b@gmail.com>
 <20200731174509.9199-1-alban.gruin@gmail.com>
 <20200731174709.GD843002@coredump.intra.peff.net>
 <xmqqpn8b30zp.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn8b30zp.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 31, 2020 at 01:04:10PM -0700, Junio C Hamano wrote:

> > Definitely fixes the issue, though I wonder:
> >
> >> -		echo $expect >expected
> >> -		test_expect_${4:-sucess} $PREREQ "basic atom: $1 contents:size" '
> >> +		echo $expect >expect
> >> +		test_expect_${4:-success} $PREREQ "basic atom: $1 contents:size" '
> >>  			git for-each-ref --format="%(contents:size)" "$ref" >actual &&
> >>  			test_cmp expect actual
> >>  		'
> >
> > Should we instead switch the test_cmp to look at "expected" to be
> > consistent with the rest of the tests in this file?
> 
> If I recall correctly, "expect vs actual" were more common when I
> counted across all the tests last time.  Matching local convention
> is fine, though.

Yes, I agree that "expect" is where we should be heading overall. I
think matching local convention is best here to avoid introducing new
mistakes like this one, but I wouldn't be opposed to somebody switching
out s/expected/expect/ in the whole file.

-Peff
