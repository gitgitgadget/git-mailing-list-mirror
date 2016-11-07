Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB8C12022A
	for <e@80x24.org>; Mon,  7 Nov 2016 17:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932803AbcKGRqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 12:46:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:39716 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932426AbcKGRqD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 12:46:03 -0500
Received: (qmail 31538 invoked by uid 109); 7 Nov 2016 17:46:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 17:46:02 +0000
Received: (qmail 13822 invoked by uid 111); 7 Nov 2016 17:46:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 12:46:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 12:46:00 -0500
Date:   Mon, 7 Nov 2016 12:46:00 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        tboegi@web.de, gitster@pobox.com
Subject: Re: [PATCH v1 1/2] config.mak.in: set NO_OPENSSL and
 APPLE_COMMON_CRYPTO for macOS >10.11
Message-ID: <20161107174559.t72vxxkckqdbxmbg@sigill.intra.peff.net>
References: <20161017002550.88782-1-larsxschneider@gmail.com>
 <20161017002550.88782-2-larsxschneider@gmail.com>
 <20161017095002.bbqyp2hkbuyau66t@sigill.intra.peff.net>
 <8C67FF53-C26F-4993-908F-A5183C5E48D9@gmail.com>
 <20161107172617.tlcrpwbjy2w7aoyc@sigill.intra.peff.net>
 <1478540194.4171.19.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1478540194.4171.19.camel@mad-scientist.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 12:36:34PM -0500, Paul Smith wrote:

> On Mon, 2016-11-07 at 12:26 -0500, Jeff King wrote:
> > I have in the back of my mind a fear that it is harder to unset a
> > make variable than it is to override it with a new value (which is
> > what you'd want to do here to turn openssl back on),
> 
> It depends on what you mean by "unset".
> 
> If you mean it as per the shell "unset" command, where the variable is
> completely forgotten as if it never was set at all, that's tricky.  You
> have to use the "undefine" special command which was introduced in GNU
> make 3.82 (released in 2010).
> 
> But if you just want to set the variable to the empty string, using
> "FOO=" works fine for that in all versions of make (GNU and otherwise)
> and using all the normal rules (command line override, etc.)

Specifically I wanted to make sure that

  FOO = bar
  FOO =
  ifdef FOO
  ... something ...
  endif

works as if FOO had never been set in the first place. Which it seems
to, at least in GNU make (and that is the only one we support, for other
reasons).

-Peff
