From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Producting Open Source Software" book and distributed SCMs
Date: Tue, 1 May 2007 16:13:10 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705011547080.3808@woody.linux-foundation.org>
References: <200704300120.42576.jnareb@gmail.com> <Pine.LNX.4.64.0705011057130.29859@racer.site>
 <200705012030.11747.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 01:13:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hj1XB-00016N-3T
	for gcvg-git@gmane.org; Wed, 02 May 2007 01:13:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbXEAXNU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbXEAXNU
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 19:13:20 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:57251 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754805AbXEAXNS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2007 19:13:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l41NDC5e025915
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 1 May 2007 16:13:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l41NDAMm008922;
	Tue, 1 May 2007 16:13:11 -0700
In-Reply-To: <200705012030.11747.jnareb@gmail.com>
X-Spam-Status: No, hits=-2.98 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45991>



On Tue, 1 May 2007, Jakub Narebski wrote:
> 
> In "Producting Open Source Software" Karl Fogel gives an example of
> GCC/EGCS fork, which resulted in "fast forward" merge (EGCS which was
> fork of GCC, became next version of GCC).

The egcs fork was a total disaster, and a big part of that was CVS and the 
tight control of the gcc tree. 

It took _years_ for people to get so fed up with the gcc maintenance that 
the egcs tree happened at all, and it was a prime example of how *painful* 
CVS makes this, and how it allowed the gcc maintainers to do a really bad 
job, and ignore a whole lot of major problems simply because the whole gcc 
setup was so hard to get into.

So yes, the egcs fork is a great example. It was not only a required (and 
very good) fork, but it is _also_ an example of a setup where all the 
infrastructure made the fork take a lot longer to materialize and be a lot 
more painful than it should have been.

> But for example GNU Emacs / XEmacs fork will never be merged, I think.
> So not always you can merge a fork - you can try, unless codebase diverged
> too much.

In all honesty, I don't think any tools would help there. Git can make 
merging easier, but it cannot solve the fundamental differences in 
personality and it can't help with ten years of differences. Git tries to 
make merging easy by making it happen all the time, and thus the git 
merge capability really depend on changing the *model*. But git cannot 
really help you all that much if you have a decade of split, and the 
codebases just don't look similar any more..

(Not entirely true: git obviously does make merging easier, since people 
have piped up to say that they imported branches from SVN just to merge 
them in git and push the result back to SVN. So git _does_ help on the 
pure technical side too, but I think the even more important part is how 
git tries to encourage the model to be that one or both sides just merge 
often enough that the merges _stay_ easy).

> What is or is not a fork is a bit blurry in the world of distributed
> version control systems. Is a clone of repository a fork? I think that
> everybody would agree that it is not. Is for example *-mm tree a fork?
> I'd say not. But I'd say that Beryl is a fork of Compiz...

Well, the -mm tree is a fork, but perhaps the difference is that the 
_intention_ is to merge back.

We've had "real forks" in the kernel community too. Vendor branches for a 
while tended to be real forks - not because the vendors didn't want to 
merge back, but simply because they didn't have the capability and 
commitment to do so. That's changed, partly because 2.4->2.6 was so 
painful for some of them.

And the VM people have had real forks. The -aa tree wasa real fork in the 
2.4.x timeframe.

So I think the reason kernel people don't really think about "-mm" as a 
fork is that we've tended to be pretty amicable about the forks, whatever 
the intention was. I personally encourage them, for example, in ways that 
most other bigger open source projects do not. That makes it easier 
psychologically to fork, but more importantly, it also makes it easier to 
join back again, because there was generally no hard feelings, just 
differences of opinion on technical matters that didn't get to be _too_ 
personal.

So to _me_, the big issue is not so much forking, but joining it all back 
(ie merging). Forking should be trivial, and not even worthy of any real 
discussion. It should be a daily event, and sure, you'd expect the small 
forks to heavily outnumber the big ones, but none of that really matters 
if you just consider forking to not be a big deal - and always realize 
that joining back is where the interesting stuff happens!

			Linus
