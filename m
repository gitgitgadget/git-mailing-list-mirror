From: Andreas Krey <a.krey@gmx.de>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Thu, 15 Jan 2015 07:38:06 +0100
Message-ID: <20150115063806.GH13247@inner.h.apk.li>
References: <20150114115130.GA5677@inner.h.apk.li> <20150114124936.GC30383@peff.net> <20150114143946.GE13247@inner.h.apk.li> <xmqqmw5lb7ho.fsf@gitster.dls.corp.google.com> <CAGyf7-EL03E8oFcuDzGcmN4bKQhroHw-T4Azm4mb0QX9F40RFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 07:38:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBe4Z-0007fR-Bd
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 07:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751175AbbAOGiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 01:38:22 -0500
Received: from continuum.iocl.org ([217.140.74.2]:56705 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbAOGiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 01:38:21 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id t0F6c7110370;
	Thu, 15 Jan 2015 07:38:07 +0100
Content-Disposition: inline
In-Reply-To: <CAGyf7-EL03E8oFcuDzGcmN4bKQhroHw-T4Azm4mb0QX9F40RFw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262458>

On Thu, 15 Jan 2015 12:23:00 +0000, Bryan Turner wrote:
...
> > Guess in the dark: "ls -l .git/objects/pack"
> > Do you see any .keep files?

Lots of. :-(

> I'm one of the Stash developers and just noticed this thread. If the
> repository in question has been forked via Stash there likely _will_
> be .keep files. Stash uses alternates for forks, so it's possible, by
> deleting those kept packs and pruning objects (which you've already
> done I see) that you will corrupt, or have already corrupted, some
> number of the forks.

There are a few forks in this stash instance, but the repository in
question is neither the source nor the destination of any.

So, git seems to be mostly out of the equation now (gc and repack
apparently doing what they are supposed to do), and the question
moves to 'how can stash let such a repo grow to that size'.


> (At the moment Stash packs "garbage" into a "dead
> pack" which it flags with a .keep, to ensure forks don't lose access
> to objects that once existed upstream that they still reference.)

Does it do so in any case even if there is no actual fork? That would
explain a lot - we are daily (force-)pushing new commit in there (and
potentially big ones) that become garbage the next day, and should
be cleaned up rather fast.

(We're pulling them into another non-stash repo for longer-term keeping -
these are backups of dev repos in the form of git stash commits including
untracked files.)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
