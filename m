From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 17:47:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606291743010.1213@localhost.localdomain>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:48:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw4Me-0001u0-6X
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbWF2VrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932919AbWF2VrR
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:47:17 -0400
Received: from relais.videotron.ca ([24.201.245.36]:11469 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932616AbWF2VrL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 17:47:11 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J1N008EI5UL8400@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 29 Jun 2006 17:47:10 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22913>

On Thu, 29 Jun 2006, Linus Torvalds wrote:

> 
> 
> On Thu, 29 Jun 2006, Nicolas Pitre wrote:
> >
> > On Thu, 29 Jun 2006, Linus Torvalds wrote:
> > 
> > > Instead of having a separate cache, wouldn't it be much better to just 
> > > take the hint from the previous pack-file?
> > 
> > DOH!  ;-)
> 
> Btw, I think this could do with a flag to turn it on/off (but probably 
> default to on).

I think it should simply be coupled with the --no-reuse-delta flag.

> The advantage of this patch is that it should guarantee that if everything 
> is already packed, a repack will basically keep the pack identical. 
> 
> However, that is obviously also the dis-advantage, since it means that 
> repacking cannot improve packing. So adding a flag to say "please try to 
> incrementally improve the pack" might well be worth it, even if this new 
> behaviour would be the _default_.

Actually, the delta reusing already prevents those deltas from being 
improved.  So your patch only extend this notion to the non-deltified 
objects as well.  And the way out is to provide the --no-reuse-delta 
flag.


Nicolas
