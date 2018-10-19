Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 872341F453
	for <e@80x24.org>; Fri, 19 Oct 2018 16:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbeJTAx1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 20:53:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:46510 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727200AbeJTAx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 20:53:26 -0400
Received: (qmail 25102 invoked by uid 109); 19 Oct 2018 16:46:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 16:46:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12743 invoked by uid 111); 19 Oct 2018 16:45:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 12:45:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 12:46:32 -0400
Date:   Fri, 19 Oct 2018 12:46:32 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Ben Peart <peartben@gmail.com>, Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
Message-ID: <20181019164631.GB24740@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
 <20181019161228.17196-3-peartben@gmail.com>
 <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 12:36:44PM -0400, Eric Sunshine wrote:

> On Fri, Oct 19, 2018 at 12:12 PM Ben Peart <peartben@gmail.com> wrote:
> > Add a reset.quiet config setting that sets the default value of the --quiet
> > flag when running the reset command.  This enables users to change the
> > default behavior to take advantage of the performance advantages of
> > avoiding the scan for unstaged changes after reset.  Defaults to false.
> >
> > Signed-off-by: Ben Peart <benpeart@microsoft.com>
> > ---
> > diff --git a/Documentation/config.txt b/Documentation/config.txt
> > @@ -2728,6 +2728,9 @@ rerere.enabled::
> > +reset.quiet::
> > +       When set to true, 'git reset' will default to the '--quiet' option.
> 
> How does the user reverse this for a particular git-reset invocation?
> There is no --no-quiet or --verbose option.
> 
> Perhaps you want to use OPT__VERBOSITY() instead of OPT__QUIET() in
> builtin/reset.c and document that --verbose overrides --quiet and
> reset.quiet (or something like that).

I think OPT__QUIET() provides --no-quiet, since it's really an
OPT_COUNTUP() under the hood. Saying "--no-quiet" should reset it back
to 0.

-Peff
