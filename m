From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Fri, 26 Oct 2007 09:53:33 +0200
Message-ID: <47219CFD.3010409@op5.se>
References: <20071024212854.GB6069@xp.machine.xx>	<05B279A2-98A3-45F1-9661-AB361F7CAA37@zib.de>	<Pine.LNX.4.64.0710242258201.25221@racer.site>	<008A7EF9-6F58-47AE-9AA0-B466797F6B1D@zib.de>	<Pine.LNX.4.64.0710250021430.25221@racer.site>	<47204297.5050109@op5.se>	<Pine.LNX.4.64.0710251112390.25221@racer.site>	<472070E5.4090303@op5.se> <20071025132401.GA22103@thunk.org>	<4720AF05.3050308@op5.se> <20071025152159.GB22103@thunk.org>	<4720CCE0.2090007@op5.se> <7vejfj11tk.fsf@gitster.siamese.dyndns.org> <4720FA00.1050805@op5.se> <D38E4717-CF67-4897-983E-2B45CA217C11@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Baumann <waste.manager@gmx.de>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Oct 26 09:54:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlK11-0001pd-KN
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 09:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbXJZHxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 03:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbXJZHxr
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 03:53:47 -0400
Received: from mail.op5.se ([193.201.96.20]:47044 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500AbXJZHxq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 03:53:46 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 78AC817306E9;
	Fri, 26 Oct 2007 09:53:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ap4-mDVIFk+4; Fri, 26 Oct 2007 09:53:14 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 72D1F17306D8;
	Fri, 26 Oct 2007 09:53:13 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <D38E4717-CF67-4897-983E-2B45CA217C11@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62400>

Steffen Prohaska wrote:
> 
> On Oct 25, 2007, at 10:18 PM, Andreas Ericsson wrote:
> 
>> Junio C Hamano wrote:
>>> Andreas Ericsson <ae@op5.se> writes:
>>
>>> With that in mind, how about making "git checkout foo", after
>>> foo is set up thusly, to show:
>>>     git log --pretty=oneline --left-right origin/pu...foo
>>> if (and only if) they have diverged?  Then you can deal with the
>>> staleness of local tracking fork 'foo' in any way you want.
>>> You could even go one step further and make this "checkout foo",
>>> in addition to or instead of showing the above left-right log,
>>>  - automatically run "git merge origin/pu" if it is a
>>>    fast-forward, and say it did _not_ run that merge if it is
>>>    not a fast-forward;
>>>  - automatically run "git merge origin/pu" always, even if it is
>>>    not a fast-forward;
>>>  - automatically run "git rebase origin/pu" always;
>>> Would that make your life easier?
>>
>> That it would, except the confusion would then be that it's automatically
>> rebased for the branches one currently hasn't got checked out while 
>> pulling,
>> and the branch that *is* checked out gets merged (crazy, yes), so those
>> who prefer the rebase would get what they want by doing something 
>> completely
>> bonkers, such as:
>>
>> git checkout -b just-gonna-pull HEAD^
>> git pull
>> git checkout whatever-other-branch-they-were-on
>>
>> (yes, "aggresively ignorant", I think Ted said in an earlier mail)
>>
>> It'd probably be better to go with Dscho's suggestion, although I'm 
>> not quite
>> sure what that was any more. It involved automagical rebasing on fetch 
>> or pull
>> though.
> 
> git pull's automagic and the automatic behaviour of git checkout
> proposed by Junio should always do the same. git pull should
> be changed to act a if your three commands were fused into it
> (but obviously implemented differently).
> 

I think it would be better to implement it as a different command that
would do all those weird and tedious dwim things that suit a particular
kind of developer, but only so long as those operations succeed without
conflicts.

So for example the flow could go something like this;
---
read_branch_merge_config();

git fetch

if prefetch(local == remote_tracking)
	set ref local to match ref remote_tracking;
else if (--safe-rebase)
	try_rebase local onto remote_tracking;
---

It's such a common operation that I really do think it's worth
having support for it. Perhaps with a "--try-rebase" option to
git-pull.

If we then add a a "--push-after-pull" (to work on the current
branch only) we have the "git sync" alias readily available to
accommodate the average reluctant git user, and I'm sure gui
hackers could do wonders with it, especially on windows, where
people seem accustomed to a lot of things happening when clicking
a single button.

> I think teaching "git checkout" a dwim mode is quite
> interesting.  The required work to bring a local branch
> up-to-date with a remote branch is deferred until really needed.
> An then "git checkout" does the right thing. A lot of automagic
> but definitely intriguing.
> 

Yup, and it can be done with a post-checkout hook (which I notice
there are no examples for, so I've added that to my ever-growing
todo).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
