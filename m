From: bert hubert <ahu@ds9a.nl>
Subject: Re: Yet another base64 patch
Date: Thu, 14 Apr 2005 23:47:56 +0200
Message-ID: <20050414214756.GA31249@outpost.ds9a.nl>
References: <425DEF64.60108@zytor.com> <20050414022413.GB18655@64m.dyndns.org> <425E0174.4080404@zytor.com> <20050414024228.GC18655@64m.dyndns.org> <425E0D62.9000401@zytor.com> <Pine.LNX.4.58.0504140038450.7211@ppc970.osdl.org> <425EA152.4090506@zytor.com> <Pine.LNX.4.58.0504141042450.7211@ppc970.osdl.org> <20050414191157.GA27696@outpost.ds9a.nl> <425EC3B4.6090908@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Christopher Li <git@chrisli.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 23:48:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMCBb-0003NW-Tm
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 23:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261445AbVDNVvD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 17:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDNVvC
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 17:51:02 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:33685 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261445AbVDNVuz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 17:50:55 -0400
Received: by outpost.ds9a.nl (Postfix, from userid 1000)
	id AD73B40E1; Thu, 14 Apr 2005 23:47:56 +0200 (CEST)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <425EC3B4.6090908@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 14, 2005 at 12:25:40PM -0700, H. Peter Anvin wrote:
> >That may be true :-), but from the "front lines" I can report that
> >directories with > 32000 or > 65000 entries is *asking* for trouble. There
> >is a whole chain of systems that need to get things right for huge
> >directories to work well, and it often is not that way.
> >
> 
> Specifics, please?

We've seen even Linus assume there is a 65K limit, and it appears more
people have been confused.

The systems I've seen mess this up include backup tools (quite serious ones
too), NetApp NFS servers, Samba shares and archivers.

Some tools just fail visibly, which is good, others become so slow as to
effectively lock up, which was the case with the backup tools. 

I've quite often been able to fix broken systems by hashing directories -
many problems just vanish. 

It is too easy to get into a O(N^2) situation. Git may be able to deal with
it but you may hurt yourself when making backups, or if you ever want to
share your tree (possibly with yourself) over the network.

But if you live in an all Linux world, and use mostly tar and rsync, it
should work.

Bert.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
