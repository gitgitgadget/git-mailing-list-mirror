From: Brendan Cully <brendan@kublai.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 11:55:05 -0800
Message-ID: <20070202195504.GC7963@ventoux.cs.ubc.ca>
References: <200702010058.43431.jnareb@gmail.com>
	<20070201003429.GQ10108@waste.org>
	<200702021055.49428.jnareb@gmail.com>
	<slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
	<epvnln$fmn$1@sea.gmane.org>
	<Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
	<20070202175923.GA6304@xanadu.kublai.com>
	<Pine.LNX.4.64.0702021027450.15057@woody.linux-foundation.org>
	<20070202192640.GA7963@ventoux.cs.ubc.ca>
	<Pine.LNX.4.64.0702021130020.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:55:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD4VB-00051z-GO
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946037AbXBBTzI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423204AbXBBTzI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:55:08 -0500
Received: from zakopane.cs.ubc.ca ([198.162.52.68]:59437 "EHLO
	mail.quuxuum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423199AbXBBTzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:55:06 -0500
Received: from zakopane.cs.ubc.ca (localhost.localdomain [127.0.0.1])
	by mail.quuxuum.com (Postfix) with ESMTP id 072435C407
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:55:06 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed; d=kublai.com; h=received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:x-delivery-agent:from:mail-followup-to; q=dns; s=dk; bh=GoJHkjMp0ONNJwGQMkP0WDupNGg=; b=Rtg1lNZBWpFLUXLgfWsgJy680QwTf1HwLkudo8QfRxjuGm5aJWMvvptJaKuo5DNJvW8dF8IjQc2MjF3UVFr1MHIhQxRGDoCuO3C+EExNaOTF7LCFpPbuchWWUbOYBVQAr/HUgi7Diw0sQ+GabKm66ccaWSxLri7dc57nzJRwNZs=
Received: by zakopane.cs.ubc.ca (tmda-sendmail, from uid 103);
	Fri, 02 Feb 2007 11:55:05 -0800 (PST)
Received: from ventoux.cs.ubc.ca (ventoux.cs.ubc.ca [198.162.52.72])
	by mail.quuxuum.com (Postfix) with ESMTP id 463C95C1EC;
	Fri,  2 Feb 2007 11:55:05 -0800 (PST)
Received: by ventoux.cs.ubc.ca (Postfix, from userid 3121)
	id 10C69340B5; Fri,  2 Feb 2007 11:55:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702021130020.15057@woody.linux-foundation.org>
X-Operating-System: Linux 2.6.17-10-generic i686
User-Agent: Mutt/1.5.13 (2006-11-21)
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
Mail-Followup-To: torvalds@linux-foundation.org, jnareb@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38531>

On Friday, 02 February 2007 at 11:42, Linus Torvalds wrote:
> 
> 
> On Fri, 2 Feb 2007, Brendan Cully wrote:
> > 
> > I don't think I do, no. (Maybe it's the double negative construction.)
> > Local tags don't get pushed. Tags on private branches don't get
> > pushed. Tags on public branches do. This business you describe, where
> > you push tags around completely separate from the revisions they tag,
> > sounds a little odd. But nothing stops you from maintaining your local
> > tags in their own repository, if that's what makes you happy.
> > 
> > > In other words, tags are just like branches. You don't tie two tags 
> > > together, because one may (and does) make sense without the other.
> > 
> > Which tags are being tied together?
> 
> If you tie "tag" together with "history", and push out history, what 
> happens?

The public tags on the public history get pushed. This still sounds to
me like the right thing.

> > It seems to me they clearly do have history.
> 
> No they don't. Quite often, tags are generated outside of history, ie you 
> tag something as being "known bad" long after it was done. Or you 
> (hopefully) tag it with the test-information after it passed (or 
> didn't) pass some debug check. Neither of which is something you'd do when 
> the thing is actually committed or developed.
>
> So tags are *events*. But if you think they are events "within" the 
> history of a tree, you're missing a big issue.

Your distinction between "history" and "events" is unclear to
me. What's history if not a series of events?

Just because a tag is created at a different time than the revision it
tags, that doesn't mean that it is ahistorical. It's still interesting
to know what the state of the repository was when the tag was
created.

> My personal use of tags tends to be
>  - I tag releases I make, and sign them etc.
>  - when debugging (and using "git bisect" in particular), I tag things for 
>    my own memory (ie if a bisection selected something that didn't 
>    compile, and I have to pick another point by hand, I tag that bad one 
>    temporarily for explanation - the tag shows up nicely in the graphical 
>    history viewers)

Mercurial supports local tags too. As far as I can tell, these
unversioned tags are about equivalent to git tags. They could
certainly be used for your bisection scenario.

> I want tags to be useful for *anybody*. A total non-developer, who decides 
> that he wants to test a release, should be able to tag the particular 
> versions he happened to test, and it damn well shouldn't be just 
> "my-tag-1023". It should allow him to write a small story about what the 
> results of the tests were!
> 
> Which is how git tags are desiged. They're separate from history, but that 
> doesn't make them less useful - it makes them *more* widely useful.

Mercurial supports both, because both are useful.
