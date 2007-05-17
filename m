From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Smart fetch via HTTP?
Date: Wed, 16 May 2007 21:03:35 -0400
Message-ID: <20070517010335.GU3141@spearce.org>
References: <20070515201006.GD3653@efreet.light.src> <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com> <Pine.LNX.4.64.0705161232120.6410@racer.site> <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com> <Pine.LNX.4.64.0705170152470.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 17 03:03:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoUPG-0000fL-AS
	for gcvg-git@gmane.org; Thu, 17 May 2007 03:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755702AbXEQBDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 21:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756534AbXEQBDo
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 21:03:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43296 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755702AbXEQBDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 21:03:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HoUOu-0003s4-8W; Wed, 16 May 2007 21:03:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D252020FBAE; Wed, 16 May 2007 21:03:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705170152470.6410@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47474>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Don't forget that those 10% probably do not do you the favour to be in 
> large chunks. Chances are that _every_ _single_ wanted object is separate 
> from the others.

That's completely possible.  Assuming the objects even are packed
in the first place.  Its very unlikely that you would be able to
fetch very large of a range from an existing packfile, you would be
submitting most of your range requests for very very small sections.
 
> > And for services like SF.net it'd be a safe low-cpu way of serving git
> > files. 'cause the git protocol is quite expensive server-side (io+cpu)
> > as we've seen with kernel.org. Being really smart with a cgi is
> > probably going to be expensive too.
> 
> It's probably better and faster than relying on a feature which does not 
> exactly help.

Yes.  Packing more often and pack v4 may help a lot there.

The other thing is kernel.org should really try to encourage the
folks with repositories there to try and share against one master
repository, so the poor OS has a better chance at holding the bulk
of linux-2.6.git in buffer cache.

I'm not suggesting they share specifically against Linus' repository;
maybe hpa and the other admins can host one seperately from Linus and
enourage users to use that repository when on a system they maintain.

In an SF.net type case this doesn't help however.  Most of SF.net
is tiny projects with very few, if any, developers.  Hence most
of that is going to be unsharable, infrequently accessed, and uh,
not needed to be stored in buffer cache.  For the few projects that
are hosted there that have a large developer base they could use
a shared repository approach as I just suggested for kernel.org.

aka the "forks" thing in gitweb, and on repo.or.cz...

-- 
Shawn.
