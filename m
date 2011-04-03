From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [GSoC 2011] Git Sequencer
Date: Sun, 3 Apr 2011 15:49:32 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.1104031407480.14365@iabervon.org>
References: <20110403172054.GA10220@kytes>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>, Stephen Beyer <s-beyer@gmx.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 21:56:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6TPJ-0005gW-JW
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 21:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab1DCT4P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2011 15:56:15 -0400
Received: from iabervon.org ([66.92.72.58]:47666 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183Ab1DCT4O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 15:56:14 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Apr 2011 15:56:14 EDT
Received: (qmail 29837 invoked by uid 1000); 3 Apr 2011 19:49:32 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Apr 2011 19:49:32 -0000
In-Reply-To: <20110403172054.GA10220@kytes>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170779>

On Sun, 3 Apr 2011, Ramkumar Ramachandra wrote:

> Hi,
> 
> I'd like to re-apply this year as a student because I really want to
> see (among other things), a sequencer in git.git.  Also, since I
> worked on areas related to fast-import and remote helpers last year, I
> thought I should work on something completely orthogonal this year.
> 
> I now have a draft of my proposal ready, and I'd really appreciate
> feedback.  Also, could someone mentor me?
> 
> ======================================================================
> Project Proposal: Git Sequencer
> Student: Ramkumar Ramachandra
> Mentor: ?
> 
> == The Objective ==
> 
> To write git-sequencer, a new builtin command, and implement existing
> commands on top of that.  This should give the commands more
> functionality, improve their error handling, and make them faster.
> The project can only be considered successful if all (or most) of the
> code written gets merged into upstream.
> 
> The Git Sequencer was a 2008 GSoC project as well; unfortunately most
> of the code did not get merged into git.git.  The learning from all
> that work should serve as a huge headstart this year.

One of the things that is hard about sequencer is that it is ultimately a 
complete replacement for several differently-implemented programs in 
different languages, with different temporary file formats and differrent 
supported operations. As such, you could probably spend an entire summer 
just getting it reviewed, revised, and accepted, starting with a working 
implementation.

So I think your proposal is good in how [1/5] includes getting something 
useful merged. My suspicion is that the outcome will be something like 
that you implemented all 7 tasks and got 4 of them merged, assuming that 
you really push getting things merged as soon as they're ready, without 
spending too much time porting other things to use the core and getting 
the ports reviewed before the core is accepted.

I actually think that it would be a worthwhile feature for git's library 
code to have a uniform mechanism for communicating that it is requesting 
human intervention in the middle of a particular operation, where library 
operations which conflict with being able to continue this operation are 
either blocked or abort the operation, and the library is able to be told 
in general that the human intervention is done and the library operation 
should be finished now (or produce complaints about the user's work). That 
is, a library-level, single-interrupted-step "sequencer". For that matter, 
it should also apply to the common '"git merge" gets a conflict' case, and 
it would be useful to get some representational uniformity between that 
and cherry-pick getting a conflict.

I think replacing existing multi-step processes is going to be a lot more 
contentious and involve user-visible changes which involve matters of 
taste and such. But I think you can make a valuable contribution in how a 
single current step is handled before getting tangled in that, and be much 
more likely to get a useful outcome than if you try to tackle the whole 
problem.

	-Daniel
*This .sig left intentionally blank*
