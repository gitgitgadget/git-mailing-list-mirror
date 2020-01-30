Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FADC33C9E
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69CBF206D5
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 10:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgA3KGz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:06:55 -0500
Received: from cloud.peff.net ([104.130.231.41]:48340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726882AbgA3KGz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 05:06:55 -0500
Received: (qmail 27860 invoked by uid 109); 30 Jan 2020 10:06:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Jan 2020 10:06:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22727 invoked by uid 111); 30 Jan 2020 10:14:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jan 2020 05:14:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jan 2020 05:06:54 -0500
From:   Jeff King <peff@peff.net>
To:     edef <edef@edef.eu>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: don't discard names under 3 characters
Message-ID: <20200130100654.GA840101@coredump.intra.peff.net>
References: <20191220003948.60272-1-edef@edef.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191220003948.60272-1-edef@edef.eu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 20, 2019 at 12:39:48AM +0000, edef wrote:

> I sometimes receive patches from people with short mononyms, and in my
> cultural environment these are not uncommon. To my dismay, git-am
> currently discards their names, and replaces them with their email
> addresses.
> 
> Link: https://www.kalzumeus.com/2010/06/17/falsehoods-programmers-believe-about-names/
> ---
> I'm not *completely* sure there's even a case where `src = email` is 
> the right thing to do, but I'd rather not modify this code more than 
> strictly necessary.

I think this makes sense. There's a lot of heuristic voodoo in this old
mailinfo code, but I think getting people's legitimate short names wrong
is worse than the likelihood that this is actually helping some
broken-parsing case in any meaningful way. I suspect this code predates
us parsing the headers carefully according to the standard (it looks to
be from 2744b2344d on 2005-04-11, which is quite early!).

The 60-char maximum also seems like something people might run afoul of
in certain cultures. Is it worth bumping, too?

I think your patch slipped through the cracks, coming as it did over the
holidays. It's probably worth re-posting it (with your signed-off-by).

-Peff
