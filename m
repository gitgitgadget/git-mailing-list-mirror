From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v4] user-manual: Add section "Why bisecting merge commits can be harder ..."
Date: Sat, 10 Nov 2007 23:41:36 +0100
Message-ID: <901775B5-D4BE-4CF1-BB0A-4FEF88D7880A@zib.de>
References: <B622E814-D7D1-4DC8-A724-666BA0A1220F@zib.de> <1194702594213-git-send-email-prohaska@zib.de> <alpine.LFD.0.999.0711101105340.15101@woody.linux-foundation.org> <7vtzntlufh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Benoit Sigoure <tsuna@lrde.epita.fr>,
	Andreas Ericsson <ae@op5.se>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 23:41:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqz1X-0003vd-14
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 23:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877AbXKJWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 17:41:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbXKJWli
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 17:41:38 -0500
Received: from mailer.zib.de ([130.73.108.11]:35618 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754761AbXKJWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 17:41:37 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAAMeLfk026969;
	Sat, 10 Nov 2007 23:40:21 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1a7c4.pool.einsundeins.de [77.177.167.196])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAAMeJB0018852
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 10 Nov 2007 23:40:20 +0100 (MET)
In-Reply-To: <7vtzntlufh.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64383>


On Nov 10, 2007, at 9:25 PM, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Sat, 10 Nov 2007, Steffen Prohaska wrote:
>>> +
>>> +But if you already made a merge C instead of rebasing, all
>>> +is not lost.  In the illustrated case, you can easily rebase
>>> +one parent branch on top of the other after the fact, just
>>> +to understand the history and to make the history more
>>> +easily to bisect.
>>
>> I simply don't think this is true.
>>
>> You can *not* easily rebase after the fact. Both the parents may  
>> have lots
>> of merges independently of each other, and rebase won't be able to do
>> *anything* with such a case. In fact, the only reason you think  
>> you can
>> easily rebase after-the-fact is that you made the example history be
>> trivial. In real life, if the example history is that trivial (just a
>> single merge of two otherwise linear histories), you'd probably  
>> generally
>> not have this problem in the first place.
>>
>> The facts are:
>>
>>  - git bisect can handle merges quite well, and points to the right
>>    commit (which is *usually* not a merge).
>>
>>  - but merges by definition introduce changes from two independent  
>> lines
>>    of development, and while both lines may work well on their  
>> own, it is
>>    possible that (a) the merge itself was done incorrectly or (b)  
>> the two
>>    (or more) features that were introduced simply clash.
>>
>>  - "git rebase" won't do a thing for this after the fact, except in
>>    trivial cases, and even then it will generate a new history  
>> that simply
>>    isn't compatible with the original history, so while it could  
>> in theory
>>    help bisect things further in some limited and simple cases, in  
>> general
>>    it's simply not that useful an approach.
>>
>> ..and I think it's simply wrong to even *try* to imply that "git  
>> rebase"
>> can somehow change any of this.
>
> Very true.  It is a suggestion useful _only_ when you can easily
> rebase.  Like the one illustrated in the description, which is
> artificial and of very limited scope.  If you cannot rebase
> easily, then (by definition) rebase would not help you.

I propose to remove this suggestion if no one comes up with a
real world example where rebasing after the fact turned out to
be useful. If nobody has such an example it doesn't make sense
to tell readers of the manual that rebase could be useful in
such a situation.

The patch would be identical except for the last paragraph
removed.

	Steffen
