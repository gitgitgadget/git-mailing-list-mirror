From: Nicolas Pitre <nico@cam.org>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Tue, 24 Apr 2007 12:19:25 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704241208460.12375@xanadu.home>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
 <9e4733910704210837y3ac3654ekb60654ef6fc397fc@mail.gmail.com>
 <e5bfff550704211006t59cb49h179685d694a1d75a@mail.gmail.com>
 <9e4733910704211059h16c06e11k967d0bdd3e4970fc@mail.gmail.com>
 <e5bfff550704211128i12035947i7597e920a0eca163@mail.gmail.com>
 <462E18C8.4070001@op5.se> <alpine.LFD.0.98.0704241058490.12375@xanadu.home>
 <462E1FBA.9020109@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Marco Costalba <mcostalba@gmail.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Apr 24 18:19:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgNjl-00066I-JC
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 18:19:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161816AbXDXQT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 12:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbXDXQT1
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 12:19:27 -0400
Received: from relais.videotron.ca ([24.201.245.36]:63968 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbXDXQT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 12:19:26 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JH000MZ6G0DE911@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 24 Apr 2007 12:19:25 -0400 (EDT)
In-reply-to: <462E1FBA.9020109@op5.se>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45467>

On Tue, 24 Apr 2007, Andreas Ericsson wrote:

> Nicolas Pitre wrote:
> > On Tue, 24 Apr 2007, Andreas Ericsson wrote:
> > 
> >> Using a more efficient compression algorithm for the objects 
> >> themselves (bzip2, anyone?) will most likely reduce storage size an 
> >> order of magnitude more than reducing the size of the hash, although 
> >> at the expense of CPU-efficiency.
> > 
> > An order of magnitude I really doubt it.  Maybe 20% could be a really 
> > optimistic prediction.  But if bzip2 could reduce the repo by 20%, it 
> > will slow runtime usage of that repo by maybe 100%.  That is not worth 
> > it.
> > 
> > This is also the reason why we changed the default zlib compression 
> > level from "best" to "default".
> > 
> 
> ... order of magnitude *more than reducing the size of the hash*.

Ah, sorry.  Still I wanted to advise against it nevertheless.

Anyway, if you compare packing with repack.usedeltabaseoffset set to 
true, then to false, you'll have a pretty good approximation of the SHA1 
storage cost.  With most objects as deltas, in the first case the 
reference to the base object is stored as an offset in the pack while in 
the second case the full SHA1 is used.  You can deduce from the size 
difference that the SHA1 doesn't constitute a terrible storage cost 
indeed.


Nicolas
