From: Nicolas Pitre <nico@cam.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 13:39:24 -0500 (EST)
Message-ID: <alpine.LRH.0.82.0702211321040.31945@xanadu.home>
References: <20070221164527.GA8513@ginosko.local>
 <Pine.LNX.4.64.0702210904350.4043@woody.linux-foundation.org>
 <alpine.LRH.0.82.0702211236180.31945@xanadu.home>
 <Pine.LNX.4.64.0702211009520.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:39:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJwNH-0002xn-93
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbXBUSj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbXBUSj0
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:39:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:43338 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422788AbXBUSjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:39:25 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDT008NET5ORR40@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Feb 2007 13:39:24 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0702211009520.4043@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40316>

On Wed, 21 Feb 2007, Linus Torvalds wrote:

> 
> 
> On Wed, 21 Feb 2007, Nicolas Pitre wrote:
> So supermodules might be a way to solve it in a better (and safer - the 
> "remove objects from the public tree" thing is very error prone, since if 
> you *ever* expose the object by mistake, its now public) way. But I don't 
> think the "filter out objects" thing is necessarily fundamentally flawed 
> as an approach.

Well if you really wanted to do such a thing then you could use a new 
object type that only serves as a stub pretending to be another object 
which SHA1 would have been xyz.  When referenced this object would 
generate a warning indicating to the user that given object has been 
excised out, but otherwise the whole reachability validation would still 
work as usual.

And since this object would be distributed through standard mechanisms 
then there would be no need for protocol extensions.

I don't know if this could help creating SHA1 collisions though.  We've 
dismissed them as highly improbable because the likelihood of a 
collision to hide compromised material would most probably require a 
binary blob somewhere to balance the hash and would hardly be 
compilable/undetected.  But with object stubs with the ability to 
pretend having any possible SHA1 is in fact a nice way to hide 20-byte 
binary blobs in the hash chain possibly making it "easier" to create 
"useful" collisions.  This is where I see a weakening of the trust 
model.


Nicolas
