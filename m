From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix fetch completeness assumptions
Date: Thu, 15 Sep 2005 01:09:25 -0700
Message-ID: <7vd5naah1m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0509142120020.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 10:10:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFooG-0004Bw-Ct
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 10:09:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVIOIJ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 04:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbVIOIJ3
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 04:09:29 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:7167 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750889AbVIOIJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2005 04:09:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050915080926.GTRL6784.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Sep 2005 04:09:26 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0509142120020.23242@iabervon.org> (Daniel
	Barkalow's message of "Wed, 14 Sep 2005 21:31:42 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8595>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Don't assume that any commit we have is complete; assume that any ref
> we have is complete.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
>
> ---
> Only lightly tested, but it seems to work. Marks all of the commits in 
> refs, and their ancestors back as far as the date of the commit it's 
> processing. If the commit it's processing is marked, it doesn't recurse 
> into it.

First I thought you were using the date for the cutting-off
decision and was going to object to the patch because of it, but
re-reading the code made me realize that you are using date only
to better the heuristics that limits how many commits reachable
from existing refs we would tangle to see if the newly seen
commit is reachable from our refs -- the logic looks correct.

The "complete" commit_list is a clever piece of code; I like it.
