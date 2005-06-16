From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Semantics of a workspace checkpoint
Date: Thu, 16 Jun 2005 10:28:48 +0200
Message-ID: <20050616082847.GA10116@pasky.ji.cz>
References: <2cfc4032050616012146948b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 10:24:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dipf8-00014q-Kl
	for gcvg-git@gmane.org; Thu, 16 Jun 2005 10:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVFPI2y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Jun 2005 04:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVFPI2y
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jun 2005 04:28:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54424 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261197AbVFPI2v (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jun 2005 04:28:51 -0400
Received: (qmail 30968 invoked by uid 2001); 16 Jun 2005 08:28:48 -0000
To: Jon Seymour <jon.seymour@gmail.com>
Content-Disposition: inline
In-Reply-To: <2cfc4032050616012146948b49@mail.gmail.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 16, 2005 at 10:21:28AM CEST, I got a letter
where Jon Seymour <jon.seymour@gmail.com> told me that...
> I'd like to propose these as the semantics for the checkpointing of a workspace

What are you actually trying to achieve? How would you define a
checkpoint? Why are checkpoints good? Why don't you just commit?
Why do you name checkpoints by treeids?

> On checkpoint, create a file called:
> 
> .git/checkpoint/<treeid>
> 
> where the contents of the file are:
>     exactly identical to the index file immediately prior to the
> checkpoint being performed
> 
> and the treeid is the tree that results from:
> 
>     git-update-cache $(git-diff-files | cut -f2)
>     git-write-tree
> 
> To restore from the checkpoint, one does:
> 
>     /* magic to remove files that are not in the resulting tree */
>     git-read-tree -m <treeid>
>     git-checkout-cache -u -f -a
>     cp .git/checkpoints/<treeid> .git/index

Why do you actually store the index itself? If you did write-tree, can't
you just work with that alone? You essentially rebuilt the index by
git-read-tree -m <treeid>, didn't you? (And half-destroyed it by the cp
since you trashed the stat information.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
