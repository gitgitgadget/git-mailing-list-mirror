From: Brendan Cully <brendan@kublai.com>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 11:26:40 -0800
Message-ID: <20070202192640.GA7963@ventoux.cs.ubc.ca>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
	<200702010058.43431.jnareb@gmail.com>
	<20070201003429.GQ10108@waste.org>
	<200702021055.49428.jnareb@gmail.com>
	<slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
	<epvnln$fmn$1@sea.gmane.org>
	<Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
	<20070202175923.GA6304@xanadu.kublai.com>
	<Pine.LNX.4.64.0702021027450.15057@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, mercurial@selenic.com,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:27:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD43w-0000Bn-Tu
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:27:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423086AbXBBT1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423101AbXBBT1F
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:27:05 -0500
Received: from zakopane.cs.ubc.ca ([198.162.52.68]:60267 "EHLO
	mail.quuxuum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423086AbXBBT1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:27:04 -0500
Received: from zakopane.cs.ubc.ca (localhost.localdomain [127.0.0.1])
	by mail.quuxuum.com (Postfix) with ESMTP id 44D865C407
	for <git@vger.kernel.org>; Fri,  2 Feb 2007 11:26:42 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed; d=kublai.com; h=received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:x-operating-system:user-agent:x-delivery-agent:from:mail-followup-to; q=dns; s=dk; bh=klOxSx4Xj7ZHAqVnaxBuoMBn8Dg=; b=K5qYeVzgVHITClgkZr1aWXGUeK7nIbcDZqcKJ8vf8pMlI4WFeWWed4lJlOQSvyU1MG7fE02PTuTZ75zXbV5fy77u59tGU8YGeTQdpHdwCqK7zkeH0+ZiGRMJlWSC1LTlpXR5EkbQlUeSJ1RRIb54Yc8hQoxSQjp+Mu+BRbgau7s=
Received: by zakopane.cs.ubc.ca (tmda-sendmail, from uid 103);
	Fri, 02 Feb 2007 11:26:41 -0800 (PST)
Received: from ventoux.cs.ubc.ca (ventoux.cs.ubc.ca [198.162.52.72])
	by mail.quuxuum.com (Postfix) with ESMTP id 853885C1EC;
	Fri,  2 Feb 2007 11:26:41 -0800 (PST)
Received: by ventoux.cs.ubc.ca (Postfix, from userid 3121)
	id 0B9A0340B5; Fri,  2 Feb 2007 11:26:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702021027450.15057@woody.linux-foundation.org>
X-Operating-System: Linux 2.6.17-10-generic i686
User-Agent: Mutt/1.5.13 (2006-11-21)
X-Delivery-Agent: TMDA/1.0.3 (Seattle Slew)
Mail-Followup-To: torvalds@linux-foundation.org, jnareb@gmail.com,
	mercurial@selenic.com, git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38527>

On Friday, 02 February 2007 at 10:32, Linus Torvalds wrote:
> 
> 
> On Fri, 2 Feb 2007, Brendan Cully wrote:
> 
> > On Friday, 02 February 2007 at 08:42, Linus Torvalds wrote:
> > > 
> > > 
> > > On Fri, 2 Feb 2007, Jakub Narebski wrote:
> > > > 
> > > > Gaaah. Why anyone would want to have non-propagated tags?
> > > 
> > > That's *definitely* not the mistake.
> > > 
> > > I use private tags (and branches, for that matter) all the time. I'd be 
> > > very upset indeed if all my tags were always pushed out when I push 
> > > something out.
> > > 
> > > The mistake seems to be to think that tags get "versioned", and are part 
> > > of the tree history. That's insane. It means that you can never have a tag 
> > > to a newer tree than the one you are on.
> > 
> > The tags you use can simply be those from the tip of the repository,
> > regardless of which revision you've currently checked out.
> 
> Did you not understand the problem?
> 
> If I want to push out my history, that does NOT mean that I don't want to 
> push out my tags. At least not to the public sites. I migth want to push 
> them out to my other *private* copies, though.

I don't think I do, no. (Maybe it's the double negative construction.)
Local tags don't get pushed. Tags on private branches don't get
pushed. Tags on public branches do. This business you describe, where
you push tags around completely separate from the revisions they tag,
sounds a little odd. But nothing stops you from maintaining your local
tags in their own repository, if that's what makes you happy.

> In other words, tags are just like branches. You don't tie two tags 
> together, because one may (and does) make sense without the other.

Which tags are being tied together?

> Tying tags into history is silly. They're not "part of" history. They are 
> pointers *to* history. And trying to make them part of history has all 
> these obvious problems.

It seems to me they clearly do have history.
