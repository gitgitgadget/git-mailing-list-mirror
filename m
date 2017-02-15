Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8932013A
	for <e@80x24.org>; Wed, 15 Feb 2017 21:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752173AbdBOVWC (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 16:22:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:55977 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdBOVWB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 16:22:01 -0500
Received: (qmail 22467 invoked by uid 109); 15 Feb 2017 21:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 21:22:00 +0000
Received: (qmail 17547 invoked by uid 111); 15 Feb 2017 21:22:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Feb 2017 16:22:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Feb 2017 16:21:58 -0500
Date:   Wed, 15 Feb 2017 16:21:58 -0500
From:   Jeff King <peff@peff.net>
To:     Fabrizio Cucci <fabrizio.cucci@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Back quote typo in error messages (?)
Message-ID: <20170215212157.qgscyglgzrd5cplf@sigill.intra.peff.net>
References: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOxYW4z=bABqhmHWCc9rizykMcGBjDvqLEuqpJ6DtPve5442Fw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 09:06:46PM +0000, Fabrizio Cucci wrote:

> it's been a couple of days that I keep noticing something (very minor)
> that my OCD for symmetric things can't really stand.
> 
> If you run the following command:
> 
> $ git branch --i-dont-exists
> 
> you should get:
> 
> error: unknown option `i-dont-exists'
> 
> Shouldn't the wrong flag be surrounded by two single quotes instead of
> a back quote and a single quote?

Some people use the matched backtick/single-quote to emulate the
non-symmetric start/end quotes used in traditional typography (and in
fact, ``foo'' in languages like asciidoc are typically rendered using
smart-quotes).

So I think what you are seeing is not wrong in the sense of being
unintended by the author of the message. But I do think that git mostly
uses matched double or single quotes in its error messages, and the
non-symmetric quotes are relatively rare. Running:

  git grep "\`.*'" -- '*.c' ':!compat'

shows that there are only a few `quoted' cases in the code base (there
are 27 matches, but many of those are false positives, and some are in
comments).

I don't know how much we care about standardizing that punctuation. If
we do, I suspect there is also inconsistency between single-quotes and
double-quotes ('foo' versus "foo", which I think is an American versus
European thing; we seem to mostly use 'foo', though).

-Peff
