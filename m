From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: [PATCH] Proof-of-concept patch to remember what the detached
 HEAD was
Date: Fri, 16 Oct 2009 18:31:23 +0100 (BST)
Message-ID: <alpine.LNX.2.00.0910161821230.30589@reaper.quantumfyre.co.uk>
References: <76718490910141156g440ee455t2e1db72ad72b7049@mail.gmail.com> <alpine.LNX.2.00.0910141509200.32515@iabervon.org> <alpine.LFD.2.00.0910141616530.20122@xanadu.home> <7v7huxbtbk.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910141647390.20122@xanadu.home>
 <7vws2xa9lu.fsf@alter.siamese.dyndns.org> <20091014230934.GC29664@coredump.intra.peff.net> <885649360910150036o72c3bd97ofad85d5316dc5b35@mail.gmail.com> <alpine.LNX.2.00.0910151523020.32515@iabervon.org> <alpine.LNX.2.00.0910161311460.28491@reaper.quantumfyre.co.uk>
 <20091016143041.GA11821@atjola.homenet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	James Pickens <jepicken@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:38:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyqlC-0001I0-N7
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 19:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbZJPRi1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 13:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbZJPRi1
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 13:38:27 -0400
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:52725 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750741AbZJPRi0 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Oct 2009 13:38:26 -0400
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id 78320358B05
	for <git@vger.kernel.org>; Fri, 16 Oct 2009 18:38:29 +0100 (BST)
Received: (qmail 27872 invoked by uid 103); 16 Oct 2009 18:31:24 +0100
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/9902. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.026399 secs); 16 Oct 2009 17:31:24 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 16 Oct 2009 18:31:23 +0100
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <20091016143041.GA11821@atjola.homenet>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130514>

On Fri, 16 Oct 2009, Bj?rn Steinbrink wrote:

> On 2009.10.16 13:15:35 +0100, Julian Phillips wrote:
>> On Thu, 15 Oct 2009, Daniel Barkalow wrote:
>>
>>> On Thu, 15 Oct 2009, James Pickens wrote:
>>>
>>>> How about not detaching the head at all if the user checks out any ref, and
>>>> reject commits if he checked out a tag or remote branch.  For example:
>>>>
>>>> $ git checkout origin/master
>>>> $ git status
>>>> # On branch origin/master
>>>> $ git commit ;# complain
>>>
>>> $ git checkout origin/master
>>> $ git fetch
>>> $ git checkout origin/next
>>> Uncommited file '...' would be overwritten.
>>
>> How about:
>>
>> $ git checkout origin/master
>> $ git fetch
>> Refusing to fetch, as it would update a checkedout branch
>> "git fetch -f" will force the update, but you will need to run "git
>> reset --hard HEAD" to update your checkout to match.
>
> That would redefine -f (currently means "allow non-fast-forward
> updates"), the flag that allows the checked out branch head to be
> updated is -u, --update-head-ok, and is for internal use only.
>
> And suggesting "reset --hard" seems wrong, that just kills any
> uncommitted changes.

Ok, so the commands were wrong.  Not important.

It was the approach that I was trying to suggest rather than the actual 
commands.  The point I was trying to make was how, as a user, I would be 
happy to git behave.

So, I try to run fetch, git says "ooh, now that would be dangerous - you 
can force it happen by running "git foo", but you will then be in 
situation X, which you can then recover from by running "git bar", though 
you may need to run "git stash" to save any edits you have made" or 
something similar.

Now as a user I know that I have tried to do something a bit unusual, but 
I don't have to run to the mailing list or #git saying "I just did X Y Z 
and everything is now FUBARed".  I can even proceed to do the unusal 
thing, as git itself has given me the information I need to sort things 
out afterwards.

> And such uncommitted changes would be lost in the big "undo the fetch
> update" diff. So you'd have to do:
> git reset --soft HEAD@{1}
> git checkout --merge HEAD@{1}
>
> to keep them, while updating to the new state of the remote tracking
> branch. Not quite intuitive, is it?

I don't care what git has to do, I'm talking about the user experience - 
if we have to write some new code to support it, that really isn't a 
terribly hard thing to do.  UIs should be driven down from the user 
interaction not up from the implementation.

-- 
Julian

  ---
Captain: "Catalyzer's a nothing part, captain."

Mal: "It's nothing until you don't got one. Then it appears to be everything."
 				--Episode #8, "Out of Gas"
