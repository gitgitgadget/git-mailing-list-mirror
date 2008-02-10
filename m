From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 00:22:09 -0500 (EST)
Message-ID: <alpine.LFD.1.00.0802100017380.2732@xanadu.home>
References: <200802081828.43849.kendy@suse.cz>
 <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz>
 <alpine.LFD.1.00.0802092200350.2732@xanadu.home>
 <BAYC1-PASMTP10AF630E8A5B3D6C255317AE290@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sun Feb 10 06:22:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO4eM-0002tl-Db
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 06:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbYBJFWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 00:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbYBJFWL
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 00:22:11 -0500
Received: from relais.videotron.ca ([24.201.245.36]:53210 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbYBJFWK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 00:22:10 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JW000CVWC8P6H40@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Feb 2008 00:22:01 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <BAYC1-PASMTP10AF630E8A5B3D6C255317AE290@CEZ.ICE>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73315>

On Sat, 9 Feb 2008, Sean wrote:

> On Sat, 09 Feb 2008 22:10:06 -0500 (EST)
> Nicolas Pitre <nico@cam.org> wrote:
> 
> > On Sat, 9 Feb 2008, Jan Holesovsky wrote:
> > 
> > > On Friday 08 February 2008 20:00, Jakub Narebski wrote:
> > > 
> > > > Both Mozilla import, and GCC import were packed below 0.5 GB. Warning:
> > > > you would need machine with large amount of memory to repack it
> > > > tightly in sensible time!
> > > 
> > > As I answered elsewhere, unfortunately it goes out of memory even on 8G 
> > > machine (x86-64), so...  But still trying.
> > 
> > Try setting the following config variables as follows:
> > 
> > 	git config pack.deltaCacheLimit 1
> > 	git config pack.deltaCacheSize 1
> > 	git config pack.windowMemory 1g
> > 
> > That should help keeping memory usage somewhat bounded.
> > 
> 
> Hi Nicolas,
> 
> Tried that earlier today and got a 1.6G pack (on a 2G machine).  There are
> some big objects in that repo.. over 100 are 30 to 62M in size, 400 more
> over 10M, and ~40,000 over 100K.  Would you expect a larger memory window
> (on a better machine) to help shrink the repo down any more?

Well, I don't think so.  Anyway, with the above pack.windowMemory 
setting, the window probably gets shrinked if those big objects are all 
to be found in the same window.  So that would be the setting to 
increase if you have lots of ram.

Finding out what those huge objects are, and if they actually need to be 
there, would be a good thing to do to reduce any repository size.


Nicolas
