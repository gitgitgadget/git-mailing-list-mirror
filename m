Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF88820365
	for <e@80x24.org>; Wed,  4 Oct 2017 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdJDRF6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 13:05:58 -0400
Received: from cpanel2.indieserve.net ([199.212.143.6]:41492 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751240AbdJDRF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 13:05:57 -0400
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:48780 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1dzn7M-00039U-DY; Wed, 04 Oct 2017 13:05:56 -0400
Date:   Wed, 4 Oct 2017 13:05:54 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-stash" explanation of "--include-untracked" and "--all"
 seems ambiguous
In-Reply-To: <xmqqtvzitpjv.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.LFD.2.21.1710041300350.9804@localhost.localdomain>
References: <alpine.LFD.2.21.1709290650530.1446@localhost.localdomain> <20171001201604.GA30301@hank> <xmqqtvzitpjv.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2 Oct 2017, Junio C Hamano wrote:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > This is fine when --include-untracked is specified first, as --all
> > implies --include-untracked, but I guess the behaviour could be a
> > bit surprising if --all is specified first and --include-untracked
> > later on the command line.
> >
> > Changing this could possibly break someone that just adds
> > parameters to their 'git stash' invocation, but I'm tempted to say
> > allowing both at once is a bug, and change it to make git die when
> > both are specified.
>
> I am on the fence.
>
> If this were --include=untracked vs --include=all, then I'd say your
> suggestion will violate the usual expectation of "on the command
> line, last one wins", but "--include-untracked" and "--all" are
> spelled very differently, and may not look all that related to a
> casual reader, so the expectation for "the last one wins" might be
> weaker than usual.
>
> But once we start complaining to a command line that has both,
> saying they are mutually exclusive, people will realize that they
> are very much closely related options, even though spelled quite
> differently.  And at that point, they will find it very unreasonable
> that we do not follow the usual "the last one wins" rule but error
> out X-<.
>
> If I really cared deeply about these two options [*1*], I would
> think that the ideal longer term direction would be to introduce
> --include={untracked,all-crufts} to replace and deprecate the
> current two options.  And then we make sure --include=* forms follow
> the usual "last one wins" rule.
>
>
> [Footnote]
>
> *1* I personally don't, but that does not mean I will block efforts
>     by others who do to make this part of the system better.

  since i'm the one who tripped over this pedantic nitpickery, i'm
willing to take a shot at patching it, as long as there's consensus
from those *way* higher up the food chain as to what that patch should
look like.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================

