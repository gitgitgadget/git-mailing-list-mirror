From: Junio C Hamano <junkio@cox.net>
Subject: Re: New way of tracking remote branches -- question
Date: Tue, 09 Jan 2007 00:28:45 -0800
Message-ID: <7vejq4r4ci.fsf@assigned-by-dhcp.cox.net>
References: <7v8xghariv.fsf@assigned-by-dhcp.cox.net>
	<524590.40333.qm@web31802.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 09:29:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4CLz-0005nu-A5
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 09:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbXAII3D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 03:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbXAII3D
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 03:29:03 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39109 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171AbXAII3B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 03:29:01 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070109082901.XDQU29122.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Tue, 9 Jan 2007 03:29:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8wVG1W00N1kojtg0000000; Tue, 09 Jan 2007 03:29:16 -0500
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <524590.40333.qm@web31802.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Mon, 8 Jan 2007 23:45:09 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36329>

Luben Tuikov <ltuikov@yahoo.com> writes:

> I guess, what I want is still to be able to "see" remotes/
> when I do "git branch".

Then do not use "remotes/" but hang everything underneath
"heads/" (or "git branch -a").

Of course, the next complaint from you would be that the latest
git-clone would not make the traditional layout, but ...

> I think that this "automatic merge/newbie protection" policy,
> should've been well suited to porcelains as opposed to
> git.

... at that point, honestly speaking, I feel that you should do
your own "spartan porcelain" that lays things out in a way you
prefer.

> So maybe we should take it one step at a time and first
> implement that, still exposing it to "git branch" and then
> if porcelains want to establish a policy on top of this,
> that's fine.  But low-level git should not hide this from me.

No low-level is hiding anything from you.

It used to be 'find .git/refs/ -type f' was the lowest level,
and these days git-for-each-ref is the lowest level.  "git
branch" has always been Porcelain.

> I really think that the line separating porcelains from git
> should be drawn at some point.

And drawing this line was done long time ago (notice different
sections in Documentation/git.txt).

While I've been claiming that I do not do Porcelain, the nature
of what are shipped with git have changed enough over time.  The
Porcelain-ish has long been "barely usable spartan set", hoping
that people would do different porcelains depending on their
needs, but that has never materialized, except perhaps a notable
example of StGIT.

I described my position on recent focus on Porcelain-ish in the
initial "digression" part of this:

http://thread.gmane.org/gmane.comp.version-control.git/34908/focus=34914

We've taken "one step at a time" by first introducing separate
remote layout as an option, taught 'git branch' the needed
options such as -a and -r, and then made this the default
layout.  It still looks _different_ to me from what I am used
to, but that's just traditionalist speaking and I cannot really
deny the advantage of the separate remote layout offers.  In
other words, we have been doing "one step at a time".
