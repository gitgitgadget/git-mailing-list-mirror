From: Nicolas Pitre <nico@cam.org>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 05 Sep 2007 19:04:27 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0709051858060.21186@xanadu.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
 <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix>
 <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix>
 <alpine.LFD.0.9999.0709051438460.21186@xanadu.home>
 <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.0.9999.0709051634190.21186@xanadu.home>
 <7v1wdciy3w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nix <nix@esperi.org.uk>, Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 01:05:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT3vb-00034d-Er
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 01:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072AbXIEXEc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 19:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757023AbXIEXEb
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 19:04:31 -0400
Received: from relais.videotron.ca ([24.201.245.36]:52110 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756617AbXIEXEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 19:04:30 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JNX00FWN43H5681@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 05 Sep 2007 19:04:29 -0400 (EDT)
In-reply-to: <7v1wdciy3w.fsf@gitster.siamese.dyndns.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57772>

On Wed, 5 Sep 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> This patch does not add invocation of the "auto repacking".  It
> >> is left to key Porcelain commands that could produce tons of
> >> loose objects to add a call to "git gc --auto" after they are
> >> done their work.  Obvious candidates are:
> >> 
> >> 	git add
> >
> > Nope!  'git add' creates loose objects which are not yet reachable from 
> > anywhere.  They won't get repacked until a commit is made.
> 
> Bzzt, I am releaved to see you are sometimes wrong ;-)
> 
> They are reachable from the index and are not subject to
> pruning.

The index?  What's that?  ;-)

> >> 	git fetch
> >
> > I think that would be a much better idea to simply decrease the 
> > fetch.unpackLimit default value.
> 
> One thing that I find lacking in that auto patch is actually
> that we should sometimes consolidate multiple small packs into a
> single larger one.  Any behaviour change to encourage creation
> of many tiny packs should be avoided until it materializes.
> 
> Probably we should introduce a built-in minimum value for a
> positive gc.auto, somewhere around 1000 or so, for this reason.

Why not just let the default value take care of it?  If someone really 
wants to set gc.auto to 50, why prevent it?

The more I think of it, the less I like automatic repack.  There is 
always a bad case for it somewhere.


Nicolas
