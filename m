From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [FIXED PATCH] Make rebase save ORIG_HEAD if changing current branch
Date: Mon, 7 Jul 2008 01:16:06 -0400
Message-ID: <803A3528-2451-4C5D-A48D-5E0C37B8E90E@silverinsanity.com>
References: <1215379370-34265-1-git-send-email-benji@silverinsanity.com> <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 07:17:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFj6F-0003Tn-G1
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 07:17:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbYGGFQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 01:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbYGGFQK
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 01:16:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35507 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750922AbYGGFQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 01:16:09 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 4388D1FFC023;
	Mon,  7 Jul 2008 05:15:56 +0000 (UTC)
In-Reply-To: <7v7iby9ucx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87576>


On Jul 7, 2008, at 12:43 AM, Junio C Hamano wrote:

> Having said that, thanks to updates to git-rebase,  
> rebased_branch@{1} has
> useful information these days, so I do not see much practical  
> upside, even
> though I _will_ apply this patch, just for the sake of consistency.

I've been running rebase a lot over the last few days, and my  
impression was that git-rebase adds an entry to ther eflog for each  
patch it runs over.  While this has its uses, it makes HEAD@{1} not  
terribly useful after a "pull --rebase".  Of course, it took me three  
tries to get a one-line patch out this weekend, so my judgement is  
obviously not that great at the moment.

I do appreciate that you'll apply it though.  As useful as I find  
rebasing pull useful, I dislike maintaining patches on top of git.  It  
tends to lead to something breaking when I don't have time to fix  
it.  ;-)

> We would make it _appear_ rebase and merge are interchangeable even  
> more.
> But the thing is, I am not convinced if promoting that appearance is
> necessarily a good thing.

I don't really think promoting it is a good idea, actually.  I do,  
however, think that having ORIG_HEAD set intelligently after a pull  
is.  I nearly added setting ORIG_HEAD to pull, but didn't think that  
removing it from merge or setting it twice was a good plan.

Besides, I've done the wrong rebase more than once and having the  
quick recovery is excellent.  (Reflogs are great, but when the commit  
messages are identical it becomes a little difficult to figure out  
which one to use.)

> But you cannot say the same thing with "gitk ORIG_HEAD..", for  
> example.
> The meaning of the topology and commits you would see would be quite
> different.  For rebase you will see your own commits that are carried
> forward, and for merge you won't.  Besides this example, there  
> probably
> are many fundamental differences between rebase and merge, and  
> trying to
> give a false impression that they are interchangeable may not add much
> value to the end user experience, and it could even be harmful from
> educational point of view.

However, the rebased patches may have changed in subtle ways, so  
having them appear in gitk is a good thing.  If I was trying to teach  
someone git, I'd compare the rebased commits to the merge commit.   
They both give information on how any conflicts were resolved  
(although the information is more subtle with rebase).

My final thought is that the rational ORIG_HEAD and when we set it is  
not clearly documented anywhere.  But I am currently out of time to  
work on git, so that patch won't be coming from me soon.

~~ Brian
