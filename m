From: "Steven J. Murdoch" <git+Steven.Murdoch@cl.cam.ac.uk>
Subject: Preserving empty directories when doing a git-svn clone/rebase
Date: Sun, 15 Nov 2009 02:06:05 +0000
Message-ID: <20091115020605.GE15966@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 03:56:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9VHa-00036b-A7
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 03:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbZKOCzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 21:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbZKOCzz
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 21:55:55 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:56479 "EHLO mta2.cl.cam.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751583AbZKOCzy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 21:55:54 -0500
X-Greylist: delayed 2994 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Nov 2009 21:55:54 EST
Received: from alport.cl.cam.ac.uk ([128.232.9.64])
	by mta2.cl.cam.ac.uk with esmtp (Exim 3.092 #1)
	id 1N9UVC-0002Ns-00; Sun, 15 Nov 2009 02:06:06 +0000
Received: from sjm217 by alport.cl.cam.ac.uk with local (Exim 4.69)
	(envelope-from <sjm217@cl.cam.ac.uk>)
	id 1N9UVB-0007E0-Ji; Sun, 15 Nov 2009 02:06:05 +0000
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132907>

When git-svn clones a Subversion repository, any empty directories
appear to be silently dropped (tested using git version 1.6.5.2 on Mac
OS X Snow Leopard). This causes problems for using git with software
projects which depend on Subversion's ability to track empty
directories. I was recently caught out by this, and it was difficult
to debug what had gone wrong.

Would it be possible to change git-svn to handle this case? Since git
doesn't have the ability to track empty directories, probably the
simplest thing to do would be to automatically add a file (e.g.
.gitignore) to any empty directories. In theory this could cause
problems, but I would think the chances of this are far lower than
with the current behaviour.

I think this feature would help projects in which some contributors
are transitioning to git. It would especially be useful to novice
users of git, who are not aware of the potential problems with having
empty directories.

I see there was a discussion in 2006:
 http://kerneltrap.org/mailarchive/git/2006/11/29/231586

However, since then I haven't seen any updates. The rationale behind
the original request still seems applicable today:

 "I think there are many potential git users out there who are
 currently svn users.  And git-svn is a really nice way to get started,
 but this sort of stumbling block could really turn people off.  For
 example, it made me look pretty dumb when I carelessly complained to
 my colleague about his code not working and then it turns out to be
 because my super-advanced scm tool "messed things up"."
  (git-svn and empty directories in svn (was: [PATCH 1.2/2 (fixed)]
   git-svn: fix output reporting from the delta fetcher))

Thanks,
Steven Murdoch.

-- 
http://www.cl.cam.ac.uk/users/sjm217/
