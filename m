Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9D31FBB0
	for <e@80x24.org>; Wed, 23 Nov 2016 00:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756394AbcKWAND (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 19:13:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:46409 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751644AbcKWANC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 19:13:02 -0500
Received: (qmail 28780 invoked by uid 109); 23 Nov 2016 00:13:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Nov 2016 00:13:02 +0000
Received: (qmail 871 invoked by uid 111); 23 Nov 2016 00:13:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 22 Nov 2016 19:13:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Nov 2016 19:12:59 -0500
Date:   Tue, 22 Nov 2016 19:12:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Taufiq Hoven <taufiq.hoven@gmail.com>
Subject: Re: [PATCH 2/3] stripspace: respect repository config
Message-ID: <20161123001259.y7wjo75bhdgxmeme@sigill.intra.peff.net>
References: <CACsJy8D5oBR+vo2B+Ro2Q4SX0CG3jME4Gfs1_6AohccmpNvD0A@mail.gmail.com>
 <alpine.DEB.2.20.1611221712480.3746@virtualbox>
 <xmqqshqjqw3z.fsf@gitster.mtv.corp.google.com>
 <xmqqzikrpbz2.fsf@gitster.mtv.corp.google.com>
 <20161122195015.rztaixpz7zvdxb4u@sigill.intra.peff.net>
 <xmqqoa17p8k0.fsf@gitster.mtv.corp.google.com>
 <20161122211920.3qdohxdktykqhyga@sigill.intra.peff.net>
 <xmqqeg23p5v3.fsf@gitster.mtv.corp.google.com>
 <20161122214305.yrn4uqh4dzzafkd2@sigill.intra.peff.net>
 <xmqq7f7vp4ck.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7f7vp4ck.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 01:55:07PM -0800, Junio C Hamano wrote:

> > And this test makes sense. Even without "sub", it would show the
> > regression, but it's a good idea to test the sub-directory case to cover
> > the path-munging.
> 
> Yup.  Obviously during my initial attempt I was scratching my head
> wondering where these two files went--they were later found inside
> t/ directory which was really bad ;-)

Heh. Yeah, it's nice when the failure mode doesn't escape the trash
directory, but it's probably not worth worrying about too much.

> > In the "archive --remote" test I added, we may want to do the same to
> > show that "--output" points at the correct path.
> 
> Perhaps something like this.  By going down one level, we make sure
> that it is not sufficient to accidentally read from .git/config to
> find out what 'foo' is, and also ../b5-nick.tar that is relative to
> the prefix (aka 'a/') ends up at the top-level.

Yeah, your modification looks good.

-Peff
