From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Change 'Deltifying objects' to 'Delta compressing objects'
Date: Thu, 18 Oct 2007 23:01:02 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710182251110.19446@xanadu.home>
References: <20071019004527.GA12930@spearce.org>
 <20071019021255.GD3290@coredump.intra.peff.net>
 <20071019022154.GY14735@spearce.org>
 <20071019023425.GB8298@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 05:01:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iii6v-0005M8-2J
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 05:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759930AbXJSDBF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 23:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759281AbXJSDBE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 23:01:04 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28947 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759674AbXJSDBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 23:01:03 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ50016N1PQZ030@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 18 Oct 2007 23:01:02 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071019023425.GB8298@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61620>

On Thu, 18 Oct 2007, Jeff King wrote:

> On a similar note, some complaints with progress meters, even after
> recent patches:
>   - When fetching, one progress meter says "Indexing" which, while
>     technically true, is almost certainly blocking on "Downloading". In
>     fact, it is not clear from the existing messages exactly _when_ we
>     are downloading, and when we are just computing, which is something
>     I think a user might want to know. Objections to changing this
>     (though perhaps index-pack will need to be told when it is
>     downloading and when it is just indexing)? Objections to a
>     throughput indicator?

I have some WIP for that.

>   - Running git-gc, we now get something like:
>       Counting objects: 62317, done.
>       Deltifying objects: 100% (18042/18042), done.
>       Writing objects: 100% (62317/62317), done.
>       Total 62317 (delta 43861), reused 61404 (delta 43036)
>       Pack pack-32f8ac40c1a5ec146e45c657cb16f53fdd354095 created.
>       Removing unused objects 100%...
>       Done.
>     Can we get rid of total statistics (I think this is useful for some
>     power users, but perhaps there should be a verbosity level), the
>     name of the pack file (same deal), and the totally useless "Done."?

Agreed for the pack name.  Certainly no one cares.

Maybe the "Removing unused objects" should use the common progress 
infrastructure?  It could even use the delayed interface, just like when 
checking out files, so no progress at all is displayed when that 
operation completes within a certain delay.  And the removal of unused 
objects is usually quick.

But I like the statistics.  They might be pretty handy to diagnoze 
performance issues on remote servers for example.


Nicolas
