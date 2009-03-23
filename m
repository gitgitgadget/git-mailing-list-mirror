From: Nicolas Pitre <nico@cam.org>
Subject: Re: Summer of Code - Cached Packs/Object Lists
Date: Mon, 23 Mar 2009 10:41:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903231037100.30483@xanadu.home>
References: <20090323015936.GM23521@spearce.org>
 <fsmk86y8vqj4f56b08UYAxe124vaj_firegpg@mail.gmail.com>
 <20090323025244.GO23521@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Thomas Coppi <thisnukes4u@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 23 15:43:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LllMZ-000256-IM
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 15:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756628AbZCWOlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 10:41:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756383AbZCWOlS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 10:41:18 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50677 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754650AbZCWOlS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 10:41:18 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGY00M9SRGNBZI0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 23 Mar 2009 10:41:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20090323025244.GO23521@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114317>

On Sun, 22 Mar 2009, Shawn O. Pearce wrote:

> Thomas Coppi <thisnukes4u@gmail.com> wrote:
> > On Sun, Mar 22, 2009 at 7:59 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> >> You could do both. ??But I think most people on the list will argue
> >> that doing both is overkill and only one is necessary, and further,
> >> that only the one that offers the "biggest bank for the buck"
> >> should be implemented.
> >
> > Alright, that seems reasonable.  Given that I think I would lean
> > towards implementing an object list caching mechanism, since that seems
> > to be more generally applicable.  The logic for this would then need to
> > be in the rev-list code(as mentioned in the JGit discussion), correct?
> 
> Probably.  IIRC upload-pack forks a rev-list to produce the
> object list, and pipes that into the forked pack-objects' stdin.
> Thus rev-list is probably what would need to know how to include
> the cached list to its output.

Related to this, the first optimization is probably to avoid the fork 
altogether.  The pack-objects code knows how to list objects by itself 
already, and that is used by git-repack.  At the moment, packed tree 
objects during a fetch are probably accessed one extra time needlessly.


Nicolas
