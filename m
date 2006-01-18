From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining Repositories
Date: Wed, 18 Jan 2006 15:14:43 +0100
Message-ID: <20060118141442.GP28365@pasky.or.cz>
References: <200601181325.59832.Mathias.Waack@rantzau.de> <20060118125158.GN28365@pasky.or.cz> <20060118125857.GO28365@pasky.or.cz> <200601181501.38791.Mathias.Waack@rantzau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 15:14:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzE44-0001BR-0l
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 15:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWARON3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 09:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWARON3
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 09:13:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:30413 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030322AbWARON2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 09:13:28 -0500
Received: (qmail 32249 invoked by uid 2001); 18 Jan 2006 15:14:43 +0100
To: Mathias Waack <Mathias.Waack@rantzau.de>
Content-Disposition: inline
In-Reply-To: <200601181501.38791.Mathias.Waack@rantzau.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14828>

  Hello,

Dear diary, on Wed, Jan 18, 2006 at 03:01:38PM CET, I got a letter
where Mathias Waack <Mathias.Waack@rantzau.de> said that...
> On Wednesday 18 January 2006 01:58 pm, Petr Baudis wrote:
> > Dear diary, on Wed, Jan 18, 2006 at 01:51:58PM CET, I got a letter
> > where Petr Baudis <pasky@suse.cz> said that...
> >
> > >   But if you want r1/a, r2/b to turn to r/r1/a, r/r2/b, you will have
> > > to rewrite the history of each (and then do the above). One rough
> > > and untested sketch...
> > >
> > > 	mkdir r1-rewritten
> > > 	cd r1-rewritten
> > > 	cp -a ../r1/.git .
> >
> > 	mkdir commitmap
> >
> > > 	for commit in $(git-rev-list --topo-order HEAD | tac); do
> > > 		git-read-tree --prefix=r1/ $commit
> 
> ...git-read-tree doesn't know the parameter --prefix (just downloaded and 
> tried it on 0.99.9i). What version shall I use?

  oops, it seems this is only in the latest pu branch of git. If you are
not brave enough for that, you will need to use the prefix facility of
checkout-index instead, and it'll take much longer:

	git-read-tree $commit
	git-checkout-index -a --prefix=r1/
	rm .git/index
	cg-add -r r1/
	rm -rf r1
	.. then proceed with git-cat-file etc ..

  Note that I'm not sure when which feature was introduced. Your best
bet is to just use the latest stable GIT/Cogito versions.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
