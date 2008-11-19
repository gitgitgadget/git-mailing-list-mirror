From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Fix handle leak in builtin-pack-objects
Date: Wed, 19 Nov 2008 09:42:43 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0811190940480.27509@xanadu.home>
References: <81b0412b0811190313p643c0cb4vad620ea942aeea93@mail.gmail.com>
 <4923FE58.3090503@viscovery.net>
 <alpine.LFD.2.00.0811190753420.27509@xanadu.home>
 <81b0412b0811190534r4f71f981s53de415f79e56e25@mail.gmail.com>
 <49241AEF.1080808@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 19 15:44:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2oHl-0001mD-Dd
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 15:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386AbYKSOmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2008 09:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753380AbYKSOmu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Nov 2008 09:42:50 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27907 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbYKSOmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2008 09:42:50 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KAL00LGS4V7NQ00@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 19 Nov 2008 09:42:44 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <49241AEF.1080808@viscovery.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101349>

On Wed, 19 Nov 2008, Johannes Sixt wrote:

> Alex Riesen schrieb:
> > 2008/11/19 Nicolas Pitre <nico@cam.org>:
> >> On Wed, 19 Nov 2008, Johannes Sixt wrote:
> >>> The work-around is to write the repacked objects to a file of a different
> >>> name, and replace the original after git-pack-objects has terminated.
> >>>
> >>> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> >> Acked-by: Nicolas Pitre <nico@cam.org>
> > 
> > Are you sure? Will it work in a real repository? Were noone does
> > rename the previous pack files into packtmp-something?
> 
> Oh, the patch only works around the failure in the test case. In a real
> repository there is usually no problem because the destination pack file
> does not exist.
> 
> The unusual case is where you do this:
> 
>  $ git rev-list -10 HEAD | git pack-objects foobar
> 
> twice in a row: In this case the second invocation fails on Windows
> because the destination pack file already exists *and* is open. But not
> even git-repack does this even if it is called twice. OTOH, the test case
> *does* exactly this.

OK.... Well, despite my earlier assertion, I think the above should be a 
valid operation.

I'm looking at it now.  I'm therefore revoking my earlier ACK as well 
(better keep that test case alive).


Nicolas
