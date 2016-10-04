Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC731F4F8
	for <e@80x24.org>; Tue,  4 Oct 2016 11:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752594AbcJDLgd (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 07:36:33 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:43821 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcJDLgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 07:36:32 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brO1L-0000SC-Hi; Tue, 04 Oct 2016 13:36:27 +0200
Date:   Tue, 4 Oct 2016 13:36:26 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeremy Morton <admin@game-point.net>, git@vger.kernel.org
Subject: Re: Reference a submodule branch instead of a commit
Message-ID: <20161004113625.GB20309@book.hvoigt.net>
References: <57F29FEF.30700@game-point.net>
 <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 12:00:45PM -0700, Junio C Hamano wrote:
> Jeremy Morton <admin@game-point.net> writes:
> 
> > At the moment, supermodules must reference a given commit in each of
> > its submodules.  If one is in control of a submodule and it changes on
> > a regular basis, this can cause a lot of overhead with "submodule
> > updated" commits in the supermodule.  It would be useful of git allows
> > the option of referencing a submodule's branch instead of a given
> > submodule commit.  How about adding this functionality?
> 
> When somebody downstream fetches from your superproject and grabs
> the set of submodules, how would s/he know what _exact_ state you
> meant to record?  When s/he says "I have your superproject commit X,
> which binds submodule's branch Y at path sub/, and it simply does
> not work.  Your project is broken", how do you go about reproducing
> the exact state s/he had trouble with to help her/him?
> 
> The only thing s/he knows is that the commit used from the submodule
> must be one of the commits that was on branch Y at some point in
> time, hopefully close to the timestamp recorded in the commit in the
> superproject.  And your record in the history of the superproject
> does not tell you more than that, so you wouldn't have any idea
> better than what s/he already has to help.
> 
> Hence, such a "functionality" will never happen, at least in the
> exact form you are describing.
> 
> It is conceivable to add some feature that allows you to squelch the
> report that the submodule recorded in your superproject is not up to
> date from "git status" etc. to help those who thinks it is OK to not
> bind the latest submodule commit to the superproject all the time,
> though.

We already have options to support these kinds of workflows. Look at the
option '--remote' for 'git submodule update'.

You then only have to commit the submodule if you do not want to see it
as dirty locally, but you will always get the tip of a remote tracking
branch when updating.

Cheers Heiko
