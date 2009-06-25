From: tom fogal <tfogal@alumni.unh.edu>
Subject: git-svn seems confused about current HEAD
Date: Wed, 24 Jun 2009 18:00:44 -0600
Message-ID: <auto-000019790488@sci.utah.edu>
Reply-To: tfogal@sci.utah.edu
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 25 02:30:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJcra-0002MU-FH
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 02:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754808AbZFYAak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 20:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754307AbZFYAak
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 20:30:40 -0400
Received: from mail.sci.utah.edu ([155.98.58.79]:52841 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753969AbZFYAak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 20:30:40 -0400
X-Greylist: delayed 1801 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Jun 2009 20:30:40 EDT
Received: from dummy.name; Wed, 24 Jun 2009 18:00:41 -0600
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122172>

I've got a repository that git-svn won't grab the most recent commits
for:

  tf@shigeru tuvok ~/sw/bin/git svn find-rev HEAD
  1164
  tf@shigeru tuvok ~/sw/bin/git svn fetch
  tf@shigeru tuvok ~/sw/bin/git --version
  git version 1.6.3.3

The repository is actually at revision 1184.  It's browsable online:

  https://gforge.sci.utah.edu/gf/project/Tuvok/scmsvn/

and publicly clonable:

  https://gforge.sci.utah.edu/svn/Tuvok

Interestingly, 1165 is also a commit which contains a string which
is not representable in 8bit ASCII in the commit log.  This is very
likely to be the only such commit in the repository's history.  After
cloning, setting i18n.commitencoding and i18n.logoutputencoding to
ISO-8859-1 and then trying another `git svn fetch' does not seem to
have any effect.

Revisions 1166-1169 actually correspond to some commits I did to split
a particular directory of that repository into another repository, and
then add an svn:external for it.  I did that via an svn checkout.

This is actually a `secondary' clone.  In the clone I use to do daily
work, I have somehow magically convinced my git repository that commits
116[56] do not exist.  A contiguous snippet from `git log':

  commit 351dedb982af09e170b17001340208af46b197b5
  Author: tfogal <tfogal@c36c8488-0289-0348-9b64-b301f74bd9a7>
  Date:   Sat Jun 6 20:42:11 2009 +0000

      Use external `scio' repository.

      git-svn-id: https://gforge.sci.utah.edu/svn/Tuvok@1167
  c36c8488-0289-0348-9b64-b301f74bd9a7

  commit 401493d9175ebdb3c62d6524c701944f208aba94
  Author: tfogal <tfogal@c36c8488-0289-0348-9b64-b301f74bd9a7>
  Date:   Fri Jun 5 22:54:48 2009 +0000

      no newline at EOF issue.

      git-svn-id: https://gforge.sci.utah.edu/svn/Tuvok@1164
  c36c8488-0289-0348-9b64-b301f74bd9a7

I have no idea how I managed to do that, but it seems to have done
the trick; I haven't noticed any issues with that clone, and I've
apparently been working with it for a couple weeks now.

Is there a known workaround for this issue (or, how did I manage to
`ignore' those commits in my initial repo)?

Thanks,

-tom
