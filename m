From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Fri, 18 Nov 2005 11:18:14 +0100
Message-ID: <437DAA66.6070301@op5.se>
References: <20051117193714.428785C7FA@nox.op5.se> <7voe4ird8v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 11:18:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed3Jy-0001cl-SU
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 11:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030604AbVKRKSQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 05:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKRKSQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 05:18:16 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:14045 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030604AbVKRKSQ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 05:18:16 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DA3B56BD02; Fri, 18 Nov 2005 11:18:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7voe4ird8v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12220>

Junio C Hamano wrote:
> exon@op5.se (Andreas Ericsson) writes:
> 
> 
>>Everything that worked earlier still works insofar as I have
>>remembered testing it.
> 
> 
> Hmph...
> 

:)

I haven't used the daemon without our patches. Everything works as per 
spec now though.

> 
>>@@ -152,45 +140,17 @@ static int set_dir(const char *dir)
>> 	 * We want a readable HEAD, usable "objects" directory, and
>> 	 * a "git-daemon-export-ok" flag that says that the other side
>> 	 * is ok with us doing this.
> 
> 
> Well, not anymore about HEAD as far as I can tell...  Maybe in
> enter_repo ([PATCH 1/5]) we need to do something like what
> setup.c::is_toplevel_directory() does?
> 

Umm... Perhaps. I just noticed that it's possible for the .git/objects 
directory to go missing though.

> 
>>-static int upload(char *dir)
>>-{
>>-	/* Try paths in this order */
>>-	static const char *paths[] = { "%s", "%s/.git", "%s.git", "%s.git/.git", NULL };
> 
> 
> I think this list was added relatively recently as a usability
> measure.  Maybe we would want an equivalent in enter_repo()?


It's already there but in a different format. Adding "if (!strict)" to 
the previously unconditional 'chdir(".git");' won't change that.

Like I said, I made sure everything that worked before works now too.


> Under strict-path, I think not doing any DWIM like this is fine,
> but otherwise I suspect changing this would break existing
> remotes/origin file people may have.  In addition enter_repo()
> as posted does its own DWIM to chdir to ".git" unconditionally
> as I pointed out...
> 


DWIM? That's an acronym I don't know.


> Needs a bit more thought, but I think otherwise the basic idea
> is right.
> 

Anything I should change before "take four" ?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
