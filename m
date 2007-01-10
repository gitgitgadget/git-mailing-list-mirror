From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: a few remaining issues...
Date: Tue, 9 Jan 2007 19:16:19 -0500
Message-ID: <20070110001619.GF30023@spearce.org>
References: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701051453520.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070105193306.GB8753@spearce.org> <Pine.LNX.4.63.0701091218080.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vtzz0j6hf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0701100051350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:16:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4R8r-0005oV-FL
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932572AbXAJAQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbXAJAQZ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:16:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36165 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932572AbXAJAQY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:16:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4R8V-0000li-20; Tue, 09 Jan 2007 19:16:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 69CCD20FBAE; Tue,  9 Jan 2007 19:16:19 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701100051350.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36435>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 9 Jan 2007, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > On Fri, 5 Jan 2007, Shawn O. Pearce wrote:
> > >
> > >> I myself am also severly lacking in time right now.
> > >
> > > Did you have any chance to look at the patch I posted?

No, I had not had a chance to look at it.  I don't see the patch in
my inbox currently, so I must have deleted it earlier.  As much as
I want this feature in 1.5.0's final release I don't really have
the time/inclination to dredge though my own local mailing list
archives or through the online ones to locate it either.

Right now I want to track down a nasty bug in git-http-fetch that I
noticed recently that's keeping me from tracking git.git through an
HTTP proxy, and then I need to do some hacking on this lightweight
subproject implementation I'm working on.  None of the existing
implementations do what I needed over two weeks ago, so I'm writing
my own.  I really need it to be done before the end of the week.

> > > It adds 
> > > "--walk-reflogs" option to the revision walker, and as long as there is 
> > > reflog information, traverses the commits in that order. It also shows the 
> > > reflog data just below the "commit" line.
> > 
> > What does it do when you say, for example:
> > 
> > 	git log --walk-reflogs master..next
> 
> It means that (ideally) all revisions are shown which are in the reflog 
> chain of next, and _not_ in the reflog chain of master.

That makes a lot of sense actually.  Cute feature.
 
> However, once the reflog traversal hits the oldest reflog entry, it 
> reverts to commit parent traversal.

That doesn't make sense...

> > I couldn't make heads or tails out of the patch and did not understand 
> > what it was trying to do.  It looked as if you were making the log 
> > traversal machinery to walk _both_ reflog (probably from the latest to 
> > older) and the usual ancestry.
> 
> Yes, first reflog, then usual ancestry.
> 
> Would you want that changed to _only_ reflog traversal?

Yes.  The old ancestry has nothing to do with my local reflog.  I
want to know where my reflog ends, as there's no record of that
branch's lifespan before that point.

Right now I have a reflog on `pu` which I've had since reflogs were
first introduced last summer.  Yet it only goes back to Dec 23, 2006.
Looking at the old ancestry of pu back into last Oct isn't really
interesting when I'm studying what changes happened to locally.

-- 
Shawn.
