From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] cvsserver: Add asciidoc documentation for new database backend configuration
Date: Sun, 08 Apr 2007 01:44:50 -0700
Message-ID: <7v64879rwd.fsf@assigned-by-dhcp.cox.net>
References: <11759575342765-git-send-email-frank@lichtenheld.de>
	<11759578902278-git-send-email-frank@lichtenheld.de>
	<11759578901878-git-send-email-frank@lichtenheld.de>
	<11759578903791-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Sun Apr 08 10:45:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HaT1R-0003Mp-Ra
	for gcvg-git@gmane.org; Sun, 08 Apr 2007 10:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbXDHIox (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Apr 2007 04:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbXDHIox
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Apr 2007 04:44:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:62030 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751483AbXDHIov (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2007 04:44:51 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070408084451.MIE27119.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Apr 2007 04:44:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kYkq1W0061kojtg0000000; Sun, 08 Apr 2007 04:44:51 -0400
In-Reply-To: <11759578903791-git-send-email-frank@lichtenheld.de> (Frank
	Lichtenheld's message of "Sat, 7 Apr 2007 16:58:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44000>

Frank Lichtenheld <frank@lichtenheld.de> writes:

> +[[dbbackend]]
> +Database Backend
> +----------------
> +
> +git-cvsserver uses one database per git head (i.e. CVS module) to

Probably "git branch" is easier to understand than "git head".

> +store information about the repository for faster access. The
> +database doesn't contain any persitent data and can be completly
> +regenerated from the git repository at any time. The database
> +needs to be updated (i.e. written to) after every commit. That
> +means that even if you offer only read access (e.g. by using
> +the pserver method), git-cvsserver should have write access to
> +the database to work reliably (otherwise you need to make sure
> +that the database if up-to-date all the time git-cvsserver is run).

This rationale for db update is a bit hard to understand.
Immediately saying that you need a database update "after every
commit", you say that read-only access still need it.

I think the situation where database update is needed is when a
commit on the branch that has not been given to any cvs client
is given out for the first time, and when somebody adds new
commits from git side, the cvsserver session that serves the
commit for the first time needs to record the branch
information.
