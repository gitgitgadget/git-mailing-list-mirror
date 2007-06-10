From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull mergetool.git
Date: Sun, 10 Jun 2007 12:55:13 -0700
Message-ID: <7v1wgj8tzy.fsf@assigned-by-dhcp.cox.net>
References: <E1HxPt7-0007jV-6V@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Jun 10 21:55:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxTVV-0007Bd-Mi
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 21:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXFJTzQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 15:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756221AbXFJTzQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 15:55:16 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:59089 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754785AbXFJTzP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 15:55:15 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610195513.OSYH25947.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 15:55:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9vvD1X00c1kojtg0000000; Sun, 10 Jun 2007 15:55:14 -0400
In-Reply-To: <E1HxPt7-0007jV-6V@candygram.thunk.org> (Theodore Ts'o's message
	of "Sun, 10 Jun 2007 12:03:33 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49761>

"Theodore Ts'o" <tytso@mit.edu> writes:

> Please pull from the "mergetool" branch at:
> 	git://repo.or.cz/git/mergetool.git mergetool
>
> It adds support for vimdiff/gvimdiff as a mergetool program, as well
> Josh's suggestion of making the default merge-tool selection more
> intelligent, although I've rewritten it somewhat take into account the
> comments made by you and others on the git mailing list.
>
> (Note that as of this writing, meld is a pretty sad/dificient tool, and
> even GNOME users may very well prefer kdiff3 over meld --- which is my
> default.  Still, it seems reasonable to default to using KDE tools in an
> KDE login session, and GNOME tools in a GNOME login session, and people
> who care differently should set their own preferences in ~/.gitconfig.)

Thanks for keeping track of the mergetool.

I do not see problems in the mergetool part, other than that I
mildly suspect that opendiff -- actually FileMerge -- might want
to be in the test -n "$DISPLAY" section, but that is inherited
from the previous iteration so in that sense leaving outside is
a sane thing to do.

> Dan McGee (1):
>       git-mergetool: Allow gvimdiff to be used as a mergetool
>
> Theodore Ts'o (2):
>       git-mergetool: Make default selection of merge-tool more intelligent
>       Add git-applymbox, git-applypatch, and *~ to .gitignore

But I hope you would not be offended if I said I do not want to.

This is not such a strong objection, but I really wish that you
did not mix in the .gitignore change; it does not belong to this
"series".

If it were an obvious and universally nondisagreeable fix, I
would not mind you mixing it in this mergetool updates, but I am
of two minds about the .gitignore change, and actually slightly
in favor of not adding git-applymbox and git-applypatch back.

About git-applymbox and git-applypatch, it helps people when
they switch branches and/or bisect to keep potential build
products from older/different revisions listed in .gitignore.
That would however imply we would end up carrying old entries
forever in it.  We do not keep clean rule in Makefile to remove
build products from older/different revisions when remove build
targets, so why should we keep them in .gitignore?

Also I deliberately have kept *~ out of .gitignore for a reason.
I do have that entry in .git/info/exclude, but the choice of
Emacs over vi is personal to me.
