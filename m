From: Andreas Ericsson <ae@op5.se>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 21:01:02 +0100
Message-ID: <473A027E.5000107@op5.se>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org> <87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com> <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Sergei Organov <osv@javad.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Nov 13 21:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is1xg-0008Ne-F7
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 21:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761618AbXKMUBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 15:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761583AbXKMUBI
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 15:01:08 -0500
Received: from mail.op5.se ([193.201.96.20]:48762 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761547AbXKMUBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 15:01:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 122331F08764;
	Tue, 13 Nov 2007 21:01:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id amMTIdNiurjC; Tue, 13 Nov 2007 21:01:04 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 9DF361F08760;
	Tue, 13 Nov 2007 21:01:03 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <A919E788-C5D0-4404-95D4-869BAFE868AC@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64846>

Steffen Prohaska wrote:
> 
> On Nov 13, 2007, at 5:03 PM, Jakub Narebski wrote:
> 
>> Sergei Organov <osv@javad.com> wrote:
>>> Jakub Narebski <jnareb@gmail.com> writes:
>>>> Sergei Organov wrote:
>>
>>>>> I want to get rid of origin/pu remote tracking branch. What do I do?
>>>>> I RTFM git-branch. What does it suggest?
>>>>>
>>>>> git branch -d -r origin/pu
>>>>>
>>>>> So far so good. However, it doesn't seem to work in practice:
>> [...]
>>>>> $ git branch -d -r origin/pu
>>>>> Deleted remote branch origin/pu.
>>>>> $ git remote show origin
>>>>> * remote origin
>>>>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>>>>   Remote branch(es) merged with 'git pull' while on branch master
>>>>>     master
>>>>>   New remote branches (next fetch will store in remotes/origin)
>>>>>     pu
>>>>>   ^^^^^^^^^^^^^^^^^^^ What???
>>>>>   Tracked remote branches
>>>>>     html maint man master next todo
>>>>
>>>> Check out what do you have in .git/config file, in the
>>>> [remote "origin"] section. Most probably (if you cloned this
>>>> repository using new enough git) you have wildcard refspec there,
>>>> which means that git would pick all new branches when
>>>> fetching / pulling from given repository.
>>>
>>> Sure, I've cloned git.git using rather recent git, so .git/config has:
>>>
>>>       fetch = +refs/heads/*:refs/remotes/origin/*
>>
>> [...]
>>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>>> get rid of the remote branch? Currently it seems like a bug introduced
>>> by addition of wildcards refspecs, right?
>>
>> No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
>> the '-d' option removes branch locally. It is meant I think to remove
>> tracking of branches which were dropped in remote, as I think that
>> wildcard refspec does create new branches, but do not delete dropped
>> branches.
> 
> "git remote prune origin" should be used to clean up stale
> remote-tracking branches.
> 
> BTW, what's the right name for this type of branch.
> I found "tracking branch", "remote tracking branch", and
> "remote-tracking branch" in the manual. The glossary only
> mentions "tracking branch".  Or is it a "tracked remote branch"
> as the output of "git remote show" suggests.  I remember,
> there was a lengthy discussion on this issue.  Does someone
> remember the conclusion?
> 

It seems we agreed to disagree. However, a "tracked remote branch"
is definitely not in your local repo. I think remote-tracking branch
grammatically is the most correct, as that's the only non-ambiguous
form (remote tracking branch might mean "remote tracking-branch" or
"remote-tracking branch"). It's also the only form that works when
used with "local" in front of it. "Tracked remote branch" will
always be a "remote branch", no matter how you prefix it.

I hate that part of git nomenclature with a passion. It's ambiguous
at best and, as a consequence, downright wrong for some uses.

> 
>> So I'm not sure if it is a bug, misfeature or a feature.
> 
> It doesn't make sense to delete remote-tracking branches
> locally if they are still present at the remote.  The main
> purpose of a remote-tracking branch is to be identical to the
> real remote branch.
> 

Yes, but it does make sense to say "I no longer want to track that
remote branch". If that should be implied by the user deleting its
local counterpart is, I think, what this discussion is about.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
