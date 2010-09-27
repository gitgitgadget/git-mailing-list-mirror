From: Nick <oinksocket@letterboxes.org>
Subject: Re: git push on tracking branches
Date: Mon, 27 Sep 2010 18:16:40 +0100
Message-ID: <4CA0D178.6070704@letterboxes.org>
References: <6958088.371432.1285602164529.JavaMail.root@mail.hq.genarts.com> <15793457.371451.1285603241207.JavaMail.root@mail.hq.genarts.com> <20100927160548.GA10256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Bash <bash@genarts.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 27 19:17:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0HKG-0005sN-9M
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 19:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759881Ab0I0RQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 13:16:49 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:45378 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759866Ab0I0RQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 13:16:49 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.102])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <oinksocket@letterboxes.org>)
	id 1P0HJl-0004nr-IR; Mon, 27 Sep 2010 18:16:45 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.12) Gecko/20100826 Lightning/1.0b1 Thunderbird/3.0.7
In-Reply-To: <20100927160548.GA10256@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157356>

On 27/09/10 17:05, Jeff King wrote:
> On Mon, Sep 27, 2010 at 12:00:41PM -0400, Stephen Bash wrote:
> 
>> A coworker alerted me to some strange behavior with git push on tracking branches (maybe a documentation error?).  Pro Git (http://progit.org/book/ch3-5.html) says:
>>
>> "To set up a local branch with a different name than the remote branch, you can easily use the first version with a different local branch name:
>>    $ git checkout -b sf origin/serverfix
>>    Branch sf set up to track remote branch refs/remotes/origin/serverfix.
>>    Switched to a new branch "sf"
>> Now, your local branch sf will automatically push to and pull from origin/serverfix."
> 
> That has never been the case by default. Push has always defaulted to
> pushing all matching branches (so of course if you use the same name, it
> will end up pushing to the tracking branch).  However, you can do:
> 
>   git config --global push.default tracking
> 
> to explicitly change the default to push the current branch to its
> upstream. See the entry for "push.default" in "git help config".

The "tracking" setting does seem more sensible and intuitive, given that current
git practice requires setting up explicit tracking relationships between branches.

For example, I find it surprising, perhaps even alarming, that by default, git
will try and push my changes on branch A to the branch origin/A - even if I
created it to track origin/B.  Why allow the possibility of A tracking a
non-matching branch origin/B, and have the default push setting ignore that?

Not only that, but I frequently get asked by puzzled colleagues, new to git, why
"git push" seems to fail all the time when they're pushing their changes.  (The
errors arise because of the default "matching" setting: many of the matching
branches fail to push cleanly because the remote branch has silently changed. My
latest answer is to tell them to set push.default to "tracking", or to do that
for them.)


I'm curious: why isn't "tracking" the default and recommended option?
"Historical reasons" might explain the first, but not the second.


- Nick
