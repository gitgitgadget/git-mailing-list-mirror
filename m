Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064EAC25B08
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 06:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238812AbiHQGUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 02:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiHQGUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 02:20:16 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8567172
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 23:20:14 -0700 (PDT)
Received: (qmail 6715 invoked by uid 109); 17 Aug 2022 06:20:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Aug 2022 06:20:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13872 invoked by uid 111); 17 Aug 2022 06:20:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Aug 2022 02:20:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 17 Aug 2022 02:20:12 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/6] fix pipe_command() deadlock
Message-ID: <YvyInMFWAVXsSQ5B@coredump.intra.peff.net>
References: <Yu/5LU+ZhbVRnSdM@coredump.intra.peff.net>
 <72d007c5-9429-1612-24d7-af5db906dd63@web.de>
 <YvQO4ZYI8/fAk0Gj@coredump.intra.peff.net>
 <77244ffe-41c1-65bd-8984-8ed6909ffe07@web.de>
 <YvTCIVN2VBir7WEP@coredump.intra.peff.net>
 <976ac297-28ec-0a38-c4e1-eb7b94d0eb8c@web.de>
 <YvVIYyA8Js0WDAMc@coredump.intra.peff.net>
 <c7c6524c-4f02-10f6-1a58-738cef5aecf2@web.de>
 <Yvx/FNlTx+DCiCOj@coredump.intra.peff.net>
 <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2022 at 02:04:05AM -0400, Jeff King wrote:

> On Wed, Aug 17, 2022 at 01:39:32AM -0400, Jeff King wrote:
> 
> > I wouldn't be opposed to that, in the sense that it's supposed to be a
> > black box to the caller, and it's relatively small in size. But I think
> > we're pretty close to having something usable without that, so I'd like
> > to pursue a smaller fix in the interim.
> 
> So here's what I came up with. Most of the changes are done as
> preparatory steps, so I believe the final commit should just work out of
> the box for you, as well as on Windows CI (which I just kicked off).

The Windows CI did indeed complete successfully, though I'm not too
surprised, since it never hit the blocking/deadlock case in the first
place. I _think_ from our conversation that it should work for you, too,
but please let me know. Fingers crossed. :)

-Peff
