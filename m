From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 15:33:00 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111527030.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
 <20080911123148.GA2056@cuci.nl> <20080911135146.GE5082@mit.edu>
 <20080911153202.GD2056@cuci.nl> <20080911180037.GH5082@mit.edu>
 <20080911190335.GB1451@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@MIT.EDU>, Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 21:35:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdrvw-0007oP-7B
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 21:34:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbYIKTdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 15:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbYIKTdV
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 15:33:21 -0400
Received: from relais.videotron.ca ([24.201.245.36]:46826 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752634AbYIKTdU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 15:33:20 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7100687QB0PP38@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 15:33:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911190335.GB1451@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95630>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> Theodore Tso wrote:
> >On Thu, Sep 11, 2008 at 05:32:02PM +0200, Stephen R. van den Berg wrote:
> >> gc will preserve the commits the origin links point to once they are
> >> reachable.  I.e. if the developer doesn't care about the commits the
> >> origin links point to (i.e. if the branches are not reachable) then gc
> >> just skips them, if the developer *does* care, the origin links are used
> >> to keep those objects alive (and, of course, all their parenthood).
> 
> >This seems wrong.  OK, suppose you have branches A, B, C, and D, while
> >you are on branch C, you cherry pick commit 'p' from branch B, so that
> >there is a new commit q on branch C which has an origin link
> >containing the commit ID's p^ and 'p.    
> 
> Ok.
> 
> >Now suppose branch B gets deleted, and you do a "git gc".  All of the
> >commits that were part of branch B will vanish except for p^ and p,
> 
> Not quite.  Obviously all parents of p and p^ will continue to exist.
> I.e. deleting branch B will cause all commits from p till the tip of B
> (except p itself) to vanish.  Keeping p implies that the whole chain of
> parents below p will continue to exist and be reachable.  That's the way
> a git repository works.

And that's what I called stupid in my earlier reply to you.  Either you 
have proper branches or tags keeping P around, or deleting B brings 
everything not reachable through other branches or tags (or reflog) 
away too.  Otherwise there is no point making a dangling origin link 
valid.


Nicolas
