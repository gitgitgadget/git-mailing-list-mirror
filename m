From: Junio C Hamano <junkio@cox.net>
Subject: Re: Wine + GIT
Date: Mon, 05 Dec 2005 18:26:54 -0800
Message-ID: <7vhd9n7yfl.fsf@assigned-by-dhcp.cox.net>
References: <4394CD68.8020500@codeweavers.com> <4394F173.6000505@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike McCormack <mike@codeweavers.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 03:28:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjSXl-0005lp-Sp
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 03:27:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964936AbVLFC05 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 21:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbVLFC05
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 21:26:57 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:3282 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964936AbVLFC04 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Dec 2005 21:26:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051206022615.QPAI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Dec 2005 21:26:15 -0500
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4394F173.6000505@pobox.com> (Jeff Garzik's message of "Mon, 05
	Dec 2005 21:03:31 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13249>

Jeff Garzik <jgarzik@pobox.com> writes:

> 5) never ever do
> 	git-checkout -f HEAD
>
> HEAD should always be a symlink.  'git checkout -f master' is probably 
> what you want.

Correct.  "git checkout -f HEAD" is a redundant way to say
"I screwed up and would want to revert the mess in my working
tree to my branch head".  You do not need to say HEAD; "git
checkout -f" (or "git reset --hard" if you really want to clean
things up) would do.

> 6) For merges with hand-merged conflicts, I could have sworn that either 
> a "git commit -a" or 'git-update-index' + 'git commit' was required. 
> Maybe I'm wrong, or that has changed?

That has not changed.  With the recent 0.99.9l change, I suspect
that the example on the wiki page (without update-index) would
fail to commit -- the index is now left unmerged after a failed
automerge.

The paragraph "Once you have finished editting [sic]..." needs
to be followed by:

	git-update-index those paths you hand corrected
        git-commit
