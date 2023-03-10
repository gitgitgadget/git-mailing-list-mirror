Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73659C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 09:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCJJKw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 04:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjCJJJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 04:09:56 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC110BA73
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 01:04:52 -0800 (PST)
Received: (qmail 19168 invoked by uid 109); 10 Mar 2023 09:04:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Mar 2023 09:04:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10373 invoked by uid 111); 10 Mar 2023 09:04:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Mar 2023 04:04:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 10 Mar 2023 04:04:19 -0500
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Paul Smith <paul@mad-scientist.net>, git@vger.kernel.org
Subject: Re: Fetching everything in another bare repo
Message-ID: <ZArykwkX827/Qpi3@coredump.intra.peff.net>
References: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
 <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
 <64282d0f99df59085a18585846d2086a652677e2.camel@mad-scientist.net>
 <ZAn80gnIFLOF4Gco@coredump.intra.peff.net>
 <20230309175718.j5c2dbx3asphiqhu@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230309175718.j5c2dbx3asphiqhu@meerkat.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 12:57:18PM -0500, Konstantin Ryabitsev wrote:

> > I will also say that while I implemented this extension a while back, it
> > never actually saw production use for my intended case. So I think it's
> > pretty good (and certainly safer than nothing), but it's not thoroughly
> > tested in the wild.
> 
> We use it in grokmirror for objstore repositories [1] (the super-parents of
> all forks), as a precautionary measure against a sysadmin running any kind of
> manual operation that may result in loose objects being deleted. I do believe
> it works well for that purpose.

Ah, cool, thanks for letting us know. That's pretty much the same case I
wrote it for (GitHub's shared-object-store fork repositories), but
deployment got hung up on compatibility issues (since we used libgit2,
as well). And then I never got around to it, and nobody seems to have
cared too much. It's a nice safety to have, but I don't recall a single
instance of an unintended naive gc ever destroying things. :)

-Peff
