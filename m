From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC] Third round of support for cloning submodules
Date: Mon, 21 May 2007 00:58:10 +0200
Message-ID: <20070520225810.GH25462@steel.home>
References: <11796842882917-git-send-email-skimo@liacs.nl> <7vhcq7l3ar.fsf@assigned-by-dhcp.cox.net> <20070520221455.GN5412@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, skimo@liacs.nl,
	git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Mon May 21 00:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpuLy-0002hf-7B
	for gcvg-git@gmane.org; Mon, 21 May 2007 00:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757844AbXETW6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 18:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757868AbXETW6N
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 18:58:13 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:43815 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844AbXETW6N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 18:58:13 -0400
Received: from tigra.home (Faeaf.f.strato-dslnet.de [195.4.174.175])
	by post.webmailer.de (mrclete mo14) (RZmta 6.5)
	with ESMTP id B042acj4KLhxDV ; Mon, 21 May 2007 00:58:11 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 164CB277BD;
	Mon, 21 May 2007 00:58:11 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C99D3D195; Mon, 21 May 2007 00:58:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520221455.GN5412@admingilde.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jEE44=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47944>

Martin Waitz, Mon, May 21, 2007 00:14:55 +0200:
> >  - Do we detach HEAD if the commit named by the superproject
> >    tree is not at the tip of the current branch of subproject?
> >    do we detach always even if the commit is at the tip?
> 
> We must not mess with random upstream branches of the submodule
> just because they happen to reference the same tip.
> That would be too confusing.

Strange. The very same reason I heard when I tried to explain why
branches are good. The people found them confusing, just like you now.
They preach Perforce, too.

> Either use one special branch or detach.

Why not just detach always?

> >  - What would we do when the subproject working tree is not
> >    clean?
> 
> The same as with normal files:
> error out if something is changed which conflicts with the requested
> update.

This is called tree-level merge. Done by -m option (it does more than
that, yes, but this one too). While at it we can do file-level merge
as well, why not?

> When we have a special managed-by-supermodule branch and the submodule
> has another branch currently checked out we can entirely ignore this
> issue.

Detached head isn't special enough?

> >  - How can a user decide which subproject to descend into and
> >    which subproject to ignore, and how does git remember the
> >    earlier decision made by the user without asking the same
> >    again, and how does a user express "now I want to also track
> >    that subproject I've ignored so far" and "now I am not
> >    interested in following that subproject anymore"?
> 
> I'd simply use explicit checkout of a submodule and removal of
> the submodule to be a fine way to express the user's wish.

The directory of the submodule will be back by the next
git-checkout-index (in the current implementation).
Not the .git's, so yes it is a fine way to express user's wish: he
just initialize the subprojects he wants (by whatever way).
