From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 14:27:11 -0700
Message-ID: <7vd4pq2ymo.fsf@gitster.siamese.dyndns.org>
References: <20080318180118.GC17940@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Axboe <jens.axboe@oracle.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5q6-0005me-6j
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbYCSV1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:27:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937251AbYCSV1X
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:27:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932263AbYCSV1S (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:27:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 018683C29;
	Wed, 19 Mar 2008 17:27:17 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2AE793C27; Wed, 19 Mar 2008 17:27:13 -0400 (EDT)
In-Reply-To: <20080318180118.GC17940@kernel.dk> (Jens Axboe's message of
 "Tue, 18 Mar 2008 19:01:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77556>

Jens Axboe <jens.axboe@oracle.com> writes:

> But the new magic is really beside the point. Doing this 'for you' is
> extremely annoying behaviour. I often work on my notebook, so disk is
> both slow and battery is precious. I DON'T want gc to run automatically,
> EVER. Not on repos I have had going for ages, not on ones I just cloned.
> Please bury this silly policy and replace it with a printf() telling me
> that I may increase my performance by running git gc. Don't just do it.
> git does not know better.

Well, earlier, git used to be "kick-ass fast, flexible and powerful if you
knew what you are doing, and if you don't, then you are forever lost" type
of a system, and I think early adopters even took pride in saying so.

Being in the scene myself from early on, I certainly sympathise with that
feeling, and sometimes when a newcomer starts making noises about dumbing
git down without understanding implications (e.g. hiding or removing the
index), I have to resist the urge to say "you need to learn certain new
concepts that do not even exist counterparts in earlier crap systems you
are used to.  If you feel you are confused, that's your problem.  Get
enlightened first."  I rarely say that out loud, to be more diplomatic,
though.

But judging from the fact that some kernel folks talking about having a
7GB kernel repository, I think supposedly early adoptors may not really
know what they are doing, and some automation, if done correctly would be
a good thing.

Having said that, I am not sure how the auto gc is triggering for your
(presumably reasonably well maintained) repository that has only small
number of loose objects.  I haven't seen auto-gc annoyance myself (and
git.git is not the only project I have my git experience with), and Linus
also said he hasn't seen breakages.

I think we did have a few patches to the area recently and we should not
rule out the possibility that we broke the criteria "gc --auto" kicks in.
