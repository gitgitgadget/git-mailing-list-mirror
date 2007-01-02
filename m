From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RFC] git-svn: make git-svn commit-diff able to work without explicit arguments
Date: Tue, 2 Jan 2007 11:18:10 -0800
Message-ID: <20070102191810.GA18856@localdomain>
References: <459AA31E.5070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 20:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1p9M-00051G-Os
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 20:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbXABTSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 14:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbXABTSO
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 14:18:14 -0500
Received: from hand.yhbt.net ([66.150.188.102]:59198 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932684AbXABTSN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 14:18:13 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 08C147DC094;
	Tue,  2 Jan 2007 11:18:11 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 02 Jan 2007 11:18:10 -0800
To: Steve Fr?cinaux <nudrema@gmail.com>
Content-Disposition: inline
In-Reply-To: <459AA31E.5070705@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35798>

Steve Fr?cinaux <nudrema@gmail.com> wrote:
> Hello,
> 
> When using git-svn to access a SVN repo, the commit policy may vary. 
> While git makes you commit small patches often, svn users tend to prefer 
> bigger patches that implement a functionnality at once.
> 
> So at the end you have a SVN commit which corresponds to several git ones.
> 
> What you can do in this case is :
> 
>   git-svn commit-diff --edit -r$REV remotes/git-svn HEAD
> 
> Which effect is that it commits (at once) all the commits between the 
> latest svn fetch and HEAD.
> 
> What I'm proposing here is this:
> 
>  - use the latest fetched rev the default for the -r argument.

Yes, this is very important.

>  - use remotes/git-svn and HEAD the defaults for the treeish objects.
> 
> A smarter way to take these defaults would be to take the last revision 
> in the current branch (which can be something else than git-svn if it 
> wasn't rebased/merged recently) and the relevant commit in the current 
> branch.
> 
> Additionnaly, --edit could be enabled by default if -m is not set and it 
> is used interactively, eventually using an option in repo-config.

This sounds useful.  This is basically what 'set-tree' (the command
formerly known as 'commit') was meant to do originally.  Unlike 
set-tree (or perhaps with modifying set-tree), this should
rebase or reset afterwards to linearize history like 'dcommit'.

-- 
Eric Wong
