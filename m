From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Which freedesktop.org "design flaws" in git are still
 relevant?
Date: Fri, 29 Feb 2008 17:58:15 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802291743330.19665@iabervon.org>
References: <51419b2c0802291232w166b3100yabd30ba30df6ef1f@mail.gmail.com>  <m3hcfrjwnk.fsf@localhost.localdomain>  <alpine.LNX.1.00.0802291614230.19665@iabervon.org> <76718490802291440x60896c93i26d8d0c2cf5678b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 23:58:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVEBp-0000Ps-Hv
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 23:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552AbYB2W6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 17:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752231AbYB2W6R
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 17:58:17 -0500
Received: from iabervon.org ([66.92.72.58]:49550 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753853AbYB2W6R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 17:58:17 -0500
Received: (qmail 16797 invoked by uid 1000); 29 Feb 2008 22:58:15 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Feb 2008 22:58:15 -0000
In-Reply-To: <76718490802291440x60896c93i26d8d0c2cf5678b2@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75586>

On Fri, 29 Feb 2008, Jay Soffian wrote:

> On Fri, Feb 29, 2008 at 4:58 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> 
> > I wonder if it would be nice to have per-branch aliases, so that you
> > could have "git update" do whatever is appropriate to update this
> > particular branch, whether it be "git pull --no-commit" or "git reset
> > --hard origin/next && git merge" or "git rebase".
> 
> Well, you effectively have this via
> branch.*.{merge,mergeoptions,rebase,remote}. e.g.:
> 
> To effect fetch + non-committing merge:
> 
>   branch.<name>.remote        = origin
>   branch.<name>.merge         = refs/heads/<name>
>   branch.<name>.mergeoptions  = --no-commit
> 
> To effect fetch + rebasing:
> 
>   branch.<name>.remote        = origin
>   branch.<name>.merge         = refs/heads/<name>
>   branch.<name>.rebase        = true

Ah, good point. I'd forgotten mergeoptions.

> To effect reset --hard origin/next, add another fetch line to your
> remote. e.g.:
> 
>   [remote "origin"]
>     url = git://git.kernel.org/pub/scm/git/git.git
>     fetch = +refs/heads/*:refs/remotes/origin/*
>     fetch = refs/heads/pu:/refs/heads/pu-readonly

This case is actually tougher. I've got:

[branch "good-stuff"]
	remote = .
	merge = refs/heads/<local topic I like>
	merge = refs/heads/<another topic>
	merge = refs/heads/<yet another>

This branch is my local equivalent of "pu" for my own topics, which gets 
next + each topic I have in a testable state (by way of an octopus merge). 
So I reset to origin/next and merge a lot of local branches.

	-Daniel
*This .sig left intentionally blank*
