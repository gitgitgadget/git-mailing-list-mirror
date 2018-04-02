Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33B981F404
	for <e@80x24.org>; Mon,  2 Apr 2018 17:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDBRqS (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 13:46:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:50826 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752900AbeDBRqR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 13:46:17 -0400
Received: (qmail 30161 invoked by uid 109); 2 Apr 2018 17:46:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Apr 2018 17:46:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18535 invoked by uid 111); 2 Apr 2018 17:47:17 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 02 Apr 2018 13:47:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2018 13:46:15 -0400
Date:   Mon, 2 Apr 2018 13:46:15 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ls-remote: create option to sort by versions
Message-ID: <20180402174614.GA28566@sigill.intra.peff.net>
References: <20180402005248.52418-1-haraldnordgren@gmail.com>
 <87605aw1ue.fsf@evledraar.gmail.com>
 <CAHwyqnV1BwsaHVsh0xSx3MroNoJRT7UYrqF_WFKhkZMf-X9Evg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHwyqnV1BwsaHVsh0xSx3MroNoJRT7UYrqF_WFKhkZMf-X9Evg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 02, 2018 at 06:26:49PM +0200, Harald Nordgren wrote:

> It would be nice to have a uniform option like
> '--sort=version:refname'. But spending a few hours to look over the
> code, it seems that ls-remote.c would require a lot of rewrites if we
> wanted to start using `ref_array` and `ref_array_item` for storing the
> refs.
> 
> Which seems necessary in order to hook in to the sorting flow used in
> other subcommands. That, or reimplement `cmp_ref_sorting`. But maybe
> I'm missing something?

I haven't looked at how painful it might be to use ref-filter.c, but it
would buy us even more if we could. That would open up other options
like --format, I think (OTOH there may be some funny corner cases; that
code assumes we're talking about local refs, so if you were to ask for
"%(committerdate)" or something, we might have to more cleanly handle
the case where we don't actually have the object).

-Peff
