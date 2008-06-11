From: Luke Lu <git@vicaya.com>
Subject: Re: Help rescuing a repository
Date: Tue, 10 Jun 2008 22:04:25 -0700
Message-ID: <025E3DB6-D0A8-497E-A5EF-9B4011FA3272@vicaya.com>
References: <C061111B-1696-4545-A3F0-D0B8B961A352@vicaya.com> <alpine.LFD.1.10.0806101848320.3101@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 07:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6IWT-000643-8q
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 07:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbYFKFEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 01:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbYFKFEb
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 01:04:31 -0400
Received: from an-out-0708.google.com ([209.85.132.240]:53025 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327AbYFKFEa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 01:04:30 -0400
Received: by an-out-0708.google.com with SMTP id d40so689004and.103
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 22:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer:sender;
        bh=1TOJAQeZH4he3++N+s1c1D+Cj1dd4C3DDSbSARruCyM=;
        b=l6Fcp/hqYLFJyh2Sv6hIWdSkphkI4/SYKw2KPjF3w2299EAKYKy5eaiWd+VunGe3nP
         +VaajZHWIvL9Cc0yiMCblbvBEPnK7GOYoAjGkPUs3OyX3qWhb/sH+zh9G0LCoiKIxUXv
         coizgIxjFcJiG6wHCJkEWG539vwlVmbsPYtro=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer:sender;
        b=GBmCHAWEmNZdbpmimWZEwZ8ALs6V4S3omYMzalglp6WRgvIQWv1KuLJTCZtB9AaqK+
         QqxxHjvsukYPx3ZhBNwJcdXJu84s8K1JbdqSL/E8+OBzxuQ7nUeVLJGUsA7Aw+j/b1si
         MzHSlFKzdBAKAIVyKDc8rftQiBjksOHgwxJpk=
Received: by 10.100.58.19 with SMTP id g19mr6759592ana.44.1213160668893;
        Tue, 10 Jun 2008 22:04:28 -0700 (PDT)
Received: from ?192.168.7.9? ( [71.198.200.243])
        by mx.google.com with ESMTPS id 4sm12346952yxd.2.2008.06.10.22.04.27
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 22:04:28 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0806101848320.3101@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84587>

On Jun 10, 2008, at 7:08 PM, Linus Torvalds wrote:
>
> On Tue, 10 Jun 2008, Luke Lu wrote:
>>
>> I was doing some git rebase -i in a topic branch (topic/ser) to  
>> squash and
>> reorder some commits. There were some conflicts. I fixed the  
>> conflicts and
>> typed git rebase --continue. The cycle continued a few times and  
>> then this
>> happened:
>>
>> 13 files changed, 68 insertions(+), 41 deletions(-)
>> error: Ref refs/heads/topic/ser is at  
>> 5cfb6b694f2d5a1ff429fe86f6c5ecafed159e47
>> but expected a10a7127be3441c732cab5baa2dd8684591f91f7
>> fatal: Cannot lock the ref 'refs/heads/topic/ser'.
>
> Ok, you seem to have committed something in another session (other  
> window
> or something) at the same time as doing that git rebase series. As a
> result, the rebasing commit was unhappy, because you basically  
> ripped the
> rug out from under it by changing the branch it was working on.

So you've seen this problem before?

>> I *might* have committed something in the same branch, while the git
>> rebase -i editor window is open (there are a lot of commits to  
>> reorder
>> and squash, so I used another window to look at the commits I'm not  
>> sure
>> about. I might have done a quick fix (likely whitespace errors :) and
>> committed)
>
> Yup, that would explain it.
>
>> I have the gut feeling that it might be fixable by some magical  
>> incantation to
>> connect the refs to my branch. But I don't know git internal very  
>> well. I need
>> your help. My work obviously depend upon it.
>
> Most likely, the only thing you actually need to do is simply
>
> 	git rebase --abort
>
> and it will just take you back to the state you were in before the  
> rebase,
> and now you'll have to redo it all.

Before I thought of that, I just used the trusted git reflog to find  
the last commit I made before the rebase commits and did a git reset -- 
hard to that commit. It returned the tree to normal. Fortunately I  
have rerere enabled (by creating the .git/rr-cache directory, because  
I read your and Junio's posts on kernel trap). so I don't have to do  
much work to reedit the conflicts.

> BUT. You can also decide that instead of doing that, you want to  
> keep the
> work you did do, and just try to continue. You'll just need to  
> figure out
> where you are, and where the rest of the commits you want to do are.
>
> And those things should not be so hard to figure out, at least if you
> still have a reasonably good idea about what the commits were that you
> cared about. You just need to find all the relevant development  
> tips, and
> it turns out that that is actually mostly pretty easy.
>
> You have one right there: the current disconnected HEAD you are on  
> is one
> tip. You can save that one away by making that a real branch, so you  
> don't
> lose it, with something like
>
> 	git branch middle-of-rebase
>
> which will just take your current state, and make it the new branch
> 'middle-of-rebase'.
>
> You can also try to get a better view of where you are by doing
>
> 	gitk --all
>
> to show all the branches graphically, which is usually a great way  
> to get
> your bearings. Keep the gitk window open in the background as a  
> reference.
>
> After that, do
>
> 	git log -g
>
> wher the "-g" (or "--walk-reflogs" for the long version) just means  
> that
> instead of looking through history as a chain of commits and their
> parents, you look through not the chain of commits, but as the chain  
> of
> reflog entries (which are basically about how the HEAD has changed  
> due to
> the commands you have done).
>
> In all of that info, look for the place you want to go back to, and  
> just
> start all over from there. You can either re-use one of your old  
> branches
> and just start over from some state that you want:
>
> 	git checkout <branch>
> 	git reset --hard <startingpoint>
>
> or you can decide that you want to start a new branch to fix up the  
> mess
>
> 	git checkout -b <newbranch> <startingpoint>
>
> and only when it's all fixed up and you're happy will you change any  
> of
> your old branches.

I'm still not sure how to fixed it up and keep the merge results  
though. Just work on the tree (middle-of-rebase, which is actually the  
end of rebase, when it blowed up) until it's good and reset --hard my  
branch to it?

> But it may well be that "git rebase --abort" and re-doing everything  
> is
> the least confusing option.


git rebase --abort, I think, would actually blow away my last commit  
(I sneaked in) though. git reset --hard to that last commit is  
probably the right thing to do. The least confusing option would be to  
update the error message to be a bit more informative, like "Did you  
change the branch while rebasing? git reset --hard to your last known  
commit and redo the rebase". Yet another safeguard would be for git  
commit to check if there is a rebase in progress and warn or abort the  
commit.

Anyway, thanks for the informative reply. I have more confidence in  
git due to this accident :)

__Luke
