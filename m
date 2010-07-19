From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 11:16:41 -0600
Message-ID: <4C448879.4040202@workspacewhiz.com>
References: <20091230065442.6117@nanako3.lavabit.com>	 <201007181355.36691.jnareb@gmail.com> <1279484847.8999.22.camel@dreddbeard>	 <201007190119.04873.jnareb@gmail.com> <1279523523.3077.8.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Mon Jul 19 19:16:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OatxQ-0004tT-Jl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 19:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760703Ab0GSRQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 13:16:42 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:49033 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756782Ab0GSRQl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 13:16:41 -0400
Received: (qmail 7654 invoked by uid 399); 19 Jul 2010 11:16:40 -0600
Received: from unknown (HELO ?192.168.1.2?) (jjensen@workspacewhiz.com@75.220.63.200)
  by hsmail.qwknetllc.com with ESMTPAM; 19 Jul 2010 11:16:40 -0600
X-Originating-IP: 75.220.63.200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
In-Reply-To: <1279523523.3077.8.camel@dreddbeard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151261>

  ----- Original Message -----
From: Will Palmer
Date: 7/19/2010 1:12 AM
> git branch -d integration
> # git renames refs/heads/integration to refs~/heads~/integration
> git co -b integration sometopic
> # git creates refs/heads/integration, unrelated to the old one
> (do some work)
> (merge into the main branch)
> git branch -d integration
>
> Now what?
> git renames refs/heads/integration to ... what?
> - does the old refs~/heads~/integration get clobbered? If that's ever
> okay, why are we even having this discussion?
> - does the "old reflog" stuff get combined? If that's ever okay, why
> even have an extra reflog, instead of just using the reflog we already
> have?
> - do we move everything else one step down, so refs~/heads~/integration
> becomes refs~2/heads~2/integration? (ie: 2-dimensional reflog, which
> sounds rather too fancy, to me
I was bit by this last week.  I deleted a branch.  A few days later, I 
realized I needed the branch.  It wasn't in the reflog, so I had to look 
through the "lost" objects to find it.

My brain has become muddied with all the ~2 stuff.  Explain again why it 
can't be as simple as this?

git branch -d integration

git reflog

0000001 HEAD@{0}: (fake)checkout: moving from integration to master 
(0000001)
8000000 HEAD@{1}: branch -d: Deleting integration
0000001 HEAD@{2}: (fake)checkout: moving from master to integration 
(8000000)

git checkout -b integration HEAD@{1}  (or 8000000)

-Josh
