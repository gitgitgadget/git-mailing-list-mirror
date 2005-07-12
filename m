From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bootstrapping into git, commit gripes at me
Date: Mon, 11 Jul 2005 19:21:39 -0700
Message-ID: <7voe98g3ws.fsf@assigned-by-dhcp.cox.net>
References: <20050708230750.GA23847@buici.com>
	<Pine.LNX.4.58.0507081842550.17536@g5.osdl.org>
	<20050711222046.GA21376@buici.com>
	<7vll4dndwu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507111646000.17536@g5.osdl.org>
	<Pine.LNX.4.58.0507111833380.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 04:22:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsAP9-0005t7-V9
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 04:21:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVGLCVr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 22:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261766AbVGLCVr
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 22:21:47 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52391 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261683AbVGLCVq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 22:21:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050712022139.BXEA18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 22:21:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507111833380.17536@g5.osdl.org> (Linus Torvalds's message of "Mon, 11 Jul 2005 18:43:23 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> But what about the branch name? Should we just ask the user? Together with 
> a flag, like
>
> 	git checkout -b new-branch v2.6.12
>
> for somebody who wants to specify the branch name? Or should we pick a 
> random name and add a helper function to rename a branch later?
>
> Opinions?

How about treating "master" a temporary thing --- "whatever I
happen to be working on right now"?

 - git branch <branch-name>       ;# copies master to branch-name;
				     if branch-name exists in refs/heads,
                                     warn and refuse.  Override
				     with --force flag.

 - git checkout <branch-name>     ;# copies branch-name to master; but
                                     if master does not match any
                                     of the other refs/heads/, warn
                                     and refuse.  Override with
                                     --force flag.

Yes I realize that you have to be careful when to push to your
public repository if you take this route, but this is only
relevant to people like Jeff with multiple heads, and I think he
publicly stated that his "refs/heads/master" aka .git/HEAD does
not mean much and what matters are his branch heads.  People who
do not use multiple branches but just checks out various tags,
the above would be reasonably convenient.
