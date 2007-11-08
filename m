From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 08 Nov 2007 14:38:54 +0100
Message-ID: <4733116E.5020300@op5.se>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net> <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, gitster@pobox.com,
	Ralf.Wildenhues@gmx.de, tsuna@lrde.epita.fr, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 08 14:40:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq7cM-0007HW-Eh
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 14:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756903AbXKHNjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 08:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754545AbXKHNjB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 08:39:01 -0500
Received: from mail.op5.se ([193.201.96.20]:60262 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756153AbXKHNjA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 08:39:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 487841F08708;
	Thu,  8 Nov 2007 14:38:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pcy-TVJCd2VJ; Thu,  8 Nov 2007 14:38:03 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 4D1CC1F08712;
	Thu,  8 Nov 2007 14:38:02 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64019>

Steffen Prohaska wrote:
> 
> On Nov 8, 2007, at 10:53 AM, Johannes Sixt wrote:
> 
>> Andreas Ericsson schrieb:
>>> Johannes Sixt wrote:
>>>> Steffen Prohaska schrieb:
>>>>>
>>>>> On Nov 8, 2007, at 8:19 AM, Johannes Sixt wrote:
>>>>>
>>>>>> Steffen Prohaska schrieb:
>>>>>>> +If you linearize the history by rebasing the lower branch on
>>>>>>> +top of the upper, instead of merging, the bug becomes much 
>>>>>>> easier to
>>>>>>> +find and understand.  Your history would instead be:
>>>>>>
>>>>>> At this point I'm missing the words
>>>>>>
>>>>>>     The solution is ...
>>>>>>
>>>>>> I.e.:
>>>>>>
>>>>>> The solution is to linearize the history by rebasing the lower 
>>>>>> branch on
>>>>>> top of the upper, instead of merging. Now the bug becomes much 
>>>>>> easier to
>>>>>> find and understand.  Your history would instead be:
>>>>>
>>>>> Hmm. It might be a solution if you did not publish history.
>>>>
>>>> This is about finding the commit that introduced a bug. Once you 
>>>> found it, better: you know how to fix the bug, you are expected to 
>>>> throw away the rebased branch, not to publish it! Maybe a note along 
>>>> these lines could be appended:
>>>>
>>>> Now that you know what caused the error (and how to fix it), throw 
>>>> away the rebased branch, and commit a fix on top of D.
>>>>
>>> Well, if rebasing becomes the standard for normal development, it's 
>>> hardly
>>> right to throw it away, is it? I like Steffen's suggestion better.
>>
>> There is a big misunderstanding. The text that the patch amends is 
>> about bisecting history that reveals that a merge commit breaks, which 
>> is not helpful, and then how to find where and what and why the 
>> breakage really was introduce.
>>
>> And the answer to "how to find" is to rebase and bisect in the rebased 
>> history.
> 
> Do you use rebase like this in real life?
> 
> I thought of the text as background information that might
> be helpful for users who want do decide wether to merge or
> to rebase. The problem described may be valuable information
> supporting a decision about a recommended workflow for a group
> of users.
> 
> My personal conclusion was: I'll accept the danger of complex
> merges that might be hard to bisect. I now understand this
> risk, but I nonetheless prefer the simplicity of a merge
> based workflow. This avoids the danger that published history
> gets rewritten.
> 
> But now I'm wondering if your suggestions of rebasing only for
> locating the evil commit is feasible in reality. You may need
> to solve a lot of merge conflicts if you rebase a larger part
> of the history. If you do not have them in your rerere cache
> this might be time consuming. ...
> 

It is no great chore to put one merge-parent on top of another
and then re-run bisect on the result. git-bisect could even be
taught to do that by itself.

> 
>> My initial complaint was that in the flow of reading the instructions 
>> the pointer to "the solution" was missing. Rather, at the point where 
>> the reader is supposed to think "ah, yes, that's how to do it", there 
>> is the conditional statement "If you linearize history". My suggestion 
>> is to put a big emphasis on the solution by using the words "The 
>> solution is".
>>
>> Now, the user can *always* rebase one of the branches on top of the 
>> other, even if both histories are already published. *But* if both 
>> were indeed published, then the rebased history must be thrown away, 
>> and the only thing you learnt from it was where and what and why the 
>> breakage really was introduced.
>>
>> Of course we could include a few "ifs" and "unlesses" (about published 
>> histories), before suggesting to throw away rebased history. But once 
>> the task is accomplished (find the bogus commit), throwing away the 
>> rebased history (and continuing at commit D) is always correct, but 
>> keeping it (and continuing at D*) is not.
> 
> ... So, again, the question for me is if someone does use
> rebase in reality in the way that you suggests. Do you?


I don't, but if I'd thought a bit further I would have on at least one
occasion in the past. Instead I spent two days manually auditing every
commit of several branches.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
