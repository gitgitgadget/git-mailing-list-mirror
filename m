From: Junio C Hamano <junkio@cox.net>
Subject: Re: I just pulled and built 'next'...
Date: Mon, 08 Jan 2007 12:11:35 -0800
Message-ID: <7vvejhwa6g.fsf@assigned-by-dhcp.cox.net>
References: <E1H3uc2-0004m1-Ua@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 21:12:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H40qZ-000390-V4
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 21:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422724AbXAHULi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Jan 2007 15:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbXAHULh
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jan 2007 15:11:37 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38053 "EHLO
	fed1rmmtao05.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422726AbXAHULg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jan 2007 15:11:36 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070108201136.HJLY15640.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Mon, 8 Jan 2007 15:11:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 8kAm1W0031kojtg0000000; Mon, 08 Jan 2007 15:10:46 -0500
To: "Theodore Ts'o" <tytso@mit.edu>
In-Reply-To: <E1H3uc2-0004m1-Ua@think.thunk.org> (Theodore Ts'o's message of
	"Mon, 08 Jan 2007 08:32:30 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36275>

"Theodore Ts'o" <tytso@mit.edu> writes:

> I just pulled and built 'next' and it reported a version number of
> 1.4.4.4.g71bb6 -- and not one v1.5.0-rc0.g71bb6.  I can understand why,
> since it found the changes pulled in from the maint branch before it
> found the v1.5.0-rc0 tag --- but it could be more than a little
> misleading.  Is this something that can be fixed in any way, short of
> finding all of the tags reachable from HEAD and then doing a sort?  That
> seems like a gross kludge, but I can't think of any other way of fixing
> it.

One question is how you would sort the result.  If you sort them
by taggerdate, you would get v1.4.4.4 anyway ;-).

If we go with topology, we do not necessarily have to find all
the tags.  When we hit a commit that is tagged, we can stop the
traversal (so after finding v1.5.0-rc0, we do not have to go
back along the 'master' lineage to find v1.4.4 tag).  Traversing
from the tip of 'master' (or 'next') this way we will notice
that v1.5.0-rc0 and v1.4.4.4 are the candidates without going
any further in the past.

But the question still remains which one between the two to
pick.
