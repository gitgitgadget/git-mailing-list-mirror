From: Larry D'Anna <larry@elder-gods.org>
Subject: I'd like to be able to know what git-push will do
Date: Thu, 18 Jun 2009 17:28:03 -0400
Message-ID: <20090618212803.GA14486@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 18 23:36:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHPHw-0008Le-6T
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 23:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752883AbZFRVgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2009 17:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbZFRVgm
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 17:36:42 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:52679 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZFRVgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2009 17:36:42 -0400
X-Greylist: delayed 517 seconds by postgrey-1.27 at vger.kernel.org; Thu, 18 Jun 2009 17:36:42 EDT
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id B893C822106; Thu, 18 Jun 2009 17:28:03 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121872>

I previously sent this to Junio, but I think I should have just sent it to the
list.

I'd like to be able to call git-push --dry-run and process the result from a
perl script, but there's a snag: what does "foobar -> foobar" mean?  foobar
could be a tag or a branch.  In fact, it could be a branch on on side and a tag
on the other!  

I've tried duplicating the refspec processing in the perl script, but this
approach is highly sub-optimal because the refspec parsing and matching is so
complicated.  I would wind up duplicating a lot of functionality, and every time
it changed in git my script would become broken.

Would you accept a patch that changes the behavior of git-push so that instead of

  $ git-push --dry-run  -v origin :
  Pushing to ~/repos/bin
  To ~/repos/bin
   = [up to date]      master -> master
  Everything up-to-date
  
It would print the full names like this (only if -v is used)

  $ git-push --dry-run  -v origin :
  Pushing to ~/repos/bin
  To ~/repos/bin
   = [up to date]      refs/heads/master -> refs/heads/master
  Everything up-to-date

Or, if you don't like changing the behavior of -v, would you accept a patch with
a new option (perhaps --symbolic-full-name) that caused git-push to behave this
way?

Once I know what the user interface should be (-v or --symbolic-full-name or
whatever) I'll post a patch.

Thanks!

        --larry
