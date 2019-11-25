Return-Path: <SRS0=39iz=ZR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123D7C432C0
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC0A020409
	for <git@archiver.kernel.org>; Mon, 25 Nov 2019 13:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfKYNxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Nov 2019 08:53:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:59892 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727462AbfKYNxs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Nov 2019 08:53:48 -0500
Received: (qmail 26245 invoked by uid 109); 25 Nov 2019 13:53:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Nov 2019 13:53:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18694 invoked by uid 111); 25 Nov 2019 13:57:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 25 Nov 2019 08:57:48 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 25 Nov 2019 08:53:47 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t5608-clone-2gb.sh: turn GIT_TEST_CLONE_2GB into a
 bool
Message-ID: <20191125135347.GB494@sigill.intra.peff.net>
References: <20190907101637.GE32087@szeder.dev>
 <20191122131437.25849-1-szeder.dev@gmail.com>
 <20191122131437.25849-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191122131437.25849-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 22, 2019 at 02:14:37PM +0100, SZEDER Gábor wrote:

> The GIT_TEST_CLONE_2GB environment variable is only ever checked with
> 'test -z' in 't5608-clone-2gb.sh', so any non-empty value is
> interpreted as "yes, run these expensive tests", even
> 'GIT_TEST_CLONE_2GB=NoThanks'.
> 
> Similar GIT_TEST_* environment variables have already been turned into
> bools in 3b072c577b (tests: replace test_tristate with "git
> env--helper", 2019-06-21), so let's turn GIT_TEST_CLONE_2GB into a
> bool as well, to follow suit.
> 
> Our CI builds set GIT_TEST_CLONE_2GB=YesPlease, so adjust them
> accordingly, thus removing the last 'YesPlease' from our CI scripts.

This might break the setup of some developer or tester who put a similar
value into their config.mak. But I think that's worth it to reduce
confusion in the long run, especially since they will get a very clear
error message due to your first patch.

-Peff
