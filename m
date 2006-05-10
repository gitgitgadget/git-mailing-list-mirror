From: Nicolas Pitre <nico@cam.org>
Subject: Re: What's in git.git
Date: Wed, 10 May 2006 10:15:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605101012250.24505@localhost.localdomain>
References: <7viroezi8s.fsf@assigned-by-dhcp.cox.net>
 <864pzyh4x0.fsf@blue.stonehenge.com>
 <Pine.LNX.4.64.0605092142050.3718@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 10 16:15:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdpTI-0008T5-6f
	for gcvg-git@gmane.org; Wed, 10 May 2006 16:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWEJOPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 May 2006 10:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWEJOPU
	(ORCPT <rfc822;git-outgoing>); Wed, 10 May 2006 10:15:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20554 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751447AbWEJOPS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 May 2006 10:15:18 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IZ100GZMZLHPA60@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 10 May 2006 10:15:18 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0605092142050.3718@g5.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19883>

On Tue, 9 May 2006, Linus Torvalds wrote:

> 
> 
> On Tue, 9 May 2006, Randal L. Schwartz wrote:
> 
> > >>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:
> > 
> > Junio> This week's "What's in" is a day early, since I do not expect to
> > Junio> be able to do much gitting for the rest of the week.
> > 
> > I just got this with the latest, on the git archive, using git-repack -a:
> > 
> > Generating pack...
> > Done counting 19151 objects.
> > Deltifying 19151 objects.
> > Segmentation fault (core dumped)
> > 
> > This is on OpenBSD.  Is there a secret sabotage afoot?  This is repeatable.
> > Is there anything I can try differently?
> 
> Can you see what the traceback is with gdb?
> 
> I'd suspect the deltifier changes, the rabin hash in particular. The core 
> file traceback would probably point right at the culprit if so.
> 
> I don't see the problem myself, but if it's an access just past the end of 
> an array or something, it would depend on exactly what the delta pattern 
> is (which, without the "-f" flag, in turn depends on what your previous 
> packs looked like) and also on the allocation strategy (which migth 
> explain why it shows on OpenBSD but Linux people hadn't seen it).

When linking with Electric Fence I can reproduce the segfault on Linux 
as well.

Looking into it now.


Nicolas
