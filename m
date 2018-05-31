Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 329951F42D
	for <e@80x24.org>; Thu, 31 May 2018 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755517AbeEaPKi (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 11:10:38 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:56121 "EHLO
        8.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755484AbeEaPKi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 11:10:38 -0400
X-Greylist: delayed 110986 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 May 2018 11:10:37 EDT
Received: from player699.ha.ovh.net (unknown [10.109.122.67])
        by mo69.mail-out.ovh.net (Postfix) with ESMTP id B4A4B17931
        for <git@vger.kernel.org>; Thu, 31 May 2018 16:54:15 +0200 (CEST)
Received: from [192.168.2.66] (62-183-157-47.bb.dnainternet.fi [62.183.157.47])
        (Authenticated sender: kevin@bracey.fi)
        by player699.ha.ovh.net (Postfix) with ESMTPSA id EB5FD2400C9;
        Thu, 31 May 2018 16:54:10 +0200 (CEST)
Subject: Re: Weird revision walk behaviour
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
References: <CAM0VKjkr71qLfksxZy59o4DYCM-x=podsCf6Qv+PzZuSe1gXZw@mail.gmail.com>
 <20180523173246.GA10299@sigill.intra.peff.net>
 <20180523173523.GB10299@sigill.intra.peff.net>
 <869a4045-0527-3dcf-33b3-90de2a45cd51@bracey.fi>
 <cb1d7c86-a989-300a-01d2-923e9c29e834@bracey.fi>
 <20180528220651.20287-1-szeder.dev@gmail.com>
 <20180529210434.GA3857@sigill.intra.peff.net>
 <97644280-2187-d314-37ce-2c79935a63bc@bracey.fi>
 <20180531054355.GA17344@sigill.intra.peff.net>
From:   Kevin Bracey <kevin@bracey.fi>
Message-ID: <28359a94-e584-a963-428d-2cf11f2cb895@bracey.fi>
Date:   Thu, 31 May 2018 17:54:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180531054355.GA17344@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Ovh-Tracer-Id: 907193852124172509
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedriedvgdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 31/05/2018 08:43, Jeff King wrote:
>
> If there are zero parents (neither relevant nor irrelevant), is it still
> TREESAME? I would say in theory yes.

Not sure - I think roots are such a special case that TREESAME 
effectively doesn't matter. We always test for roots first.
>   So what I was proposing would be to
> rewrite the parents to the empty set.
That feels a bit radical - I believe we need to retain (some) parent 
information for modes that show it (eg the dangling unfilled circles in 
gitk). And making it a root I think could cause other problems with 
making it look like we have a disjoint history. I believe the next 
simplification step may be trying to follow down to the common root.
> What next here? It looks like we have a proposed solution. Do you want
> to try to work up a set of tests based on what you wrote earlier?
I was hoping Gábor would carry on, as he's made a start... I was just 
planning to back-seat drive.
> I'd also love to hear from Junio as the expert in this area, but I think
> he's been a bit busy with maintainer stuff recently. So maybe I should
> just be patient. :)
>
Likewise - I have been quite deep into this, but it was a quite short 
window of investigation a long time ago, and I've not looked at it 
since. Would like input from someone with more active knowledge.

Kevin

