Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDF1C433E1
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6340A20702
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 21:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391334AbgFWVOa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:14:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:41000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389409AbgFWVO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 17:14:29 -0400
Received: (qmail 14203 invoked by uid 109); 23 Jun 2020 21:14:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Jun 2020 21:14:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22135 invoked by uid 111); 23 Jun 2020 21:14:28 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Jun 2020 17:14:28 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 23 Jun 2020 17:14:26 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, don@goodman-wilson.com, stolee@gmail.com,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 11/12] submodule: use the correct default for the main
 branch name
Message-ID: <20200623211426.GA2072288@coredump.intra.peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
 <59d6267f099f30f830836a2422289bc83f5c35e5.1592225416.git.gitgitgadget@gmail.com>
 <20200616134618.GI666057@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2006232259320.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2006232259320.54@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 11:03:57PM +0200, Johannes Schindelin wrote:

> > [use HEAD instead of master]
> This is the route that I am taking.
> [...]
> This is of course a bit worrisome, as there might actually be users out
> there relying on the confusing behavior.
> 
> However, I think it is okay to fix this:
> 
> - The `git submodule update --remote` command does not strike me as
>   awfully common. In fact, I had never heard of it before I worked on this
>   here patch.
> 
> - Current Git's behavior when running this command is outright confusing,
>   unless the remote repository's current branch _is_ `master` (in which
>   case the proposed behavior matches the old behavior).
> 
> - It is actually easily fixed by setting `submodule.<name>.branch` to
>   `master` _iff_ users want to reinstate the old behavior.

Thanks, I agree that this is the best way forward, and that the current
confusing behavior is as likely to be doing the wrong thing as the right
(when it even differs).

-Peff
