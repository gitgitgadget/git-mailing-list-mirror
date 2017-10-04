Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 900812036B
	for <e@80x24.org>; Wed,  4 Oct 2017 05:32:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751198AbdJDFcL (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:32:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:60070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751049AbdJDFcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:32:10 -0400
Received: (qmail 9563 invoked by uid 109); 4 Oct 2017 05:32:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 05:32:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14994 invoked by uid 111); 4 Oct 2017 05:32:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 01:32:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 01:32:08 -0400
Date:   Wed, 4 Oct 2017 01:32:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Lars Schneider <larsxschneider@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] sub-process: allocate argv on the heap
Message-ID: <20171004053208.6vha2qj23md6t44y@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-4-t.gummerer@gmail.com>
 <85456f81-9e9f-d0e4-86f7-9f546691dee3@kdbg.org>
 <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ewbecek.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 01:59:31PM +0900, Junio C Hamano wrote:

> > Perhaps this should become
> >
> > 	argv_array_push(&process->args, cmd);
> >
> > so that there is no new memory leak?
> 
> Sounds like a good idea (if I am not grossly mistaken as to what is
> being suggested).
> 
> Here is what I am planning to queue.
> 
> -- >8 --
> From: Johannes Sixt <j6t@kdbg.org>
> Date: Tue, 3 Oct 2017 22:24:57 +0200
> Subject: [PATCH] sub-process: use child_process.args instead of child_process.argv

This looks good (and is exactly the type of case for which I added
"args" to the child_process in the first place). The commit message
is well-explained and the patch looks obviously correct.

-Peff
