Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A050C7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 07:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjDFHTT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 03:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDFHTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 03:19:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D859B59D6
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 00:19:15 -0700 (PDT)
Received: (qmail 12665 invoked by uid 109); 6 Apr 2023 07:19:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Apr 2023 07:19:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23593 invoked by uid 111); 6 Apr 2023 07:19:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Apr 2023 03:19:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 Apr 2023 03:19:14 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Subject: Re: [PATCH] doc: asciidoc: remove custom header macro
Message-ID: <20230406071914.GA2143526@coredump.intra.peff.net>
References: <20230323221523.52472-1-felipe.contreras@gmail.com>
 <20230406035729.GA2092667@coredump.intra.peff.net>
 <CAMP44s2u4tj7hUZHZ9H4qsJGp1a=Y=YUTBAxmSzftdfHX_HqwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s2u4tj7hUZHZ9H4qsJGp1a=Y=YUTBAxmSzftdfHX_HqwQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 06, 2023 at 01:18:36AM -0500, Felipe Contreras wrote:

> > and even today still does not seem to handle manversion.
> 
> Why do we need `manversion`?
> 
> All that it's used for is in the DocBook Stylesheets to join the
> source name and the version, even its own documentation explains what
> it looks like in practice [3]:
> 
>   In practice, there are many pages that simply have a version number
> in the "source" field. So, it looks like what we have is a two-part
> field, Name Version
> 
> So if we have `source="Git"`, and `version="2.4.0"`, we can just have
> `source="Git 2.40.0"`.
> 
> Why do we have to split that information only for the DocBook
> Stylesheets to join it in?

I don't know of any particular reason why we couldn't put both in the
source field.

I had forgotten we discussed this 2 years ago.

> >   Aside: If we think asciidoctor 1.5.7 is recent enough to rely on, then
> >   we might want to simplify our hack to just output manversion.
> 
> There is no need for any hack: we can just set the "mansource"
> attribute to "Git $(GIT_VERSION)", and everything will work correctly
> for both asciidoc and asciidoctor in all backends.
> 
> Why do we insist on hacks for asciidoc.py/2007 and asciidoc|docbook5/2017?
> 
> Especially when I sent the fix for *everything* in 2021 [4].

You say "insist" like somebody is arguing for it. It looks like the
series you linked got some review comments, and you followed-up. I
didn't carefully read the re-rolls (then or now), but the original
patches seem like a good direction to me.

Looking at the timing in the archive, I suspect that inter-personal
drama in other threads caused people not to read those re-rolls.

At any rate, I don't think any of that needs to hold up this patch,
which is not touching the asciidoctor side at all (I only wondered while
reviewing it what the implications might be).

-Peff
