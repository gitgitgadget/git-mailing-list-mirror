From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add -d flag to git-pull-* family.
Date: Wed, 01 Jun 2005 10:39:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0506011032570.7439@localhost.localdomain>
References: <Pine.LNX.4.58.0505301253070.1876@ppc970.osdl.org>
 <Pine.LNX.4.62.0505301644430.5330@localhost.localdomain>
 <7vacmapo18.fsf@assigned-by-dhcp.cox.net>
 <7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 01 16:39:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdUL1-0003CK-Qh
	for gcvg-git@gmane.org; Wed, 01 Jun 2005 16:36:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVFAOjs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Jun 2005 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVFAOjs
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jun 2005 10:39:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9008 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261393AbVFAOjq
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Jun 2005 10:39:46 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR011.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IHE0028BU1PVQ@VL-MO-MR011.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 01 Jun 2005 10:39:26 -0400 (EDT)
In-reply-to: <7vu0kilc21.fsf_-_@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 1 Jun 2005, Junio C Hamano wrote:

> When a remote repository is deltified, we need to get the
> objects that a deltified object we want to obtain is based upon.
> Since checking representation type of all objects we retreive
> from remote side may be costly, this is made into a separate
> option -d; -a implies it for convenience and safety.

I wonder if making this optional makes sense.  In fact, if you believe 
having the option is useful then it should probably be the other 
way around i.e. to _not_ look at deltas when it is specified.  Otherwise 
you'll end up with an incoherent repository.

To minimize the cost a lot it could be possible to uncompress just the 
first 40 bytes or so which is enough to determine if the object is a 
delta and if so what object it is against.

What do you think?


Nicolas
