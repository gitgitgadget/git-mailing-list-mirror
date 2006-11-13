X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Getting new branches from remote repo.
Date: Sun, 12 Nov 2006 20:49:33 -0800
Message-ID: <7v8xigar36.fsf@assigned-by-dhcp.cox.net>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 04:49:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com>
	(Alexander Litvinov's message of "Mon, 13 Nov 2006 10:33:52 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31288>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjTlX-0006KM-6C for gcvg-git@gmane.org; Mon, 13 Nov
 2006 05:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753891AbWKMEtk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 23:49:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753918AbWKMEtk
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 23:49:40 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:58270 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1753891AbWKMEtj
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 23:49:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061113044939.SMFN97.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 23:49:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id m4pD1V00Q1kojtg0000000; Sun, 12 Nov 2006
 23:49:13 -0500
To: "Alexander Litvinov" <litvinov2004@gmail.com>
Sender: git-owner@vger.kernel.org

"Alexander Litvinov" <litvinov2004@gmail.com> writes:

> I have a trouble I don't know how to solve. When I am cloning remote
> repo I automatically get all it's branches stored at my repo (they are
> listed at .git/remotes/origin). When someone adds new branch(es) to
> remote repo git pull (git fetch) does not automatically add them to my
> repo. I have a tool to list all remote branches (git ls-remote --heads
> origin) but I can't find how to add interesting (or all) branches to
> by repo.

After finding out $that_new_branch's name, add either

	Pull: refs/heads/$that_new_branch:refs/heads/$that_new_branch

or if you are in "separate remote" school, then perhaps

	Pull: refs/heads/$that_new_branch:refs/remotes/origin/$that_new_branch

to .git/remotes/origin and running git fetch would give you what
you want, I think.

> By the way, how can I clone remote repo created by cloning another
> repo using git clone --use-separate-remotes ? Even git ls-remote
> --heads origin does not show all branches taken from that another
> repo.

Well, the point of "separate remote" is not to pollute local
heads/ namespace with refs that merely track remote repository,
so if you say "ls-remote --heads" you would not see them.  They
are not "heads" in that repository.

You would still see them if you say "ls-remote" without --heads.
