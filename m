Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0612520958
	for <e@80x24.org>; Fri, 24 Mar 2017 00:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932790AbdCXAuG (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 20:50:06 -0400
Received: from [104.130.231.41] ([104.130.231.41]:50747 "EHLO cloud.peff.net"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752601AbdCXAsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 20:48:25 -0400
Received: (qmail 1980 invoked by uid 109); 24 Mar 2017 00:40:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Mar 2017 00:40:21 +0000
Received: (qmail 13124 invoked by uid 111); 24 Mar 2017 00:40:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 20:40:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 20:40:19 -0400
Date:   Thu, 23 Mar 2017 20:40:19 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] completion: extract completing ctags symbol names
 into helper function
Message-ID: <20170324004018.rqtcrx7oewaooizh@sigill.intra.peff.net>
References: <20170323153839.24283-1-szeder.dev@gmail.com>
 <20170323153839.24283-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170323153839.24283-3-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 04:38:38PM +0100, SZEDER Gábor wrote:

> The previous commit doubled the number of __git_match_ctag()'s
> positional parameters, and, to keep the position of existing
> parameters for the sake of backwards compatibility, the prefix,
> current word and suffix parameters ended up in different order than in
> other functions accepting the same parameters.  Then there is a
> condition checking the existence of the tag file before invoking this
> function.
> 
> We could still live with this if there were only a single callsite,
> but the next commit will add a few more, so it's worth providing a
> cleaner interface.
> 
> Add the wrapper function __git_complete_symbol(), which encompasses
> the condition for checking the presence of the tag file and filling
> COMPREPLY, and accepts '--opt=val'-style options with default values
> that keep callsites simpler.

Nice cleanup. The resulting code in _git_grep() is much more readable.

I use the same completion for "vim -t". Now I can cheat and switch it to
__git_complete_symbol. :)

-Peff
