From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 11:02:54 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0809111047380.23787@xanadu.home>
References: <20080909132212.GA25476@cuci.nl>
 <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org>
 <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com>
 <20080911123148.GA2056@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 17:05:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdnim-00029p-Vt
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 17:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752438AbYIKPD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 11:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752446AbYIKPD2
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 11:03:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20278 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752423AbYIKPD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 11:03:27 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K7100BFQDSUJGH0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 11 Sep 2008 11:02:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080911123148.GA2056@cuci.nl>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95609>

On Thu, 11 Sep 2008, Stephen R. van den Berg wrote:

> So short-circuiting the reasoning suggests that since the only thing
> that actually changes now is the position of the field (at the top or
> end of the commit message), we might as well do it right and put it in
> the top, that gets rid of the two minuses.
> 
> Anything I missed?

A good convincing demonstration that this is actually worth doing in the 
first place.  And here I'm talking about the _feature_ and not the 
_implementation_.

> Basically it means that:
> 
> a. If there is a better solution to tracking the backports, I'll gladly
>    use that instead, but simply using the current really freeform
>    approach doesn't cut it (it currently refers to a single commit,
>    instead of a pair of commits, and takes too long to parse out in a
>    --top-order or blame command).  Better solutions I haven't heard so
>    far.
> 
> b. I need the integrity protection of a commit to make sure that the
>    origin fields cannot be altered later; blame would be too easy to fool
>    otherwise.  So using the notes solution seems to be out (it would also
>    be quite a performance hit again).
> 
> c. I consider the Origin: field at the end of the commit message a
>    workable solution, but it smells like X-header-extension-messes as in
>    E-mail headers, and it incurs a small performance hit (in case of
>    --topo-order/blame/prune/fsck), but maybe this performance hit can be
>    minimised by making sure that the fields are *always* at the end
>    of the commit message.
> 
> d. Using the proposed origin header in the standard commit header has
>    close to zero overhead (in most commits the field is not present), yet
>    codecomplexitywise it is almost identical with the Origin: field at
>    the end of the commit message.
> 
> I find it remarkable though that people are dragging their feet at
> solution d, yet are quite ok with solution c.  IMO solution c and d are
> almost identical, except that solution c is ugly, and solution d is
> elegant.  But if it makes it easier to prove the usefulness by
> implementing the ugly solution first, that's fine.

Technically speaking, implementation d is obviously the most efficient.  
but, as mentioned above, the actual need for this feature has not been 
convincing so far.  Until then, it is not wise to add random stuff to 
the very structure of a commit object, while c can be done even 
externally from git which is a good way to demonstrate and convince 
people about the usefulness of such feature.


Nicolas
