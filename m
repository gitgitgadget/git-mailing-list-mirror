From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Mon, 27 Feb 2006 12:27:13 -0800
Message-ID: <20060227202713.GB21684@hand.yhbt.net>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <20060227184641.GA21684@hand.yhbt.net> <62354.84.163.87.135.1141068867.squirrel@mail.geht-ab-wie-schnitzel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 21:28:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDoxi-0002iU-J4
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 21:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWB0U1P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 15:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWB0U1P
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 15:27:15 -0500
Received: from hand.yhbt.net ([66.150.188.102]:61105 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751621AbWB0U1O (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2006 15:27:14 -0500
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 4B0642DC01A; Mon, 27 Feb 2006 12:27:13 -0800 (PST)
To: Nicolas Vilz 'niv' <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <62354.84.163.87.135.1141068867.squirrel@mail.geht-ab-wie-schnitzel.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16881>

Nicolas Vilz 'niv' <niv@iaglans.de> wrote:
> ok, i experienced that on little modifications on the git-svn-HEAD branch
> either... so its really about modifying and not about the huge data
> ammount...
 
Huge data should not have anything to do with it.  Well, besides
increasing the chance of somebody committing a conflicting commit while
you're in the middle of your commit.  But hey, that's the nature of
centralized SCMs.

> >> now i am still on rev 2 on this branch but i updated it to rev 5 on the
> >> svn-side...
> >>
> >> any hints?
> >
> > Save your current work in git-svn-HEAD to a private branch
> >
> > 	git branch -b private git-svn-HEAD
> >
> > then reset git-svn-HEAD to the last revision where it was managed by
> > git-svn fetch:
> >
> > 	git-checkout git-svn-HEAD
> > 	git-log (look for the last commit with 'git-svn-id:' in it)
> > 	git-reset --hard <last commit with 'git-svn-id:' in it>
> >
> > Now go to your private branch:
> >
> > 	git checkout private
> >
> > And continue working on your private branch as usual.
> 
> I will keep that in mind for the future. Fortunatelly i am still testing
> and i saved the git repository before experimenting with git-svn.

:)

> Have you any suggestions howto migrate a git-repository to svn and then
> work with git-svn on both of it? I tried cg-merge -j to merge my git
> branch with the private git svn branch, i am allowed to modify safely.
> 
> that does work actually... now i can start getting this automated.
> 
> perhaps i will write a patch with that automated script, when it is
> finished, just to contribute git.

Cool.  I don't know much about cg-*, but I think I did more or less the
same thing (joining branches, but did the join on git-svn-HEAD instead
of a git-only branch) using <revision>=<commit> arguments[1] to git-svn
fetch.

[1] - See the 'Additional Fetch Arguments' section of the manpage for
more info on this.  I'll freely admit that the UI for this was an
accident, but it works fairly well for me.

-- 
Eric Wong
