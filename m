From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] Clean up work-tree handling
Date: Fri, 27 Jul 2007 12:20:29 -0700
Message-ID: <7v8x911wn6.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707260729150.14781@racer.site>
	<20070726220949.GA4420@moooo.ath.cx>
	<Pine.LNX.4.64.0707271146290.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 27 21:20:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEVMa-0006Dl-38
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 21:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbXG0TUc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 15:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762407AbXG0TUb
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 15:20:31 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34740 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbXG0TUb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 15:20:31 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070727192031.FITP14885.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Jul 2007 15:20:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id UjLW1X0061kojtg0000000; Fri, 27 Jul 2007 15:20:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53952>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But there is a fundamental question I have to ask: Is there any reason why 
>
> 	$ git --git-dir=/some/where/else.git bla
>
> should pretend that the repo is bare if core.bare == 1?  I mean, we are 
> implicitely setting the work tree to the cwd, no?

I have two repositories at the primary k.org machine.

 - /home/junio/git.git --- this is with a worktree so that I can
   build and test on a FC machine (my primary development
   machine at home is a Debian).

 - /pub/scm/git/git.git/ --- this is a bare repository that is
   mirrored out to git://git.kernel.org/ and friends.

And I usually am in the former.  From time to time, I do this:

 $ GIT_DIR=/pub/scm/git/git.git/ git fsck
 $ GIT_DIR=/pub/scm/git/git.git/ git repack

because I am old fashioned, but I would expect these to be
equivalent to the above:

 $ git --git-dir=/pub/scm/git/git.git/ fsck
 $ git --git-dir=/pub/scm/git/git.git/ repack

I do not think these imply that the repository is with worktree.
