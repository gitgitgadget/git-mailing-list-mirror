Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749AFC433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B7D207DE
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 13:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgHTNBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:01:51 -0400
Received: from cloud.peff.net ([104.130.231.41]:36208 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728250AbgHTNBg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 09:01:36 -0400
Received: (qmail 6755 invoked by uid 109); 20 Aug 2020 13:01:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 20 Aug 2020 13:01:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15157 invoked by uid 111); 20 Aug 2020 13:01:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 20 Aug 2020 09:01:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 20 Aug 2020 09:01:25 -0400
From:   Jeff King <peff@peff.net>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        'git' <git@vger.kernel.org>, 'Elijah Newren' <newren@gmail.com>,
        'Brandon Williams' <bwilliams.eng@gmail.com>,
        'Johannes Schindelin' <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 0/2] Allow adding .git files and directories
Message-ID: <20200820130125.GB2522289@coredump.intra.peff.net>
References: <cover.1597853634.git.lukasstraub2@web.de>
 <xmqqr1s2tswd.fsf@gitster.c.googlers.com>
 <04aa01d67659$2dc217b0$89464710$@nexbridge.com>
 <xmqqimdetpuw.fsf@gitster.c.googlers.com>
 <20200819201736.GA2511157@coredump.intra.peff.net>
 <xmqqa6yqtm03.fsf@gitster.c.googlers.com>
 <20200819203825.GA2511902@coredump.intra.peff.net>
 <20200820133445.2bd162a3@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820133445.2bd162a3@luklap>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 20, 2020 at 01:34:45PM +0200, Lukas Straub wrote:

> Yes, there are many workarounds and they work well in the CI usecase. However,
> for the arbitrary files usecase there is no good workaround. I currently use
> a script which iterates over the tree and renames .git -> dotgit before running
> any git command and back again afterwards, but it is slow and brittle. I toyed
> with the idea of writing a FUSE filesystem to do the renaming, but it is
> needlessly complex and hurts performance.
> 
> Really, this problem should be solved in git itself.

It is unclear to me why need to hold many sub-repositories within the
parent one, nor what Git operations you expect to perform over them. And
what disadvantages your script solution has.

Perhaps you can give a more concrete use-case (but before you spend a
lot of time doing so, I'll warn you that I find it pretty unlikely that
it will cross the bar necessary to counter the downsides we've discussed
so far).

-Peff
