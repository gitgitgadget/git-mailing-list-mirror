From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 18:23:23 -0700
Message-ID: <7vzmck7pis.fsf@assigned-by-dhcp.cox.net>
References: <20060928001241.62887.qmail@web51013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 03:23:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSkcd-0001Wr-Jd
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 03:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031129AbWI1BX0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 21:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031134AbWI1BX0
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 21:23:26 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:28117 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1031129AbWI1BXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 21:23:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928012324.QCBF16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Wed, 27 Sep 2006 21:23:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TdPS1V00S1kojtg0000000
	Wed, 27 Sep 2006 21:23:27 -0400
To: Matthew L Foster <mfoster167@yahoo.com>
In-Reply-To: <20060928001241.62887.qmail@web51013.mail.yahoo.com> (Matthew
	L. Foster's message of "Wed, 27 Sep 2006 17:12:41 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27961>

Matthew L Foster <mfoster167@yahoo.com> writes:

> Ignoring the separate issue of replication for a momment, can
> someone respond to my time integrity question about whether a
> future version of git could trust/prefer its local time rather
> than a remote/sub/parent (non replicated) git server's
> timestamp?

This must be a trick question.  git does not trust _any_
timestamp, so there is no local "rather than" remote.

So, no there is no chance for that.

Having said that, what Porcelains like gitweb and gitk do are
completely different issue.  I already outlined how you can do
that using reflog last night, so I am not going to repeat it
here.  Also Linus stressed that why the "order that commits
appeared on a particular branch in one particular repository" is
strictly local issue today at least three times, and I hope
everybody understood it by now.

As Shawn said in a nearby thread, in a public and prominent
repository like kernel.org repository it may sometimes be
interesting and useful to know when each commit became available
on each branch.  I am reasonably sure that it would not however
make gitweb output easier to read to order its output by that
timestamp.   Linus pulls from subsystem maintainers all the time
and one pull may bring in dozens of commits, and they will get
the same timestamp if you did so.  Actually it is worse than
that.  He tends to batch, so he would have many such pulls and
patch applications in his private repository, perhaps over a few
hour, but the result will be pushed out to kernel.org with one
push operation.  To show the "truthful" time, your gitweb would
give the timestamp of that push operation for hundreds of
commits pushed out during that operation.

I do not personally think that would be useful at all.  And I
happen to know how expensive to teach gitweb to produce such an
output, so I would not seriously suggest anybody to try it.

Can we please close this topic?
