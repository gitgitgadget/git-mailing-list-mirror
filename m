Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBACEB64D9
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 20:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjF0UWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjF0UWG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 16:22:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642D2700
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 13:22:00 -0700 (PDT)
Received: (qmail 17087 invoked by uid 109); 27 Jun 2023 20:22:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 20:22:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20990 invoked by uid 111); 27 Jun 2023 20:22:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 16:22:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 16:21:59 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 5/5] strbuf: simplify strbuf_expand_literal_cb()
Message-ID: <20230627202159.GC1358527@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <ded69969-158d-b05f-fdd4-91b26e9b502b@web.de>
 <20230627085701.GK1226768@coredump.intra.peff.net>
 <3654f95d-5709-28f6-eeb2-ca62a1ee789c@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3654f95d-5709-28f6-eeb2-ca62a1ee789c@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2023 at 06:32:22PM +0200, René Scharfe wrote:

> A format-advancing version would also look a bit weird in an if/else
> cascade:
> 
> 	else if (strbuf_expand_literal(&sb, &format))
> 		; /* nothing */
> 	else ...
> 
> > I dunno. It is a little thing, and I am OK with it either way (I would
> > not even think of changing it if you were not already touching the
> > function).
> 
> Unsure.  Should I overcome my horror vacui and let the /* nothing */ in?

Heh. It is a little funny to have an empty block. But at the same time,
it aligns the conditional with all of the skip_prefix() calls, which are
advancing "format" as a side effect of matching.

So I could go either way (and we can always change it on top).

I think based on your responses that there's nothing that would require
a re-roll. The only thing left from my review is the extra parentheses
in format_commit_item, which could possibly be fixed up while applying.

-Peff
