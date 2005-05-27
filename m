From: Nicolas Pitre <nico@cam.org>
Subject: Re: BEWARE: mkdelta is broken
Date: Fri, 27 May 2005 13:37:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.62.0505271335170.16151@localhost.localdomain>
References: <Pine.LNX.4.62.0505262125050.16151@localhost.localdomain>
 <20050527094133.GR24351@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 19:39:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dbilj-0004it-7g
	for gcvg-git@gmane.org; Fri, 27 May 2005 19:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVE0RjJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 13:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVE0RjJ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 13:39:09 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65098 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261905AbVE0Ri5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 13:38:57 -0400
Received: from xanadu.home ([24.200.213.96]) by VL-MO-MR007.ip.videotron.ca
 (iPlanet Messaging Server 5.2 HotFix 1.21 (built Sep  8 2003))
 with ESMTP id <0IH5007QLSYPYI@VL-MO-MR007.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 27 May 2005 13:37:38 -0400 (EDT)
In-reply-to: <20050527094133.GR24351@cip.informatik.uni-erlangen.de>
X-X-Sender: nico@localhost.localdomain
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 27 May 2005, Thomas Glanzmann wrote:

> Hello,
> 
> > The current delta loop detection logic is broken.  So if you have 
> > multiple merged branches or you have a changeset that revert things then 
> > you might end up with a delta loop and fsck-cache will effectively 
> > complain about unresolved deltas and assorted dangling/broken object 
> > links.
> 
> I wanted to give you heads-up, but I forgot it. But I think noone is
> using it at the moment otherwise they had complained in the first place.
> 
> However ... I took linux-2.6 repository. Ran git-deltafy-script &&
> git-deltafy-script -d 0 and it segfaulted on me. Same for my mutt-cvs
> import.

Yes, that's because you end up with delta loops.  When trying to expand 
the delta, it keeps looping and allocating memory until killed.

I fixed that already and am preparing a patch at the moment.


Nicolas
