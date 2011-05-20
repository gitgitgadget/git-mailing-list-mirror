From: John Lumby <johnlumby@hotmail.com>
Subject: Re: git  --  how to revert build to as-originally-cloned?
Date: Fri, 20 May 2011 10:15:52 -0400
Message-ID: <4DD67798.4050503@hotmail.com>
References: <4DD44DCD.7010508@hotmail.com> <SNT124-W3827431D13C320A4C9BF9DC48F0@phx.gbl>,<4DD536EC.3060308@hotmail.com> <SNT124-W51D709B129B6A940ED17F2C4710@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Mazid <timmazid@hotmail.com>
X-From: git-owner@vger.kernel.org Fri May 20 16:16:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNQUi-0006ku-1T
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 16:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934680Ab1ETOPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 10:15:55 -0400
Received: from toip5.srvr.bell.ca ([209.226.175.88]:34660 "EHLO
	toip5.srvr.bell.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932841Ab1ETOPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 10:15:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ag4MANh11k1GHzDf/2dsb2JhbACCJ4MtoEd4iHCqE4ckiR6GGQSUQIpi
Received: from bas3-toronto06-1176449247.dsl.bell.ca (HELO lumbywnt.localdomain) ([70.31.48.223])
  by toip5.srvr.bell.ca with ESMTP; 20 May 2011 10:15:52 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by lumbywnt.localdomain (8.14.4/8.14.1) with ESMTP id p4KEFrkH003073;
	Fri, 20 May 2011 10:15:54 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <SNT124-W51D709B129B6A940ED17F2C4710@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174061>

Tim,  Thanks very much indeed for taking the time to provide all that 
explanation.    Very helpful.
Not sure I have understood all of it but it makes more sense now.

I will embed answers to specific questions you raised :

On 05/19/11 22:16, Tim Mazid wrote:
>
>>> Can you please post the commit message that you see in the first commit
>>> when doing a git log?
>> Here are the first three. I assume (not sure) they are what was merged
>> into the newer clone, /b, just before I cloned it
>>
>> ------------------------------------------------------------------------------
>> commit 89c64d755fbf04d7541d526931dc4b38301946d1
>> Merge branch 'master' of
>> master.kernel.org:/pub/scm/linux/kernel/git/jkirsher/net-next-2.6
>>
>> commit 4dc6ec26fe7d9f89349d4c0c654e2f07420f4b27
>> Merge branch 'batman-adv/next' of
>> git://git.open-mesh.org/ecsv/linux-merge
>>
>> commit 5c5095494fb545f53b80cbb7539679a10a3472a6
>> ------------------------------------------------------------------------------
> You actually skipped the message of the third message there. :P

You're right.    as it happens,   after the reset back to origin/master,
that third merge is now the first one shown in the log and it reads

commit 5c5095494fb545f53b80cbb7539679a10a3472a6
Merge: 4d586b8 def5768
Author: David S. Miller <davem@davemloft.net>
Date:   Thu May 12 23:01:55 2011 -0400

     Merge branch 'master' of 
master.kernel.org:/pub/scm/linux/kernel/git/davem/net-next-2.6


> But I can see that the first two are actually merges. Were they both
> your doing? If so, doing a git reset --hard HEAD^ will only take you
> back one commit.
> See above, and then below.

Ah  - I should have said that I selected only merges in my git log 
command  -
git log --merges
(With no qualifier,   git log returns about 3.8 million lines /  150 
MBytes,   hard to work with)
And,  based on what the command now returns,  it seems that the first 
two that I listed before
(which are no longer present) were as a result of my (single) merge 
command,  i.e. my merge
resulted in merging :
     .   two merges that were done by someone else in the master that I 
cloned into my /b filesystem,
     .   maybe some other non-merge commits that I did not query before 
and now don't know

>
>> So I now think I see the problem with using a reset based on something
>> relating to commits -
>> apparently (??) there is nothing in the git log to distinguish commits
>> done by my last merge versus commits prior to that. I.e. the "merge"
>> does not appear to be logged as an event in its own right, only as the
>> commits inside it??
> Two points:
>   - in git, you have commits and "pointers to commits"; and
>   - the commit itself IS the merge.

You've lost me here.    If a merge can consist of many commits,  
including other merges (see above),
then how can one commit be a merge?     Note that in my original git log 
--merges output that I posted
in my earlier post,  i.e. the one before I reset,  there was *no* record 
of *my* merge command itself,
only of the sub-merges that my merge dragged along.   I think this is 
the crucial (to me) point -
git did not record what I did,  only the effects of what I did.    Not 
saying this is wrong or right,
but significant.

> See below.
>
>
>>> Also, if you just want to go back to a particular branch, you can
>>> specify it to git reset, in the form of "git reset --hard
>>> origin/master". This will reset (discarding any changes) YOUR branch to
>>> wherever origin/master happens to be, which, from reading your message
>>> seems to be where you want to go?
>> Ah - that did it, thanks Tim. I had seen that one but wasn't
>> sure whether it would reset me back to what I cloned or the master of
>> that clone i.e. way back to the "original" origin of this build.
>>
>> It seems if I had not created a separate branch -- I would now be
>> completely sunk?
> Your branches are completely separate to the branches of other repos.

Ah,  ok.    Good.

> See below.
>
>
>> It would be nice if there was a "git undo" which undid whatever changes
>> to files+index were made by the immediately preceding git command,
>> whatever it was and whatever it did.
> I believe (speculation) that the reason this hasn't been done is that
> there are too many things you can _DO_ in git in order to have a simple
> "undo" button. Compare it to having an "undo" button in real life; what
> and how much would it actually undo? There are simply too many different
> situations to have something as simple as undo.
> Having said that, there are ways to recover from almost every situation
> in git (most of which I'm yet to learn). See below.

I see it would be a large and tedious thing to code,  but I do think it 
would be
perfectly well-defined   :

     gather all relevant information about the most recent git command 
that changed
     either files or index or pointers,    and reverse its effects.

In my particular case,  with your insight,  I can now see that it would 
have been quite easy to delve into
the log and calculate how many carets or tildes I needed to revert back 
to the commit that
corresponded to my initial cloned state.

In a general case,   I think this could easily be a complex burden for a 
dumb user to have to do
compared with "undo what I just did".


>
>>> Be careful if you have made changes you want to keep, though.
>> No worries there although thanks for the warning.
> I've lost data a few times not thinking about what I was doing. :P
>
>
> Alright, so I promised you a crack at an explanation. List, please feel
> free to chime in and correct me where I am mistaken.
>
>
Yes,   I have used gitk and it helps a lot.

Thanks again     John Lumby
