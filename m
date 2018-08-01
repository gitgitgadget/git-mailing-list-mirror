Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6983D1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 01:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732892AbeHADZ5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Jul 2018 23:25:57 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:44358 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732855AbeHADZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jul 2018 23:25:57 -0400
X-Greylist: delayed 449 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jul 2018 23:25:56 EDT
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id AEC6B1F597;
        Wed,  1 Aug 2018 01:35:24 +0000 (UTC)
Date:   Wed, 1 Aug 2018 01:35:24 +0000
From:   Eric Wong <e@80x24.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michael <aixtools@felt.demon.nl>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Dan Shumow <shumow@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Is detecting endianness at compile-time unworkable?
Message-ID: <20180801013524.4u5ioghtc2trhsqd@dcvr>
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
 <2309fa7f-c2d8-ee57-aff5-b9e32d2da609@felt.demon.nl>
 <20180729192753.GD945730@genre.crustytoothpaste.net>
 <dfe374bf-d9de-8dad-6ec9-4edfa3e9b12b@felt.demon.nl>
 <20180729200623.GF945730@genre.crustytoothpaste.net>
 <701d9f4b-efbd-c584-4bec-bddb51b11d96@felt.demon.nl>
 <87wotdt649.fsf@evledraar.gmail.com>
 <xmqq600wkc4i.fsf@gitster-ct.c.googlers.com>
 <xmqqh8kgfuba.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh8kgfuba.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:
> Well, having said all that, I do not think I personally mind if
> ./configure learned to include a "compile small program and run it
> to determine byte order on the build machine" as part of "we make a
> reasonable effort" as long as it cleanly excludes cross building
> case (and the result is made overridable just in case we misdetect
> the "cross-ness" of the build).

No need to run the program for cross-compiles, grepping a object
file seems to work for autoconf:

	git clone https://git.sv.gnu.org/git/autoconf.git
	$PAGER autoconf/lib/autoconf/c.m4
	# look for "BIGenDianSyS"
