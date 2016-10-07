Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F22420986
	for <e@80x24.org>; Fri,  7 Oct 2016 12:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755906AbcJGMwr (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 08:52:47 -0400
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:50221 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755856AbcJGMwq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 08:52:46 -0400
Received: from [84.46.92.130] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1bsUdl-0006MZ-3e; Fri, 07 Oct 2016 14:52:41 +0200
Date:   Fri, 7 Oct 2016 14:52:39 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        torvalds@linux-foundation.org, peff@peff.net
Subject: Re: [PATCH 1/2] submodule add: extend force flag to add existing
 repos
Message-ID: <20161007125239.GB61543@book.hvoigt.net>
References: <20161006193725.31553-1-sbeller@google.com>
 <20161006193725.31553-2-sbeller@google.com>
 <xmqqshs9i6fr.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshs9i6fr.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 06, 2016 at 01:11:20PM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> > Currently the force flag in `git submodule add` takes care of possibly
> > ignored files or when a name collision occurs.
> >
> > However there is another situation where submodule add comes in handy:
> > When you already have a gitlink recorded, but no configuration was
> > done (i.e. no .gitmodules file nor any entry in .git/config) and you
> > want to generate these config entries. For this situation allow
> > `git submodule add` to proceed if there is already a submodule at the
> > given path in the index.

Is it important that the submodule is in the index? How about worktree?
From the index entry alone we can not deduce the values anyway. So I
would say the submodule has to be in the worktree, no matter what is in
the index. If its not in the index we can also add it.

BTW, that is the way I imagined submodules would work in the first
place: just clone and add them, like I described here[1].

> > Signed-off-by: Stefan Beller <sbeller@google.com>
> > ---
> 
> Yup, the goal makes perfect sense.  
> 
> I vaguely recall discussing this exact issue of "git submodule add"
> that refuses to add a path that already is a gitlink (via "git add"
> that has previously been run) elsewhere on this list some time ago.

Yes there was a discussion, see the link.

Cheers Heiko

[1] http://public-inbox.org/git/%3C20160916141143.GA47240@book.hvoigt.net%3E/
