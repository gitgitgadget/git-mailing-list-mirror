From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Git benchmarks at OpenOffice.org wiki
Date: Thu, 3 May 2007 12:16:05 +0200
Organization: Dewire
Message-ID: <200705031216.19817.robin.rosenberg.lists@dewire.com>
References: <200705012346.14997.jnareb@gmail.com> <87lkg61j99.fsf@mid.deneb.enyo.de> <Pine.LNX.4.64.0705031131410.4015@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 03 12:17:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjYN0-0001Hc-VW
	for gcvg-git@gmane.org; Thu, 03 May 2007 12:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031151AbXECKQ7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 06:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031138AbXECKQ6
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 06:16:58 -0400
Received: from [83.140.172.130] ([83.140.172.130]:24944 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1031141AbXECKQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 06:16:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 5994D80265D;
	Thu,  3 May 2007 12:10:54 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02329-05; Thu,  3 May 2007 12:10:53 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id D5FDE800783;
	Thu,  3 May 2007 12:10:53 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705031131410.4015@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46078>

torsdag 03 maj 2007 skrev Johannes Schindelin:
> Hi,
> 
> On Thu, 3 May 2007, Florian Weimer wrote:
> 
> > * Jakub Narebski:
> > 
> > > What I'm really concerned about is branch switch and merging branches, 
> > > when one of the branches is an old one (e.g. unxsplash branch), which 
> > > takes 3min (!) according to the benchmark. 13-25sec for commit is also 
> > > bit long, but BRANCH SWITCHING which takes 3 MINUTES!?
> > 
> > IIRC, GIT accesses every file in the tree, not just the ones that need
> > updating.  How many files were actually updated when you changed
> > branches in your experiment?
> 
> No. Git does not access every file, but rather all stats. That is a huge 
> difference. And it should not take _that_ long for ~64000 files. Granted, 
> it will cause a substantial delay, but not in the range of minutes.

It's worse... On my laptop the switch took ~ten minutes, not three. 
A diff --stat takes over six minutes!! For reference, dd:in the pack 
file with my disk takes ~50 seconds.

The reason is simple. I have a lousy one gigabyte RAM only, while 
git wants 1.7GB virtual to do the diff-stat.  and 800 MB resident. The swap is having a party,

$ vmstat 1
procs -----------memory---------- ---swap-- -----io---- -system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 1  2 1861632  14108    428 126816   70  347   605   647  594 1041 11  2 74 13
 0  2 1861204  12096    420 125724 3096    8  3096    24  625 1171  5  1  0 94
 0  2 1860896  18972    404 115836 3524  292  3524   292  671 1474  7  4  0 89
 0  2 1860820  18668    364 113736 3556  784  3556   784  669 1384  7  5  0 88
 0  3 1860420  19692    300 109904 3008  180  3156   180  684 1325  8  5  0 87
 0  3 1860184  18560    300 108596 3316  232  3396   232  643 1246  8  4  0 88
 0  2 1859856  21808    292 103744 2108   32  2356    32  637 1319  9  1  0 90

-- robin
