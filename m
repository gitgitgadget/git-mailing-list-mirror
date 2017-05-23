Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 390A01FF30
	for <e@80x24.org>; Tue, 23 May 2017 11:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761547AbdEWL1l (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 07:27:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:56633 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757843AbdEWL1k (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 07:27:40 -0400
Received: (qmail 369 invoked by uid 109); 23 May 2017 11:27:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 11:27:37 +0000
Received: (qmail 31015 invoked by uid 111); 23 May 2017 11:28:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 May 2017 07:28:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 May 2017 07:27:35 -0400
Date:   Tue, 23 May 2017 07:27:35 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCHv3 4/4] clone: use free_refspec() to free refspec list
Message-ID: <20170523112734.ftjdrgzesmfcau2r@sigill.intra.peff.net>
References: <20170515110557.11913-1-szeder.dev@gmail.com>
 <20170515110557.11913-5-szeder.dev@gmail.com>
 <CAM0VKjkr+EBEErQZxW-prrcdAyF4D-icU_ao9vvO3yJ1HWhmhw@mail.gmail.com>
 <xmqqa864kops.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa864kops.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 23, 2017 at 04:38:07PM +0900, Junio C Hamano wrote:

> > First, the unchanged commit message is now (i.e. by using the parsed
> > refspecs returned by remote_get()) completely outdated.
> > Second, while it properly frees those refspecs, i.e. the array and all
> > its string fields, it will now leak the memory pointed by the
> > 'refspec' variable.  However, why free just that one field of the
> > 'struct *remote'?  Alas, we don't seem to have a free_remote()
> > function...
> 
> I was sifting entries in the draft "What's cooking" report to find
> topics to merge to 'next'.  I read the series over and as Peff said
> in his <20170515224615.f6hnnfngwpierqk4@sigill.intra.peff.net>, I
> think the series overall is good.
> 
> Do you want to update the proposed log message for this one before
> the entire thing is merged to 'next'?

I didn't quite say that it was good. I think the overall direction is
good, but I had some comments on patch 1. Maybe we want to accept the
ugliness there, but I had some suggestions that might make it less bad.

-Peff
