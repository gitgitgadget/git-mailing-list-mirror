Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6652027C
	for <e@80x24.org>; Fri,  2 Jun 2017 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbdFBW0U (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 18:26:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:34145 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdFBW0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 18:26:19 -0400
Received: (qmail 14221 invoked by uid 109); 1 Jun 2017 21:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 21:26:18 +0000
Received: (qmail 21991 invoked by uid 111); 1 Jun 2017 21:26:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Jun 2017 17:26:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Jun 2017 17:26:16 -0400
Date:   Thu, 1 Jun 2017 17:26:16 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Ben Peart <peartben@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 0/6] Fast git status via a file system watcher
Message-ID: <20170601212616.ecnisoedlkjzs6ln@sigill.intra.peff.net>
References: <20170601155105.28356-1-benpeart@microsoft.com>
 <CACBZZX6+V6=gSs0pdN9WU+LPZv5qSAmE5u_f=NFYht2dT-hxEQ@mail.gmail.com>
 <020b09ef-6035-285d-c033-8831564d8752@gmail.com>
 <CAGZ79ka1hjTFt9iRDrEy89ie9c3zj=BZ3SnZjPbLt6LGVDzeJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79ka1hjTFt9iRDrEy89ie9c3zj=BZ3SnZjPbLt6LGVDzeJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 01, 2017 at 02:13:10PM -0700, Stefan Beller wrote:

> >
> >>      $ git am /tmp/original_msg.txt
> >>      Applying: fsmonitor: add documentation for the fsmonitor extension.
> >>      error: patch failed: Documentation/githooks.txt:448
> >>      error: Documentation/githooks.txt: patch does not apply
> >>      Patch failed at 0001 fsmonitor: add documentation for the
> >> fsmonitor extension.
> >>      The copy of the patch that failed is found in:
> >> .git/rebase-apply/patch
> >>      When you have resolved this problem, run "git am --continue".
> >>      If you prefer to skip this patch, run "git am --skip" instead.
> >>      To restore the original branch and stop patching, run "git am
> >> --abort".
> 
> Try again with -3. (We should make that the default for am, maybe?)
> It helped me for most of the conflicts that I saw.

Yeah, I was going to suggest the same thing. "git apply" is much pickier
than "patch" about fuzzing the hunks (intentionally so, because the
results can sometimes end up not what the sender intended). But in most
cases "-3" can apply the patch without losing safety (unless the sender
built off a branch that you don't even have).

There's some more discussion of --3way as the default in

  http://public-inbox.org/git/CAKwvOdn9j=_Ob=xq4ucN6Ar1G537zNiU9ox4iF6o1qO7kPY41A@mail.gmail.com/T/#u

-Peff
