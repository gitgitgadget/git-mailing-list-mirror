Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40A4A1F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeB0WEs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:04:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:39508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751919AbeB0WEq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:04:46 -0500
Received: (qmail 9621 invoked by uid 109); 27 Feb 2018 22:04:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:04:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27900 invoked by uid 111); 27 Feb 2018 22:05:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:05:34 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:04:43 -0500
Date:   Tue, 27 Feb 2018 17:04:43 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 14/35] connect: request remote refs using v2
Message-ID: <20180227220443.GB11187@sigill.intra.peff.net>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-15-bmwill@google.com>
 <20180221145411.35b2ea84747518a499276bdd@google.com>
 <20180222181922.GD185096@google.com>
 <20180222182657.GE19035@sigill.intra.peff.net>
 <20180222112533.0d7c6023fb8e4098efedfe31@google.com>
 <20180227062128.GG65699@aiede.svl.corp.google.com>
 <xmqq8tbep02f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8tbep02f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 01:58:00PM -0800, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Jonathan Tan wrote:
> >> On Thu, 22 Feb 2018 13:26:58 -0500
> >> Jeff King <peff@peff.net> wrote:
> >
> >>> I agree that it shouldn't matter much here. But if the name argv_array
> >>> is standing in the way of using it, I think we should consider giving it
> >>> a more general name. I picked that not to evoke "this must be arguments"
> >>> but "this is terminated by a single NULL".
> > [...]
> >> This sounds reasonable - I withdraw my comment about using struct
> >> string_list.
> >
> > Marking with #leftoverbits as a reminder to think about what such a
> > more general name would be (or what kind of docs to put in
> > argv-array.h) and make it so the next time I do a search for that
> > keyword.
> 
> So are we looking for a natural name to call an array of trings?  I
> personally do not mind argv_array too much, but perhaps we can call
> it a string_array and then everybody will be happy?

That would be fine with me. Though I would love it if we could find a
shorter name for the associated functions. For example,
argv_array_pushf() can make lines quite long, and something like
argv_pushf() is easier to read (in my opinion). And that might work
because "argv" is pretty unique by itself, but "string" is not.

Some one-word name like "strarray" might work, though I find that is not
quite catchy. I guess "strv" is short if you assume that people know the
"v" suffix means "vector".

It may not be worth worrying too much about, though. We already have
24-character monstrosities like string_list_append_nodup(). ;)

-Peff
