From: david@lang.hm
Subject: Re: unable to push
Date: Sun, 1 Jun 2008 11:28:39 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0806011125340.15294@asgard.lang.hm>
References: <alpine.DEB.1.10.0805310759540.15294@asgard.lang.hm> <20080531155036.GA27397@sigill.intra.peff.net> <alpine.DEB.1.10.0805310855000.15294@asgard.lang.hm> <20080601182205.GA742@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 01 20:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2sJ1-0005AE-IP
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 20:29:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYFAS2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 14:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbYFAS2b
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 14:28:31 -0400
Received: from mail.lang.hm ([64.81.33.126]:45179 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbYFAS2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 14:28:31 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m51ISM5m032677;
	Sun, 1 Jun 2008 11:28:22 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <20080601182205.GA742@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83459>

On Sun, 1 Jun 2008, Jeff King wrote:

> On Sat, May 31, 2008 at 09:10:26AM -0700, david@lang.hm wrote:
>
>> I created localmaster in an attempt to get things working again. I'll try
>> creating a new master branch... that does make it work again, thanks.
>>
>> what I'm not understanding completely is how I broke things in the first
>> place.
>
> I'm not understanding that, either. You not only created localmaster,
> but you deleted master. Did you maybe do a "git branch -m"?

in the public repo I had never created a 'master' branch. I had just done 
a clone, setup git daemon, and pushed to it.

at some point several days later I found that my push didn't work and that 
I wasn't on any branch in the public repo. in reading the man page for git 
branch I saw the --track option, so I created the localmaster branch to 
try and get things working.

>> going back through .git/logs/HEAD it looks like I did a checkout HEAD^^^
>> and never properly recovered. should I have done a checkout master to get
>> things back on track? I had thought that I could do a checkout of an old
>> version, modify it, do a commit, and the commit would go on top of the old
>> HEAD and I could just keep going (the reason for doing this instead of a
>> reset is that I had already published the intermediate commits to the
>> public repo, so I didn't want to roll back the history, just get the old
>> version of one of the files)
>
> I think you did eventually "recover" which is to say you ended up on the
> localmaster branch. When you did a checkout of HEAD^^^, your HEAD became
> "detached", meaning that you were no longer on any branch, but at a
> specific commit (and there should have been a warning message mentioning
> that).
>
> When you make commits on a detached HEAD, your HEAD remains detached,
> meaning that those commits are not on any branch. So when you did a
> checkout back to some actual branch, those commits were "lost" (meaning
> that no branch contains them, but they are still available by peeking
> through the reflog).
>
> But that shouldn't have had anything to do with the state of the master
> branch; once you detached, you were purely operating on the detached
> HEAD.

that explains things.

David Lang
