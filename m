From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 12:44:47 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712111237530.555@xanadu.home>
References: <9e4733910712102301p5e6c4165v6afb32d157478828@mail.gmail.com>
 <alpine.LFD.0.9999.0712110806540.25032@woody.linux-foundation.org>
 <alpine.LFD.0.99999.0712111202470.555@xanadu.home>
 <20071211.092402.266823343.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>, jonsmirl@gmail.com,
	Junio C Hamano <gitster@pobox.com>, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Tue Dec 11 18:45:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29AM-0007bx-Q3
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005AbXLKRot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 12:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752282AbXLKRot
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:44:49 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30662 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017AbXLKRos (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 12:44:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JSW005BGBYNVIF0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 11 Dec 2007 12:44:48 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071211.092402.266823343.davem@davemloft.net>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67891>

On Tue, 11 Dec 2007, David Miller wrote:

> From: Nicolas Pitre <nico@cam.org>
> Date: Tue, 11 Dec 2007 12:21:11 -0500 (EST)
> 
> > BUT.  The point is that repacking the gcc repo using "git repack -a -f 
> > --window=250" has a radically different memory usage profile whether you 
> > do the repack on the earlier 2.1GB pack or the later 300MB pack.  
> 
> If you repack on the smaller pack file, git has to expand more stuff
> internally in order to search the deltas, whereas with the larger pack
> file I bet git has to less often undelta'ify to get base objects blobs
> for delta search.

Of course.  I came to that conclusion two days ago.  And despite being 
pretty familiar with the involved code (I wrote part of it myself) I 
just can't spot anything wrong with it so far.

But somehow the threading code keep distracting people from that issue 
since it gets to do the same work whether or not the source pack is 
densely packed or not.

Nicolas 
(who wish he had access to a much faster machine to investigate this issue)
