Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762AFC43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C802077D
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 10:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgDAKRS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:17:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:58038 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725860AbgDAKRS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 06:17:18 -0400
Received: (qmail 1168 invoked by uid 109); 1 Apr 2020 10:17:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 01 Apr 2020 10:17:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6669 invoked by uid 111); 1 Apr 2020 10:27:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Apr 2020 06:27:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Apr 2020 06:17:16 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.ath.cx>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/6] Doc: drop support for docbook-xsl before 1.74
Message-ID: <20200401101716.GC60227@coredump.intra.peff.net>
References: <20200330094513.GB1735224@coredump.intra.peff.net>
 <20200331192600.588-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200331192600.588-1-martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 31, 2020 at 09:26:00PM +0200, Martin Ågren wrote:

> But most importantly: When I looked into the history, I came upon
> c2a7f5d438 ("docs: monospace listings in docbook output", 2012-08-07),
> which made me worry about breaking "make info". On second thought, I
> might have broken it many times already over the past few years, since
> I've never built the info. So maybe worrying about that all of a sudden
> is a bit unfounded in a way. :-/
> 
> (I tried to build "info" while working on this. It works in the sense
> that it doesn't error out, but I don't get anything that looks remotely
> useful. I've never used info at all though, to be honest, so could be
> missing something fundamental.)

I don't find "info" useful, either. The big thing it offers over "man"
is actual hyperlinks, but linkgit attributes (the only thing we actually
bother annotating) don't seem to actually become links! These days I'd
expect most people interested in hyperlinking to just use HTML.  I
wouldn't be surprised if there's some emacs integration with info,
though, so maybe people use it there. I dunno. I'd be happy to see all
of the info bits go away.

I've add brian to the cc, since he was the last person to touch texi
stuff (though he may have just been doing it out of a sense of
cleanup/duty).

The .texi generated for the user-manual is the same before and after
your patch, so I think it's OK to do.

There _is_ an older regression in the user-manual, though. After commit
03920ac69b (asciidoctor: fix user-manual to be built by `asciidoctor`,
2017-01-02), the whole front-matter is missing from the generated
"git.info" file, and there's a funky ": idm4" node. Nobody seems to have
noticed or complained since then (though perhaps people are more likely
to look at the manpages than the user manual).

> -- >8 --
> Subject: [PATCH 7/6?] user-manual.conf: don't specify [listingblock]

Yeah, this looks good to me (and it looks like Junio already picked it
up on top of your series).

-Peff
