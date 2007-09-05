From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 23:07:41 +0200
Message-ID: <20070905210741.GA3770@steel.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:07:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT26H-0000gd-Bh
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbXIEVHo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756024AbXIEVHo
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:07:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:49188 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbXIEVHn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 17:07:43 -0400
Received: from tigra.home (Facc5.f.strato-dslnet.de [195.4.172.197])
	by post.webmailer.de (klopstock mo19) (RZmta 12.6)
	with ESMTP id C07133j85JBHvH ; Wed, 5 Sep 2007 23:07:41 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 828FC277BD;
	Wed,  5 Sep 2007 23:07:41 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 22794BEAC; Wed,  5 Sep 2007 23:07:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz4AZk=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57763>

Linus Torvalds, Wed, Sep 05, 2007 09:09:27 +0200:
> I personally repack everything way more often than is necessary, and I had 
> kind of assumed that people did it that way, but I was apparently wrong. 
> Comments?

I do it from time to time. Seldom in working repositories, because
they usually come and go before they have a chance to accumulate
enough of loose objects. I do a partial repack (git repack -d) after
every import from p4 repo, because every snapshot of it is an ugly
mess changing files all over the tree. Sometimes, after I merged a big
chunk with the p4 repo and sent it over (the process involves rebase).

It is usually concious decision when to do a repack or gc. The repack
time is seldom a problem: it is fast enough even on windows (and I do
have big repos and binary objects). The gc causes my machines to swap,
though. Some of them heavily, so there my repos stay longer partially
packed. I do use .keep packs for this reason (and because windows or
cygwin or both have more problems with big files the they have with
small).

I used to clone repos with "-s", but quickly stopped after a few
broken histories.  This also tought me to think before running
"git gc" or "git repack -a -d".

On a rare occurance I even use "git repack -a -d -l" and "git
pack-refs" separately.

This was all specific to my day-job. At home, on linux systems I just
run git-gc whenever I please, without even thinking why. It finishes
mostly in less than a minute (the kernel: ~40-50 sec on my P4 2.6GHz, 1Gb).
