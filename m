From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: use of version 3 delta is now optional.
Date: Mon, 16 Oct 2006 09:43:04 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610160929450.17085@xanadu.home>
References: <7v4pu62ite.fsf@assigned-by-dhcp.cox.net>
 <7virim10rb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151135110.17085@xanadu.home>
 <7vac3xzbze.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610151150530.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 16 15:43:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZSkV-0002eE-0u
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 15:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbWJPNnK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 09:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWJPNnK
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 09:43:10 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18240 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932066AbWJPNnF
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Oct 2006 09:43:05 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J78006JAE3S9FO1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 16 Oct 2006 09:43:05 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610151150530.3952@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28960>

On Sun, 15 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Sun, 15 Oct 2006, Junio C Hamano wrote:
> > 
> > I think that is sensible.  I also was thinking that we should
> > call the current one packv3 and the one with delta-base-offset
> > packv4.
> 
> Quite frankly, I wonder if the pure "copy size extension" (aka "v3") thing 
> is really worth it at all. 
> 
> I mean, seriously, how much does it buy us? A couple of bytes per every 
> 64kB of delta copied? And the downside is that you can't re-use the deltas 
> with old clients and/or you have to re-create a "v2" delta at run-time 
> from a v3 delta by inflating, fixing and deflating it.

Right.  This is why I suggested Junio to just drop it for now.  Let's 
just wait some more until this is just not an issue any longer, say in a 
year from now when all major distributions have switched to a GIT 
version that can read V3.

If until then we find the saving really worth the backward compatibility 
v3-to-v2 conversion then we could reconsider.  But I don't think it is 
worth it just yet.

In the mean time, if Junio adds the patch I posted yesterday advertising 
the pack version capability over the native protocol then it'll help us 
make things forward compatible if ever we decide to go with generating 
packs v3 sooner.


Nicolas
