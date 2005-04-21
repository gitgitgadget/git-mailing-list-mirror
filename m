From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-viz tool for visualising commit trees
Date: Fri, 22 Apr 2005 00:06:18 +0200
Message-ID: <20050421220618.GA31657@elte.hu>
References: <20050421130242.GA5817@elte.hu> <20050421.155519.112619323.oandrieu@nerim.net> <20050421143840.GA14059@elte.hu> <20050421.221441.85407120.oandrieu@nerim.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 00:03:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOjlE-0004kB-8j
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 00:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVDUWHZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVDUWHZ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:07:25 -0400
Received: from mx1.elte.hu ([157.181.1.137]:21913 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261337AbVDUWHM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 18:07:12 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id 1C1A131FA58;
	Fri, 22 Apr 2005 00:05:51 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id CC9221FC2; Fri, 22 Apr 2005 00:06:37 +0200 (CEST)
To: Olivier Andrieu <oandrieu@nerim.net>
Content-Disposition: inline
In-Reply-To: <20050421.221441.85407120.oandrieu@nerim.net>
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


* Olivier Andrieu <oandrieu@nerim.net> wrote:

>  > - naming the boxes by key is quite meaningless. It would be more 
>  >   informative to see the author's email shortcuts in the boxes. Also, it 
>  >   would be nice to see some simple graphical feedback about the size and 
>  >   scope of a changeset, without having to zoom on it.
> 
> That's interesting. What do you mean exactly by scope ?

usually there are two interesting things about a patchset: how many 
lines does it change, and how many files. Patches that change lots of 
files (but change only a couple of lines in every file) have a 'large' 
scope.  Patches that change 1-2 files have a 'small' scope. A pure 
'number of lines changed' metric is useful too. Generally patches that 
have either a large linecount or a large scope are more interesting.  

(I'm not sure how this could be displayed - perhaps the size of the 
rectangle could vary to a certain degree? Perhaps the shape too?  
Something non-numeric, so that one gets immediate visual feedback.)

>  > i guess you know it, and i'm definitely not complaining about prototype 
>  > code, but rendering is quite slow: drawing the 340 changesets in the 
>  > current kernel repository takes 15 seconds on a 2 GHz P4. Drawing the 
>  > full kernel history (63,000 changesets) would take more than 45 minutes 
>  > on this box.
>  > 
>  > the current rate of kernel development is ~2000 changesets per month, so 
>  > drawing the kernel history will get 3 seconds slower every day - it will 
>  > exceed 1 minute in 20 days, so this will become a pressing issue quite 
>  > soon i suspect.
> 
> Right, it is slow. From what I could understand with a bit of 
> profiling, the problem is with the "text" canvas item for the boxes' 
> labels. I guess libgnomecanvas isn't using Pango properly or 
> something: it lookups the font with fontconfig each time I create such 
> an item. I'm not sure what I can do about this.

when the redrawing happens in the visible area then one can see how 
really slow it is: 100-200 msec per rectangle (!).

> It works with Petr Baudis' git-pasky (it calls `git diff'). I don't 
> know how to do that with the canonical git.

ah, ok. I guess it will start working once Petr's changes are merged 
into Linus' tree.

	Ingo
