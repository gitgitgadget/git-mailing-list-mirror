From: Andi Kleen <andi@firstfloor.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 23:30:33 +0200
Message-ID: <20080814213033.GE13814@one.firstfloor.org>
References: <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 23:30:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTkOb-0001y5-QV
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbYHNV3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 17:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYHNV3L
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:29:11 -0400
Received: from one.firstfloor.org ([213.235.205.2]:47323 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbYHNV3K (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:29:10 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
	id CB1B218900BB; Thu, 14 Aug 2008 23:30:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92405>

> Here's a hint: the cost of a cache miss is generally about a hundred times 

100 times seems quite optimistic %)

> 
> No, zlib isn't perfect, and nope, inflate_fast() is no "memcpy()". And 
> yes, I'm sure a pure memcpy would be much faster. But I seriously suspect 
> that a lot of the cost is literally in bringing in the source data to the 
> CPU. Because we just mmap() the whole pack-file, the first access to the 
> data is going to see the cost of the cache misses.

I would have thought that zlib has a sequential access pattern that the
CPU prefetchers have a easy time with hiding latency.

BTW I always wonder why people reason about cache misses in oprofile
logs without actually using the cache miss counters.

-Andi
