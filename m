From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 09:28:00 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703190912190.6730@woody.linux-foundation.org>
References: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319025636.GE11371@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 17:28:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTKiW-0008Fr-TJ
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 17:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbXCSQ2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 12:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbXCSQ2N
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 12:28:13 -0400
Received: from smtp.osdl.org ([65.172.181.24]:40668 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030339AbXCSQ2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 12:28:12 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JGS1cD030154
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 09:28:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JGS07V010931;
	Mon, 19 Mar 2007 08:28:00 -0800
In-Reply-To: <20070319025636.GE11371@thunk.org>
X-Spam-Status: No, hits=-0.479 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42637>



On Sun, 18 Mar 2007, Theodore Tso wrote:
> 
> Berkely got it horribly wrong when it tried to start with the "small
> and beautiful" functions that were non-reentrant, and we've been
> paying the price ever since.

I don't think that's a good argument, ESPECIALLY when coming from somebody 
from MIT.

Berkeley may have gotten it "horribly wrong", but the fact is, BSD kicked 
ass and took over the world, in a way that nothing comparable I know of 
from MIT ever did. Exactly *because* the BSD people didn't try to make it 
perfect, but made things "small and easy to *implement*".

(I would not say "small and beautiful". "Beauty" had nothing to do with 
it. "simple" had. And unlike beauty, simplicity really *is* more than skin 
deep, and is a fundamentally good design).

I'm a *huge* believer in "Worse is Better" (for people who don't know it, 
just google for that phrase, with the quotes around it).

In fact, I'd argue that the reason git kicks ass is exactly that "Worse is 
Better" design: you need to have a few conceptual (good) ideas to base 
your design off on, but given those good ideas, it's more important that 
things _work_well_in_practice_ than some "wouldn't it be better.." kind of 
mentality.

The "paying the price ever since" argument is bogus. If you get to that 
point, you've by definition *already*won*! 

Here's the real world according to Linus:
 1) everybody makes mistakes
 2) only the winners "pay the price" of those mistakes ever since, since 
    the losers will not be around to pay it, and the winners will have 
    made mistakes too (see #1)
 3) the more complex and subtle you make the interfaces, the more mistakes 
    you'll make, AND the less likely you are to be a winner anyway, since 
    you'll have problems implementing it *and* it will probably be subtle 
    to use too!

So the motto should always be: "Just Do It!", and screw worrying about 
paying the price. You *want* to have to pay the price. It's the best thing 
that can ever happen to you. And you want to have to start paying the 
price as early as possible - because that not only means that you won, it 
also means that you'll now be learning from your mistakes instead of 
trying to anticipate them, and I will *guarantee* that learnign from 
mistakes is going to be a lot more productive than trying to worry about 
them up-front.

> Do we really want to support two versions of the API forever?

I'd personally strongly vote for a "simple library" interface as a first 
cut.

And yes, if that means supporting two versions, I think it's better. You 
can easily have "libgit-simple.a" for trivial non-threaded accesses with 
out-of-memory conditions causing the process to die. That really *is* a 
very useful schenario, as shown by the fact that *every*single*core*git 
program has been happy with it.

Claiming that you need a complicated interface in the face of the *proof* 
that git itself dosn't need that complicated an interface is to me a bit 
disingenious.

Yes, *some* people will want a thread-safe one. But we're not talking 
something like libc here, where the library is so fundamental that it 
needs to be acceptable for everybody. It's perfectly possible to have a 
"libgit-simple.a" that is good for 99% of all uses, and that is simple to 
use, and less bug-prone simply because is is *simpler* (not just for 
users, but as an implementation).

And then for the small small minority of programs that want something 
fancier, do a "libgit-complicated.a" library. IF you ever get it working 
and complete, you can always then implement "libgit-simple" in terms of 
the complicated version.



  Is it 
> really that hard to support a reentrant API from the beginning?  I'd 
> submit the answer to these two questions are no, and no, respectively.
> 
> 						- Ted
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
