From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-fast-import crashes
Date: Sat, 13 Oct 2007 13:58:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710131357391.25221@racer.site>
References: <e66701d40710120242p6fc05148hd40d19d295373ac4@mail.gmail.com>
 <20071013032916.GL27899@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shun Kei Leung <kevinlsk@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Oct 13 14:58:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IggZl-0003Y2-OI
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 14:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbXJMM6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 08:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752966AbXJMM6a
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 08:58:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:42996 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750858AbXJMM63 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 08:58:29 -0400
Received: (qmail invoked by alias); 13 Oct 2007 12:58:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 13 Oct 2007 14:58:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182TuY9rgc26nx1UwDmN3VbPBf88vr7H7qoG8K9Cg
	UC7Llo7eS0r5yi
X-X-Sender: gene099@racer.site
In-Reply-To: <20071013032916.GL27899@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 12 Oct 2007, Shawn O. Pearce wrote:

> Shun Kei Leung <kevinlsk@gmail.com> wrote:
> > Program received signal EXC_BAD_ACCESS, Could not access memory.
> > Reason: KERN_INVALID_ADDRESS at address: 0x64617469
> > in_window (win=0x5004d0, offset=3501) at sha1_file.c:701
> > 701             off_t win_off = win->offset;
> ...
> > (gdb) print win
> > $1 = (struct pack_window *) 0x5004d0
> > (gdb) print *win
> > $2 = {
> >   next = 0x64617461,
> >   base = 0x20333936 <Address 0x20333936 out of bounds>,
> >   offset = 22523564414626158,
> >   len = 1685026675,
> >   last_used = 795894075,
> >   inuse_cnt = 0
> > }
> 
> Wow.  There's no way that struct pack_window is valid anymore.
>
> [...] 
>
> This looks like it is memory corruption (e.g. someone overwriting a 
> free'd segment), but that sort of memory corruption is very hard to 
> track down.

I found valgrind invaluable to find such errors.

Ciao,
Dscho
