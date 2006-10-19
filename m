From: Nicolas Pitre <nico@cam.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 10:27:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610191025340.1971@xanadu.home>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org>
 <20061018185225.GU20017@pasky.or.cz> <20061018185907.GV20017@pasky.or.cz>
 <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home>
 <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home>
 <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org>
 <20061018214143.GF19194@spearce.org> <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home>
 <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
 <7vac3tx900.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:30:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaYs6-0005Jr-6H
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161434AbWJSO1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161426AbWJSO1m
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:27:42 -0400
Received: from relais.videotron.ca ([24.201.245.36]:37817 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1161434AbWJSO1l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Oct 2006 10:27:41 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7E00AM2064JW70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 19 Oct 2006 10:27:40 -0400 (EDT)
In-reply-to: <7vac3tx900.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29352>

On Wed, 18 Oct 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Actually, I've hit an impasse.
> >
> > So there's _another_ way of fixing a thin pack: it's to expand the objects 
> > without a base into non-delta objects, and keeping the number of objects 
> > in the pack the same. But _again_, we don't actually know which ones to 
> > expand until it's too late.
> 
> pack-objects.c::write_one() makes sure that we write out base
> immediately after delta if we haven't written out its base yet,
> so I suspect if you buffer one delta you should be Ok, no?

If we create full packs out of thin packs the base objects will end up 
at the end of the pack so this assumption is a bad one to rely upon if 
we want to make things robust (like being able to feed such a pack 
back).


Nicolas
