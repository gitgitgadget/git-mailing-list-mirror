Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3F2C433EF
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A746124B
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbhIWRmt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:42:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:53692 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242557AbhIWRms (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:42:48 -0400
Received: (qmail 15506 invoked by uid 109); 23 Sep 2021 17:41:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 23 Sep 2021 17:41:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29833 invoked by uid 111); 23 Sep 2021 17:41:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Sep 2021 13:41:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Sep 2021 13:41:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #06; Mon, 20)
Message-ID: <YUy8Osh+YJXOmgF/@coredump.intra.peff.net>
References: <xmqq1r5iaj9j.fsf@gitster.g>
 <875yut8nns.fsf@evledraar.gmail.com>
 <xmqqczoz2qr3.fsf@gitster.g>
 <87mto343ze.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87mto343ze.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 23, 2021 at 06:51:12PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Isn't the direction of dependency the other way?  Once fixes go in,
> > checks will no longer complain, but until fixes are reviewed and
> > applied, checking at CI will break the testing and this would need
> > working around by marking various tests as "not ready to be tested".
> 
> The fixes are structured as fixing the code, and then for both
> self-documentation & testing turning on:
> 
>     TEST_PASSES_SANITIZE_LEAK=true
> 
> In the same commit, I could fix the leaks and have a second series later
> for turning on the regression test, or just turning on the test and
> having it kick in once it's merged with ab/sanitize-leak-ci, but waiting
> until ab/sanitize-leak-ci hit master first seemed less confusing for
> everyone.
> 
> But if you'd like to have 'em now with either of those caveats...

Yeah, I think it's much easier to demonstrate the leak and that it is
fixed when we have the infrastructure from that series. So the leaks
themselves can obviously be fixed without depending on that series, but
it's much easier to review the patches when we have that extra tooling.

-Peff
