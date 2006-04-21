From: Nicolas Pitre <nico@cam.org>
Subject: Re: 1.3.0 creating bigger packs than 1.2.3
Date: Thu, 20 Apr 2006 20:52:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0604202050180.2215@localhost.localdomain>
References: <20060420133640.GA31198@spearce.org>
 <Pine.LNX.4.64.0604200745550.3701@g5.osdl.org>
 <20060420150315.GB31198@spearce.org>
 <Pine.LNX.4.64.0604200857460.3701@g5.osdl.org>
 <20060420164351.GB31738@spearce.org>
 <Pine.LNX.4.64.0604200954440.3701@g5.osdl.org>
 <20060420175554.GH31738@spearce.org>
 <Pine.LNX.4.64.0604201414490.2215@localhost.localdomain>
 <7v8xq0yteb.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0604201630320.2215@localhost.localdomain>
 <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 21 02:52:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWjsM-00076Q-C2
	for gcvg-git@gmane.org; Fri, 21 Apr 2006 02:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWDUAvz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 20:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWDUAvz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 20:51:55 -0400
Received: from relais.videotron.ca ([24.201.245.36]:19077 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751296AbWDUAvy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 20:51:54 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IY1000LGRQIZRO1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 20 Apr 2006 20:51:54 -0400 (EDT)
In-reply-to: <7vfyk8vscl.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19010>

On Thu, 20 Apr 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> >> But I suspect we have a built-in "we sort bigger to smaller, and
> >> we cut off when we switch bins" somewhere in find_delta() loop,
> >> which I do not recall touching when I did that change, so that
> >> may be interfering and preventing 0-11-AdjLite.deg from all over
> >> the place to delta against each other.
> >
> > I just cannot find something that would do that in the code.  When 
> > --no-reuse-delta is specified, the only things that will break the loop
> > in find_delta() is when try_delta() returns -1, and that happens only 
> > when changing object type or when the size difference is too big, but 
> > nothing looks at the name hash.
> 
> The list is sorted by type then hash then size (type_size_sort),
> so if you have t/Makefile that are big medium small too-small
> and then doc/Makefile that are big medium, once you see the
> too-small t/Makefile it would not consider the big doc/Makefile
> as a candidate X-<.

Bingo!  I didn't think it all through before.


Nicolas
