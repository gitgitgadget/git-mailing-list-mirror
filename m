From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] git: fix memory leak #2 in read-cache.c
Date: Thu, 14 Apr 2005 17:14:56 +0200
Message-ID: <20050414151456.GA11385@elte.hu>
References: <20050414112638.GA12593@elte.hu> <20050414120834.GA14290@elte.hu> <20050414123258.GA15148@elte.hu> <20050414123934.GA15420@elte.hu> <Pine.LNX.4.58.0504140804480.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 17:14:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM60q-00060w-DZ
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 17:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVDNPPa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 11:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVDNPPa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 11:15:30 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59555 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261520AbVDNPPZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 11:15:25 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 554313197C1;
	Thu, 14 Apr 2005 17:14:11 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D96481FC2; Thu, 14 Apr 2005 17:14:59 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504140804480.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> In other words, if the common case is that we update a couple of 
> entries in the active cache, we actually saved 1.6MB (+ malloc 
> overhead for the 17 _thousand_ allocations) by my approach.
> 
> And the leak? There's none. We never actually update an existing entry 
> that was allocated with malloc(), unless the user does something 
> stupid.  In other words, the only case where there is a "leak" is when 
> the user does something like
> 
> 	update-cache file file file file file file .. 
> 
> with the same file listed several times.

fair enough - as long as this is only used in a scripted environment, 
and not via some library and not within a repository server, web 
backend, etc.

	Ingo
