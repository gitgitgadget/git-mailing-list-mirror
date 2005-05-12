From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Wed, 11 May 2005 18:46:45 -0700
Message-ID: <7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	<1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	<1115858022.22180.256.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 03:40:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DW2gX-0004rF-Vw
	for gcvg-git@gmane.org; Thu, 12 May 2005 03:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbVELBrO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 21:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVELBrO
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 21:47:14 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38793 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261232AbVELBqt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 21:46:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512014646.ZVCU23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 May 2005 21:46:46 -0400
To: tglx@linutronix.de
In-Reply-To: <1115858022.22180.256.camel@tglx> (Thomas Gleixner's message of
 "Thu, 12 May 2005 00:33:41 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:

TG> So what alternatives do we have ?

How about doing nothing of this sort, introducing repo-id?  I do
not understand what problem repo-id is solving.

Earlier in your response to Sean <seanlkml@sympaticoca>, you
gave a QA department example.

TG> You have to track down a problem in bugfix and the source of it.
TG> It does not matter whether the maintainer of "bugfix" pulled it from
TG> devel or from stable. It's his fault anyway. 
TG> 
TG> But we are not talking about faults and guiltiness. We want
TG> to identify the location and the context _where_ and _why_
TG> this change was created.

Here is my understanding of the scenario you are describing.
Are these correct?

 - There is a problem in the source.

 - You know what lines of which file is causing the problem.
   But you cannot tell how the file got into that state and why
   by just looking at the problem revision.

 - You have the complete history (commit chain) leading to the
   revision.

 - You want to get some context to help you understand why those
   offending lines are there.

Assuming I am with you so far, I would like to know what kind of
information you are looking for ("some context to help you
understand").  Is a specific commit object (rather, one pair of
commits that is parent-child) that made those lines into the
current shape enough?

My understanding of Sean's argument is that finding such a
commit (or a commit-pair) is a good enough place to start
understanding why that change was introduced and finding who to
ask for help, and it does not matter in which repository the
change was introduced.  I tend to agree with him if that is what
is being discussed.

If the owner has multiple repositories and he needs to know in
which of his repositories the change was introduced, I assume he
would xsbe able to run the same procedure the QA department run
to find the problem commit on each of his repositories to find
such a commit, and commits around it (its ancestors and
descendants).  So a maintainer having more than one repositories
does not seem to be an issue, either.

So I am having a hard time understanding what problem repo-id
solves.



