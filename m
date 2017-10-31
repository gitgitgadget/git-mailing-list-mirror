Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029A420437
	for <e@80x24.org>; Tue, 31 Oct 2017 17:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753298AbdJaRBY (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 13:01:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:41460 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753551AbdJaRBX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 13:01:23 -0400
Received: (qmail 32278 invoked by uid 109); 31 Oct 2017 17:01:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Oct 2017 17:01:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3178 invoked by uid 111); 31 Oct 2017 17:01:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 31 Oct 2017 13:01:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Oct 2017 13:01:20 -0400
Date:   Tue, 31 Oct 2017 13:01:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 0/2] Re* Consequences of CRLF in index?
Message-ID: <20171031170120.3tg3mrenyhmp5uwc@sigill.intra.peff.net>
References: <xmqqinf1ce3i.fsf_-_@gitster.mtv.corp.google.com>
 <20171027170745.2125-1-sbeller@google.com>
 <CAGZ79kbNMWqPkk9PGDH44YYPC=Mgqk4+sTmRwQUGKF_JCmbpLA@mail.gmail.com>
 <xmqqpo942fzk.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kaSQzLEjmD3+YgQOz5cety9Y3MZmUo7EkKA-JdQRt_Diw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kaSQzLEjmD3+YgQOz5cety9Y3MZmUo7EkKA-JdQRt_Diw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 09:41:25AM -0700, Stefan Beller wrote:

> On Mon, Oct 30, 2017 at 7:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> (I note this as you regard your patches as a lunch time hack
> >> in the cooking email; I am serious about these patches though.)
> >
> > We do not want to touch borrowed code unnecessarily.  Are these
> > lines and bits hampering further progress we are actively trying to
> > make right now?
> 
> No they are not, you are correct.
> 
> I differ in opinion on 'borrowed code'. The latest release of xdiff
> (v0.23) was in Nov 13, 2008 according to http://freecode.com/projects/xdiff-lib
> or on March 23, 2006 according to https://directory.fsf.org/wiki/LibXDiff
> and given that we incorporated so many changes already to xdiff,
> I would argue it is sufficiently different from the original, we'll probably
> never import another upstream version (if there will be a release at all).
> 
> So the code was rather taken and now we are the bag holders in
> maintaining it, so we can make it pretty even only for the sake of
> pleasing ourselves (or rather: not confusing ourselves with too
> many unused flags).

Yes, I'd agree. For what it's worth both sides of this argument played
out in my head when I saw your patches, and I ended up at the same "we
are the bag holders" place. And there's certainly precedent for touching
that code and cleaning it up to make it easier to work with (just look
at at "git log -p xdiff").

I don't know that I would support a full-scale rewrite (for the same
reason that I wouldn't on the rest of the code base -- avoiding churn).
But deleting unused bits seems like an easy win for readability.

-Peff
