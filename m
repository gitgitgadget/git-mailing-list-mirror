From: Junio C Hamano <junkio@cox.net>
Subject: Re: [GIT PULL] Please pull mergetool.git
Date: Wed, 14 Mar 2007 02:45:07 -0700
Message-ID: <7vtzwob1lo.fsf@assigned-by-dhcp.cox.net>
References: <E1HRI5K-0008T9-9e@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 14 10:45:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRQ2u-0007zy-Va
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 10:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030837AbXCNJpL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 05:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030829AbXCNJpL
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 05:45:11 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51804 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030837AbXCNJpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 05:45:09 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070314094509.XYBS24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 05:45:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id aZl81W0071kojtg0000000; Wed, 14 Mar 2007 05:45:08 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42193>

"Theodore Ts'o" <tytso@mit.edu> writes:

> In order to make this easier for me to send future features and
> cleanups, I've set up a repository on repo.or.cz.  So please pull from:
>
> 	git://repo.or.cz/git/mergetool.git
>
> The final patch that is the repository is attached.

Thanks, pulled.

There should be a checklist for adding a new user-level command.

I've been reluctant to write this up, partly because some people
seem to be disturbed by seeing too many git-blah commands in
their distro's /usr/bin/ and I've been avoiding introducing new
commands (I even rejected "git-diff2", which I liked what it
did), but that is a lame excuse.

So here it is.

 - An .gitignore entry to ignore the build product.

 - An Makefile entry to build and clean.

   - For scripts, add git-foo.sh to SCRIPT_SH (or
     git-foo.perl to SCRIPT_PERL).

   - For a new built-in 'git-foo' that is produced from
     builtin-foo.c, add builtin-foo.o to BUILTIN_OBJS.

   - For a new standalone 'git-foo' whose main is in foo.c, add
     git-foo$X to PROGRAMS.

   - (these are not limited to a new program) If you are adding
     a library object 'foo.o', add it to LIB_OBJS; add new
     headers to to LIB_H.  For the latter, sorry but our
     dependencies are a bit too eager to recompile.

 - Asciidoc manual in Documentation/git-foo.txt to be formatted
   to both HTML and man.

 - An entry in Documentation/cmd-list.perl (the list at the end
   of the script).  This is used to link the command from the
   main documentation git(7) and git.html.

The last one you missed but that is not a big deal.  I'll add an
extra commit to add one entry to classify this as an ancillary
manipulator.
