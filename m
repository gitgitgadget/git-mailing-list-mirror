From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: make the size member first in the context
 struct
Date: Mon, 17 Aug 2009 20:39:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908172035320.6044@xanadu.home>
References: <alpine.LFD.2.00.0908172012591.6044@xanadu.home>
 <alpine.DEB.1.00.0908180223280.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCjm-000661-Kd
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:39:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756102AbZHRAjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 20:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755987AbZHRAjf
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:39:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:33600 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbZHRAje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 20:39:34 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOJ003PYR5UA680@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 17 Aug 2009 20:39:30 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.DEB.1.00.0908180223280.8306@pacific.mpi-cbg.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126330>

On Tue, 18 Aug 2009, Johannes Schindelin wrote:

> Hi,
> 
> On Mon, 17 Aug 2009, Nicolas Pitre wrote:
> 
> > This is a 64-bit value, hence having it first provides a better 
> > alignment.
> > 
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> > 
> > diff --git a/block-sha1/sha1.h b/block-sha1/sha1.h
> > index 6ff59b2..b864df6 100644
> > --- a/block-sha1/sha1.h
> > +++ b/block-sha1/sha1.h
> > @@ -7,9 +7,9 @@
> >   */
> >  
> >  typedef struct {
> > +	unsigned long long size;
> >  	unsigned int H[5];
> >  	unsigned int W[16];
> > -	unsigned long long size;
> >  } blk_SHA_CTX;
> 
> By the reasoning suggested in the commit message, should H[5] not go to 
> the end?

Both arrays are based of unsigned ints which have the same alignment 
rules.  Furthermore the size and H members are much more used than the W 
member, and keeping them close should help with CPU cache locality.


Nicolas
