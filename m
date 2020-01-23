Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB17C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2594A21D7E
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAWT1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:27:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:42904 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727590AbgAWT1I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:27:08 -0500
Received: (qmail 28759 invoked by uid 109); 23 Jan 2020 19:27:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 23 Jan 2020 19:27:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2638 invoked by uid 111); 23 Jan 2020 19:34:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 23 Jan 2020 14:34:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 23 Jan 2020 14:27:07 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] gitk: to run in a bare repository (was: gitk can't be
 run from non-worktree folders)
Message-ID: <20200123192707.GA110440@coredump.intra.peff.net>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
 <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
 <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 11:20:36AM -0800, Junio C Hamano wrote:

> -- >8 --
> Subject: [PATCH] gitk: be prepared to be run in a bare repository

Thanks all for cleaning up the mess I caused. I do prefer adjusting gitk
like this rather than reverting the change in Git. Despite the
regression, I think the case of "--show-toplevel without a working tree"
is sufficiently undefined that it's probably good for callers to
actually decide what the right behavior is.

> Recent versions of git however notices that "rev-parse --show-toplevel"
> executed in a bare repository is an error, which makes gitk stop,
> even before the user could attempt to run external diff.

It might be worth mentioning 2d92ab32 by name in this paragraph of the
commit message.

-Peff
