Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ABE92013E
	for <e@80x24.org>; Fri,  3 Mar 2017 05:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdCCFSg (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 00:18:36 -0500
Received: from cloud.peff.net ([104.130.231.41]:37674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdCCFSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 00:18:35 -0500
Received: (qmail 3440 invoked by uid 109); 3 Mar 2017 05:17:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 05:17:24 +0000
Received: (qmail 24848 invoked by uid 111); 3 Mar 2017 05:17:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 00:17:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 00:17:21 -0500
Date:   Fri, 3 Mar 2017 00:17:21 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Braun <thomas.braun@virtuell-zuhause.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: log -S/-G (aka pickaxe) searches binary files by default
Message-ID: <20170303051721.r6pahs4vjtqqoevc@sigill.intra.peff.net>
References: <7a0992eb-adb9-a7a1-cfaa-3384bc4d3e5c@virtuell-zuhause.de>
 <CAPc5daVSY5Z_+cpT1dHY-cM-TzNeu+Vzv+zouoOHW08PTFRQ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPc5daVSY5Z_+cpT1dHY-cM-TzNeu+Vzv+zouoOHW08PTFRQ7A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 05:36:17PM -0800, Junio C Hamano wrote:

> On Thu, Mar 2, 2017 at 4:52 PM, Thomas Braun
> <thomas.braun@virtuell-zuhause.de> wrote:
> >
> > I happen to have quite large binary files in my repos.
> >
> > Today I realized that a line like
> > git log -G a
> > searches also files found to be binary (or explicitly marked as binary).
> >
> > Is that on purpose?
> 
> No, it's a mere oversight (as I do not think I never even thought
> about special casing binary
> files from day one, it is unlikely that you would find _any_ old
> version of Git that behaves
> differently).

The email focuses on "-G", and I think it is wrong to look in binary
files there, as "grep in diff" does not make sense for a binary file
that we would refuse to diff.

But the subject also mentions "-S". I always assumed it was intentional
to look in binary files there, as it is searching for a pure byte
sequence. I would not mind an option to disable that, but I think the
default should remain on.

-Peff
