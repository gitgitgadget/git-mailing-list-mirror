From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 20:35:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, Andreas Ericsson <ae@op5.se>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 05:35:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga2DG-0006MU-50
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 05:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWJRDfX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 23:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWJRDfX
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 23:35:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51889 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751245AbWJRDfW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 23:35:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9I3ZBaX022721
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Oct 2006 20:35:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9I3Z77p018101;
	Tue, 17 Oct 2006 20:35:10 -0700
To: Aaron Bentley <aaron.bentley@utoronto.ca>
In-Reply-To: <45357CC3.4040507@utoronto.ca>
X-Spam-Status: No, hits=-0.47 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29185>



On Tue, 17 Oct 2006, Aaron Bentley wrote:
> 
> > That doesn't matter...
> 
> It has significant UI impact.

Right. You have to do it your way, because of the "simple revision 
numbers".

Which gets us back to where we started: "simple" is in the eye of the 
beholder. I personally think that git revision naming is a lot simpler, 
exactly because it doesn't impose arbitrary rules on users.

For example, what happens is that:
 - you like the simple revision numbers
 - that in turn means that you can never allow a mainline-merge to be done 
   by anybody else than the main maintainer
 - that in turn means that the whole situation is no longer distributed, 
   it's more like a "disconnected access to a central repository"

The "main trunk matters" mentality (which has deep roots in CVS - don't 
get me wrong, I don't think you're the first one to do this) is 
fundamentally antithetical to truly distributed system, because it 
basically assumes that some maintainer is "more important" than others. 

That special maintainer is the maintainer whose merge-trunk is followed, 
and whose revision numbers don't change when they are merged back. 

That may even be _true_ in many cases. But please do realize that it's a 
real issue, and that it has real impact - it does two things:

 - it impacts the technology and workflow directly itself: "pull" and 
   "merge" are different: a central maintainer would tend to do a "merge", 
   and one more in the outskirts would tend to do more of a "pull", 
   expecting his work to then be merged back to the "trunk" at some later 
   point)

 - it will result in _psychological_ damage, in the sense that there's 
   always one group that is the "trunk" group, and while you can pass the 
   baton around (like the perl people do), it's always clear who sits 
   centrally.

Maybe this is fine. It's certainly how most projects tend to work. 

I'll just point out that one of my design goals for git was to make every 
single repository 100% equal. That means that there MUST NOT be a "trunk", 
or a special line of development. There is no "vendor branch". It's 
something that a lot of people on the git lists understand now, but it 
took a while for it to sink in - people used to believe that the "first 
parent" of a merge was somehow special, and I had to point out several 
times on the git list that no, that's not how it works - because the merge 
might have been done by somebody _else_ than the person who you think of 
as being "on the trunk".

So when I say that your "simple" revision numbers are totally broken and 
horrible, I say that not because I think a number like "1.45.3.17" is 
ugly, but because I think that the deeper _implications_ of using a number 
like that is ugly. It implies one of two things:

 - the numbers change all the time as things get merged both ways

OR

 - people try to maintain a "trunk" mentality

and I think both of those situations are simply not good situations.

In git, the fact that everybody is on an equal footing is something that I 
think is really good. For example, when I was away for effectively three 
weeks during August, all the git-level merging for the kernel was done by 
Greg KH.

And realize that he didn't use "my tree". No baton was passed. I emailed 
with him (and some others) before-hand, so that everybody knew that I 
expected to be just pull from Greg when I came back, but it was _his_ tree 
that he merged in, and he just worked the same way I did.

And when I did come back, I did a "pull" from his tree. At no point is 
there a big merge-commit with a sign saying

	"I now merged all the work that Greg did while I was away"

No. Because the way git works, my pull just fast-forwarded my tree, 
because while I was away, Greg's tree _was_ the main tree, thanks to the 
fact that git believes that everybody is 100% equal.

So it's actually a big conceptual thing. 

I'm actually very happy with the design of git, and a large part of that 
is that I think the data structures and the basic design was really good. 
Now, I know I'm smarter than anybody else ("Bow down before me, you 
worthless scum"), but the thing is, the way to do good basic design isn't 
actually to be really smart about it, but to try to have a few basic 
concepts.

And the "every repository is equal" is one such concept. The naming 
follows from that - you simply _cannot_ use numbers if everybody is on the 
same footing (at least not _stable_ numbers). 

Btw, BK did get this right. I didn't _like_ the naming in BK, and it was 
numbers, but it worked. But it only worked when people understood that the 
numbers were ephemeral, and it _did_ cause confusion. But hey, the 
confusion wasn't _that_ big of a problem.

> Even if I agreed that the revision was meaningless, the cost of such a
> revision is miniscule.

No. The _cost_ of the revision is the "trunk mentality". THAT is the true 
cost.  The belief that there is one "main line of development".

		Linus
