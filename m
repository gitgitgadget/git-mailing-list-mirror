From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 16:00:55 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111546270.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
 <20080911123148.GA2056@cuci.nl>
 <alpine.LFD.1.10.0809111047380.23787@xanadu.home>
 <20080911160040.GE2056@cuci.nl>
 <alpine.LFD.1.10.0809111222170.23787@xanadu.home>
 <20080911184405.GA1451@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:02:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdsMl-0002j6-Rj
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878AbYIKUBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756051AbYIKUBD
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:01:03 -0400
Received: from relais.videotron.ca ([24.201.245.36]:31240 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987AbYIKUBB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:01:01 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K71005ALRLJN2C0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 16:00:55 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911184405.GA1451@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95634>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> Nicolas Pitre wrote:
> >First, its name.  The word "origin" probably has a too narrow meaning 
> >that creates confusion.  I'd suggest something like a 
> >"may-be-related-to" field that would be like a weak link.
> 
> Well, the important properties of the name/field would be:
> - It should be as specific as possible, in order to minimise the
>   potential for abuse in the future.  I distill the desirability of this
>   requirement out of the various earlier discussions about commitheaders
>   in the past on this mailinglist held by others.

Well, sure.  But being too specific sometimes limits its usefulness.  
There could be other usages for such a link which IMHO should be defined 
in terms of graph connectivity semantics rather than high level purpose.

> - It should convey a sense of direction (it's a directed graph).

Well, isn't that already obvious?

> Any generic may-be-related-to field is therefore probably a non-starter.

Well, my whole argument is that if it has no generic purpose then it 
probably doesn't belong in the commit header.

> The origin field as currently proposed tightens the requirements that
> it either is dangling and ignored or points to a commit.
> rev-list --topo-order should use the origin links to order the output.
> gc/prune won't delete commits referenced *by* an origin link.

And I disagree on the gc/prune point, as mentioned previously.

As to rev-list --topo-order, it doesn't need for this link to actually 
be part of the commit object to accomplish the desired effect.

> The only two other arguments one might give to actually keep the field
> in the header of the commit as opposed to the trailer is that the 
> physical field can be kept machine readable, and the actual display can be
> beautified like:  Origin: 2abcdef..1234567
> The output of the field could be suppressed (if so desired) if the
> target commit isn't reachable.
> All this is of course possible for a trailer field in the free-form
> area as well, but it seems a bit silly to have two places for "headers".

And I think you should simply create a file within the repository with 
that info instead of either thecommit header or the free form text.  It 
gives all the usability advantages you wish for and more.


Nicolas
