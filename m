From: david@lang.hm
Subject: Re: Untracked working tree files
Date: Wed, 15 Oct 2008 12:42:25 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810151240220.7808@asgard.lang.hm>
References: <20081015115654.fb34438f.akpm@linux-foundation.org> <alpine.DEB.1.10.0810151208100.7808@asgard.lang.hm> <alpine.DEB.1.10.0810151211580.7808@asgard.lang.hm> <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:43:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqCHA-00069f-0T
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 21:43:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbYJOTmF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 15:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbYJOTmE
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 15:42:04 -0400
Received: from mail.lang.hm ([64.81.33.126]:57392 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbYJOTmD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 15:42:03 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9FJfd4B005499;
	Wed, 15 Oct 2008 12:41:39 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <alpine.LFD.2.00.0810151219120.3288@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98310>

On Wed, 15 Oct 2008, Linus Torvalds wrote:

> On Wed, 15 Oct 2008, david@lang.hm wrote:
>>
>> the fact that git will happily leave modified things in the working directory
>> appears to be very helpful for some developers, but it's also a big land mine
>> for others.
>
> Hmm. It doesn't actually do that normally. If you switch between trees,
> git will (or _should_) remove the old files that it knows about. If you
> get a lot of left-over turds, there's something wrong.
>
> It could be a git bug, of course. That said, especially considering the
> source of this, I wonder if it's just that Andrew ends up using all those
> non-git scripts on top of a git tree, and then that can result in git
> *not* knowing about a certain file, and then when switching between trees
> (with either git checkout or with git reset), the data that was created
> with non-git tools gets left behind and now git will be afraid to
> overwrite it.
>
> So yes, there are ways to force it (both "git checkout -f"  and "git reset
> --hard" having already been mentioned), but the need for that - especially
> if it's common - is a bit discouraging.
>
> Especially since it's still possible that it's some particular mode of git
> usage that leaves those things around. Andrew - have you any clue what it
> is that triggers the behavior?

I see it fairly frequently when switching between different branches of a 
project.

I also see it when I try applying a patch to a tree, then want to get up 
to date with that tree (in this case it really is different)

It could be that git is looking to see if the file is the same as the old 
tree had it before checking out the new tree. if it isn't for any reason 
it sounds the alert.

David Lang

> (By the filename, I realize it's a file that doesn't exist in one tree or
> the other, and which doesn't get removed at some point. But have you had
> merge failures, for example? Is it perhaps a file that was created during
> a non-clean merge, and then got left behind due to the merge being
> aborted? It would be interesting to know what led up to this..)
>
> 			Linus
>
