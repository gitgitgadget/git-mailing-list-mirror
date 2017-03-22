Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3554F20323
	for <e@80x24.org>; Wed, 22 Mar 2017 22:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751250AbdCVWJl (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 18:09:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:49767 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751248AbdCVWJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 18:09:40 -0400
Received: (qmail 29889 invoked by uid 109); 22 Mar 2017 22:09:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 22:09:39 +0000
Received: (qmail 32677 invoked by uid 111); 22 Mar 2017 22:09:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Mar 2017 18:09:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Mar 2017 18:09:35 -0400
Date:   Wed, 22 Mar 2017 18:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jan Palus <jan.palus@gmail.com>
Subject: Re: [PATCH] t7406: correct test case for submodule-update initial
 population
Message-ID: <20170322220934.ru7wgujbpg5lq2w6@sigill.intra.peff.net>
References: <20170322213953.oddbgw5nfrvmzjgm@sigill.intra.peff.net>
 <20170322214948.12015-1-sbeller@google.com>
 <20170322215951.f4xbxehzvsd64c4y@sigill.intra.peff.net>
 <CAGZ79kbFjCQB_k8E1dMVop_EGF6TpnY04U1NV60VmSs1zHOnZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbFjCQB_k8E1dMVop_EGF6TpnY04U1NV60VmSs1zHOnZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 22, 2017 at 03:07:45PM -0700, Stefan Beller wrote:

> > Neither of those is true, but I think:
> >
> >   cat >expect <<-EOF &&
> >   Execution of '\''false $submodulesha1'\'' failed in ...
> >   EOF
> >
> > is safer and less surprising. The single-quote handling is unfortunate and
> > ugly, but necessary to get them into the shell snippet in the first
> > place. I notice the others tests in this script set up the expect file
> > outside of a block. You could also do something like:
> >
> >   sq=\'
> >   test_expect_success '...' '
> >         cat >expect <<-EOF
> >         Execution of ${sq}false $submodulesha1${sq} ...
> >   '
> >
> > but I'm not sure if that is any more readable.
> >
> 
> If I recall correctly, I made a big fuss about single quotes used correctly when
> writing that patch (which is why I may have lost track of the actual work there)
> to be told the one and only blessed way to use single quotes in our test suite.
> 
> Your proposal to use ${sq} sounds good to me, though we did not
> follow through with it for some other reason. I can reroll with that, though.

I'm not sure if it's a proposal. I ended it with "I'm not sure if that
is any more readable". :)

I mainly care about making sure the interpolation happens inside the
test block (i.e., at the top of the quoted section above).

-Peff
