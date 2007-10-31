From: Sergei Organov <osv@javad.com>
Subject: Bug in git-show-branch, or in core-tutorial?
Date: Wed, 31 Oct 2007 23:17:39 +0300
Message-ID: <878x5j3uos.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 21:18:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InK0o-0004Bf-7A
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:18:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbXJaURr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 16:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752287AbXJaURr
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:17:47 -0400
Received: from javad.com ([216.122.176.236]:2559 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155AbXJaURr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:17:47 -0400
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id l9VKHjm87924
	for <git@vger.kernel.org>; Wed, 31 Oct 2007 20:17:45 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1InK0R-000080-ME
	for git@vger.kernel.org; Wed, 31 Oct 2007 23:17:39 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62862>

Or is it me who needs a fix?

[Sorry, this is roughly a repeat of my earlier post
<http://permalink.gmane.org/gmane.comp.version-control.git/62493>
I didn't get any answer to, and I'm trying once more to attract
your attention to the issue.]

Please consider the following quote starting at core-tutorial.txt:933
(emphasis is mine):

<quote>
------------------------------------------------
$ git show-branch --topo-order master mybranch
* [master] Merge work in mybranch
 ! [mybranch] Some work.
--
-  [master] Merge work in mybranch
*+ [mybranch] Some work.
------------------------------------------------

The first two lines indicate that it is showing the two branches
and the first line of the commit log message from their
top-of-the-tree commits, you are currently on `master` branch
(notice the asterisk `\*` character), and the first column for
the later output lines is used to show commits contained in the
`master` branch, and the second column for the `mybranch`
branch. *Three* commits are shown along with their log messages.
All of them have non blank characters in the first column (`*`
shows an ordinary commit on the current branch, `-` is a merge commit), which
means they are now part of the `master` branch. Only the "Some
work" commit has the plus `+` character in the second column,
because `mybranch` has not been merged to incorporate these
commits from the master branch.  The string inside brackets
before the commit log message is a short name you can use to
name the commit.  In the above example, 'master' and 'mybranch'
are branch heads.  '*master~1*' is the first parent of 'master'
branch head.
</quote>

You see, there are only *two* commits shown by git-show-branch while
description mentions *three* of them, and there is no 'master~1' commit
in the git-show-branch output while description does mention it.

I've replayed all the tutorial up to this point, and the git-show-branch
output matches those in the tutorial exactly, but then the explanation
text makes little sense? On the other hand, the state of the repo
suggests that there should be 'master~1' commit in the git-show-branch
output in accordance with the explanation, so it's git-show-branch that
is buggy? I'm totally confused :(

Please, help!

-- 
Sergei.
