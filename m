Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDA911F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfHTTtI (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:49:08 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:38949 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbfHTTtH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:49:07 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id A39B71BF205;
        Tue, 20 Aug 2019 19:49:04 +0000 (UTC)
Date:   Wed, 21 Aug 2019 01:19:02 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/3] git-gui: Add ability to revert selected hunks and
 lines
Message-ID: <20190820194902.dhbvrdhx6xm7lzia@localhost.localdomain>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <xmqq5zmrvfl1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zmrvfl1.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/19 11:47AM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> > This series adds the ability to revert selected lines and hunks in
> > git-gui. Partially based on the patch by Bert Wesarg [0].
> >
> > The commits can be found in the topic branch 'py/git-gui-revert-lines'
> > at https://github.com/prati0100/git/tree/py/git-gui-revert-lines
> 
> Please don't do this.  
 
All right, I'll send a re-roll of the patches based on your fork of 
Pat's tree as soon as I get some time.

PS: Thanks for the detailed explanation of how I should structure my 
workflow :)

> I would strongly prefer keeping the contination of history from the
> history in Pat's git-gui repository.  If you clone from
> 
>     git://repo.or.cz/git-gui.git/
> 
> you'll notice everything for git-gui is one level up, and nothing
> for git-core is duplicated in there.  You'll work on top of that, so
> the patches to the git-gui project should not say things like
> 
>     ---
>      git-gui/lib/index.tcl | 27 +++++++++++++++++----------
>      1 file changed, 17 insertions(+), 10 deletions(-)
> 
>     diff --git a/git-gui/lib/index.tcl b/git-gui/lib/index.tcl
>     index b588db11d9..cb7f74af45 100644
>     ...
> 
> The leading "git-gui/" should not appear.
> 
> I have a fork of Pat's history with a single topic on top at
> https://github.com/gitster/git-gui/ so building on top would
> maintain the continuity of the history as well.
> 
> Once you prepared your changes in such a clone of the git-gui
> project, in order to test them with the rest of Git, you'd make a
> trial merge with the -Xsubtree=git-gui option.  Perhaps you have
> git-gui's clone in $HOME/git-gui and git's clone in $HOME/git, like
> so
> 
> 	$ cd $HOME
> 	$ git clone https://github.com/gitster/git-gui git-gui
> 	$ cd git-gui
> 	... from now on, you'd work on git-gui in this directory  ...
> 	... do the work of this topic perhaps on 'revert-hunks' branch ...
> 
> 	$ git clone https://github.com/gitster/git git
> 	$ cd ../git
> 	... trial integration ...
> 	$ git pull -Xsubtree=git-gui ../git-gui/ revert-hunks
> 	... do whatever testing necessary ...
> 
> As an interim (and hopefully evantual) maintainer of the git-gui
> project, you'd publish from your local git-gui directory to a fork
> of git-gui project you host somewhere.  Your patches for review
> would also be taken from your local git-gui directory.
> 
> Thanks.

-- 
Regards,
Pratyush Yadav
