From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn branch naming question
Date: Sat, 8 Dec 2007 19:26:08 -0800
Message-ID: <20071209032608.GB31033@soma>
References: <20071208010438.GE3199@genesis.frugalware.org> <20071208105901.GA2844@xp.machine.xx> <20071208141449.GH3199@genesis.frugalware.org> <20071208165657.GC2844@xp.machine.xx> <20071208235248.GK3199@genesis.frugalware.org> <20071209020510.GM3199@genesis.frugalware.org> <20071209022624.GA31033@soma> <20071209023600.GP3199@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 04:26:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1CoS-0007p8-MF
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 04:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbXLID0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 22:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbXLID0L
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 22:26:11 -0500
Received: from hand.yhbt.net ([66.150.188.102]:50372 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705AbXLID0K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 22:26:10 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 06EFF7DC025;
	Sat,  8 Dec 2007 19:26:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071209023600.GP3199@genesis.frugalware.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67592>

Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Sat, Dec 08, 2007 at 06:26:24PM -0800, Eric Wong <normalperson@yhbt.net> wrote:
> > I'm not sure if it's considered a "bug", but that's just the
> > way it is at the moment.  I can't remember why, but I did
> > make git-svn force the presence of the "remotes/" prefix
> > in all refs it writes to...
> 
> okay, i see. one problem: git-svnimport is to be removed and (afaik) the
> supposed way is to use git-svn instead. what is the supposed way to use
> git-svn to convert an svn repo to a git one if the method i tried is not
> working?
> 
> (if the branches are fetched to "remotes/" then they won't be visible
> when one clones the converted repo)

I'm pretty sure the reasoning behind "remotes/" being forced by git-svn
was to prevent users from shooting themselves in the foot, since
committing to those remote refs will break both git-svn fetch and
dcommit...

Heck, the entire "remotes/" idea started because a git-svn user made the
mistake of committing to the remote tracking branch directly:

  http://thread.gmane.org/gmane.comp.version-control.git/16869/focus=16875

I'll consider accepting a patch to lift that restriction (but still use
the "remotes/" by default, of course).


Also, it's possible to fetch them after editing .git/config a little:

  Harvey Harrison's "[RFC] Mirroring svn" post has a good example
  on how to do it.

  http://mid.gmane.org/1196922153.10408.101.camel@brick

Perhaps git-clone could gain the ability to clone refs/remotes/ as-is
without an extra step?

-- 
Eric Wong
