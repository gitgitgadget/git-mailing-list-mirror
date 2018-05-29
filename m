Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F9D61F42D
	for <e@80x24.org>; Tue, 29 May 2018 21:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967058AbeE2VZB (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 17:25:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:55774 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966847AbeE2VZB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 17:25:01 -0400
Received: (qmail 3607 invoked by uid 109); 29 May 2018 21:25:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 29 May 2018 21:25:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30927 invoked by uid 111); 29 May 2018 21:25:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 29 May 2018 17:25:11 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2018 17:24:58 -0400
Date:   Tue, 29 May 2018 17:24:58 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsckObjects tests: show how v2.17.1 can exploit
 downstream
Message-ID: <20180529212458.GC7964@sigill.intra.peff.net>
References: <20180529211950.26896-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180529211950.26896-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 29, 2018 at 09:19:50PM +0000, Ævar Arnfjörð Bjarmason wrote:

> Something that's known but not explicitly discussed in the v2.17.1
> release notes, or tested for, is that v2.17.1 will still happily pass
> on evil .gitmodules objects by default to vulnerable downstream
> clients.
> 
> This could happen e.g. if an in-house git hosting site is mirroring a
> remote repository that doesn't have transfer.fsckObjects turned on.
> Someone can remotely push evil data to that remote hosting site
> knowing that it's mirrored downstream, and the in-house mirror without
> transfer.fsckObjects will happily pass those evil objects along, even
> though it's been updated to v2.17.1.

Sure, I agree with all of the above, but...

> It's worth testing for this explicitly. So let's amend the tests added
> in 73c3f0f704 ("index-pack: check .gitmodules files with --strict",
> 2018-05-04) to show how this can result in a v2.17.1 client passing
> along the evil objects.

I'm not sure what testing this buys us. If it stopped passing them
along, would we consider that a regression? This seems more like a
documentation issue than something that needs to be tested.

-Peff
