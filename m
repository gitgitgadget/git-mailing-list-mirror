From: Eric Wong <normalperson@yhbt.net>
Subject: Re: svn to git, N-squared?
Date: Sun, 11 Jun 2006 21:29:34 -0700
Message-ID: <20060612042934.GA12083@hand.yhbt.net>
References: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 06:29:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fpe3W-0003C5-Pm
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 06:29:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751272AbWFLE3g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 00:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWFLE3g
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 00:29:36 -0400
Received: from hand.yhbt.net ([66.150.188.102]:19383 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751272AbWFLE3f (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Jun 2006 00:29:35 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id E20C77DC005; Sun, 11 Jun 2006 21:29:34 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
Content-Disposition: inline
In-Reply-To: <9e4733910606111902l709c71ccyf45070d55112739e@mail.gmail.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21688>

Jon Smirl <jonsmirl@gmail.com> wrote:
> I have Mozilla CVS in a SVN repository. I've been using git-svnimport
> to import it. This time I am letting it run to completion; but the
> import has been running for four days now and it is only up to 2004.
> The import task is stable at 570MB and it is using about 50% of my
> CPU. It is constantly spawning off git write-tree, read-tree,
> hash-object, update-index. It is not doing excessive disk activity.

SVN itself seems to get much slower as you get towards newer revisions
in a repository (FSFS) with lots of history.  I've been experimenting a
bit with a local copy of the gcc repo from November and git-svn SUCKED
at importing it (it took over a week and I cancelled it out of
frustration).   I started repacking too, but, and it didn't help,  Much
of the performance defieciency was the svn sub process. being extremely
slow at updating.

I also tried git-svnimport, of course, but I only had 512M on that
machine and the machine became unusable due to heavy swapping.

> The import seems to be getting n-squared slower. It is still making
> forward progress but the progress seems to be getting slower and
> slower.
> 
> It looks like it is doing write-tree, read-tree, hash-object,
> update-index once or more per change set. If these commands are
> n-proportional and they are getting run n times, then this is a
> n-squared process. Projecting this out, the import may take 10 days or
> more to completely finish.

I'm working on some improvements to git-svn to make it a bit more
spiffy.

-- 
Eric Wong
