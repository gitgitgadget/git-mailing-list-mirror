Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFBFD1F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 14:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754412AbcJEOOq (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 10:14:46 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.32]:41545 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753488AbcJEOOp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 10:14:45 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1brmy0-00017Y-Tt; Wed, 05 Oct 2016 16:14:41 +0200
Date:   Wed, 5 Oct 2016 16:14:39 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeremy Morton <admin@game-point.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Reference a submodule branch instead of a commit
Message-ID: <20161005141439.GD30930@book.hvoigt.net>
References: <57F29FEF.30700@game-point.net>
 <xmqqfuod6yw2.fsf@gitster.mtv.corp.google.com>
 <20161004113625.GB20309@book.hvoigt.net>
 <CAGZ79kZWtAU6YG4Qz9_Gwk2db5L2kPCCKrN+64hMYDovRjiLRw@mail.gmail.com>
 <xmqqshscuilh.fsf@gitster.mtv.corp.google.com>
 <xmqqlgy4szuu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqlgy4szuu.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 12:01:13PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Stefan Beller <sbeller@google.com> writes:
> >
> >> I wonder if we could make that convenient for users by not tracking
> >> the submodule,
> >> i.e.
> >> * we have the information in the .gitmodules file
> >> * the path itself is in the .gitignore
> >> * no tree entry
> >>
> >> Then you can update to the remote latest branch, without Git reporting
> >> a dirty submodule locally, in fact it reports nothing for the submodule.
> >>
> >> It sounds like a hack, but maybe it's worth looking into that when
> >> people want to see that workflow.
> >
> > It IS a hack.  
> >
> > But if you do not touch .git<anything> file and instead say "clone
> > this other project at that path yourself" in README, that would
> > probably be sufficient.
> 
> eh,... hit send too early.
> 
> It IS a hack, but having this information in .git<something> would
> mean that it can be forced to be in machine readable form, unlike a
> mention in README.  I do not know if the .gitmodules/.gitignore
> combination is a sensible thing to use, but it does smell like a
> potentially useful hack.

IIRC the tree entries are the reference for submodules in the code. We
are iterating over the tree entries in many places so that change does
not seem so easy to me.

But you are right maybe we should stop arguing against this workflow and
just let people use it until they find out whats wrong with it ;)

I have another tip for Jeremy:

	git config submodule.<name>.ignore all

and you will not see any changes to the submodule. Put that into your
.gitmodules and you do not see any changes to the submodules anymore.

So now the only thing missing for complete convenience is a config
option for the --remote option in 'git submodule update'.

Jeremy, does the ignore option combined with --remote what you want?

Cheers Heiko
