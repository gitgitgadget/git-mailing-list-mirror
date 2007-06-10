From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn set-tree bug
Date: Sun, 10 Jun 2007 14:33:22 -0700
Message-ID: <20070610213322.GB12222@muzzle>
References: <1181323515.30670.110.camel@gentoo-jocke.transmode.se> <20070610014734.GA542@muzzle> <1181496086.30670.115.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:33:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxV2P-0005gy-S5
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 23:33:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753768AbXFJVdY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 17:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755112AbXFJVdY
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 17:33:24 -0400
Received: from hand.yhbt.net ([66.150.188.102]:48170 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768AbXFJVdX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 17:33:23 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6273D7DC09D;
	Sun, 10 Jun 2007 14:33:22 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 10 Jun 2007 14:33:22 -0700
Content-Disposition: inline
In-Reply-To: <1181496086.30670.115.camel@gentoo-jocke.transmode.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49770>

Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Sat, 2007-06-09 at 18:47 -0700, Eric Wong wrote:
> > Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> > > trying to do git-svn set-tree remotes/trunk..svn
> > > in my new git-svn repo I get:
> > > config --get svn-remote.svn.fetch :refs/remotes/git-svn$: command returned error: 1
> > 
> > You need to specify "-i trunk" in the command-line
> > 
> > git-svn set-tree -i trunk remotes/trunk..svn
> > 
> 
> Thanks
> 
> I have found a bug or two. Run this script and
> see what happens ant the end.

<snip>

> git pull . merge

This is a non-fast-forward merge, giving you non-linear history.  git
understands non-linear history without problems, but svn does not.

> git svn dcommit  # this fails 

If you have non-linear history, don't use dcommit, use set-tree.  Linear
history is cleaner and easier to manage, which is why I recommend
format-patch/am/dcommit/rebase, and avoid using pull/merge unless it's
fast-forward.

-- 
Eric Wong
