From: Joel Dice <dicej@mailsnare.net>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 16:24:31 -0600 (MDT)
Message-ID: <Pine.LNX.4.62.0609191609090.9752@joeldicepc.ecovate.com>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com>
 <20060919211844.GB8259@pasky.or.cz> <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
 <20060919220011.GD8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:24:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPo16-0005mf-DL
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:24:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWISWYd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:24:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWISWYd
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:24:33 -0400
Received: from v187.mailsnare.net ([206.246.200.187]:7045 "EHLO
	mail.mailsnare.net") by vger.kernel.org with ESMTP id S1751238AbWISWYd
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:24:33 -0400
Received: from joeldicepc.ecovate.com (unknown [208.50.222.162])
	by mail.mailsnare.net (Postfix) with ESMTP id C52A62C07D;
	Tue, 19 Sep 2006 22:24:30 +0000 (UTC)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060919220011.GD8259@pasky.or.cz>
X-Virus-Scanned: by ClamAV at mailsnare.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27303>

On Wed, 20 Sep 2006, Petr Baudis wrote:

> Dear diary, on Tue, Sep 19, 2006 at 11:42:20PM CEST, I got a letter
> where Joel Dice <dicej@mailsnare.net> said that...
>> On Tue, 19 Sep 2006, Petr Baudis wrote:
>>> Also, multiple IRNs could refer to a single real commit if you do e.g.
>>> cg-admin-uncommit, since revlog logs revision updates, not new revisions
>>> created. This may or may not be considered a good thing. If you rather
>>> want to just create a new IRN at commit object creation time, also note
>>> that some tools _might_ validly create commit objects and then throw
>>> them away, which would generate non-sensical (and after prune, invalid)
>>> IRNs.
>>
>> I'm not too worried about cg-admin-uncommit or git-reset, since the IRN
>> feature is intended mainly for shared repositories.  I would suggest that
>> such commands simply be disallowed for such repositories.
>
>  What kind of shared repositories? You yourself said that IRNs are
> local to a repository, thus they are not preserved over cloning/fetching
> from a repository, if you mean that.

The scenario I envision is several developers, each with a clone of a 
shared repository.  The clones would not have IRNs turned on, only the 
shared repository.  So, when I do a "git push", I get an IRN back, and I 
am not confused, because I know that IRN only applies to the shared 
repository.  Then, when I mark a Bugzilla bug as fixed and attach the IRN 
to it, everybody knows that IRN refers to the shared repository.  After 
all, I wouldn't mark the bug fixed if I had only committed it to my own 
private repository.

I could also turn on IRNs on my clone if I really wanted, but not if I 
thought it would confuse myself or others.

>> The problem of temporary commits certainly needs to be addressed.  In this
>> case, may I assume nothing under $GIT_DIR/refs is ever modified?  If so,
>> perhaps I could somehow hook into the git-update-ref step.  Is that what
>> the revlog code does?
>
>  Yes. But not every commit is always recorded to something in refs/.
> The simplest case is if you fetch from a remote repository (or push to
> your repository), only the latest commit is recorded.

That's what I figured.  I should be able to walk the commit chain to get 
at all the commits in a push or fetch, right?

  - Joel
