From: Sergei Organov <osv@javad.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 20:40:24 +0300
Message-ID: <87lk9282nr.fsf@osv.gnss.ru>
References: <874pfq9q8s.fsf@osv.gnss.ru> <fhcdpv$9u3$1@ger.gmane.org>
	<87ve86889o.fsf@osv.gnss.ru> <200711131703.16357.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrzrL-0003ci-8t
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 18:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755872AbXKMRrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 12:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755650AbXKMRrN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 12:47:13 -0500
Received: from javad.com ([216.122.176.236]:2372 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755344AbXKMRrM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 12:47:12 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lADHeU037586;
	Tue, 13 Nov 2007 17:40:30 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1IrzkO-0004aA-Dr; Tue, 13 Nov 2007 20:40:24 +0300
In-Reply-To: <200711131703.16357.jnareb@gmail.com> (Jakub Narebski's message of "Tue\, 13 Nov 2007 17\:03\:16 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64817>

Jakub Narebski <jnareb@gmail.com> writes:
> Sergei Organov <osv@javad.com> wrote:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> Sergei Organov wrote:
>
>>>> I want to get rid of origin/pu remote tracking branch. What do I do?
>>>> I RTFM git-branch. What does it suggest?
>>>> 
>>>> git branch -d -r origin/pu
>>>> 
>>>> So far so good. However, it doesn't seem to work in practice:
> [...]
>>>> $ git branch -d -r origin/pu
>>>> Deleted remote branch origin/pu.
>>>> $ git remote show origin
>>>> * remote origin
>>>>   URL: git://git.kernel.org/pub/scm/git/git.git
>>>>   Remote branch(es) merged with 'git pull' while on branch master
>>>>     master
>>>>   New remote branches (next fetch will store in remotes/origin)
>>>>     pu
>>>>   ^^^^^^^^^^^^^^^^^^^ What???  
>>>>   Tracked remote branches
>>>>     html maint man master next todo
>>>
>>> Check out what do you have in .git/config file, in the
>>> [remote "origin"] section. Most probably (if you cloned this
>>> repository using new enough git) you have wildcard refspec there,
>>> which means that git would pick all new branches when
>>> fetching / pulling from given repository. 
>> 
>> Sure, I've cloned git.git using rather recent git, so .git/config has:
>> 
>>       fetch = +refs/heads/*:refs/remotes/origin/*
>
> [...] 
>> Isn't "git branch -d -r" supposed to do whatever magic is required to
>> get rid of the remote branch? Currently it seems like a bug introduced
>> by addition of wildcards refspecs, right?
>
> No, the '-r' part translates 'pu' into 'refs/remotes/origin/pu', and
> the '-d' option removes branch locally. It is meant I think to remove 
> tracking of branches which were dropped in remote, as I think that 
> wildcard refspec does create new branches, but do not delete dropped 
> branches.

Isn't it 'git remote prune <name>' that is meant to remove tracking of
branches which were dropped in remote?

Anyway, description of '-r' in man git-branch:

-r::
	List or delete (if used with -d) the remote-tracking branches.

Suggests it should be deleted. What's a point to delete it if it will be
re-created on next fetch anyway?

> So I'm not sure if it is a bug, misfeature or a feature.
>
> Can anyone better versed in wildcard refspecs speak up, please?

Yes, please!

-- 
Sergei.
