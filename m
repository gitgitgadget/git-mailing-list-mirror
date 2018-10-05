Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10511F453
	for <e@80x24.org>; Fri,  5 Oct 2018 16:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbeJEXYo (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 19:24:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:43142 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729060AbeJEXYo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 19:24:44 -0400
Received: (qmail 18289 invoked by uid 109); 5 Oct 2018 16:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Oct 2018 16:25:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12429 invoked by uid 111); 5 Oct 2018 16:24:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Oct 2018 12:24:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Oct 2018 12:25:17 -0400
Date:   Fri, 5 Oct 2018 12:25:17 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH v3] coccicheck: process every source file at once
Message-ID: <20181005162517.GB11254@sigill.intra.peff.net>
References: <20181002200710.15721-1-jacob.e.keller@intel.com>
 <CA+P7+xoqKG84n5EMKbajuZoXrOKZMudZ6CT-OKzz8XYyTYaCWQ@mail.gmail.com>
 <CA+P7+xo=cY2nSHk99CETvba-nZ_jOan5YgpDUjaD=cpTs2ub3A@mail.gmail.com>
 <20181005124048.GT23446@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181005124048.GT23446@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 05, 2018 at 02:40:48PM +0200, SZEDER Gábor wrote:

> On Thu, Oct 04, 2018 at 07:17:47PM -0700, Jacob Keller wrote:
> > Junio, do you want me to update the commit message on my side with the
> > memory concerns? Or could you update it to mention memory as a noted
> > trade off.
> 
> We have been running 'make -j2 coccicheck' in the static analysis
> build job on Travis CI, which worked just fine so far.  The Travis CI
> build environments have 3GB of memory available [1], but, as shown in
> [2], with this patch the memory consumption jumps up to about
> 1.3-1.8GB for each of those jobs.  So with two parallel jobs we will
> very likely bump into this limit.
> 
> So this patch should definitely change that build script to run only a
> single job.

It should still be a net win, since the total CPU seems to drop by a
factor of 3-4.

Are we OK with saying 1.3-1.8GB is necessary to run coccicheck? That
doesn't feel like an exorbitant request for a developer-only tool these
days, but I have noticed some people on the list tend to have lousier
machines than I do. ;)

-Peff
