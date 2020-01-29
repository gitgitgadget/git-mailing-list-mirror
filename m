Return-Path: <SRS0=89pV=3S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6E9C33C9E
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A078E20CC7
	for <git@archiver.kernel.org>; Wed, 29 Jan 2020 02:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgA2ClZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 21:41:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:47084 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726467AbgA2ClZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 21:41:25 -0500
Received: (qmail 13214 invoked by uid 109); 29 Jan 2020 02:41:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Jan 2020 02:41:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13131 invoked by uid 111); 29 Jan 2020 02:49:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jan 2020 21:48:59 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jan 2020 21:41:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
Message-ID: <20200129024124.GC596379@coredump.intra.peff.net>
References: <1113893dd36a1e8cf72331dd01f36206b44f45ad.1580116685.git.bert.wesarg@googlemail.com>
 <xmqqr1zj6xl6.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr1zj6xl6.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 28, 2020 at 02:11:01PM -0800, Junio C Hamano wrote:

> >  push.default::
> >  	Defines the action `git push` should take if no refspec is
> > -	explicitly given.  Different values are well-suited for
> > -	specific workflows; for instance, in a purely central workflow
> > -	(i.e. the fetch source is equal to the push destination),
> > -	`upstream` is probably what you want.  Possible values are:
> > +	neither explicitly (on the command-line) nor implicitly (via a
> > +	`remote.*.push` config option) given.  Different values are
> > +	well-suited for specific workflows; for instance, in a purely
> > +	central workflow (i.e. the fetch source is equal to the push
> > +	destination), `upstream` is probably what you want.  Possible
> > +	values are:
> >  +
> >  --
> 
> Hmph, I am not sure the act of deliberately setting remote.*.push
> configuration should not count as an explicit request to Git the
> user makes.
> 
> Immediately follows the above, the description of one of the
> possible values read thusly:
> 
>     * `nothing` - do not push anything (error out) unless a refspec is
>       explicitly given. This is primarily meant for people who want to
>       avoid mistakes by always being explicit.
> 
> which may need an adjustment to keep the whole coherent. 

Yeah, you're right. The term "explicit" gets thrown around a fair bit
there.

In that sense my original was slightly better, in that it defines
"explicit" (one might say it even does so...explicitly). But...

> If we have to change anything in the description, I would say that
> we can just drop "explicitly". [...]

Yes, I like dropping that word even better.

Though I'd still slightly worry that somebody might not consider
configured refspecs. Saying more clearly "any refspec no matter where it
comes from" might still be worthwhile. I.e., something like:

  Defines the action `git push` should take if no refspec is given
  (whether from the command-line, config, or elsewhere).

?

-Peff
