From: Nicolas Pitre <nico@cam.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 14:41:06 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701271430310.3021@xanadu.home>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
 <20070127080126.GC9966@spearce.org>
 <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BB5888.9020608@fs.ei.tum.de>
 <Pine.LNX.4.63.0701271728020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45BB87EB.7010200@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 20:41:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAtQH-0000CQ-CM
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 20:41:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbXA0TlK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 14:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbXA0TlJ
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 14:41:09 -0500
Received: from relais.videotron.ca ([24.201.245.36]:31781 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbXA0TlI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 14:41:08 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCJ00LO7LCIMPG0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 14:41:07 -0500 (EST)
In-reply-to: <45BB87EB.7010200@fs.ei.tum.de>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37991>

On Sat, 27 Jan 2007, Simon 'corecode' Schubert wrote:

> Maybe I was not clear enough.  I do not propose to change the file format, but
> to extend the information stored.  In which way whatsoever.  However I think
> that keeping this information along with trees in pack files seems very
> sensible.  Or along pack files, whatever.

Along pack files please.

> > Rather, calculate the information you need from the existing data, and if
> > you can reuse it, store it locally. _That_ is flexibility.
> 
> Of course this is flexibility.  But this also means that every consumer has to
> do this for every repo.  Wouldn't it be nice to have it done one time and then
> stored in a pack?

NO!  That would mean that this extra information is now tied to the pack 
format and this is not a good thing to depend on.

Every consumer is already recomputing the pack index locally for every 
repo.  This has the advantage that we can change the pack index format 
as we so choose without having to bother with backward compatibility in 
the pack transfer protocol.

> > And if something is wrong with that "auxillary information", it can be
> > regenerated correctly, without touching the real data -- the commit
> > ancestry.
> 
> Yes, it always can be regenerated.  I never said it should be made part of the
> core structure.

But the pack format is pretty much part of the core structure.  If 
things can be deduced from the pack without adding to it then they 
should.  This way you have the freedom to experiment with any ancillary 
format you wish.


Nicolas
