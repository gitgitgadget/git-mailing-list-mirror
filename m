Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C55C4727C
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 432632076A
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gBKd3NCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgI2VcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 17:32:05 -0400
Received: from mout01.posteo.de ([185.67.36.65]:41382 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727740AbgI2VcC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Sep 2020 17:32:02 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 6F220160060
        for <git@vger.kernel.org>; Tue, 29 Sep 2020 23:31:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1601415118; bh=taUwIHs2MtwAn9icxd0CSSeW+B4UaIcF0P8K2AMa1a8=;
        h=Date:From:To:Cc:Subject:From;
        b=gBKd3NCR23x+XEjEZeysN/7WiL9a6mHEFspHXqLQAeKSLwc0Y17JOxKoaM2xTUpO/
         j5xsrBFIxCDGM7cRx/lwi3O8PZAw+xXekJjV+7rhPSATpkCrAUd76qo73qn4Tv4OGA
         EpZOxz3bFYFw87KAeiY1OxbQXxxzJ7O1vis8Qrw3nXekfiGxpF/YDikJtmUDurXKkn
         WRBKaftpG2CCr8nJTb90twWoA8XgKvWhdnI9wV0oz16p4Be3eHm7eIv3FrFINIZFv9
         tavc2ozoyWtltxdZr0A5ghEm8oN+GQKreVn8Pn7c+FTQnhiqzhiDl24gS/llmA6gQL
         HYblVMysjmjLg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C1CJY0ZrMz6tmX;
        Tue, 29 Sep 2020 23:31:56 +0200 (CEST)
Date:   Tue, 29 Sep 2020 23:31:54 +0200
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-completion.bash: stash-show: add --patch-with-stat
Message-ID: <20200929213154.GA18321@HP>
References: <20200928110517.24915-1-avoidr@posteo.de>
 <xmqqh7rhn3nk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7rhn3nk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 28, 2020 at 11:43:11AM -0700, Junio C Hamano wrote:
> Robert Karszniewicz <avoidr@posteo.de> writes:
> 
> > Signed-off-by: Robert Karszniewicz <avoidr@posteo.de>
> > ---
> >  contrib/completion/git-completion.bash | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> > index 8be4a0316e..d98c731667 100644
> > --- a/contrib/completion/git-completion.bash
> > +++ b/contrib/completion/git-completion.bash
> > @@ -3016,7 +3016,10 @@ _git_stash ()
> >  		list,--*)
> >  			__gitcomp "--name-status --oneline --patch-with-stat"
> >  			;;
> > -		show,--*|branch,--*)
> > +		show,--*)
> > +			__gitcomp "--patch-with-stat"
> > +			;;
> 
> Why is --patch-with-stat so special?  
> 
> Without completion support for "--patch" and "--stat", typing
> "--<TAB>" after "git stash show" and seeing only "--patch-with-stat"
> (which has been made obsolete-but-still-kept synonym immediately
> after the other two were invented in 2005) would make a rather

Oh, I didn't know --patch-with-stat was obsoleted. It was recently added
to `stash-list`, too. I can as well use "--patch --stat".

> surprising experience to the end users.  For "show" alone, it may
> make a lot of sense to complete "git stash show -<TAB>" and offer
> "-p".

Does git complete short options at all? I only see long options
completed. (I'm also very new to bash-completion)

> 
> In any case, it might make more sense to do this instead, and then
> rethink what options make sense to these subcommands of "git stash".
> I do not think patch-with-stat should be among them.

So shall I do a v2 as per your suggestion and replace
"--patch-with-stat" with "--patch --stat"?

> 
> -  		list,--*)
> +  		list,--* | show,--*)
>   			__gitcomp "--name-status --oneline --patch-with-stat"
> 
> Thanks.

Thank you.
