X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merging five months of Linux kernel history
Date: Sun, 29 Oct 2006 12:34:53 -0800
Message-ID: <7vhcxm274i.fsf@assigned-by-dhcp.cox.net>
References: <20061029193228.GR26271@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 20:35:03 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061029193228.GR26271@lug-owl.de> (Jan-Benedict Glaw's message
	of "Sun, 29 Oct 2006 20:32:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30456>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeHMw-0006ll-AK for gcvg-git@gmane.org; Sun, 29 Oct
 2006 21:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030195AbWJ2Uez (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 15:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030197AbWJ2Uez
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 15:34:55 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4228 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S1030195AbWJ2Uez
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 15:34:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061029203454.NUOS2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 15:34:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gLay1V00c1kojtg0000000 Sun, 29 Oct 2006
 15:34:58 -0500
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Sender: git-owner@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> writes:

> Hi!
>
> Due to a move to a new flat and other reasons, I wasn't able to
> do daily merges from Linus's tree into our vax-linux tree.
> My time situation has improved and I want to merge all the new
> and shiny stuff, but it seems a straight "git pull" isn't the
> best way to do that.
>
> What I'd actually love to do is to go through all commits since the
> last merge and pull/accept/cherry-pick then one by one.  That way I'll
> learn about new stuff. I'll specifically see generic changes that
> imply arch-specific stuff, things I'll need to implement later on.
>
> Is there any sane way to cluse such a large gap?  I don't mind looking
> through tenthousands of commits, as long as I get a chance to spot
> "important" ones.

I think the best way is:

	git pull
        git log ORIG_HEAD..

The latter would give your ten thousands of commits to inspect.

If the pull results in a conflict, then

	git pull
	git log --merge

	... fix conflicts ...
	git commit
        git log ORIG_HEAD..

Since ORIG_HEAD is transient, and you probably would want to
revisit the list of these ten thousands of commits later, it
might make sense to do

	git tag WHERE_WE_WERE

before "git pull" in either case.

