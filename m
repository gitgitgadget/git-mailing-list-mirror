Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA27C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81D16191D
	for <git@archiver.kernel.org>; Tue, 11 May 2021 06:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhEKGLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 02:11:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:50168 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229840AbhEKGLe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 02:11:34 -0400
Received: (qmail 21167 invoked by uid 109); 11 May 2021 06:10:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 06:10:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20545 invoked by uid 111); 11 May 2021 06:10:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 02:10:29 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 02:10:27 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 1/8] compat/terminal: let prompt accept input from pipe
Message-ID: <YJof0/Eq18QnLumV@coredump.intra.peff.net>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <20210506165102.123739-2-firminmartin24@gmail.com>
 <xmqqr1ijwi0i.fsf@gitster.g>
 <YJTH+sTP/O5Nxtp9@coredump.intra.peff.net>
 <875yzrgr1f.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
 <YJmmXZdwSoR+vxjw@coredump.intra.peff.net>
 <xmqq1raeos7x.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1raeos7x.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 12:38:10PM +0900, Junio C Hamano wrote:

> >> I actually inspired myself from the two occurrences of git_prompt in
> >> builtin/bisect--helper.c introduced in 09535f056b (bisect--helper:
> >> reimplement `bisect_autostart` shell function in C, 2020-09-24).
> >> Not sure if they should also be converted to a simple fgets.
> >
> > Yes, I think they should be switched.
> 
> OK, that is because in the context of a "bisect" session, we won't
> be feeding any real data from its standard input, unlike "git am"
> that may well be eating a patch stream from its standard input
> stream.  If so, makes sense.

Yes, though even in "git am", we forbid using interactive mode with
patches on stdin (and did so even when we were reading from the tty;
presumably the rule dates back to when it was a shell script and was
using stdin).

-Peff
