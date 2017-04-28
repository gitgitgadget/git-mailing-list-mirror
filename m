Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59D811FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 08:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164005AbdD1ILu (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 04:11:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:41568 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939575AbdD1ILr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 04:11:47 -0400
Received: (qmail 2601 invoked by uid 109); 28 Apr 2017 08:11:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 08:11:45 +0000
Received: (qmail 17407 invoked by uid 111); 28 Apr 2017 08:12:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 28 Apr 2017 04:12:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Apr 2017 04:11:43 -0400
Date:   Fri, 28 Apr 2017 04:11:43 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Norbert Kiesel <nkiesel@gmail.com>
Subject: Re: [PATCH] diff: prefer indent heuristic over compaction heuristic
Message-ID: <20170428081143.7ae7jflhrjukxcsh@sigill.intra.peff.net>
References: <xmqq7f6zqr3i.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xp=7h7oATwO6vunqO+nfGhvQgiRkwG0P44hC4YLW2MRhA@mail.gmail.com>
 <xmqqinqbfz2r.fsf@gitster.mtv.corp.google.com>
 <20161223072201.zw2lwkdcs6qmb4rp@sigill.intra.peff.net>
 <CA+P7+xrWsCkABzpSkYJ4fb2_JijmUx=Sf4Hgsr6Z+k=_GogE_Q@mail.gmail.com>
 <20161223161917.4a352c2wzerj5uyz@sigill.intra.peff.net>
 <xmqqh95uedzu.fsf@gitster.mtv.corp.google.com>
 <xmqq8tr6e46o.fsf@gitster.mtv.corp.google.com>
 <653b67e6-9dba-d331-c396-932a59cdb4da@alum.mit.edu>
 <CAGZ79kY2Yu=B+75D6DpNjdriAZnJ5pZSmYAUiYtF2aUK47_HPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kY2Yu=B+75D6DpNjdriAZnJ5pZSmYAUiYtF2aUK47_HPw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2017 at 02:17:55PM -0700, Stefan Beller wrote:

> >> Retire "compaction", and keep "indent" as an experimental feature.
> >> The latter hopefully will be turned on by default in a future
> >> release, but that should be done as a separate step.
> 
> Maybe turning on this feature by default is the next step instead of
> adding them to bash competition or making them available in plumbing
> commands for the upcoming release.
> 
> Then in a later release we could even remove the knobs to turn it off.

Yeah, if we are going to proceed with making it the default, I'd rather
do that than worry about adding frills that will eventually not matter.

We could take Marc's patch to move the config to git_diff_basic_config()
as an interim step, though. It gives people an escape hatch if they find
that they need to disable the feature for some plumbing command.

In that discussion, the only argument I could come up with against
making it the default (or respecting it for plumbing) is that it may
have an impact on patch-ids. I'm not sure I'm swayed by that, but I
wanted to mention it to make sure we're deciding consciously not to care
about it.

-Peff
