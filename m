From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 12:34:11 +0200
Message-ID: <20060326103411.GA4483@c165.ib.student.liu.se>
References: <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz> <Pine.LNX.4.64.0603251919170.15714@g5.osdl.org> <20060326100717.GD18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 26 12:34:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNSZj-0003YW-Ru
	for gcvg-git@gmane.org; Sun, 26 Mar 2006 12:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWCZKeT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Mar 2006 05:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWCZKeS
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Mar 2006 05:34:18 -0500
Received: from 85.8.31.11.se.wasadata.net ([85.8.31.11]:15011 "EHLO
	mail6.wasadata.com") by vger.kernel.org with ESMTP id S1751245AbWCZKeS
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Mar 2006 05:34:18 -0500
Received: from c165 (85.8.2.189.se.wasadata.net [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 11CA140FD; Sun, 26 Mar 2006 12:50:46 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1FNSZX-0001FB-00; Sun, 26 Mar 2006 12:34:11 +0200
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060326100717.GD18185@pasky.or.cz>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18034>

On Sun, Mar 26, 2006 at 12:07:17PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, Mar 26, 2006 at 05:19:50AM CEST, I got a letter
> where Linus Torvalds <torvalds@osdl.org> said that...
> > On Sun, 26 Mar 2006, Petr Baudis wrote:
> > > 
> > >   In [1], Linus suggests a non-core solution. Unfortunately, it doesn't
> > > fly - it requires at least two git-ls-tree calls per revision which
> > > would bog things down awfully (to roughly half of the original speed).
> > 
> > No it doesn't. It requires one git-ls-tree WHEN SOMETHING IS RENAMED.
> > 
> > In other words, basically never.
> 
> Huh? I don't see that now (and caps don't help me see it better). That's
> certainly not what is in [1], and I don't see _how_ to detect the
> renames in this case, and what would I be actually doing git-ls-tree for
> when I've already detected the rename. Based on [1], I'd be doing
> git-ls-tree merely to detect that a file _disappeared_ in the first
> place, I have to do other stuff to detect the renames themselves.
> 
> Dear diary, on Sun, Mar 26, 2006 at 09:35:02AM CEST, I got a letter
> where Ryan Anderson <ryan@michonline.com> said that...
> > A simple example is the first loop in git-annotate.perl.  (Which was
> > basically written by Linus, I just translated it from a
> > shell/pseudo-code example into Perl)
> 
> Thanks for the hint. Unfortunately, this is precisely the thing I want
> to avoid, that is essentially reimplementing part of git-rev-list - to
> do something good, I would have to do my own toposort and merge by date
> between parallel lines. OTOH, I might just construct a large revlist
> commandline specifying all the segments I'm interested in and see what
> happens when I run that.
> 
> Besides, doing it in shell would be pretty ugly job (forcing me to
> finally rewrite it in perl is not a bad thing but that'd be a somewhat
> larger project since I share various common routines with other cg
> tools, etc).
> 

If you decide to modify rev-list to do rename tracking you might want
to have a look at how this is done in blame.c. git-blame only tracks
one file (since that is what it needs) but I think it should be
possible to track multiple files with a similar approach.

- Fredrik
