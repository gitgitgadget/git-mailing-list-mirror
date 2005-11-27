From: Junio C Hamano <junkio@cox.net>
Subject: What's in master and pu (aka when will 1.0rc4 be out)
Date: Sun, 27 Nov 2005 02:56:21 -0800
Message-ID: <7vek52e4ve.fsf@assigned-by-dhcp.cox.net>
References: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 27 11:57:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgKDY-0000Og-9Q
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 11:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVK0K4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 05:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbVK0K4X
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 05:56:23 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:34233 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750988AbVK0K4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Nov 2005 05:56:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051127105504.QQEZ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 27 Nov 2005 05:55:04 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe48gqg9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 25 Nov 2005 17:15:02 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12800>

Junio C Hamano <junkio@cox.net> writes:

> This series is what I've been cooking for the past several days,
> partly based on patch from Martin Atukunda but with hopefully
> smaller impact.
>
> [PATCH 1/4] Repository format version check.
> [PATCH 2/4] Check repository format version in enter_repo().
> [PATCH 3/4] init-db: check template and repository format.
> [PATCH 4/4] setup_git_directory(): check repository format version.

And they are now in the master branch, along with a couple of
bugfixes I received in the last couple of days.  I've given them
some testing and believe they are in good enough shape for 1.0
futureproofing.  Bug reports with reproduction recipe and/or
patch are most welcomed.

Cooking in the proposed updates branch is the 8-series "work
from subdirectory" patch I posted yesterday, with some polishing
based on suggestion from Linus. The ls-tree rework is not
included at this point, neither is the git-sh-setup, both of
which unfortunately have wider impact than I feel comfortable to
swallow in one day.

I am hoping to base the next "maint" branch update, probably on
Wednesday, on what is in "pu" tonight, with safer updates I will
receive from the list (Documentation fixes and updates, and
archimport updates from Eric and Martin are the candidates).
That will be tagged as 1.0rc4 and hopefully be the last 1.0rc,
which means no more major feature/semantics changes after that
until 1.0 --- famous last words.

So I anticipate that many of the barebone Porcelain commands
that insist on running from the toplevel will ship the way they
are in 1.0.  If you run "git grep git-sh-setup 'git*sh'", you
will notice that most of them are whole-tree operations anyway,
so not much is lost [*1*].

[Footnote]

*1* Bisecting only in a subdirectory might be an interesting
thing to do, hunting down a bug in a subsystem, but usually a
subsystem has at least two relevant subdirectories (source and
include file trees) ;-).

I suspect that it would be trivial to convert whole-repository
operations such as count-objects, prune, and repack to work from
subdirectory, although the value of that is dubious.
