From: Junio C Hamano <junkio@cox.net>
Subject: Re: Live Merging from remote repositories
Date: Thu, 14 Apr 2005 16:22:39 -0700
Message-ID: <7vfyxtose8.fsf@assigned-by-dhcp.cox.net>
References: <IGEMLBGAECDFPIKMIMLCCEELCHAA.barry@disus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Petr Baudis" <pasky@ucw.cz>, "Junio C Hamano" <junkio@cox.net>,
	"Linus Torvalds" <torvalds@osdl.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 15 01:19:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMDcY-0005zz-O9
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 01:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbVDNXW7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 19:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDNXW7
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 19:22:59 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32454 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261647AbVDNXWm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 19:22:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050414232239.DEJP22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Apr 2005 19:22:39 -0400
To: "Barry Silverman" <barry@disus.com>
In-Reply-To: <IGEMLBGAECDFPIKMIMLCCEELCHAA.barry@disus.com> (Barry
 Silverman's message of "Thu, 14 Apr 2005 16:01:32 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "BS" == Barry Silverman <barry@disus.com> writes:

I have not thought about remote issues at all, other than the
distribution mechanism vaguely outlined in my previous mail (not
cc'ed to git list but I would not mind if you reproduced it here
if somebody asked), so I am not qualified to comment on that
part of your message.

BS> The way Junio has done it, no intermediate trees or commits
BS> are used...

BS> Is this a bug or a feature?

I would call that a feature in that there is no need to look at
intermediate state.  I also might call that a misfeature in that
it may have resulted in a better merge if it looked at
intermediate state.

I just have this fuzzy feeling that, when doing this merge:

                     A-1 --- A-2 --- A-3
                    /                   \ 
    Common Ancestor                      Merge Result
                    \                   /
                     B-1 --- B-2 --- B-3

looking at diff(Common Ancestor, A-1), diff(Common Ancestor,
B-1), diff(A-1, A-2), ... might give you richer context than
just merging 3-way using Common Ancestor, A-3, and B-3 to derive
the Merge Result.  It might not.  I honestly do not know.

BTW, Pasky, the above paragraph is my answer to your question in
the other message <20050414202016.GC22699@pasky.ji.cz>:

> But one different thing to note here.
> 
> You say "merge these two trees" above (I take it that you mean
> "merge these two trees, taking account of this tree as their
> common ancestor", so actually you are dealing with three trees),
> and I am tending to agree with the notion of merging trees not
> commits.  However you might get richer context and more sensible
> resulting merge if you say "merge these two commits".  Since
> commit chaining is part of the fundamental git object model you
> may as well use it.

Pasky> Could you be more particular on the richer context etc?

