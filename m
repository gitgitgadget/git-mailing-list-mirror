From: Junio C Hamano <junkio@cox.net>
Subject: Re: rebasing trouble
Date: Thu, 29 Jun 2006 15:34:21 -0700
Message-ID: <7vlkrfoaky.fsf@assigned-by-dhcp.cox.net>
References: <20060629194723.GD14287@fieldses.org>
	<20060629215725.GI14287@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 00:34:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw55e-0001mk-GS
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933065AbWF2WeX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933066AbWF2WeX
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:34:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55490 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S933065AbWF2WeW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 18:34:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629223421.JUGI12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 18:34:21 -0400
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20060629215725.GI14287@fieldses.org> (J. Bruce Fields's message
	of "Thu, 29 Jun 2006 17:57:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22923>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> In my defense, it is a little confusing: none of
> the examples in the man page that use --onto actually need it, and the
> "upstream" argument probably should be described as a commit or something
> instead of a branch.
>
> (What is --onto actually useful for?)

Think of it as a replacement of cherry-picking series of patches
from remotely related branches.

For example, I maintain two public branches "master" and
"next", the former is supposed to be quite stable and the latter
to contain sane proposed updates that need to be proven before
graduating to "master".

Sometimes I get patches that I have to apply on top of "next"
because of textual dependency, but the changes are worthwhile to
have it in "master" earlier than the changes the other series
depends on.

 o---o---o---o---o master
      \
       o---o---o---o---o next
                        \
                         o---o---o good

	$ git checkout good
        $ git rebase --onto master next

 o---o---o---o---o master
     |            \
     |             o---o---o good
      \
       o---o---o---o---o next
