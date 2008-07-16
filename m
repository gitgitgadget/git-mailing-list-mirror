From: Theodore Tso <tytso@mit.edu>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 18:32:05 -0400
Message-ID: <20080716223205.GK2167@mit.edu>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com> <7v7iblsnfh.fsf@gitster.siamese.dyndns.org> <32541b130807161151x19c20f9t91b7fb9b8c7b8c7b@mail.gmail.com> <7vmykhr6h1.fsf@gitster.siamese.dyndns.org> <32541b130807161229ob4c21cbsc6c86ee3e42c4101@mail.gmail.com> <7vabghr5br.fsf@gitster.siamese.dyndns.org> <32541b130807161246l579d3a5em65496ee9119ef1ef@mail.gmail.com> <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 00:33:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJFYc-0000w6-G2
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 00:33:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbYGPWcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 18:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752121AbYGPWcL
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 18:32:11 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:42561 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751472AbYGPWcK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 18:32:10 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KJFXa-0005Oy-7b; Wed, 16 Jul 2008 18:32:06 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KJFXZ-000509-E2; Wed, 16 Jul 2008 18:32:05 -0400
Content-Disposition: inline
In-Reply-To: <7vr69tpoze.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88774>

On Wed, Jul 16, 2008 at 01:12:53PM -0700, Junio C Hamano wrote:
> If you are advocating that mode of operation to be easy in git, you should
> think again.  That pull (be it with or without --rebase) can conflict and
> you would need to resolve it, and then your "stash pop" can conflict
> again.  You can have your own "git avery-up" alias which is your "svn up"
> equivalent, but if you train users with that first, the users have to
> learn how to cope with conflicts in individual steps anyway.
> 
> Making these three into a single alias is not an improvement either.  If
> you are not ready to incorporate other's changes to your history, why are
> you pulling?  Being distributed gives the power of working independently
> and at your own pace.  You should train your brain to think about the
> workflow first.  "You should stash before pull" is _not_ a good advice.
> "Do not pull when you are not ready" is.

What I've found is that some people will take that advice, and other
people won't.  Saying that you are thinking about things the wrong way
doesn't really help for people who have been so ingrained into an old
way of doing things.  Indeed, it can end up sounding very elistist.

So from a pedagogical perspective, what I would probably do is show
them how to replicate svn-up, and explain to them how this script
works:

#!/bin/sh
# git-up

if git diff --quiet && git diff --quiet --cached ; then
	git pull $*
else
	git stash ; git pull $*; git stash pop
fi

And then tell them that if this put this into their path, then "git
up" will work the same way as "svn up" --- but that git has a better
way of doing things, and why it is so.  And then what I would tell
them is that no really, merges are really easy with git, and that even
if they were to rely on the "git up" alias as a crutch, that over time
they would find that there are much more natural, easy, and powerful
ways of doing things.

In general, I find that people are more willing to listen to "we have
a more powerful way of doing things", if you can first give them the
equivalent of the "dumb and stupid" way that they are used to doing
things so they can switch to the new tool right away without too much
of a steep learning curve; they will then switch to the more
advanced/powerful workflows at their own pace.  Other people may have
other pedgogical techniques, but I find mine to work fairly well.

Regards,

						- Ted
