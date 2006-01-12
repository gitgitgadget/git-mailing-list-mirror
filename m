From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] (Updated) Exec git programs without using PATH.
Date: Thu, 12 Jan 2006 01:11:50 +0100
Message-ID: <43C59EC6.6070905@op5.se>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>	<1136849810.11717.518.camel@brick.watson.ibm.com>	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>	<1136900174.11717.537.camel@brick.watson.ibm.com>	<43C3CC4A.4030805@op5.se>	<1136910406.11717.579.camel@brick.watson.ibm.com>	<43C4075E.4070407@op5.se> <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>	<1136924980.11717.603.camel@brick.watson.ibm.com>	<7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>	<1136945538.11717.643.camel@brick.watson.ibm.com>	<7v4q4bwavi.fsf@assigned-by-dhcp.cox.net>	<1136999157.11717.658.camel@brick.watson.ibm.com>	<7vek3esdw0.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0601111238550.5073@g5.osdl.org>	<1137014812.11717.669.camel@brick.watson.ibm.com> <7vk6d6qwmn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 12 01:12:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ewq4J-0003zE-6f
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 01:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWALALw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 19:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWALALw
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 19:11:52 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:28066 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932649AbWALALv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 19:11:51 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 5FEDC6BD03
	for <git@vger.kernel.org>; Thu, 12 Jan 2006 01:11:50 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vk6d6qwmn.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14536>

Junio C Hamano wrote:
> Michal Ostrowski <mostrows@watson.ibm.com> writes:
> 
> 
>>I briefly tried to consider if I could hide the various fork()+exec()
>>sequences behind something like the run_command*() interfaces (which
>>would move us down the direction of something "spawn()"-like).  I found
>>that there's a lot of variation between the various paths in terms of
>>what happens between fork() and exec() on the various paths that does
>>not lend itself to such consolidation.
>>
>>I'd love to be convinced otherwise.
> 
> 
> Unfortunately I am with Michal on this one (both "eh, I do not
> think that is feasible" and "I'd love to be...").
> 
> The run_command*() interfaces and its users were the best I
> could come up with as far as such consolidations could go when I
> did it.
> 

Not being entirely knowledgeable on what spawn() actually does and how 
its semantics differ from fork() and exec*() style API's (Google was 
depressingly unhelpful and wikipedia dredged up froglings...), I've got 
a decent "clone-lots-of-processes-and-multiplex-between-them" kind of 
library lying around. Would it be of any use?

 From the prototypes I've seen on spawn it doesn't seem to be much more 
than a fork() + execve(), either closing or dup2'ing all the 
file-descriptors, so I don't understand why that couldn't be implemented 
for git. Some pointers, anyone?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
