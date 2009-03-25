From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] avoid possible overflow in delta size filtering computation
Date: Wed, 25 Mar 2009 15:17:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903251514360.26337@xanadu.home>
References: <alpine.LFD.2.00.0903241535010.26337@xanadu.home>
 <86hc1hdcj1.fsf@broadpark.no>
 <alpine.LFD.2.00.0903250936100.26337@xanadu.home> <86bprptvcx.fsf@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:19:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYd4-00021F-Oa
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbZCYTRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 15:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbZCYTRj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:17:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35454 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbZCYTRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 15:17:39 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KH200IFMTL7VBC0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 25 Mar 2009 15:17:32 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <86bprptvcx.fsf@broadpark.no>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114650>

On Wed, 25 Mar 2009, Kjetil Barvik wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > On Wed, 25 Mar 2009, Kjetil Barvik wrote:
> >
> >>   So, it seems that this patch almost fixed the issue.  But notice that
> >>   the pack file was 10 bytes larger for the --depth=95000 case.
> >> 
> >>   I made a small perl script to compare the output from 'git verify-pack
> >>   -v' of the 2 idx/pack files, and found the following difference(1)
> >>   (first line from --depth=20000 case, second from --depth=95000):
> >> 
> >>   fe0a6f3e971373590714dbafd087b235ea60ac00  tree   9  19  18921247  731  96a3ec5789504e6d0f90c99fb1937af1ebd58e2d
> >>   fe0a6f3e971373590714dbafd087b235ea60ac00  tree  20  29  18921247  730  12e560f7fb28558b15e3a2008fba860f9a4b2222
> >
> > OK.  Apparently, a different base object for that one delta was chosen 
> > between those two runs.
> >
> > Is your machine SMP?
> 
>   kjetil ~$ uname -a
>   Linux localhost 2.6.28.4 #26 SMP PREEMPT Tue Feb 10 17:07:14 CET 2009
>   i686 Intel(R) Core(TM)2 CPU T7200 @ 2.00GHz GenuineIntel GNU/Linux

Here you go.  If you want a perfectly deterministic repacking, you'll 
have to force the pack.threads config option to 1.


Nicolas
