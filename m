From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: Is a given file known to git?
Date: Tue, 11 Mar 2008 10:27:16 +0100
Message-ID: <47D65074.4000505@melosgmbh.de>
References: <47D6317D.7030700@melosgmbh.de> <47D636FC.2060203@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Tue Mar 11 10:30:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0nh-0004Fr-5f
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbYCKJ26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbYCKJ26
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:28:58 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:16615 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbYCKJ25 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:28:57 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDNQA471tmH
Received: from mail.melosgmbh.de
	(p5B07A7E6.dip0.t-ipconnect.de [91.7.167.230])
	by post.webmailer.de (mrclete mo26) (RZmta 16.8)
	with ESMTP id t047d6k2B7fN7K ; Tue, 11 Mar 2008 10:28:55 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.035,BAYES_00: -1.665,TOTAL_SCORE: -1.630
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Tue, 11 Mar 2008 10:28:53 +0100
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <47D636FC.2060203@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76818>

Johannes Sixt schrieb:
> Christoph Duelli schrieb:
>> Given a repository and a path p to a file in it:
>> Is it possible (how?) to detect (in a bash script) if the file pointed
>> to by p is "known" to git?
>> Something along the line:
>> if `git knows p?
>> then
>> ...
>> fi
> 
> For simplicity, I'll assume with "known to git" you mean whether the
> current branch's tip has some content at the given path. Then you could write:
> 
> 	if git rev-parse HEAD:"$p" >/dev/null 2>&1
> 	then
> 		# git knows about $p
> 	else
> 		# git does not know about $p
> 	fi
> 
> -- Hannes
Yes, thank you, Johannes and Shawn, this works.
(A bit slow, though: with this test enabled my script takes 77 secs; 
without it it takes 0.3 secs. The time is spent in 9000 calls to the 
above test (the rev-parse version). (ok, the fact that there is a Perl 
system call around it might take some time, too).)

[For the record:
Shawn's ls-files variant takes: 148 secs
Shawn's cat-file variant takes: 251 secs
Time taken by time; roughly half user, half system.
]

As this script won't run often, that not too big a deal.
Still I would have hoped for a quicker way.

Thanks
-- 
Christoph Duelli
