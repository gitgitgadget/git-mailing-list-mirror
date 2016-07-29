Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFFF1F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbcG2Sbs (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:31:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:51264 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750799AbcG2Sbq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:31:46 -0400
Received: (qmail 6928 invoked by uid 102); 29 Jul 2016 18:31:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:31:47 -0400
Received: (qmail 4322 invoked by uid 107); 29 Jul 2016 18:32:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:32:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:31:43 -0400
Date:	Fri, 29 Jul 2016 14:31:43 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Dakota Hawkins <dakotahawkins@gmail.com>, git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" +
 "pull.rebase = preserve" - "user.email"
Message-ID: <20160729183143.GB9877@sigill.intra.peff.net>
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
 <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
 <xmqqa8h0nw5a.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa8h0nw5a.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 11:20:49AM -0700, Junio C Hamano wrote:

> There is one that still wants to know who you are, I think.  The
> reflog entries record who moved the tip of the ref and when, and
> obviously a fast-forward is also recorded.
> 
> I _think_ our intention was to allow a bogus ident in reflog entries
> (even though we want to avoid a bogus ident in commits and tags), so
> perhaps additional code/logic for user.useConfigOnly may need to know
> about that (I didn't dig)?

I think we handle this case OK, or you would not even be able to "git
fetch" into a repository.

It works because the check is predicated on the "strict" flag, and the
reflog writer passes IDENT_NO_STRICT.

-Peff
