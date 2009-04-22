From: Nicolas Pitre <nico@cam.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 16:00:06 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904221548310.6741@xanadu.home>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com>
 <20090422152719.GA12881@coredump.intra.peff.net>
 <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil>
 <alpine.LFD.2.00.0904221331450.6741@xanadu.home>
 <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:02:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lwieg-0004Fw-Rp
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756518AbZDVUAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbZDVUAY
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:00:24 -0400
Received: from relais.videotron.ca ([24.201.245.36]:57730 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756394AbZDVUAV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:00:21 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KII00BZ2Q86JLB1@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Apr 2009 16:00:07 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117247>

On Wed, 22 Apr 2009, Brandon Casey wrote:

> Nicolas Pitre wrote:
> > On Wed, 22 Apr 2009, Brandon Casey wrote:
> 
> >> I've often wondered whether a plain 'git gc' should adopt the behavior
> >> of --auto with respect to the number of packs.  If there were few packs,
> >> then 'git gc' would do an incremental repack, rather than a 'repack -A -d -l'.
> > 
> > Why so?  Having fewer packs is always a good thing.  Having only one 
> > pack is of course the optimal situation.  The --auto version doesn't do 
> > it in the hope of being lightter and less noticeable by the user.
> 
> The only reason for avoiding packing all packs into one would be speed in
> this case also.  I recall reading complaints or surprise about gc
> repacking all packs into one, so I'm only trying to think about how to
> match program behavior with user expectations.

It's user's expectations that need adjusting then.  Making a single pack 
is indeed the job of an explicit gc invocation.

> gc does a lot already, and even Jeff wasn't sure what to expect from 
> 'git gc' with respect to packs.  Possibly an acceptable trade off 
> between speed and optimal packing would be to adopt the --auto 
> behavior for deciding when to use '-A' with repack.

And what would be the point of manually running 'git gc' then, given 
that 'git gc --auto' is already invoked automatically after most commit 
creating commands?

I mean, if you consider explicit 'git gc' too long, then simply wait 
until you can spare the time, if at all.  This is not like a non gc'd 
repository suddently becomes non functional.

WRT trade offs, the current behavior is already a pretty good compromize 
between speed and optimal packing, the later implying -f to 'git 
repack' which is far far slower.


Nicolas
