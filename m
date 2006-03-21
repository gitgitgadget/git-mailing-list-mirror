From: Andreas Ericsson <ae@op5.se>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 09:19:33 +0100
Message-ID: <441FB715.1000500@op5.se>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>	<200603201730.19373.Josef.Weidendorfer@gmx.de>	<7voe00iupp.fsf@assigned-by-dhcp.cox.net>	<20060320232101.GQ18185@pasky.or.cz> <7vfylcismx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 09:20:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLc5m-0000lj-8K
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 09:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWCUITf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 03:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWCUITf
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 03:19:35 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:43687 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751444AbWCUITf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 03:19:35 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id BD8476BD00; Tue, 21 Mar 2006 09:19:33 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfylcismx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17776>

Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> 
>>I still don't get what's wrong on what I'm proposing. I'm not seeing the
>>disadvantages, if there are any.
> 
> 
> The only thing I think there is is that I do not get what you
> are proposing ;-), since I am not paying full attention while at
> day-job.
> 
> If you are proposing to root --use-separate-remote not at
> refs/remotes but refs/remotes/origin/, I think it makes kind of
> sense.  It would make tons of sense _if_ dealing more than one
> remote repository is the norm, but otherwise you would have an
> extra level of directory refs/remotes which almost always have
> only one subdirectory 'origin' and nothing else, which is
> pointless.
> 

afaiu, this is exactly what Pasky's proposing, and I agree. We could 
then teach 'git diff origin master' to mean 'origin/master' *if* no 
other tag/branch is found in the lookup order. I think it makes sense to 
do searching like this, for a ref named foo

(current order, with .git/, .git/refs/, etc...)
.git/refs/remotes/foo
.git/refs/remotes/foo/master

That way the only extra dwimery would be to add "remotes" after "heads" 
under .git/refs and accept directory in .git/remotes/ as ref and tack on 
'/master' at the end of it as the last option to search. For a specific 
branch on an imported remote, one would have to say "jc/next". This 
means we still only handle 'master' specially so we don't introduce any 
new protected or special names.


> I am not sure if you are also advocating to map (somehow) origin
> to remotes/origin/master (or whatever branch remote's HEAD
> points at), but if so I am not quite sure what its semantics
> would be.  Which remote branch would you pick (that would not
> necessarily be "master") and where are you going to record that
> and when.  It all sounds to me complicating things
> unnecessarily.
> 

Not too much so, I think. I'll look into it tonight, although I'm not 
very familiar with the core stuff so possibly (/ hopefully) someone else 
will beat me to it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
