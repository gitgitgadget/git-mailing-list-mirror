From: Nicolas Pitre <nico@cam.org>
Subject: Re: Efficiency of initial clone from server
Date: Mon, 12 Feb 2007 10:20:31 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0702121013150.1757@xanadu.home>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
 <20070211225326.GC31488@spearce.org>
 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
 <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
 <9e4733910702112101h256b1468j5de65c6e89109a22@mail.gmail.com>
 <20070212051108.GB699@spearce.org>
 <9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 16:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGcz5-0002sf-Gy
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 16:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbXBLPUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 10:20:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964963AbXBLPUl
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 10:20:41 -0500
Received: from relais.videotron.ca ([24.201.245.36]:25633 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964961AbXBLPUl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 10:20:41 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JDC000Z0VY7U2G0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 12 Feb 2007 10:20:31 -0500 (EST)
In-reply-to: <9e4733910702112117o53630946ja50572c7c7f2b2c1@mail.gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39408>

On Mon, 12 Feb 2007, Jon Smirl wrote:

> I didn't want to cache the packfile, instead I wanted to repack the
> repository and then copy the resulting pack file down the wire. A
> clone would just be a trigger to make sure everything in the repo was
> packed (maybe into multiple packs) before starting to send anything.
> Doing it this way means that everyone benefits from the packing.

Repacking on clone is not the solution at all.

This problem is going to largely be resolved when GIT 1.5.0 gets 
installed on kernel.org.  With latest GIT, pushes are kept as packs on 
the remote end (when they're big enough which is over 100 objects by 
default).  Then repacking multiple packs into one is almost free as most 
of the data is simply copied from one pack and sent over the wire as a 
single pack.

As for the cache problem on kernel.org, that would be largely resolved 
if all kernel related projects were repacked with reference to Linus' 
repository to avoid copying the same set of data all over the place.


Nicolas
