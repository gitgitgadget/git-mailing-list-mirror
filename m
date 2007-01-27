From: Nicolas Pitre <nico@cam.org>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 12:47:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701271228270.3021@xanadu.home>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
 <20070127080126.GC9966@spearce.org> <7vbqkklv3h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Jan 27 18:47:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAreW-0006Fd-Rx
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 18:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbXA0Rrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 12:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbXA0Rrq
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 12:47:46 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13474 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbXA0Rrp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 12:47:45 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCJ00MM9G3KWGB0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 27 Jan 2007 12:47:44 -0500 (EST)
In-reply-to: <7vbqkklv3h.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37976>

On Sat, 27 Jan 2007, Junio C Hamano wrote:

> Anything you would do, storing that in tree is wrong.  Tree
> object only represents just the contents of a single state and
> in itself there should not be any information that describes its
> relation with other trees [*1*].
> 
> And of course making it pack-only is doubly wrong.
> 
> 
> *1* That's why my thinking-aloud talked about "N list of changed
> paths recorded in a commit object with N parents".  A commit is
> to talk about one particular state (i.e. tree) and its relation
> to other commits (and by indirection, other trees), so logically
> the information could belong there --- that is merely a "could",
> since that is strictly caching for performance.  After finding
> where the bottleneck is, obviously finding a way to optimize the
> tree pathlimiting with the currently available data without
> having such redundant data is more preferable.

I do think, too, that such data is not desirable in the object database.

However there is nothing wrong with a separate "cache", just like the 
pack index, that can be discarded and recreated at any time.  
Especially since this "cache data" might change with time as new tricks 
to speed up things are found.  OTOH it is preferable to keep the object 
database as slick and stable as possible.


Nicolas
