Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDCCC433DF
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF172076C
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 18:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgHKSQD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 14:16:03 -0400
Received: from aibo.runbox.com ([91.220.196.211]:52400 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgHKSQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 14:16:03 -0400
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Aug 2020 14:16:02 EDT
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <antti@keraset.fi>)
        id 1k5YoS-0001aP-Bl; Tue, 11 Aug 2020 20:15:52 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated alias (932218)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1k5YoE-0007OY-9S; Tue, 11 Aug 2020 20:15:38 +0200
Date:   Tue, 11 Aug 2020 21:15:37 +0300
From:   Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     phillip.wood@dunelm.org.uk,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
References: <20200811131313.3349582-1-detegr@rbx.email>
 <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
 <20200811153621.GD19871@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200811153621.GD19871@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip and Taylor.

On Tue, Aug 11, 2020 at 04:32:37PM +0100, Phillip Wood wrote:
> > I'm not sure it's worth rearranging these lines. It probably does not matter
> > but we could do
> >
> > +	char shortonto[GIT_MAX_HEXSZ + 1];
> >
> > and then later call find_unique_abbrev_r() instead so we don't have to worry
> > about freeing shortonto.

I like this. I'll change the code, if the rest of the patch is okay.

> > Thanks for taking the trouble to add a test, I think all the lines above
> > could be simplified to
> >
> > 	GIT_SEQUENCE_EDITOR=cat git rebase -i HEAD~5 branch1 >actual

Nice! :) There was a test called 'todo count' which I mimicked. This
obviously is much cleaner solution, thanks.

> > we could lose the final .*

Ack.

On Tue, Aug 11, 2020 at 11:36:21AM -0400, Taylor Blau wrote:
> Ack, I noticed this too during my review, but apparently forgot to
> comment on it. I'm puzzled by the first '..*'. If you're searching for
> any non-empty string, how about '.+' instead?

That's true. Good point. I pretty much copy&pasted the 'todo count' test
so I didn't give this much thought. I'll fix this.

-- 
Antti
