Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FE6C43460
	for <git@archiver.kernel.org>; Thu,  6 May 2021 17:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0951F6103E
	for <git@archiver.kernel.org>; Thu,  6 May 2021 17:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbhEFRHc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 13:07:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:46598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236188AbhEFRH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 13:07:29 -0400
Received: (qmail 30398 invoked by uid 109); 6 May 2021 17:06:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 May 2021 17:06:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23563 invoked by uid 111); 6 May 2021 17:06:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 May 2021 13:06:30 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 6 May 2021 13:06:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>, git@vger.kernel.org
Subject: Re: git send-email says AUTH is unknown command?
Message-ID: <YJQiFYYENfsZk7B+@coredump.intra.peff.net>
References: <878s4sc7gr.fsf@vps.thesusis.net>
 <87k0obvqa1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87k0obvqa1.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 06, 2021 at 05:22:31PM +0200, Ævar Arnfjörð Bjarmason wrote:

> 
> On Thu, May 06 2021, Phillip Susi wrote:
> 
> > git send-email prompts for my SMTP password then says:
> > Command unknown: 'AUTH' at /usr/lib/git-core/git-send-email line 1573.
> >
> > That line reads:
> >
> > smtp_auth_maybe or die $smtp->message;
> >
> > Why is it complaining that it does not know what AUTH means?  It is
> > connecting to port 25 and /should/ be using STARTTLS.
> 
> This message is from your server indirectly, i.e. there is no AUTH verb
> supported by it.
> 
> I'm almost certain that you'll find that you cannot in fact auth on port
> 25 on this server, and must use another port to do SSL from the start,
> i.e. not STARTSSL[1].

Alternatively, it may be that the server would prefer port 587 (with
STARTTLS), which is typically used for "submission" (i.e., originating
new messages from authenticated users, versus the normal port 25 for
MTA's routing messages between them).

-Peff
