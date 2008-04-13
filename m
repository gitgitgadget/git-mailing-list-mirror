From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Friendly refspecs
Date: Sun, 13 Apr 2008 12:31:02 +0300
Message-ID: <20080413093102.GC12107@mithlond.arda.local>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 11:32:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkyZD-0006s8-Vu
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 11:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbYDMJbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 05:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbYDMJbI
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 05:31:08 -0400
Received: from pne-smtpout3-sn1.fre.skanova.net ([81.228.11.120]:42336 "EHLO
	pne-smtpout3-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478AbYDMJbH (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Apr 2008 05:31:07 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout3-sn1.fre.skanova.net (7.3.129)
        id 47A78857003DECCC for git@vger.kernel.org; Sun, 13 Apr 2008 11:31:04 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JkyYA-0003KC-P0
	for git@vger.kernel.org; Sun, 13 Apr 2008 12:31:02 +0300
Content-Disposition: inline
In-Reply-To: <20080409225112.GB12103@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79399>

Jeff King wrote (2008-04-09 18:51 -0400):

> On Thu, Apr 10, 2008 at 01:25:00AM +0300, Teemu Likonen wrote:
> 
> > Another thing I spoke of was this refs/ stuff. I know my way around
> > with them now, so maybe they are not actually confusing to me
> > anymore. It's just that I have noticed a pattern: I always use
> > refs/heads/... in certain places and refs/remotes/ in certain
> > places. If such a pattern is very common (well, I don't know if it
> > is) one starts to think that maybe the pattern can/should be hidden
> > and made part of the tool. Just thoughts.
> 
> I almost never use refs/remotes/ or refs/heads/. Some effort has been
> put into doing the right thing with partial refnames (which you can of
> course override by being more specific). Do you have specific examples
> of where you use the full refname? I suspect it is either not required
> (and documentation may be out of date), or it is a bug we could fix.
> :)

In real work I have used refs/heads/...:refs/remotes/... only once or
maybe twice (I just quite recently started using Git). But when
I studied Git and the workflows it supports I tried all kinds of
fetching, pulling and pushing, back and forth, between test repos. There
I used refs/ paths a lot, almost all the time actually. At first it was
very much just trying to see how they work and this is where I found
this common pattern: local refs start with refs/heads/ and remote
tracking ones with refs/remotes/ . Thoughts like "why not simplify them,
like L: for local and R: for remote" (or something) started to develop.

Now it seems that I have been too much attached to the full refspec
form. My guide have been the config remote.<name>.fetch as "git remote
add" adds those long refspecs. Now I learnt that almost all refspecs can
be written as "branch:another" or "branch:remotes/another" for example.
So the "friendly refspecs" are pretty much already there! Well, I've
been stupid. :)

(I understand that in real work when constantly dealing with same remote
repos one just adds a remote config and can forget about URLs and
probably most of the refspecs too.)

Ok, this was partly an RTFM error but even after reading man pages of
fetch, pull and push it isn't quite clear how to use these short and
nice and friendly refspecs. I thought about it and decided to add some
more examples to fetch manual (see my patch in the next message). My
English may not be manual-writing quality but I wanted to do something
useful anyway. Somebody needs to proof read my text though. Of course
there may be some inaccuracies too. Anyway, I think that concrete
examples in manuals help people to understand Git better.

There is still one thing (at least) that I don't quite understand. It's
about "git push". When I do

  $ git push <remote> <branch>

the refs/heads/<branch> is updated or created on the remote side. But if
I do

  $ git push <remote> <branch1>:<branch2>

the refs/heads/<branch2> is not automatically created. Why there is need
to say "<branch1>:refs/heads/<branch2>" to make it work if <branch2>
does not exist? The 'git push' manual says something vague about branch
not matching (?). What does it mean?
