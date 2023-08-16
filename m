Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F6AC001DE
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 02:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241262AbjHPCYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 22:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241326AbjHPCYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 22:24:24 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F291FDF
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 19:24:22 -0700 (PDT)
Received: (qmail 4579 invoked by uid 109); 16 Aug 2023 02:24:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Aug 2023 02:24:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14096 invoked by uid 111); 16 Aug 2023 02:24:23 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Aug 2023 22:24:23 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Aug 2023 22:24:20 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Andy Koppe <andy.koppe@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: main != master at github.com/git/git
Message-ID: <20230816022420.GA2248431@coredump.intra.peff.net>
References: <20230715103758.3862-1-andy.koppe@gmail.com>
 <20230715160730.4046-1-andy.koppe@gmail.com>
 <kl6l351j22dr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CAHWeT-ZA8f-TGRwDHixAvi5kddVBbuK8LpVGJ9cjYZMsMk5ODw@mail.gmail.com>
 <xmqq7cpwjhr1.fsf@gitster.g>
 <006574bd-4d53-495e-8cfe-677ede521908@gmail.com>
 <xmqq350kjfk8.fsf@gitster.g>
 <ce5d20db-2220-45dd-8c39-2a52e0f9f816@gmail.com>
 <ZNv5PQlkn6tbUcH7@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNv5PQlkn6tbUcH7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2023 at 06:16:29PM -0400, Taylor Blau wrote:

> > An alternative might be to exclude one of the branches in the workflow file,
> > as per [1].
> 
> I think that this should be relatively straightforward to do, and would
> be preferable to dropping 'main'.

That was my inclination, too, though I wonder if that might cause
hassles for Git for Windows:

  $ git ls-remote --symref https://github.com/git-for-windows/git HEAD
  ref: refs/heads/main	HEAD
  a67b85bf88ddbccae96714edb64d741ddfc3a1c9	HEAD

I'm not sure how big a deal it would be in practice. Obviously they
carry patches that are not in upstream git and could adjust the file
themselves that way. But it might introduce extra friction, and in my
experience changes to "meta" files like this can be a hassle, because
you often want them independently on every branch (though in theory this
one only matters for the "main" branch itself).

So I won't say it's obviously a bad idea, but it might bear some
thinking on what the ramifications would be for downstream.

-Peff
