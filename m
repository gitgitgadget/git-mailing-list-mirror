From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling of 'git-config foo=bar'
Date: Sun, 04 Feb 2007 11:59:43 -0800
Message-ID: <7vsldlr8wg.fsf@assigned-by-dhcp.cox.net>
References: <20070204113350.GN5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sun Feb 04 20:59:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDnWh-0006MD-Nh
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 20:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbXBDT7q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Feb 2007 14:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbXBDT7q
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 14:59:46 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:56555 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752529AbXBDT7p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Feb 2007 14:59:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070204195945.OGGR4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 14:59:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KXzj1W00W1kojtg0000000; Sun, 04 Feb 2007 14:59:44 -0500
In-Reply-To: <20070204113350.GN5362@nan92-1-81-57-214-146.fbx.proxad.net>
	(Yann Dirson's message of "Sun, 4 Feb 2007 12:33:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38703>

Yann Dirson <ydirson@altern.org> writes:

> Currently, running "git-config foo=bar", ie. presumably an erroneous
> attempt at setting "foo", indeed queries "foo=bar", so outputs nothing
> and reports success.
>
> Do we want to allow "=" signs in config var names ?  It would seem
> reasonable to refuse them, and report an error to the innocent user
> (OK, i'm not that innocent, but still ;)
>
> Or does that sound a bad idea to anyone ?

Something like:

   git config remote.origin.fetch=refs/heads/master:refs/heads/origin
   git config remote.origin.fetch+=refs/heads/next:refs/heads/next
   git config remote.origin.fetch+=+refs/heads/pu:refs/heads/pu
   git config remote.origin.fetch+=refs/heads/maint:refs/heads/maint

sounds sensible.

However, my feeling is "git repo-config" is primarily for use by
scripts, and we are better off educating users not to be afraid
of viewing and editing .git/config file themselves.
