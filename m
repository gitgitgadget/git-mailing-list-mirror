From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff-options: add --stat
Date: Wed, 12 Apr 2006 23:53:44 -0700
Message-ID: <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604130301240.28688@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7ya13e3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 08:54:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTviB-0001b4-1V
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 08:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWDMGxs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 02:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWDMGxs
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 02:53:48 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:63937 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964792AbWDMGxr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 02:53:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413065346.ZZAY18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 02:53:46 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <7vy7ya13e3.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 12 Apr 2006 21:54:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18653>

Junio C Hamano <junkio@cox.net> writes:

> I wonder if you can also make this an independent option that
> prepends diffstat in front of the patch, just like the way the
> new flag --patch-with-raw flag prepends raw output in front of
> the patch.

Clarification.

Traditionally, we had diff-raw and diff-patch formats.
We can think of --name-status and --name-only variants of
diff-raw (just like different --abbrev settings give different
visuals for diff-raw).  Until very recently, these were either-or
output formats, but for Cogito we added an option to show both.

We could reorganize the output format options to:

	- diff-raw and its name variants
	- diff-stat
        - diff-patch

and have (internally) three bools to specify which ones to
output, in the above order.  The recent --patch-with-raw would
flip bit #0 (show raw) and bit #2 (show patch) on.  It is very
likely that diff-stat followed by diff-patch would be a popular
format (that is what git-format-patch does), and it also is
conceivable that diff-raw with diff-stat but without diff-patch
might turn out to be useful for some people.

Also, I forgot to mention, but would it be useful to have a
diffstat to show --cc?  It is unclear, without much thinking,
what the numbers would mean, though...
