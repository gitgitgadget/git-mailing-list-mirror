From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: auto-squash commits
Date: Thu, 18 Jun 2009 00:54:47 -0700
Message-ID: <7vws7ayo1k.fsf@alter.siamese.dyndns.org>
References: <e1868cfe0906170506o37a75c35m47f9456bf8ae47c1@mail.gmail.com>
	<43d8ce650906170555m644564b3v3722168f7217c326@mail.gmail.com>
	<7vvdmurfao.fsf@alter.siamese.dyndns.org>
	<20090618063348.6117@nanako3.lavabit.com>
	<4A39EAAB.70402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	John Tapsell <johnflux@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 18 09:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHCSZ-0001MJ-Lg
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 09:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbZFRHyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 03:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754327AbZFRHyp
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 03:54:45 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:33920 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754261AbZFRHyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 03:54:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090618075448.IKHP18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 18 Jun 2009 03:54:48 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 5Kun1c0014aMwMQ04Kun9W; Thu, 18 Jun 2009 03:54:47 -0400
X-VR-Score: -120.00
X-Authority-Analysis: v=1.0 c=1 a=y44SSOj0rWsA:10 a=m7EVdoU-gkeU-PtthwEA:9
 a=htTOtrU2ax4PFmW8ZQ84O6vXgtUA:4 a=i30y-_3cDNMwcNAW:21 a=p7IkTTWt-CPJ5MlN:21
X-CM-Score: 0.00
In-Reply-To: <4A39EAAB.70402@alum.mit.edu> (Michael Haggerty's message of "Thu\, 18 Jun 2009 09\:20\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121800>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> It seems to me that even this requires more steps than strictly
> necessary, namely a commit then a rebase, and conveying the information
> from the commit step to the rebase step is somewhat awkward.  Since I
> have to specify a magic commit message to trigger this behavior, I
> obviously know at the time of the commit that I want to squash the new
> changes onto an older commit.  So why not implement this functionality
> as a variant of "commit"?

That may be a good feature, but that won't work as well as the patch being
discussed for _me_.

IOW, I think what you are suggesting is a different feature.

It largely depends on how you work.  I do not function well when I get
interrupted and/or disrupted often, and I would prefer the convenience of
being able to simply queue a trivial patch with a minimum amount of fuss
(e.g. just leave a note that says "to be squashed to that other one" and
nothing else) when I find a trivial breakage that is unrelated to what I
am concentrating on.

Imagine the "Clean up the surrounding code" then "Lay the groundwork" and
finally "Implement a cool new feature" sequence I outlined in the message
the patch was response to.  When I thought I am finished cleaning up the
surrounding code and laid the groundwork, and finally concentrating on
implementing the new feature (which is the fun part), I may notice small
breakages and untidiness I could squash into earlier commits.

It is very distracting, however, if I have to go back to the state _before
I wrote all the fun code for the new feature_ to fix the breakage right
there.  Once I go back, the surrounding code would look all different, and
I may even be tempted to do the full test cycle before finishing your
"amend in the past" operation.  The distraction will destroy my momentum
and concentration.

It's much more easier on my brain to commit the fix-up to be later
squashed (use "add -p then commit" for that) and continue.  I can keep the
momentum going that way.

But that is how _I_ work.  You may well work differently, and for you
"stop, switch brain back to the state before all these fun work and amend,
then finally come back" workflow may work better.

What I am saying is that "a variant of commit" you talk may be good but it
won't be a _replacement_ for the effort to make squash easier to do while
running "rebase -i".
