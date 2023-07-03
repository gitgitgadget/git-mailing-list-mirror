Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA4C001B3
	for <git@archiver.kernel.org>; Mon,  3 Jul 2023 17:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjGCRct (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jul 2023 13:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGCRcs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2023 13:32:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D811CE
        for <git@vger.kernel.org>; Mon,  3 Jul 2023 10:32:46 -0700 (PDT)
Received: (qmail 2056 invoked by uid 109); 3 Jul 2023 17:32:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Jul 2023 17:32:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9563 invoked by uid 111); 3 Jul 2023 17:32:42 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Jul 2023 13:32:42 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Jul 2023 13:32:41 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 04/16] ref-filter: add `ref_filter_clear()`
Message-ID: <20230703173241.GA3544413@coredump.intra.peff.net>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
 <777e71004d68dc9bb9c4cad2b896acff2c615cbf.1687270849.git.me@ttaylorr.com>
 <20230703051946.GD3502534@coredump.intra.peff.net>
 <ZKMBxnQo1MyB7s9e@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZKMBxnQo1MyB7s9e@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 03, 2023 at 01:13:42PM -0400, Taylor Blau wrote:

> On Mon, Jul 03, 2023 at 01:19:46AM -0400, Jeff King wrote:
> > > +void ref_filter_init(struct ref_filter *filter)
> > > +{
> > > +	struct ref_filter blank = REF_FILTER_INIT;
> > > +	memcpy(filter, &blank, sizeof(blank));
> > > +}
> >
> > I was a little surprised by adding init() here, but we need it at the
> > end of clear(). So this is an OK place for it (the other option would be
> > in the earlier INIT patch, but it would be unused until now).
> 
> I used to write more patches in this style where I would add as much of
> a new API as possible as early as possible in the series. But I think
> reviewers seem to have an easier time reviewing API additions in the
> same patch that adds their caller.
> 
> So I tend to agree that this patch is probably a good spot to introduce
> `ref_filter_init()`. But if you feel strongly, I'm happy to drag it
> around.

Nope, I don't feel strongly at all. Let's leave it as you have it.

-Peff
