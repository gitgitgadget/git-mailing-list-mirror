Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2EEC001DB
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 14:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbjHKOoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 10:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbjHKOoR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 10:44:17 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342302D43
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 07:44:16 -0700 (PDT)
Received: (qmail 14575 invoked by uid 109); 11 Aug 2023 14:44:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Aug 2023 14:44:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25889 invoked by uid 111); 11 Aug 2023 14:44:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Aug 2023 10:44:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Aug 2023 10:44:03 -0400
From:   Jeff King <peff@peff.net>
To:     phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] t4053: avoid race when killing background processes
Message-ID: <20230811144403.GA2303200@coredump.intra.peff.net>
References: <pull.1571.git.1691677993195.gitgitgadget@gmail.com>
 <xmqqedkassng.fsf@gitster.g>
 <2d9e9b59-bf78-8470-0731-3cd7fe15a727@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d9e9b59-bf78-8470-0731-3cd7fe15a727@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 10:56:40AM +0100, Phillip Wood wrote:

> This is only a fix for the test failure that Peff saw when running with
> --stress.
> 
> > which
> > presumably is a symptom that somebody is trying to read from
> > a pipe that nobody is making progress to write into?
> 
> That or a process blocking when tying to open a fifo seems the mostly likely
> cause but I can't see where that is happening. As you say this patch does
> not obviously change anything that would be causing the test to hang.

Yeah, sorry if my initial report was unclear. It was while digging for
the cause of the hang that I ran into the racy failures. This patch
looks good for fixing the race. I'm still waiting to hit the hang again
to get more data. But if it never happens again, then that is a success
of sorts. :)

-Peff
