Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BA320966
	for <e@80x24.org>; Sun, 26 Mar 2017 04:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750755AbdCZEnP (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 00:43:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:51874 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750743AbdCZEnO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 00:43:14 -0400
Received: (qmail 12150 invoked by uid 109); 26 Mar 2017 04:43:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 04:43:11 +0000
Received: (qmail 29574 invoked by uid 111); 26 Mar 2017 04:43:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Mar 2017 00:43:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Mar 2017 00:43:09 -0400
Date:   Sun, 26 Mar 2017 00:43:09 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Will OpenSSL's license change impact us?
Message-ID: <20170326044308.7hxiqsgrzvxmsfnh@sigill.intra.peff.net>
References: <CACBZZX6F47uC9jLxppgkUnwVpGV2jpzzP4kwTuqKgayCevomeA@mail.gmail.com>
 <20170325214427.f3kdxgrldpnar4ag@genre.crustytoothpaste.net>
 <CACBZZX6=zEHkYUZ3qOQLmB+6658YN1Hy+3TY8zLAxjpUtivQpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACBZZX6=zEHkYUZ3qOQLmB+6658YN1Hy+3TY8zLAxjpUtivQpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 10:52:47PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > If we want to consider performance-related concerns, I think the easier
> > solution is using Nettle, which is LGPL 2.1.  Considering that the
> > current opinions for a new hash function are moving in the direction of
> > SHA-3, which Nettle has, but OpenSSL does not, I think that might be a
> > better decision overall.  It was certainly the implementation I would
> > use if I were to implement it.
> 
> Yeah there's a lot of options open for just sha1-ing, but we also use
> OpenSSL for TLS via imap-send.

These days imap-send has basically two implementations: one that speaks
imap itself (optionally using openssl), and one that just uses curl's
imap support.  If you build with NO_OPENSSL, the curl implementation
kicks in by default.

So I think any distro worried about licensing can just "make NO_OPENSSL"
today and get full functionality.

Curl may use openssl behind the scenes, of course, but distros already
have to deal with that (at least on Debian, you can drop-in gnutls).

-Peff
