From: bdowning@lavos.net (Brian Downing)
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 9 Jul 2007 02:36:12 -0500
Message-ID: <20070709073612.GK4087@lavos.net>
References: <20070709044326.GH4087@lavos.net> <7v1wfixhvk.fsf@assigned-by-dhcp.cox.net> <20070709065235.GJ4087@lavos.net> <7vbqemvxyb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 09:36:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7nnH-0000Py-3d
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 09:36:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290AbXGIHgW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 03:36:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbXGIHgW
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 03:36:22 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:36532 "EHLO
	asav09.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbXGIHgV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 03:36:21 -0400
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav09.insightbb.com with ESMTP; 09 Jul 2007 03:36:21 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnA9AEyBkUZKhvbzR2dsb2JhbACBTIVdiAQBAT8B
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 5A0BF309F31; Mon,  9 Jul 2007 02:36:12 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vbqemvxyb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51967>

On Mon, Jul 09, 2007 at 12:27:24AM -0700, Junio C Hamano wrote:
> >> It would become worrysome (*BUT* infinitely more interesting)
> >> once you start talking about a tradeoff between slightly larger
> >> delta and much shorter delta.  Such a tradeoff, if done right,
> >> would make a lot of sense, but I do not offhand think of a way
> >> to strike a proper balance between them efficiently.
> >
> > Yeah, I was thinking about that too, and came to the same conclusion.
> > I suspect you'd have to save a /lot/ of delta depth to want to pay any
> > more I/O, though.
> 
> That may not be so.  Deeper delta also means more I/O (and
> worse, because they can be from discontiguous areas) plus delta
> application.

Good point.

I guess if I were to think about a metric for deciding whether to go for
a small deep delta or a larger shallow one, I would probably keep track
of the total path size (the sum of the base size and all the delta sizes)
for each entry, and play with a weighting formula of single delta size
verses total path size.

-bcd
