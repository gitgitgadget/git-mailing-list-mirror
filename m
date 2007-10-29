From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] gcc constant expression warning...
Date: Sun, 28 Oct 2007 20:55:32 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710282053590.22100@xanadu.home>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org>
 <slrnfi8pj7.mb4.antti-juhani@kukkaseppele.kaijanaho.fi>
 <alpine.LFD.0.999.0710281000260.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.fi>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Oct 29 01:55:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImIux-0004gk-Ff
	for gcvg-git-2@gmane.org; Mon, 29 Oct 2007 01:55:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbXJ2Azf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 20:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752142AbXJ2Azf
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 20:55:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:23942 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbXJ2Aze (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 20:55:34 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JQN00GKZEKKFZE1@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 28 Oct 2007 20:55:33 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.0.999.0710281000260.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62592>

On Sun, 28 Oct 2007, Linus Torvalds wrote:

> 
> 
> On Sun, 28 Oct 2007, Antti-Juhani Kaijanaho wrote:
> >
> > A correct fix would be to check for the size of off_t in some other (and
> > defined) manner, but I don't know off_t well enough to suggest one.
> 
> In this case, it's trying to make sense that "off_t" can hold more than 32
> bits. So I think that test can just be rewritten as
> 
> 	if (sizeof(off_t) <= 4) {
> 		munmap(idx_map, idx_size);
> 		return error("pack too large for current definition of off_t in %s", path);
> 	}
> 
> instead.

The test must also make sure off_t isn't signed, since in that case it 
can only hold 31 bits.


Nicolas
