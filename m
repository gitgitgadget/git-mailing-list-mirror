From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] introduce GIT_WORK_DIR environment variable
Date: Sun, 11 Mar 2007 13:10:24 -0700
Message-ID: <7vlki3wngv.fsf@assigned-by-dhcp.cox.net>
References: <20070311043250.GA21331@moooo.ath.cx>
	<7vabykxs15.fsf@assigned-by-dhcp.cox.net>
	<20070311162201.GA26983@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:10:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQUNE-00072V-Nf
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487AbXCKUK0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbXCKUK0
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:10:26 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:61209 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932487AbXCKUKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:10:25 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311201024.XYQE24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 16:10:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZYAQ1W00V1kojtg0000000; Sun, 11 Mar 2007 16:10:25 -0400
In-Reply-To: <20070311162201.GA26983@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 11 Mar 2007 17:22:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41969>

Matthias Lederhofer <matled@gmx.net> writes:

> For example have the checkout of a git repository publicly available
> (e.g. on a webserver).  The .git directory containing all the history
> should probably not go there (especially if it tracks scripts).  Sure,
> setting strict permissions solves this too in most cases but anyway
> it's nice to have the option to move the repository away.

That's fine.  Will you constantly work inside that webserver exposed
working tree, though?  I suspect the operation you would do
there would only be "GIT_DIR=/some/where/else git checkout -f"
to refresh the published copy, so I do not think even GIT_WORK_DIR
is needed for that use case (just to make sure, I am not opposed
to having GIT_WORK_DIR -- my "why bother" is about having the
equivalent in .git/work_dir or .git/config).

> Additionally when reading the man page about GIT_DIR it says 'the
> default value is .git', which sounds a bit like "hey, if you don't
> like the name you're free to change it", but as soon as you change it
> you run into problems because git behaves strange in subdirectories :)

That is really a historical mention.  The current Porcelain-ish
depend on that "default" layout (I know you know that after
seeing what setup_git_directory does), and I think GIT_DIR
should not be taught to new people as such.

> The tools to inspect (git diff, ..) and track (git add, ..) work fine.
> So one could easily (without copying stuff around) track changes of a
> read-only directory.

Why does read-only directory have changes to begin with???
