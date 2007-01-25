From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: cvsimport/cvsps: wrong revisions in branch
Date: Thu, 25 Jan 2007 12:52:20 -0500
Message-ID: <20070125175220.GC13089@spearce.org>
References: <20070125142242.1402.qmail@b4b5deb4d44aa3.315fe32.mid.smarden.org> <45B8C032.7020004@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 18:52:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HA8lx-0004XF-Rs
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 18:52:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965392AbXAYRw0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 12:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965383AbXAYRw0
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 12:52:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41870 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965392AbXAYRwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 12:52:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HA8ln-0001Dq-D8; Thu, 25 Jan 2007 12:52:19 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3959720FBAE; Thu, 25 Jan 2007 12:52:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45B8C032.7020004@fs.ei.tum.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37749>

Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
> Gerrit Pape wrote:
> >Hi, I struggle with importing a CVS repository into git to switch over
> >development.  In some branches there're differences in the source code
> >after importing into git.  We tracked this down to tags and branches
> >that where tagged partially in CVS, first a tag was set on one
> >subdirectory tree (sources), later on another subdirectory tree (docs).
> >This confuses cvsimport or cvsps, the tag in git after import doesn't
> >match the tag in CVS.
> 
> how do you expect this to ever work?  your tag is not a time stable one.  
> the tag spans multiple change sets.  best forget the whole tag thing, 
> seriously.  my cvs converter [1] already has a hard time reproducing 
> branches correctly.  doing this with tags is impossible.  svn can do this 
> because they don't have tags, so it is a kind of fake.  of course you could 
> do this in git as well by actually creating a branch for a tag, but it is 
> really messy.  just don't do that.

If you are importing your history you probably really do want
the tags.  As broken as they may be.  Because they represent real
state that you probably need to be able to recover in the future.

One could make the argument that most very old tags aren't worth
importing, but certainly tags related to recent releases that are
still in production use (and thus may need patching) are probably
needed.

In Git the only way to really do this is to create a branch from a
nearby commit, then modify the branch until it conforms to the tag.
Do a series of evil merges from the relevant commits of each file
until you get the branch looking the way it needs to.  *THEN*
you tag it.
 
> [1]: <http://ww2.fs.ei.tum.de/~corecode/hg/fromcvs>, not 100% yet, but 
> probably the best you can get at the moment.  i'm a perfectionist, so i 
> might never call it "done".

Also probably the fastest CVS->Git converter publiclly available,
as its backed by git-fast-import.  :)

-- 
Shawn.
