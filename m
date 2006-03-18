From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] 3% tighter packs for free
Date: Sat, 18 Mar 2006 13:23:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0603181315060.4889@localhost.localdomain>
References: <Pine.LNX.4.64.0603172205490.4889@localhost.localdomain>
 <7vwtesxloi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 18 19:23:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKg5k-0000OK-PA
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 19:23:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWCRSXi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 13:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWCRSXi
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 13:23:38 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44440 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1750786AbWCRSXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 13:23:38 -0500
Received: from xanadu.home ([74.56.105.38]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IWC000535RDX920@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 18 Mar 2006 13:23:37 -0500 (EST)
In-reply-to: <7vwtesxloi.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17701>

On Fri, 17 Mar 2006, Junio C Hamano wrote:

> Once you make it into a patch form, it is plainly obvious that
> this is a good optimization.  Since our BLK_SIZE is 16 bytes,
> you are grabbing up to 15 more bytes (on average 8 more bytes or
> so) for every match after a partially modified block.
> 
> Very nice.  I wonder if a larger BLK_SIZE (say 32 bytes) would
> give us faster packing without losing much compression if we use
> this idea.

Tried that long ago.  As BLK_SIZE is increased the adler32 cost, which 
has to be computed for every offset in the target buffer, increases 
accordingly.  So you end up with both worse compression and more CPU 
usage.


Nicolas
