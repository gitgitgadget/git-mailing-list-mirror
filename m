From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 22:16:39 +0200
Message-ID: <20080911201639.GF1451@cuci.nl>
References: <20080909235848.GE7459@cuci.nl> <alpine.LFD.1.10.0809091722010.3384@nehalem.linux-foundation.org> <20080910054244.GB15715@cuci.nl> <alpine.LFD.1.10.0809100828360.3384@nehalem.linux-foundation.org> <20080910230906.GD22739@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <alpine.LFD.1.10.0809110835070.3384@nehalem.linux-foundation.org> <48C940C8.6040407@gnu.org> <alpine.LFD.1.10.0809110910430.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 11 22:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdsbs-0007Mj-A4
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 22:17:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbYIKUQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 16:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752359AbYIKUQl
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 16:16:41 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:49873 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbYIKUQl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 16:16:41 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 8AEBC5465; Thu, 11 Sep 2008 22:16:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0809110910430.3384@nehalem.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95639>

Linus Torvalds wrote:
>But my point is, _none_ of what Stephen proposes has _any_ advantage over 
>the already existing functionality.

I think you're missing some of the advantages because you don't have a
lot of experience with cherry-pick workflows between multiple permanent
branches.

>IOW, absolutely *everything* is actually done better with existing data 
>structures, and then just adding tools to perhaps follow those SHA1's in 
>the commit message.

The best way to explain the difference is probably by implementing the
free-form support, so I think I'll do that.

>For example, the claim was that it's hard to follow the chain of 
>cherry-picks. That's not _true_. Use gitweb and gitk, and you can already 
>see them. Sure, you need to use "-x", BUT YOU'D HAVE TO USE THAT WITH 
>Steven's MODEL TOO!

The existing cherry-pick -x option doesn't cut it, it helps for the
simple cases, yes, but there are cherry-pick situations where it just
adds to the confusion.

>Exactly because it would be a frigging _disaster_ if that "origin" field 
>was done by default.

That never was the intention, and never will be happening.

>And the only thing that "origin" does is:

> - hide the information

Only if you want to hide it, you control if it does, this point is moot.

> - make it easier to make mistakes (either enable the feature by default, 
>   or not notice that you didn't enable it when you wanted to)

The same holds for -x, so this point is moot as well.

> - add a requirement for a backwards-incompatible field that is just 
>   guaranteed to confuse any old git binaries.

This is a problem, I admit, but maybe this can be solved in the future.
Then again, since use of the feature is a *very* conscious decision, anyone
using the feature can advise their users to use git version xxx at least.

> - make it _harder_ to do things like send revert/cherry-pick information 
>   by email.

Not necessarily, adding an Origin field in the patch sent by mail is
easy.  I don't see how it would be more difficult otherwise.  Please
explain.

>See? There are only downsides.

I think I just neutralised all but one of the mentioned downsides, and
the backward compatibility issue is at least mitigated.

>and then go to its parent commit (just click on the parent SHA). And 
>notice how the stable kernel tree commits talk about where they were 
>back-ported from, or _why_ they aren't back-ports at all!

And this is impossible when using the origin link?  The usage with an
origin link would be just as flexible, even more so.

>IOW, there are really two main cases:

> - the common case for cherry-picking: you do not want any origin 
>   information, because it's irrelevant, pointless, and *wrong*.

Quite, and my proposal is not generating those anyway.

> - you _do_ want origin information, but you actually want to _explain_ 
>   explicitly why it's not irrelevant, pointless, or wrong.

>And yes, the latter case is about a lot more than "this was 
>cherry-picked". It's about "this fixes that other commit we did", or it's 
>about "this was anti-cherry-picked - ie reverted". They are all "origins" 
>for the commit in the sense that they are relevant to the commit, but they 
>all need some explanation of what _kind_ of origins they are.

Yes, and that *extra* information can and should go into the free-form
commit message, alongside of the origin field inside the header (or
trailer), just edit the commit message before committing after a
cherry-pick -o.  What's your point?
-- 
Sincerely,
           Stephen R. van den Berg.
"There are three types of people in the world;
 those who can count, and those who can't."
