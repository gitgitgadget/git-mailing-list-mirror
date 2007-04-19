From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 13:57:35 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704191341370.9964@woody.linux-foundation.org>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>
 <20070417104520.GB4946@moonlight.home> <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com>
 <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org>
 <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site>
 <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org>
 <Pine.LNX.4.64.0704191118050.8822@racer.site>
 <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org>
 <4627ABBB.8060709@softax.com.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Marcin Kasperski <Marcin.Kasperski@softax.com.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 22:57:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HedhJ-0003B0-Il
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 22:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766987AbXDSU5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766988AbXDSU5m
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 16:57:42 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:45564 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1766987AbXDSU5l (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2007 16:57:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3JKvaRX013634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Apr 2007 13:57:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3JKvZ97030406;
	Thu, 19 Apr 2007 13:57:35 -0700
In-Reply-To: <4627ABBB.8060709@softax.com.pl>
X-Spam-Status: No, hits=-3.041 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45044>



On Thu, 19 Apr 2007, Marcin Kasperski wrote:
> > 
> > I agree. And to some degree I suspect that the documentation pushes some of
> > the advanced things a bit *too* eagerly. (...)
>
> As I am among those, who think that git *is* complicated, I decided to 
> sit down, and find out why exactly I think so. Here are the top 
> words/options/concepts, which I faced almost immediately while trying 
> GIT, and which I find confusing:
> 
> rebase
> index
> revtree
> reset
> ref / refs
> rev-list
> rev-parse

Yes. I think it might be a good idea to write some kind of tutorial aimed 
for two very simple cases. Because there are really two cases that stand 
out as being (a) common and (b) something you start out with!

 - Case #1 would be using git basically as a "anonymous CVS" replacement 
   to track somebody others project.

   None of the above are ever really needed for that case, and I think all 
   you really want to learn is:

	git clone
	git pull

	gitk
	git log HEAD@{2.days.ago}..
	gitk HEAD@{1}.. some-file-or-directory

   and not a whole lot more (maybe pointing them at gitweb repos and 
   telling them what the thing can do).  In other words, you want to teach 
   people to just fetch the repo, and perhaps how to see what has changed 
   lately.

   In an advanced section for this usage case might be things like

	git bisect

   to teach people who track other peoples repository how to help those 
   other people find bugs when something goes wrong. But that would 
   literally be an "advanced topic".

 - Case #2 is the "how to start tracking your own project".

   In some ways, it's even *more* trivial, becuase if you start a new 
   project, you usually start from scratch (or perhaps from some CVS 
   import), with just one branch, and your first worry is not even how to 
   export it yet, but how to just *use* it for development.

   So for case #2, we'd never even mention "git clone/pull" or branches, 
   but instead we'd just talk about

	git init	(and "git cvsimport" or something)
	git add/rm/commit
	git diff/show
	git reset
	git checkout

   and walk through an everyday problem set of just some _very_ basic 
   situations. Explain the whole "content" thing, so that people 
   understand why "git add <filename>" + "git diff" doesn't actually show 
   the filename at all, and what the difference between "git diff" and 
   "git diff HEAD" is.

Those two usage cases actually cover a lot of trivial CVS usage already. A 
lot of people probably don't need to learn about branches AT ALL,  or 
about concurrent development, or anything like that. 

And the good news is that once you are very comfy with the two trivial 
cases, it's much easier to *later* explain how those two can actually be 
combined. In other words, there's probably not any reason at all to even 
start to talk about merging and branches until people are actually ready 
for it, and start asking you "so what happens if I've made changes and 
want to update to the most recent version". 

Similarly, you generally don't want to actually start serving your 
projects to others until long after you've started using the thing for 
development, so early on, it's probably perfectly fine to tell people: 
don't worry about setting up a server or gitweb, just be happy in the 
knowledge that it *can* be done, and has been done for big projects, so 
when you actually want to do that, you can do all these fancy things, but 
you shouldn't worry about it _yet_.

			Linus
