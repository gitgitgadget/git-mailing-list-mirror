X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: Resolving conflicts
Date: Thu, 30 Nov 2006 23:52:04 -0800
Message-ID: <456FDF24.1070001@saville.com>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 07:52:24 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32862>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3C2-0000fb-0t for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:52:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935687AbWLAHwB (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935979AbWLAHwA
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:52:00 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:57472 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S935687AbWLAHv7 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 02:51:59 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id A321357A6F; Thu, 30 Nov 2006 23:48:02 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 Nov 2006, Wink Saville wrote:
>> I then searched the net for how to resolve conflicts, seems you
>> should start by doing a git-diff, so I did and I get this:
>>
>>   diff --cc kernel/fork.c
>>   index d74b4a5,8cdd3e7..0000000
>>   --- a/kernel/fork.c
>>   +++ b/kernel/fork.c
>>   diff --cc kernel/spinlock.c
>>   index f4d1718,2c6c2bf..0000000
>>   --- a/kernel/spinlock.c
>>   +++ b/kernel/spinlock.c
> 
> Hmm. That doesn't look like a conflict. If it had a real conflict, I'd 
> have expected to see it mentioned in that diff..
> 
> This may be a stupid question, but if you haven't actually ever needed to 
> do any file-level merges before, this may be the first time you've 
> actually had the external 3-way "merge" program called, and that's one of 
> the few things that git still depends on _external_ programs for. And if 
> that program is broken or missing, you'd get bubkis.
> 
> (This is hopefully getting fixed, and we'll have one less external 
> dependency to worry about, but it's the only thing that springs to mind)
> 
> That's especially true since the merge-head your log shows wasn't even all 
> that long ago: there's just 80 commits since that common merge base, and 
> only two of them even change those two files, and only in rather simple 
> ways at that.
> 
> So my guess is that there wasn't actually a conflict at all, but the 
> "merge" program (usually in /usr/bin/merge) returned an error for some 
> reason. What does "which merge" and "rpm -qf /usr/bin/merge" say?
> 
> But you can also do "git diff --ours" (or "git diff --their") to get a 
> simple two-way diff of the end result of the merge to what you were 
> looking at.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Earlier had a problem with git wanting merge but didn't have it and
couldn't figure out which package it was in Ubuntu:( So I symlinked merge
to kdiff3 which worked at the time:

wink@winkc2d1:~/linux/linux-2.6$ ls -al /usr/bin/merge
lrwxrwxrwx 1 root root 6 2006-11-17 19:24 /usr/bin/merge -> kdiff3

But doesn't/didn't work this time.

I tried "git diff --ours"

wink@winkc2d1:~/linux/linux-2.6$ git diff --ours
* Unmerged path kernel/fork.c
diff --git a/kernel/fork.c b/kernel/fork.c
* Unmerged path kernel/spinlock.c
diff --git a/kernel/spinlock.c b/kernel/spinlock.c
wink@winkc2d1:~/linux/linux-2.6$

Wink

Not too helpful:(
