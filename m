From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 16:03:23 -0800
Message-ID: <7vwtg9cq0k.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<20060205225116.GC24561@blinkenlights.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 01:03:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5tqr-0003Xv-LL
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 01:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWBFADZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 19:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWBFADZ
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 19:03:25 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:13812 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWBFADY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2006 19:03:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206000105.WQNJ17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Feb 2006 19:01:05 -0500
To: Michael Fischer <michael@visv.net>
In-Reply-To: <20060205225116.GC24561@blinkenlights.visv.net> (Michael
	Fischer's message of "Sun, 5 Feb 2006 17:51:17 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15644>

Michael Fischer <michael@visv.net> writes:

[Michael, forgive me to respond in public -- which I know is
against an established netiquette, but I think this comment is
useful to people on the list in general.]

> $ git-applymbox ../patch 
> 1 patch(es) to process.
>
> Applying 'git-commit: revamp the git-commit semantics.'
>
> error: Documentation/core-tutorial.txt: does not exist in index
> error: patch failed: git-commit.sh:213
> error: git-commit.sh: patch does not apply
>
> So, kind of hard to give an opinion on it.
>
> I've got 1.1.6 from a couple of days ago, downloaded source.

Ah, sorry, the development happens on the "master" branch.  The
maintenance release 1.1.6 has only fixes since 1.1.0 was done,
and lacks all the new developments on the master branch.

Especially this update involves backward incompatible changes,
it will _not_ appear in any of the future 1.1.X releases.

To keep yourself up to date:

	$ git clone git://git.kernel.org/pub/scm/git master.git
        $ cd master.git

This would give you the latest from the master branch that the
patch would apply cleanly to.

It is in the the pu (proposed updates) branch, so once you make
clone like this, you do not have to apply the patch yourself.
Instead, you could find the commit that merges jc/commit topic
branch on it:

        $ git show-branch --topo-order master pu

which probably would show something like this:

	...
         - [pu^] Merge branch 'jc/commit'
         + [pu^^2] git-commit: revamp the git-commit semantics.
        ...

The easiest way to try it out is:

	$ git checkout -b test pu^

Note: this would also get other topic branches merged on top of
master, but I consider them to be safe.  The rule of thumb is
that the closer to the tip of the "pu", the less ready the
change is to be of general use.

Then build it as usual.

	$ make && make install

Thanks.
