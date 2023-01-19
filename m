Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9246BC677F1
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 02:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjASCHd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 21:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjASCHc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 21:07:32 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042FA51428
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 18:07:29 -0800 (PST)
Received: (qmail 5650 invoked by uid 109); 19 Jan 2023 02:07:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 02:07:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28045 invoked by uid 111); 19 Jan 2023 02:07:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 21:07:31 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 21:07:27 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/6] fsck: provide a function to fsck buffer without
 object struct
Message-ID: <Y8il34JHhEqLkdnC@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8haCbAQIV9s/95l@coredump.intra.peff.net>
 <Y8hjiWUAIuiWfJoD@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hjiWUAIuiWfJoD@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 04:24:25PM -0500, Taylor Blau wrote:

> On Wed, Jan 18, 2023 at 03:43:53PM -0500, Jeff King wrote:
> > However, the only external interface that fsck.c provides is
> > fsck_object(), which requires an object struct, then promptly discards
> > everything except its oid and type. Let's factor out the post-discard
> > part of that function as fsck_buffer(), leaving fsck_object() as a thin
> > wrapper around it. That will provide more flexibility for callers which
> > may not have a struct.
> 
> It's really nice that the only thing we care about having an object
> struct around for is basically just knowing its type. IOW it seems to
> have made the refactoring here pretty straightforward, which is nice
> ;-).

Yeah, it was always in the back of my mind while doing other fsck
refactors. But I have to admit that I was surprised that we were so
close to the finish line. :)

-Peff
