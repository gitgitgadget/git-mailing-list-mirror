Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9510120C11
	for <e@80x24.org>; Mon, 27 Nov 2017 23:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbdK0XLe (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 18:11:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:41928 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752348AbdK0XLd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 18:11:33 -0500
Received: (qmail 14235 invoked by uid 109); 27 Nov 2017 23:11:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Nov 2017 23:11:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7068 invoked by uid 111); 27 Nov 2017 23:11:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 27 Nov 2017 18:11:51 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Nov 2017 18:11:31 -0500
Date:   Mon, 27 Nov 2017 18:11:31 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Liam Beguin <liambeguin@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH 4/5] rebase -i: learn to abbreviate command names
Message-ID: <20171127231131.GB29636@sigill.intra.peff.net>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171127045514.25647-5-liambeguin@gmail.com>
 <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1711272344290.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 28, 2017 at 12:04:45AM +0100, Johannes Schindelin wrote:

> > +rebase.abbreviateCommands::
> > +	If set to true, `git rebase` will use abbreviated command names in the
> > +	todo list resulting in something like this:
> > +
> > +-------------------------------------------
> > +	p deadbee The oneline of the commit
> > +	p fa1afe1 The oneline of the next commit
> > +	...
> > +-------------------------------------------
> 
> I *think* that AsciiDoc will render this in a different way from what we
> want, but I am not an AsciiDoc expert. In my hands, I always had to add a
> single + in an otherwise empty line to start a new indented paragraph *and
> then continue with non-indented lines*.

Good catch. Interestingly enough, my asciidoc seems to render this
as desired for the docbook/roff version, but has screwed-up indentation
for the HTML version.

Fixing it as you suggest makes it look good in both (and I think you can
never go wrong with "+"-continuation, aside from making the source a bit
uglier).

Squashable patch below for convenience, since I did try it.

-Peff

diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
index 0820b60f6e..42e1ba7575 100644
--- a/Documentation/rebase-config.txt
+++ b/Documentation/rebase-config.txt
@@ -34,18 +34,19 @@ rebase.instructionFormat::
 rebase.abbreviateCommands::
 	If set to true, `git rebase` will use abbreviated command names in the
 	todo list resulting in something like this:
-
++
 -------------------------------------------
 	p deadbee The oneline of the commit
 	p fa1afe1 The oneline of the next commit
 	...
 -------------------------------------------
-
-	instead of:
-
++
+instead of:
++
 -------------------------------------------
 	pick deadbee The oneline of the commit
 	pick fa1afe1 The oneline of the next commit
 	...
 -------------------------------------------
-	Defaults to false.
++
+Defaults to false.
