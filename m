From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sat, 10 Mar 2007 21:34:14 -0800
Message-ID: <7vabykxs15.fsf@assigned-by-dhcp.cox.net>
References: <20070311043250.GA21331@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 06:34:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQGhI-00063P-6x
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 06:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166AbXCKFeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 00:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933175AbXCKFeR
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 00:34:17 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:64796 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166AbXCKFeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 00:34:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311053416.GZDI321.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 00:34:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZHaE1W00h1kojtg0000000; Sun, 11 Mar 2007 00:34:15 -0500
cc: git@vger.kernel.org
In-Reply-To: <20070311043250.GA21331@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 11 Mar 2007 05:32:50 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41912>

Matthias Lederhofer <matled@gmx.net> writes:

> Missing:
> Documentation update but if this feature should not get accepted..
> therefore I'll wait for feedback first.

Did I say something about a comment like this in the past?  But
I'll let this pass this time...

> Idea:
> Add some way to configure tho working directory for one repository
> and set GIT_WORK_DIR automatically when GIT_DIR is used.  I think of:
>  * a subdirectory in the repository directory
>    e.g. .git/work_dir which is supposed to be a symlink (or a textfile
>    containing the path for windows compatibility?)
> or
>  * a configuration variable

I am not sure why you bother.  Obviously I am missing a few
useful use cases you and Nguyen have in mind.

One very typical use of GIT_DIR to have the repository somewhere
other than the usual $GIT_TOP_DIR/.git is to do an initial
import from an extracted tarball into a bare repository (and
then wipe away the temporary directory that contains extracted
tarball), and that use case I understand well.

But either .git/work_dir or a configuration means you are
linking a repository with a _single_ working tree, permanently.
If you are permanently linking one repository with a _single_
working tree, is it too much bother to have that repository at
the usual $GIT_TOP_DIR/.git like everybody else?

If storage space is the issue, then doing

	$ln -s $else_where/.git .git

would be sufficient.

What's the real motivation behind all this?  

I've heard read-only working tree in the past, but that cannot
be it.  If the working tree is read-only and if you are telling
git to always use that read-only working tree when using that
particular repository, what useful git operations are you doing
while in that working tree?
