From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 00:04:35 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0811140001070.5938@reaper.quantumfyre.co.uk>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org>
 <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 01:06:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0mCo-0003ne-P7
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 01:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYKNAFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 19:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbYKNAFT
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 19:05:19 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:33819 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753319AbYKNAFS (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Nov 2008 19:05:18 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 36EE41A9F61
	for <git@vger.kernel.org>; Fri, 14 Nov 2008 00:05:16 +0000 (GMT)
Received: (qmail 26317 invoked by uid 103); 14 Nov 2008 00:04:35 +0000
Received: from 212.159.54.234 by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-1.25st 
 (clamdscan: 0.94/8623. spamassassin: 3.2.1. perlscan: 1.25st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.02882 secs); 14 Nov 2008 00:04:35 -0000
Received: from darkphoton.datavampyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 14 Nov 2008 00:04:35 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100934>

On Thu, 13 Nov 2008, Linus Torvalds wrote:

> The good news is that I seem to actualluy see a bit of a win from this
> even on a disk, now that the kernel doesn't serialize things. So it may
> be worth it. So I have some hope that it actually helps on NFS too.
> The numbers for five runs (with clearing of the caches in between, of
> course) are:
>
> Before:
>
> 	0.01user 0.23system 0:10.87elapsed 2%CPU
> 	0.04user 0.19system 0:10.86elapsed 2%CPU
> 	0.03user 0.26system 0:10.82elapsed 2%CPU
> 	0.02user 0.27system 0:12.67elapsed 2%CPU
> 	0.01user 0.22system 0:10.86elapsed 2%CPU
>
> After:
>
> 	0.03user 0.26system 0:07.88elapsed 3%CPU
> 	0.02user 0.25system 0:07.63elapsed 3%CPU
> 	0.01user 0.26system 0:08.62elapsed 3%CPU
> 	0.01user 0.26system 0:07.27elapsed 3%CPU
> 	0.05user 0.28system 0:08.61elapsed 3%CPU
>
> so it really does seem like it has possibly given a 30% improvement in
> cold-cache performance even on a disk.

On an NFS kernel checkout I get the following elapsed times:

master:

0:02.78
0:02.70
0:02.43
0:02.28
0:02.71
0:02.80
0:02.60
0:02.06
0:02.00

master + new patch:

0:00.77
0:00.83
0:01.02
0:00.77
0:00.91
0:00.78
0:00.78
0:01.09
0:01.00

-- 
Julian

  ---
There are no accidents whatsoever in the universe.
 		-- Baba Ram Dass
