From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Updated git HOWTO for kernel hackers
Date: Thu, 23 Jun 2005 09:38:45 +0200
Message-ID: <20050623073845.GA5204@pasky.ji.cz>
References: <42B9FCAE.1000607@pobox.com> <Pine.LNX.4.58.0506221724140.11175@ppc970.osdl.org> <42BA14B8.2020609@pobox.com> <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org> <42BA1B68.9040505@pobox.com> <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org> <42BA271F.6080505@pobox.com> <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org> <42BA45B1.7060207@pobox.com> <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 23 09:39:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlMIr-0007dz-Eg
	for gcvg-git@gmane.org; Thu, 23 Jun 2005 09:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262559AbVFWHoV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 03:44:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVFWHoV
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 03:44:21 -0400
Received: from w241.dkm.cz ([62.24.88.241]:15017 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262574AbVFWHir (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jun 2005 03:38:47 -0400
Received: (qmail 7388 invoked by uid 2001); 23 Jun 2005 07:38:45 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jun 23, 2005 at 07:58:13AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Does it help when I scream?

Nope. I still think you are wrong. :-) (BTW, Cogito always fetches all
the tags now - but it's not that I would have a huge problem with
changing that to some better behaviour.)

> > Multiple users -- not just me -- would prefer that git-pull-script 
> > pulled the tags, too.
> 
> And multiple users -- clearly including you -- aren't listening to me. 
> Tags are separate from the source they tag, and they HAVE TO BE. There is 
> no "you automatically get the tags when you get the tree", because the two 
> don't have a 1:1 relationship.
> 
> And not making them separate breaks a lot of things. As mentioned, it
> fundamentally breaks the distributed nature, but that also means that it
> breaks whenever two people use the same name for a tag, for example. You
> can't "merge" tags. BK had a very strange form of merging, which was (I
> think) to pick the one last in the BK ChangeSet file, but that didn't make
> it "right". You just never noticed, because Linux could never use tags at
> all due to the lack of privacy, except for big releases..

I think there should simply be two namespaces - public tags and private
tags. Private tags for stuff like "broken", "merged", or "funnychange".
Other people don't care about those, and they certainly shouldn't get
them by default (but they should have a way to get them explicitly, if
you tell them). But then there are the official tags, like "v2.6.13" or
even "v2.6.12-ck2" - if you merge with those branches, you should always
get those precisely for what Jeff says - they are big syncing points for
a lot of people and you should be always able to refer to v2.6.13 if you
have the commit in your tree.

Since there should be _few_ of those tags, you might even want to get
tags only from branches marked "tagtrusted" (Cogito's origin branch
would be by default), or want to interactively confirm new tag additions
during a pull. Also, ideally there would be no or only extremely rare
tag conflicts.

I think it would be simplest to use a special prefix for the private
tags. ~ and ! might get touched by shell, so what about %?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
