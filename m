Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18FF7208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 17:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbeHFTMM (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 15:12:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:44158 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726279AbeHFTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 15:12:12 -0400
Received: (qmail 16310 invoked by uid 109); 6 Aug 2018 17:02:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 06 Aug 2018 17:02:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27943 invoked by uid 111); 6 Aug 2018 17:02:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 06 Aug 2018 13:02:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Aug 2018 13:02:11 -0400
Date:   Mon, 6 Aug 2018 13:02:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
Message-ID: <20180806170211.GD19053@sigill.intra.peff.net>
References: <20180804020009.224582-1-sbeller@google.com>
 <20180804020255.225573-1-sbeller@google.com>
 <20180804060928.GB55869@aiede.svl.corp.google.com>
 <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
 <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
 <87zhxzsb2p.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zhxzsb2p.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 06, 2018 at 06:40:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Responding to the thread in general, perhaps people would like this more
> if we turned DEVELOPER=1 DEVOPTS=no-error on by default?
> 
> That's basically why I added it in 99f763baf5 ("Makefile: add a DEVOPTS
> to suppress -Werror under DEVELOPER", 2018-04-14), because I wanted the
> abilty to have verbose informative output without the build dying on
> some older systems / compilers.
> 
> It's fine and understandable if you're someone who's just building a
> package on some older system if you get a bunch of compiler warnings,
> but more annoying if you have to dig into how to disable a default
> -Werror.

I had the impression that DEVELOPER=1 was allowed to set flags that old
versions might not even know about. Hence they might actually barf, even
without -Werror. Maybe that's better since the introduction of the
detect-compiler script, though.

I do think we may have a skewed view of the population on this list.
We're developers ourselves, and we interact with new developers that we
want to help.  But there are masses of people[1] building Git who are
_not_ developers, and want the default to be as robust as possible.
They're probably not going to show up in this thread.

-Peff

[1] I actually wonder how large that mass is. Clearly there are many
    orders of magnitude more users than there are developers. But I have
    no idea what percentage of them build from source versus using
    somebody else's binary package.
