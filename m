Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27D211F97E
	for <e@80x24.org>; Mon, 12 Nov 2018 15:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeKMB3r (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:29:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:35862 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729371AbeKMB3r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:29:47 -0500
Received: (qmail 31191 invoked by uid 109); 12 Nov 2018 15:36:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 12 Nov 2018 15:36:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11800 invoked by uid 111); 12 Nov 2018 15:35:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 12 Nov 2018 10:35:22 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2018 10:36:00 -0500
Date:   Mon, 12 Nov 2018 10:36:00 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Geert Jansen <gerardu@amazon.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Takuto Ikuta <tikuta@chromium.org>
Subject: Re: [PATCH 3/9] rename "alternate_object_database" to
 "object_directory"
Message-ID: <20181112153600.GA12232@sigill.intra.peff.net>
References: <20181112144627.GA2478@sigill.intra.peff.net>
 <20181112144846.GC7400@sigill.intra.peff.net>
 <315c0fd5-e7a6-2c85-ba3c-861522c703bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <315c0fd5-e7a6-2c85-ba3c-861522c703bb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 10:30:55AM -0500, Derrick Stolee wrote:

> On 11/12/2018 9:48 AM, Jeff King wrote:
> > In preparation for unifying the handling of alt odb's and the normal
> > repo object directory, let's use a more neutral name. This patch is
> > purely mechanical, swapping the type name, and converting any variables
> > named "alt" to "odb". There should be no functional change, but it will
> > reduce the noise in subsequent diffs.
> > 
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > I waffled on calling this object_database instead of object_directory.
> > But really, it is very specifically about the directory (packed
> > storage, including packs from alternates, is handled elsewhere).
> 
> That makes sense. Each alternate makes its own object directory, but is part
> of a larger object database. It also helps clarify a difference from the
> object_store.
> 
> My only complaint is that you have a lot of variable names with "odb" which
> are now object_directory pointers. Perhaps "odb" -> "objdir"? Or is that
> just too much change?

Yeah, that was part of my waffling. ;)

From my conversions, usually "objdir" is a string holding the pathname,
though that's not set in stone. I also like that "odb" is the same short
length as "alt", which helps with conversion.

But I dunno.

-Peff
