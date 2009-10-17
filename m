From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Sat, 17 Oct 2009 18:35:38 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910171829430.7906@reaper.quantumfyre.co.uk>
References: <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet> <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk> <7vvdiftb0d.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.0910162029460.31673@reaper.quantumfyre.co.uk> <alpine.LFD.2.00.0910161557500.20122@xanadu.home>
 <alpine.LNX.2.00.0910171606180.6644@reaper.quantumfyre.co.uk> <20091017170421.GA10490@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Nicolas Pitre <nico@fluxnic.net>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Jay Soffian <jaysoffian@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 17 19:38:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzDEf-0006o9-Cv
	for gcvg-git-2@lo.gmane.org; Sat, 17 Oct 2009 19:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753202AbZJQRiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Oct 2009 13:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753194AbZJQRiW
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Oct 2009 13:38:22 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:39905 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753189AbZJQRiW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Oct 2009 13:38:22 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 8F91135772F
	for <git@vger.kernel.org>; Sat, 17 Oct 2009 18:38:25 +0100 (BST)
Received: (qmail 31662 invoked by uid 103); 17 Oct 2009 18:35:38 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9906. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.025803 secs); 17 Oct 2009 17:35:38 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 17 Oct 2009 18:35:38 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20091017170421.GA10490@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130570>

On Sat, 17 Oct 2009, Bj?rn Steinbrink wrote:

> On 2009.10.17 16:15:13 +0100, Julian Phillips wrote:
>> On Fri, 16 Oct 2009, Nicolas Pitre wrote:
>>
>>> On Fri, 16 Oct 2009, Julian Phillips wrote:
>>>
>>>> My interest in this thread is solely that it might provide a mechanism to find
>>>> out which tag was checked out.  So, I'm just chucking in my $0.02 as a user.
>>>
>>> Try this:
>>>
>>> $ git checkout v1.5.5
>>> Note: moving to 'v1.5.5' which isn't a local branch
>>> If you want to create a new branch from this checkout, you may do so
>>> (now or later) by using -b with the checkout command again. Example:
>>> git checkout -b <new_branch_name>
>>> HEAD is now at 1d2375d... GIT 1.5.5
>>>
>>> [look around, and then ...]
>>>
>>> $ git checkout HEAD~2
>>> Previous HEAD position was 1d2375d... GIT 1.5.5
>>> HEAD is now at f61cc48... git-svn: fix following renamed paths when tracking a single path
>>>
>>> [go out for lunch ... and forget what this was about.]
>>>
>>> $ git reflog -3
>>> f61cc48 HEAD@{0}: checkout: moving from 1d2375d... to HEAD~2
>>> 1d2375d HEAD@{1}: checkout: moving from master to v1.5.5
>>> c274db7 HEAD@{2}: pull : Fast forward
>>>
>>> Here I have all the information to see what I did, and from what state.
>>> I even know that I did a pull on the master branch before moving away
>>> from it.  The -3 limits the log to 3 entries.  With no limit you get it
>>> all in your default pager.
>>>
>>> So there is no need for another mechanism to find out what tag was
>>> actually checked out -- you have it all already.
>>
>> What I want is a way for my build process to reliably know what
>> branch or tag is currently being built.  "git symbolic-ref HEAD"
>> will give me the branch name, but doesn't work for tags.  "git
>> describe" will find _a_ tag, but I can't tell if it's actually the
>> one checked out.
>
> Do you have multiple (annotated) tags for the same commit?

Potentially, yes.  Releasing isn't the only thing that requires keeping 
track of things.  It's even possible that the person creating the newer 
tag doesn't yet know that a release tag has been applied if the person 
who applied it hasn't yet pushed it back.

> Otherwise, I don't see why "git describe HEAD" should print the wrong 
> one. If there's a tag that can be resolved to the same commit that HEAD 
> can be resolved, then "git describe HEAD" must output that one. 
> Otherwise, that'd be a clear bug to me.

Oh, definately no bug.  git describe works exactly as expected, the 
problem is that the tag checked out isn't always the latest tag applied to 
that commit.

-- 
Julian

  ---
Jayne: Shee-nio high tech Alliance crap!"
 				--Episode #9, "Ariel"
