From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 18:23:52 -0400
Message-ID: <20060919222352.GC11601@spearce.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <eeppkl$rm9$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPo0Y-0005ff-T2
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbWISWX5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWISWX5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:23:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:32710 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751003AbWISWX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:23:56 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPo0H-0007kH-Fu; Tue, 19 Sep 2006 18:23:45 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C5DF820E48E; Tue, 19 Sep 2006 18:23:52 -0400 (EDT)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eeppkl$rm9$2@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27302>

Jakub Narebski <jnareb@gmail.com> wrote:
> Joel Dice wrote:
> > Proposal:
> > 
> > As with Subversion, the IRN state in Git would be specific to a given 
> > repository and have no significance beyond that repository.  Also like 
> > Subversion, IRN state would be global across a repository, so that a 
> > commit to any branch would increment the current IRN value.  Every Git 
> > command taking a revision parameter would accept an IRN using a syntax 
> > such as "r$IRN".  Every commit would report the IRN to the user as well as 
> > the SHA ID.  The IRN feature could be enabled or disabled via a 
> > configuration option.
> 
> This of course limits IRN much. Tags are valid across repositories.
> I'm not sure if many repositories are managed using shared repositories
> (centralized approach).

Not only that but its somewhat difficult to execute
`git log v1.4.0..v1.4.1` on a central repository; if IRNs are only
valid within that repository then that's the only way they could
even be used.

Note that somewhat difficult here means you need to:

	- gain direct read-only access to the repository's files (not
	  all systems may be able to offer this to all users);

	- set GIT_DIR environment variable OR pass --git-dir before
	  the subcommand;

	- do all of that without doing something stupid in the
	  repository directory such as `rm *` without realizing
	  where you are;

	- but still maintain write access so you can push.

and that latter GIT_DIR/--git-dir part users are bound to forgot as
its not as natural as just assuming the repository is the directory
you are in.  Of course that could be probably fixed...

-- 
Shawn.
