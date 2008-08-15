From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 21:46:40 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808142139410.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <48A3D1D7.5030805@op5.se>
 <200808141204.07530.trast@student.ethz.ch> <48A405A6.7000405@op5.se>
 <20080814223327.GV3782@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Thomas Rast <trast@student.ethz.ch>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 03:47:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KToPv-0001dK-8i
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 03:47:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412AbYHOBqs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 21:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752440AbYHOBqs
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 21:46:48 -0400
Received: from relais.videotron.ca ([24.201.245.36]:43691 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbYHOBqr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 21:46:47 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5M003O3CX1MV10@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Aug 2008 21:46:13 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20080814223327.GV3782@spearce.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92455>

On Thu, 14 Aug 2008, Shawn O. Pearce wrote:

> Andreas Ericsson <ae@op5.se> wrote:
> > How does one go about getting the object sizes? rev-list appears
> > to have no option for it.
> 
> With great pain.  You can use the output of verify-pack -v to
> tell you the size of the inflated portion of the object, but for
> a delta this is the inflated size of the delta, not of the fully
> unpacked object.

Delta objects have the size of the final object in their header.  There 
is get_size_from_delta() extracting that information already.  There is 
simply no interface exporting that info to external tools but that 
shouldn't be hard to add.


Nicolas
