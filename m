From: Junio C Hamano <junkio@cox.net>
Subject: Re: More precise tag following
Date: Fri, 26 Jan 2007 03:53:48 -0800
Message-ID: <7v8xfqxaur.fsf@assigned-by-dhcp.cox.net>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 26 12:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAPeo-0006Hc-UR
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 12:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965222AbXAZLxv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 06:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965320AbXAZLxu
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 06:53:50 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40269 "EHLO
	fed1rmmtao06.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965222AbXAZLxu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 06:53:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126115349.MVIT2628.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 06:53:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fnsr1W00J1kojtg0000000; Fri, 26 Jan 2007 06:52:52 -0500
In-Reply-To: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 26 Jan 2007 03:07:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37845>

Junio C Hamano <junkio@cox.net> writes:

> What if (I know, this discussion does not belong here until
> 1.5.0 final) we had a "reverse" database that keeps track of
> what tag references which object, and "git rev-list" knows how
> to exploit it?  That is, just like generating a list of objects
> that are reachable with --objects option, if we can add a new
> option --with-tag very cheaply to list tag objects that would
> reach what are in the generated list of objects?
> ...
> Just an idle thought.

Nah, that would not work.  Please disregard.

The thing is, you cannot sanely traverse and transfer objects
that have such reverse connectivity.  The other end can annotate
a commit long after you acquired it, and trying to make
git-fetch to retrieve newly created annotations would mean
breaking "things reachable from your local refs are complete and
there is nothing missing from them" invariant.  Pushing into
somebody else after annotating an old commit that already exists
at the other end has the same issue.
