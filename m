Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFD1C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjBALYd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:24:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbjBALYT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:24:19 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480113801A
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:24:02 -0800 (PST)
Received: (qmail 31465 invoked by uid 109); 1 Feb 2023 11:24:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 11:24:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19222 invoked by uid 111); 1 Feb 2023 11:24:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 06:24:01 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 06:24:00 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rick van Rein <rick@openfortress.nl>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@github.com>
Subject: Re: Git over HTTP; have flexible SASL authentication
Message-ID: <Y9pL0D2WuKqqwB7X@coredump.intra.peff.net>
References: <20230127163434.GA784@openfortress.nl>
 <xmqq7cx7aov7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cx7aov7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 27, 2023 at 09:06:36AM -0800, Junio C Hamano wrote:

> Rick van Rein <rick@openfortress.nl> writes:
> 
> > Git providers are inventing proprietary extensions to HTTP authentication
> > for Git.  It seems smarter to use SASL for this purpose, possibly allowing
> > the client a choice and authentication ringback to the client's own domain.
> 
> To adopt things like this, the work to extend how to make extensible
> what is on WWW-Authenticate in the thread that contains this recent
> message https://lore.kernel.org/git/Y9LvFMzriAWUsS58@coredump.intra.peff.net/
> may be relevant, perhaps?

It's relevant, but I think there's a ways to go. That is just about
passing WWW-Authenticate headers to helpers, which can then try to make
sense of them. But Git would still only understand getting back a
username/password from the helper, and passing it along to curl. And
hopefully we'd do it all through curl's SASL support, and not invent our
own handling.

I'm not sure what all that might might look like. I'm sure Matthew has
probably thought about it, so I'll let him say something more
intelligent. :)

-Peff
