Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F26DF1F404
	for <e@80x24.org>; Wed,  4 Apr 2018 20:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751994AbeDDUtX (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 16:49:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53674 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751849AbeDDUtX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 16:49:23 -0400
Received: (qmail 24213 invoked by uid 109); 4 Apr 2018 20:49:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Apr 2018 20:49:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7855 invoked by uid 111); 4 Apr 2018 20:50:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 04 Apr 2018 16:50:23 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2018 16:49:21 -0400
Date:   Wed, 4 Apr 2018 16:49:21 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Daniel Jacques <dnj@google.com>
Subject: Re: What's cooking in git.git (Mar 2018, #06; Fri, 30)
Message-ID: <20180404204920.GA15402@sigill.intra.peff.net>
References: <xmqqvadd1epf.fsf@gitster-ct.c.googlers.com>
 <87a7uow0jc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a7uow0jc.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 08:41:11PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > [...]
> > * jk/drop-ancient-curl (2017-08-09) 5 commits
> >  - http: #error on too-old curl
> >  - curl: remove ifdef'd code never used with curl >=7.19.4
> >  - http: drop support for curl < 7.19.4
> >  - http: drop support for curl < 7.16.0
> >  - http: drop support for curl < 7.11.1
> >
> >  Some code in http.c that has bitrot is being removed.
> >
> >  Expecting a reroll.
> 
> This has been idle for a long time. Peff: What's left to be done for it?

It wasn't clear to me we actually wanted to do this. It got some
complaints, and then somebody showed up to actually fix the compilation
problems with the old versions.

It also isn't that much of a burden to carry the #ifdefs. The main
question is whether we're doing a disservice to users, since those old
setups likely aren't well tested.

Even if we do proceed, I'm not sure if we'd want the top #error patch,
given the reports that distros will sometimes backport features.

-Peff
