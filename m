From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Deleting files
Date: Thu, 12 Jun 2008 22:44:19 +0200
Message-ID: <20080612204419.GA22787@steel.home>
References: <g2r19e$s6e$1@ger.gmane.org> <g2r1sb$tut$1@ger.gmane.org> <g2r36d$2ju$1@ger.gmane.org> <477B22F6-9F24-4CBE-98EE-58EF697E6320@ai.rug.nl> <g2r4ha$74i$1@ger.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shak <sshaikh@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tfa-00014e-Hy
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbYFLUoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754761AbYFLUoW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:44:22 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:58121 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbYFLUoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:44:22 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg20lf50S7
Received: from tigra.home (Fab42.f.strato-dslnet.de [195.4.171.66])
	by post.webmailer.de (mrclete mo7) (RZmta 16.42)
	with ESMTP id 605a65k5CJPvqZ ; Thu, 12 Jun 2008 22:44:19 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 9182F277BD;
	Thu, 12 Jun 2008 22:44:19 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7F25656D28; Thu, 12 Jun 2008 22:44:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g2r4ha$74i$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84791>

Shak, Thu, Jun 12, 2008 14:23:53 +0200:
> "Pieter de Bie" <pdebie@ai.rug.nl> wrote in message  
> news:477B22F6-9F24-4CBE-98EE-58EF697E6320@ai.rug.nl...
>>
>> In short, the point is that you never commited the deletions! Your  
>> whole history
>> until now will still show those deleted files. You can commit the  
>> actually deletions
>> now, as you should have done before (either by using "git rm <file>",  
>> "git add -u",
>> "git commit -a" or "git commit <file>".
>>
>
> Thanks for the quick workflow. To fill in a gap in my OP, I was using 
> "git add ." to add new files before a "commit". Since I (perhaps 
> incorrectly) took "commit -a" as a short cut for these two commands, I 
> assumed that "git add ." would also commit deletions.

"git add" just adds, unless told to update (with -u). And "git commit -a"
just updates and commits. Updates include forgetting removed files,
but not adding new (thats on purpose: too many of us have random files
in our working trees).

> So sticking to my previous workflow (I need to do this since "commit -a" 
> as I understand it doesn't commit new files, and I often forget that I've 
> added :)), it seems I should do the following to keep the working 
> directory in sync with the repository:
>
> git add .

this will add everthing which isn't ignored (in .git/info/exclude or
.gitignore's). Are you sure you want that generated and backup files
in your history? Maybe your workflow could use "git add new-file-1
new-file-2..."?

> git add -u
> git commit
>
> Is that right? Should the two add commands be called in that order or  
> doesn't it matter?

either "git add . && git commit -a" or "git add . && git add -u && git
commit".

> I ask because I'm still concerned with how git assumed I had renamed 
> files after I had "git rm"d them. As far as I could tell they were not 
> very alike. Perhaps adding the new files before removing the old ones 
> would stop this behavior?

Why should you care? They seem to be similar enough, but besides the
listing, there is nothing which relates them in the git structures.
Happens often for small files.

Just adopt "git commit -a" and ignore that.
