From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] gc --aggressive: make it really aggressive
Date: Thu, 06 Dec 2007 09:15:11 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712060908490.555@xanadu.home>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
 <20071205.202047.58135920.davem@davemloft.net>
 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
 <20071205.204848.227521641.davem@davemloft.net>
 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
 <Pine.LNX.4.64.0712061201580.27959@racer.site>
 <20071206134243.GA17037@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org, gitster@pobox.com
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 06 15:15:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0HVz-0001dg-BN
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 15:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbXLFOP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 09:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbXLFOP0
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 09:15:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:36700 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752375AbXLFOPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 09:15:25 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSM004I6SXBJDC0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Dec 2007 09:15:12 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071206134243.GA17037@thunk.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67288>

On Thu, 6 Dec 2007, Theodore Tso wrote:

> Linus later pointed out that what we *really* should do is at some
> point was to change repack -f to potentially retry to find a better
> delta, but to reuse the existing delta if it was no worse.  That
> automatically does the right thing in the case where you had
> previously done a repack with --window=<large n> --depth=<large n>,
> but then later try using "gc --agressive", which ends up doing a worse
> job and throwing away the information from the previous repack with
> large window and depth sizes.  Unfortunately no one ever got around to
> implementing that.

I did start looking at it, but there are subtle issues to consider, such 
as making sure not to create delta loops.  Currently this is avoided by 
never involving already reused deltas in new delta chains, except for 
edge base objects.

IOW, this requires some head scratching which I didn't have the time for 
so far.


Nicolas
