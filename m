Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1F3FA373E
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 20:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJVUZW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 16:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJVUZV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 16:25:21 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2606F6B150
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 13:25:18 -0700 (PDT)
Received: (qmail 20959 invoked by uid 109); 22 Oct 2022 20:25:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 22 Oct 2022 20:25:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3289 invoked by uid 111); 22 Oct 2022 20:25:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 22 Oct 2022 16:25:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 22 Oct 2022 16:25:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/3] config: require at least one digit when parsing
 numbers
Message-ID: <Y1RRrK4/2vr/YPfz@coredump.intra.peff.net>
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
 <cd753602e48a2faa0d59edca2f6fab0fe753f0f6.1666359915.git.gitgitgadget@gmail.com>
 <Y1L+Qv+cs1bjqjK9@coredump.intra.peff.net>
 <xmqqilkbhhlw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilkbhhlw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 22, 2022 at 10:51:23AM -0700, Junio C Hamano wrote:

> > This one is easier to test than the last. Just:
> >
> >   git config --int --default='m' some.key
> >
> > works. And even playing devil's advocate, I can't think of a case where
> > anybody would rely on the current behavior.
> 
> Hmph, but --default=" m" would not be caught with the patch with the
> same error, but is still a valid way to say zero mega unit.

I assumed that --default=" m" was supposed to be an error. It is already
in the current code (because strtoimax doesn't skip the whitespace).

I admit I don't care much either way, though.

-Peff
