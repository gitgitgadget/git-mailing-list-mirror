Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A76EB64DC
	for <git@archiver.kernel.org>; Tue, 27 Jun 2023 08:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjF0I0t (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Jun 2023 04:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjF0I0j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2023 04:26:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EA22955
        for <git@vger.kernel.org>; Tue, 27 Jun 2023 01:26:23 -0700 (PDT)
Received: (qmail 1897 invoked by uid 109); 27 Jun 2023 08:26:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Jun 2023 08:26:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14966 invoked by uid 111); 27 Jun 2023 08:26:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Jun 2023 04:26:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Jun 2023 04:26:22 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/5] strbuf: factor out strbuf_expand_step()
Message-ID: <20230627082622.GH1226768@coredump.intra.peff.net>
References: <767baa64-20a6-daf2-d34b-d81f72363749@web.de>
 <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caf8e100-1308-cb4e-d61a-4e15ee3f47f7@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 17, 2023 at 10:41:44PM +0200, René Scharfe wrote:

> Extract the part of strbuf_expand that finds the next placeholder into a
> new function.  It allows to build parsers without callback functions and
> the overhead imposed by them.
> 
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/branch.c | 13 ++-----------
>  strbuf.c         | 28 ++++++++++++++--------------
>  strbuf.h         |  8 ++++++++
>  3 files changed, 24 insertions(+), 25 deletions(-)

I was a little surprised to see the change in branch.c here (as well as
the one in strbuf_addftime), since the commit message just says
"extract..." and doesn't mention them.

They do serve as examples of how it can be used, so I think it's OK. But
it made me wonder: is this all of the sites? Or are these just examples?

-Peff
