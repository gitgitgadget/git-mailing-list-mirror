From: Nicolas Pitre <nico@cam.org>
Subject: Re: How to replace a single corrupt, packed object?
Date: Sun, 10 Aug 2008 23:40:30 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808102325280.22892@xanadu.home>
References: <alpine.DEB.1.00.0808081639490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <0BF03F86-8E4E-46D2-9B04-4385CEBD6902@ai.rug.nl>
 <20080808161937.GC9152@spearce.org>
 <90E12BC7-1950-41DF-8BE5-C6B63CE060D9@ai.rug.nl>
 <alpine.DEB.1.00.0808081841290.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <alpine.LFD.1.10.0808102146050.22892@xanadu.home>
 <20080811030744.GD27195@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 05:41:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSOHy-000807-G3
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 05:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753856AbYHKDkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 23:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbYHKDkh
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 23:40:37 -0400
Received: from relais.videotron.ca ([24.201.245.36]:34441 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753835AbYHKDkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 23:40:36 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5F001AP3JITIC0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 10 Aug 2008 23:40:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080811030744.GD27195@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91915>

On Sun, 10 Aug 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > OK, here's what the patch to allow repacking without -f and still using 
> > redundant objects in presence of pack corruption might look like.  
> > Please tell me if that works for you.
> 
> Aside from goto being considered harmful by some really smart people,

Well, other really smart people consider gotos perfectly fine when used 
judiciously.  So this ends up being a question of belief and taste.

> this patch makes a lot of sense.  Its only downside is a backwards
> goto within this function, but the code is actually still quite
> clear to me.

The actual downside I see with this patch is the fact that real data 
corruptions might be "fixed" automagically with user unaware of it.  
This could be a serious sign that the hardware is going bad and 
requiring the user to consciously use -f to fix things is good.  However 
it is most unlikely that redundant objects will be kept around in the 
normal case, hence manual intervention will be needed anyway to bring a 
copy of bad object into the repository.  So not having to use -f might 
not be such an issue.

> If this allows git to magically fix Dscho's bad pack, it may be
> worth including in the core tree.

Yep.


Nicolas
