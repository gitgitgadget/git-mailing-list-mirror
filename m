From: Andreas Ericsson <ae@op5.se>
Subject: Re: git pull opinion
Date: Tue, 06 Nov 2007 09:59:51 +0100
Message-ID: <47302D07.9030703@op5.se>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com> <7vd4uomfn8.fsf@gitster.siamese.dyndns.org> <18223.46848.109961.552827@lisa.zopyra.com> <472FBB3F.8080307@op5.se> <Pine.LNX.4.64.0711060115130.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Bill Lear <rael@zopyra.com>, Junio C Hamano <gitster@pobox.com>,
	Aghiles <aghilesk@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 10:00:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKIA-0002lf-Mp
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbXKFI76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbXKFI76
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:59:58 -0500
Received: from mail.op5.se ([193.201.96.20]:60518 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750741AbXKFI75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:59:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A96D2173065A;
	Tue,  6 Nov 2007 09:59:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qg7KVBsZlORU; Tue,  6 Nov 2007 09:59:30 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 7364B17305AB;
	Tue,  6 Nov 2007 09:59:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0711060115130.4362@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63647>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 6 Nov 2007, Andreas Ericsson wrote:
> 
>> Bill Lear wrote:
>>> On Monday, November 5, 2007 at 15:33:31 (-0800) Junio C Hamano writes:
>>>> Aghiles <aghilesk@gmail.com> writes:
>>>>
>>>>> Is there an "easier" way to pull into a dirty directory ? I am
>>>>> asking this to make sure I understand the problem and not
>>>>> because I find it annoying to type those 4 commands to perform
>>>>> a pull (although some of my colleagues do find that annoying :).
>>>> You need to switch your mindset from centralized SVN workflow.
>>>>
>>>> The beauty of distributedness is that it redefines the meaning
>>>> of "to commit".  In distributed systems, the act of committing
>>>> is purely checkpointing and it is not associated with publishing
>>>> the result to others as centralized systems force you to.
>>>>
>>>> Stop thinking like "I need to integrate the changes from
>>>> upstream into my WIP to keep up to date."  You first finish what
>>>> you are currently doing, at least to the point that it is
>>>> stable, make a commit to mark that state, and then start
>>>> thinking about what other people did.  You may most likely do a
>>>> "git fetch" followed by "git rebase" to update your WIP on top
>>>> of the updated work by others.
>>>>
>>>> Once you get used to that, you would not have "a dirty
>>>> directory" problem.
>>> I respectfully beg to differ.  I think it is entirely reasonable, and
>>> not a sign of "centralized" mindset, to want to pull changes others
>>> have made into your dirty repository with a single command.
>>>
>> I find it much more convenient to just fetch them. I'd rather see
>> git-pull being given a --rebase option (which would ultimately mean
>> teaching git-merge about it) to rebase already committed changes on
>> top of the newly fetched tracking branch. It's being worked on, but
>> rather slowly.
> 
> git-pull learning about --rebase does not mean teaching git-merge about 
> it.  See my patch, which you (and others) failed to enthusiastically 
> embrace, which is the sole reason it is stalled.
> 

I must have missed it. Found the thread now though. Gonna try the patch in
production for a while and see how it pans out.

I'm curious about this hunk though. It seems unaffiliated with the --rebase
option as such, but was still in the patch. Would you care to clarify?

@@ -86,7 +95,6 @@ merge_head=$(sed -e '/	not-for-merge	/d' \
 
 case "$merge_head" in
 '')
-	curr_branch=$(git symbolic-ref -q HEAD)
 	case $? in
 	  0) ;;
 	  1) echo >&2 "You are not currently on a branch; you must explicitly"

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
