From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sun, 19 Jun 2005 19:36:34 +0200
Message-ID: <20050619173634.GA25768@elte.hu>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org> <2cfc403205061817181e4d6d5e@mail.gmail.com> <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org> <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org> <2cfc403205061903155a6090db@mail.gmail.com> <2cfc40320506190741409f3a5@mail.gmail.com> <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jon@blackcubes.dyndns.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 19:48:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dk3tw-0002Qy-ES
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 19:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbVFSRxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 13:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVFSRxw
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 13:53:52 -0400
Received: from mx2.elte.hu ([157.181.151.9]:61078 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262267AbVFSRxu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 13:53:50 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 41042321353;
	Sun, 19 Jun 2005 19:34:07 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id D6D711FC2; Sun, 19 Jun 2005 19:37:13 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506190951330.2268@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> NOTE NOTE NOTE! The above is all based on random distribution of bugs, 
> where all commits count equally, which is obviously not even true. You 
> coudl try to do a "weighted bisection", where you weigh commits 
> differently: you might say, for example, that if the author field 
> matches the string "torvalds", then the likelihood of a bug is 
> obviously miniscule, so such a commit only counts as 0.1.

another assumption is that the number of testsystems is a power of two 
minus 1. With 2 or more testsystems (and automated testing) you could 
dissect the search space into 3, 5 or more roughly equal pieces in the 
first step (2, 4, 8 ... sections are already supported via the bisect 
flag). To decrease the time needed to find a bug it makes sense to 
increase the number of testsystems, especially if it takes minutes to 
boot - or if it takes minutes (or hours) to reproduce a bug. If each box 
runs a separate kernel then statistically, if one of them triggers the 
bug, only half of them have to be rebooted with new kernels, the others 
would still be kept running in a "commit space of interest".

But i guess it's not a big degradation to just round the test method to 
the nearest power-of-2 bisection method.

	Ingo
