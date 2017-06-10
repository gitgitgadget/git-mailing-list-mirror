Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFFA11FAEB
	for <e@80x24.org>; Sat, 10 Jun 2017 09:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751918AbdFJJFk (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Jun 2017 05:05:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:37582 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbdFJJFj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2017 05:05:39 -0400
Received: (qmail 5893 invoked by uid 109); 10 Jun 2017 09:05:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 09:05:38 +0000
Received: (qmail 29808 invoked by uid 111); 10 Jun 2017 09:05:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 10 Jun 2017 05:05:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Jun 2017 05:05:36 -0400
Date:   Sat, 10 Jun 2017 05:05:36 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/8] help: use early config when autocorrecting aliases
Message-ID: <20170610090536.zqsiqi72ffpqt2ue@sigill.intra.peff.net>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
 <2be3d75cd3341c1386f97c77cc63bec89c1f6a47.1496951503.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2be3d75cd3341c1386f97c77cc63bec89c1f6a47.1496951503.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 08, 2017 at 09:53:38PM +0200, Johannes Schindelin wrote:

> Git has this feature which suggests similar commands (including aliases)
> in case the user specified an unknown command.
> 
> This feature currently relies on a side effect of the way we expand
> aliases right now: when a command is not a builtin, we use the regular
> config machinery (meaning: discovering the .git/ directory and
> initializing global state such as the config cache) to see whether the
> command refers to an alias.
> 
> However, we will change the way aliases are expanded in the next
> commits, to use the early config instead. That means that the
> autocorrect feature can no longer discover the available aliases by
> looking at the config cache (because it has not yet been initialized).
> 
> So let's just use the early config machinery instead.
> 
> This is slightly less performant than the previous way, as the early
> config is used *twice*: once to see whether the command refers to an
> alias, and then to see what aliases are most similar. However, this is
> hardly a performance-critical code path, so performance is less important
> here.

Good explanation, and the patch looks obviously correct.

-Peff
