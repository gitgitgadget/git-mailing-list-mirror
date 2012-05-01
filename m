From: Rich Pixley <rich.pixley@palm.com>
Subject: Re: Newbie grief
Date: Mon, 30 Apr 2012 18:15:05 -0700
Message-ID: <4F9F3919.6060805@palm.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Tue May 01 03:15:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP1h2-0006g8-K4
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 03:15:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757489Ab2EABPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 21:15:17 -0400
Received: from smtp-relay2.palm.com ([64.28.152.243]:64666 "EHLO
	smtp-relay2.palm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab2EABPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 21:15:16 -0400
X-IronPort-AV: E=Sophos;i="4.75,508,1330934400"; 
   d="scan'208";a="13229499"
Received: from unknown (HELO ushqusdns4.palm.com) ([148.92.223.164])
  by smtp-relay2.palm.com with ESMTP; 30 Apr 2012 18:15:06 -0700
Received: from fuji.noir.com ([10.100.2.13])
	by ushqusdns4.palm.com (8.14.4/8.14.4) with ESMTP id q411F5xk012174;
	Mon, 30 Apr 2012 18:15:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <201204302331.q3UNVo7o032303@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196641>

Thank you for the info and the help.  Just one argument...

On 4/30/12 16:31 , Seth Robertson wrote:
>      It seems that git is allergic to the dual head branch solution or
>      something, which is surprising and disappointing.
>
> Git tracks your version of master separately from each other remote's
> master.  This is exactly dual/multiple heads.

No, it isn't at all.

Multiple heads are the idea that a single commit can "branch" in the 
repository and that both commits can be HEADS of the same branch at once 
in a single repository.  This allows a potential collision to exist in 
the repository and to be pushed and pulled through multiple 
repositories.  It also largely eliminates this entire discussion since 
each of the intermediate repositories between, say, you and I can carry 
the collision.  Either you or I, at will, can merge these heads just 
like we'd merge any other two commits, push/fetch, etc.

That would seem to be the obvious and intuitive behavior, rather than 
arbitrarily preventing the transfer.

 >  What git *does* forbid
> (by default) is:
>
> 1: Letting you update someone else's checked out (non-bare) repository
> underneath them

Yeah.  That "underneath them" thing is confusing.  I don't see any 
reason why that should necessarily be so.

Git knows what commit is checked out.  That's HEAD, yes?  So what's 
wrong with letting it collect other commits from other repositories 
while your working directory sits?  You can always commit your change 
right on top of what's checked out, creating a second head for that branch.

Yes, I've read that git-diff, etc, are all making assumptions that fail 
in this case, but there's nothing significantly different about 
collecting commits to other branches and collecting commits to the 
branch you're currently checked out from.  Either way, you're going to 
need to merge those into your working directory before committing your 
current changes will make much semantic sense.  And if you don't want to 
do that, you can always commit them directly onto HEAD, and thereby 
create a new branch, at least temporarily.  That's one of the huge 
advantages of the daggy architecture.

> 2: Letting you update someone else's repository if they have more
> recent changes than you do.

Again, if they have more recent changes, then my line of changes should 
create a fresh HEAD on that branch.  Then the repositories hold all of 
our changes to be merged at our leisure.

 From a UI perspective, that request has a valid, and relatively obvious 
semantic.  That git simply refuses to do anything except produce a 
cryptic error message seems... well, sad.

> Both of these defaults are really good ideas, but you can disable them
> if you think you know better.

I know better for source code control systems that support the multiple 
HEAD concept.  I don't know better for git.  So far, it looks to me as 
though git is just plain failing here.

I thank you for your suggestions.  It'll take me a few readings before I 
follow them all.  Regardless of how I think git _should_ behave, I'll 
still need to figure something, so thank you.

--rich
