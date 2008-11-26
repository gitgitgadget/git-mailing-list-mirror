From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 26 Nov 2008 09:33:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811260931030.14328@xanadu.home>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
 <4923FE58.3090503@viscovery.net>
 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
 <49241AEF.1080808@viscovery.net>
 <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
 <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 15:35:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5LUC-0005uJ-OY
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 15:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751958AbYKZOd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 09:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYKZOd7
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 09:33:59 -0500
Received: from relais.videotron.ca ([24.201.245.36]:54568 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYKZOd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 09:33:58 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAY00335338LV80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 26 Nov 2008 09:33:08 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <81b0412b0811260518o52adb107tbddafb324e7fd97b@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101738>

On Wed, 26 Nov 2008, Alex Riesen wrote:

> 2008/11/19 Nicolas Pitre <nico@cam.org>:
> > On Wed, 19 Nov 2008, Johannes Sixt wrote:
> >> Alex Riesen schrieb:
> >> > 2008/11/19 Nicolas Pitre <nico@cam.org>:
> >> >> On Wed, 19 Nov 2008, Johannes Sixt wrote:
> >> >>> The work-around is to write the repacked objects to a file of a different
> >> >>> name, and replace the original after git-pack-objects has terminated.
> >> >>>
> >> >>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> >> >> Acked-by: Nicolas Pitre <nico@cam.org>
> >> >
> >> > Are you sure? Will it work in a real repository? Were noone does
> >> > rename the previous pack files into packtmp-something?
> >>
> >> Oh, the patch only works around the failure in the test case. In a real
> >> repository there is usually no problem because the destination pack file
> >> does not exist.
> >>
> >> The unusual case is where you do this:
> >>
> >>  $ git rev-list -10 HEAD | git pack-objects foobar
> >>
> >> twice in a row: In this case the second invocation fails on Windows
> >> because the destination pack file already exists *and* is open. But not
> >> even git-repack does this even if it is called twice. OTOH, the test case
> >> *does* exactly this.
> >
> > OK.... Well, despite my earlier assertion, I think the above should be a
> > valid operation.
> >
> > I'm looking at it now.  I'm therefore revoking my earlier ACK as well
> > (better keep that test case alive).
> >
> 
> Any news here?

Yes: my hard disk crashed a couple hours after I mentioned this, so most 
of my time has been spent on recovery since then.  I'll come back to it 
eventually.


Nicolas
