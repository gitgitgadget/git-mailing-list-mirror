From: Nicolas Pitre <nico@cam.org>
Subject: Re: Something is broken in repack
Date: Sun, 09 Dec 2007 21:49:32 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0712092144220.555@xanadu.home>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
 <alpine.LFD.0.99999.0712072032410.555@xanadu.home>
 <7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 10 03:50:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Yj0-0002zi-Lr
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 03:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbXLJCtf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 21:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756093AbXLJCtf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 21:49:35 -0500
Received: from relais.videotron.ca ([24.201.245.36]:13605 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756705AbXLJCte (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 21:49:34 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JST00APJBULVK20@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 09 Dec 2007 21:49:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vodd0vnhv.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67670>

On Sat, 8 Dec 2007, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Fri, 7 Dec 2007, Jon Smirl wrote:
> >
> >> Starting with a 2GB pack of the same data my process size only grew to
> >> 3GB with 2GB of mmaps.
> >
> > Which is quite reasonable, even if the same issue might still be there.
> >
> > So the problem seems to be related to the pack access code and not the 
> > repack code.  And it must have something to do with the number of deltas 
> > being replayed.  And because the repack is attempting delta compression 
> > roughly from newest to oldest, and because old objects are typically in 
> > a deeper delta chain, then this might explain the logarithmic slowdown.
> >
> > So something must be wrong with the delta cache in sha1_file.c somehow.
> 
> I was reaching the same conclusion but haven't managed to spot anything
> blatantly wrong in that area.  Will need to dig more.

I didn't find anything wrong there either. I'll have to run some more 
gcc repacking tests myself, despite not having a blazingly fast machine 
making for rather long turnarounds.


Nicolas
