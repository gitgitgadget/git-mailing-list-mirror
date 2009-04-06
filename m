From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 06 Apr 2009 12:14:11 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904061207110.6741@xanadu.home>
References: <20090404220743.GA869@curie-int>
 <alpine.DEB.1.10.0904051419490.6245@asgard.lang.hm>
 <20090405225954.GA18730@vidovic>
 <alpine.DEB.1.10.0904051613420.6245@asgard.lang.hm>
 <alpine.LFD.2.00.0904052326090.6741@xanadu.home>
 <7vab6ue520.fsf@gitster.siamese.dyndns.org>
 <9e4733910904060652t6c0f37d9t246b7394e3aad350@mail.gmail.com>
 <alpine.LFD.2.00.0904060959250.6741@xanadu.home>
 <9e4733910904060737k3d1c082fk785cd98cdeb6d73d@mail.gmail.com>
 <alpine.LFD.2.00.0904061042300.6741@xanadu.home>
 <9e4733910904060828m414dfe7v66b19f7b4c5b670e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_+O1ICX4blPBy+V141Dth2A)"
Cc: Junio C Hamano <gitster@pobox.com>, david@lang.hm,
	Nicolas Sebrecht <nicolas.s-dev@laposte.net>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 06 18:17:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqrVM-00009b-4B
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 18:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757102AbZDFQOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 12:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbZDFQOl
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 12:14:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:30297 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758921AbZDFQOk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 12:14:40 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KHO0065JT3OWEH0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 06 Apr 2009 12:14:12 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <9e4733910904060828m414dfe7v66b19f7b4c5b670e@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115848>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_+O1ICX4blPBy+V141Dth2A)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Mon, 6 Apr 2009, Jon Smirl wrote:

> On Mon, Apr 6, 2009 at 11:14 AM, Nicolas Pitre <nico@cam.org> wrote:
> > This means that, when those objects are about to be stored in the new
> > pack, their raw data is simply copied straight from the original pack
> > using the offset and size noted above.  In other words, those objects
> > are simply never redeltified nor redeflated at all, and all the work
> > that was previously done to find the best delta match is preserved with
> > no extra cost.
> 
> Does this process cause random reads all over a 2GB pack file? Busy
> servers can't keep a 2GB pack in memory.

The creation of a new pack follows the same object recency rule as the 
ones it copies from, so the various reads should be perfectly 
sequential.

> sendfile() the 2GB pack to client is way more efficient. (assuming the
> pack is marked as being ok to send).

Git is not a FTP server.  Otherwise we would have stayed with the rsync 
protocol.


Nicolas

--Boundary_(ID_+O1ICX4blPBy+V141Dth2A)--
