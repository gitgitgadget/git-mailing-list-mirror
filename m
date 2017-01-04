Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1DD205C9
	for <e@80x24.org>; Wed,  4 Jan 2017 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbdADII4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 03:08:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:35043 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933251AbdADIIz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 03:08:55 -0500
Received: (qmail 5710 invoked by uid 109); 4 Jan 2017 08:08:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 08:08:54 +0000
Received: (qmail 30629 invoked by uid 111); 4 Jan 2017 08:09:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Jan 2017 03:09:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jan 2017 03:08:52 -0500
Date:   Wed, 4 Jan 2017 03:08:52 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?66eI64iE7JeY?= <nalla@hamal.uberspace.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] asciidoctor: fix user-manual to be built by
 `asciidoctor`
Message-ID: <20170104080852.bmlmtzxhjx4qt74f@sigill.intra.peff.net>
References: <cover.1483373021.git.johannes.schindelin@gmx.de>
 <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3c160f81a88cf8697f2459bb7f2a3e27fb3e469c.1483373021.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 02, 2017 at 05:03:57PM +0100, Johannes Schindelin wrote:

> From: =?UTF-8?q?=EB=A7=88=EB=88=84=EC=97=98?= <nalla@hamal.uberspace.de>
> 
> The `user-manual.txt` is designed as a `book` but the `Makefile` wants
> to build it as an `article`. This seems to be a problem when building
> the documentation with `asciidoctor`. Furthermore the parts *Git
> Glossary* and *Appendix B* had no subsections which is not allowed when
> building with `asciidoctor`. So lets add a *dummy* section.

The git-scm.com site uses asciidoctor, too, and I think I have seen some
oddness with the rendering though. So in general I am in favor of making
things work under both asciidoc and asciidoctor.

I diffed the results of "make user-manual.html" before and after this
patch. A lot of "h3" chapter titles get bumped to "h2", which is OK. The
chapter titles now say "Chapter 1. Repositories and Branches" rather
than just "Repositories and Branches". Likewise, references now say

  Chapter 1, _Repositories and Branches_

rather than:

  the section called "Repositories and Branches".

which is probably OK, though the whole thing is short enough that
calling the sections chapters feels a bit over-important. Chapters now
get their own table of contents, too. This is especially silly in
one-section chapters like "Git Glossary".

So I dunno. I really do think "article" is conceptually the most
appropriate style, but I agree that there are some book-like things
(like appendices).

-Peff
