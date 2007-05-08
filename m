From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Tue, 8 May 2007 10:52:49 -0400
Message-ID: <20070508145249.GP11311@spearce.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> <vpqbqgxak1i.fsf@bauges.imag.fr> <Pine.LNX.4.64.0705062344230.29485@reaper.quantumfyre.co.uk> <20070507063505.GA31269@diana.vm.bytemark.co.uk> <20070508014114.GC11311@spearce.org> <20070508073739.GA24409@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:53:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlR3o-0003dd-8P
	for gcvg-git@gmane.org; Tue, 08 May 2007 16:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967771AbXEHOw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 10:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968055AbXEHOw6
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 10:52:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38813 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967771AbXEHOw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 10:52:57 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlR3W-0007XR-50; Tue, 08 May 2007 10:52:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C0AFB20FBAE; Tue,  8 May 2007 10:52:49 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070508073739.GA24409@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46582>

Karl Hasselstr??m <kha@treskal.com> wrote:
> It's currently possible to split some hunks by
> reducing the number of content lines, but if the changes aren't
> separated by any unchanged lines at all, that doesn't work.

Yea, I've played that game before too (reduce content lines) to
try and simulate a hunk splitter.  ;-)  Doesn't always work.

Right now I feel like a huge chunk of the git-gui code is simply not
maintainable.  The 0.7.0 release is really more about refactoring the
code to make it more maintainable, than it is about actual features
(though there are some new things, like vi-keys).

The hunk selection stuff is just one part of the 2,000 lines
still left in git-gui.sh itself, and that still uses a lot of
messy globals.  I want to get the code better organized before
I take on major new additions to it.

> > I also want to let you revert hunks from the working directory copy.
> 
> That would be handy. But unlike stage/unstage, this can lose
> information, so there'd need to be some kind of "are you _really_
> sure? [Yes] [No]" safety hatch, which would make it less convenient.

True, but that beats the tar out of copying the - lines to your
clipboard and pasting them into your text editor, then deleting
the - prefix.  Especially if its a couple of hunks that you want
to revert.  Which I find myself doing all to often.

Actually I work around it today by staging what I care about,
then reverting the file.  Since the revert comes out of the index,
I get (mostly) the same action as reverting a particular hunk.
But it does mean that I lose my index state, if that happened to
be of any particular interest.

> I assume that shelves would be implemented as branches that are
> precisely one commit on top of HEAD? If so, I'd just like to point out
> that they're exactly like unapplied patches in StGIT.

I haven't looked at StGIT in a while.  I've seen noise on the list
about nifty features being added, but I haven't kept up with what
those features actually are.  I think you are right about this and
maybe git-gui should try to be compatible with StGIT's unapplied
patches, should I get into actually implementing a shelving system.
 
> Hmm. I find it inconsistent to force or strongly encourage the user to
> commit precisely the working directory changes and not a subset
> thereof, which the shelf idea seems to encourage, while at the same
> time not committing straight from the working directory but from a
> specific staging area (the index).

Indeed; I was thinking that this very morning.  Making an index that
you stage things into, but then also saying you cannot really do that
and instead have to shelve what you don't want - that's just evil.
I'll have to think about it more.

The blame interface in git-gui needs help more than the index
staging features.  The colors suck.  ;-)
 
-- 
Shawn.
