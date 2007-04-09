From: Nicolas Pitre <nico@cam.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 09 Apr 2007 16:02:37 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704091601470.28181@xanadu.home>
References: <11760951973172-git-send-email-nico@cam.org>
 <20070409171925.GS5436@spearce.org>
 <alpine.LFD.0.98.0704091328130.28181@xanadu.home>
 <20070409174305.GU5436@spearce.org> <7vtzvpz5tu.fsf@assigned-by-dhcp.cox.net>
 <20070409195322.GB5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:23:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hb04f-0003L5-IB
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 22:02:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbXDIUCj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 16:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965345AbXDIUCj
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 16:02:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17321 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbXDIUCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 16:02:38 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JG8008G5YCDYKQ0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 09 Apr 2007 16:02:37 -0400 (EDT)
In-reply-to: <20070409195322.GB5436@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44079>

On Mon, 9 Apr 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > 
> > > Nicolas Pitre <nico@cam.org> wrote:
> > > ...
> > > Here's something we didn't think about, but that occurred to me today
> > > when reading this series: If we move the SHA-1 table out of the index
> > > and into the packfile (like we are planning) dumb commit-walkers
> > > (http-fetch) will have problems.  Right now they download the
> > > indexes of every available packfile to determine if they need to
> > > download the corresponding packfile to obtain a needed object.
> > 
> > If we really care about older dumb clients, one option is to
> > generate not .idx but .idx2, and have a corresponding .idx only
> > to support them.  But at that point, it's probably cleaner to
> > have an explicit option to produce .idx file of a particular
> > version, and tell people to pack public repositories they expect
> > older dumb clients to access with that option to keep things
> > backward compatible.
> 
> Sure, fine.  But I think you missed my point above - right now if
> we move the SHA-1 table out of the .idx file I'm not sure we know
> how to support the dumb clients *at all*.  Even if they understand
> the latest-and-greatest file formats...

The table could live in both the pack and the index for those repos 
expected to be exportable through dumb protocols.


Nicolas
