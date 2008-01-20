From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Time to flush developer accumulated patches?
Date: Sun, 20 Jan 2008 12:05:50 -0800
Message-ID: <7vlk6k6z4x.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 20 21:06:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGgRC-00060V-HQ
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 21:06:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbYATUGG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2008 15:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755407AbYATUGF
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jan 2008 15:06:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38131 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755391AbYATUGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2008 15:06:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 90A382242;
	Sun, 20 Jan 2008 15:06:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C2BE72241;
	Sun, 20 Jan 2008 15:05:57 -0500 (EST)
In-Reply-To: <e5bfff550801200210y212d0921x214773596810be52@mail.gmail.com>
	(Marco Costalba's message of "Sun, 20 Jan 2008 11:10:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71187>

"Marco Costalba" <mcostalba@gmail.com> writes:

> I understand that you want people focused on fixing bugs, but I also
> understand that people don't ;-)

Current policy during rc stabilization period is roughly:

 - No new feature is accepted, starting early in the rc cycle;

 - An intrusive fix is sent back and requested to be rewritten
   as minimum "fix" without enhancements, starting mid rc cycle;

 - I do not want to take patches early.

The third point is a double-edged sword:

 - Developers can easily get distracted when encouraged to do
   new things.  That's human nature.  Everybody finds doing new
   things more interesting than finding and fixing existing
   bugs.

   This is especially true if the fix is about somebody else's
   code and the breakage does not affect you.  Even your own
   earlier half-baked-hack that has not been discovered by other
   people is often not interesting to fix (once discovered, the
   embarrassment factor tends to make it a higher priority).

   However, we won't have enough good people who know the
   codebase and are capable of fixing existing bugs if they all
   go and work on "other" things.

 - Developers tend to notice _existing_ breakage more easily
   when given a chance to play with _existing_ code (either
   enhancing the existing code, or adding new call sites to the
   existing API).  And one way to encourage playing with
   _existing_ code is to to encourage developing on top of it.

In earlier releases, I used to keep 'next' open during the
freeze.  I think it had the effect of encouraging new things too
much without having enough side-effect (from the point of view
of a person who wants to do new things) of uncovering and fixing
existing issues (which is the primarily desired effect during
the stabilization).

This time I have been deliberately playing differently to strike
the balance a bit differently:
 
 - In order to discourage new things, I do not accept patches
   early.

 - In order not to discourage new things too much, I try to give
   brief feedback, and add them to "What's not in 'master', and
   likely not to be until 1.5.4".

Another practical reason I do not take patches early is because
it is a time drain.  Taking patches early means it will increase
the merge impact _before_ 1.5.4.

Now that high level description out of the way, let's see what
you said:

    - Give more time to fix bugs before 1.5.4 is out without stopping
    people from having fun and reduce the pressure to release.

That is precisely what I want to discourage.

    - Reduce the merging impact when master reopens because patches are
    already merged in new_stuff and developers have already taken care of
    conflicts

Bogus.

When two or more new things are outstanding, and if I take
patches early, 'next' needs merge resolution.  You are arguing
to take my time away from what matters to 1.5.4 during the
stabilization period, and instead encourage people to have fun
and get distracted.

Post 1.5.4 if one series contradicts/conflicts with another, I
can just say "I have decided to take that series and your series
conflicts with it.  Please rebase", to shift the burden to the
contributor of the second series.  If I do that before 1.5.4,
that means I will not just encourage but actively ask the second
contributor not to work on uncovering and fixing existing issues
but spend time on new things.

Do you think that helps the stabilization period in _any_ way?

    - Do not slow down the wheel: I can develop some patches and keep them
    myself, but until are not discussed in the list and eventually got in
    master has little meaning to continue develop additional stuff.

That's exactly the point of stabilization freeze.  You can
develop and keep developing.  I have a few topics myself that
are backburnered, and I occasionally visit them when I am bored.
However, I try not to distract others with the series.  Please
try to do the same.
