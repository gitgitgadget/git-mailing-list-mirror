From: Junio C Hamano <junkio@cox.net>
Subject: Re: git versus CVS (versus bk)
Date: Wed, 02 Nov 2005 01:26:59 -0800
Message-ID: <7v8xw7v1r0.fsf@assigned-by-dhcp.cox.net>
References: <200511012356.jA1NuPBd004502@inti.inf.utfsm.cl>
	<43687EAF.4060505@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 10:27:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXEte-0003eA-MA
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 10:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVKBJ1D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 04:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVKBJ1C
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 04:27:02 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:29409 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964780AbVKBJ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 04:27:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102092609.NYOY2059.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 04:26:09 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <43687EAF.4060505@op5.se> (Andreas Ericsson's message of "Wed, 02
	Nov 2005 09:54:07 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11016>

Andreas Ericsson <ae@op5.se> writes:

> Incidentally though, is there any way to make a commit completely go 
> away without resetting the files?

I am not sure if this is what you are looking for, but after I
make a commit and find a mistake (either in the checked-in files
or commit log message), I do this:

	$ git reset --soft HEAD^
        ... fix the checked-in files, maybe do git-add files that
        ... I forgot to add when I made the last commit.
        $ git commit -a -c ORIG_HEAD ;# edit commit log, too.

Soft reset leaves the working tree files intact and just rewinds
the .git/HEAD to whatever commit you specify, and as a side
effect stores the original .git/HEAD in .git/ORIG_HEAD.  The
lowercase -c flag to git-commit is "bring the commit log editor,
initialized with the commit log message from that commit".
