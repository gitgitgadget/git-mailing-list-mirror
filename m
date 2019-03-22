Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2F020248
	for <e@80x24.org>; Fri, 22 Mar 2019 03:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfCVDsj (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 23:48:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:60332 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726460AbfCVDsj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 23:48:39 -0400
Received: (qmail 1601 invoked by uid 109); 22 Mar 2019 03:48:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Mar 2019 03:48:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16343 invoked by uid 111); 22 Mar 2019 03:49:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 21 Mar 2019 23:49:01 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Mar 2019 23:48:37 -0400
Date:   Thu, 21 Mar 2019 23:48:37 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matthew Kraai <mkraai@its.jnj.com>
Subject: Re: [PATCH v2] stash: setup default diff output format if necessary
Message-ID: <20190322034837.GA20091@sigill.intra.peff.net>
References: <20190319190503.GA10066@dev-l>
 <20190319231826.GB32487@hank.intra.tgummerer.com>
 <20190320224955.GE32487@hank.intra.tgummerer.com>
 <20190321095103.GB2894@sigill.intra.peff.net>
 <xmqqtvfvr3oi.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtvfvr3oi.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 12:25:17PM +0900, Junio C Hamano wrote:

> > There is a "set_default" callback that was added by 6c374008b1
> > (diff_opt: track whether flags have been set explicitly, 2013-05-10),
> > but it looks like it was never actually used. I think the theory is that
> > cases like this could do their tweaking in such a callback. But I think
> > it makes sense to follow the lead of builtin/diff.c for the immediate
> > fix, and we can look at using set_default as a separate topic.
> 
> I agree with the conclusion.  I wouldn't be surprised if this is one
> of the things that was once used but left behind when the last
> caller disappeared, though.

I wondered, too, but `git log --pickaxe-regex -S'set_default[^_]'` seems
to think it was purely aspirational. :)

That calls for a little extra caution when starting to use it (because
it has not really been tested), but from a quick look I cannot see how
it would go wrong.

-Peff
