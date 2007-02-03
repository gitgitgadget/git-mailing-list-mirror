From: Pavel Roskin <proski@gnu.org>
Subject: stg pull doesn't pull anymore
Date: Fri, 02 Feb 2007 22:00:47 -0500
Message-ID: <1170471647.9733.24.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Feb 03 04:01:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDB9E-0005Ja-Mw
	for gcvg-git@gmane.org; Sat, 03 Feb 2007 04:01:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946244AbXBCDAu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 22:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946265AbXBCDAu
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 22:00:50 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:56544 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946244AbXBCDAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 22:00:49 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HDB7x-0001Ax-06
	for git@vger.kernel.org; Fri, 02 Feb 2007 21:59:45 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1HDB8x-00056q-8O; Fri, 02 Feb 2007 22:00:47 -0500
X-Mailer: Evolution 2.8.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38546>

Hello!

I have noticed that "stg pull" doesn't merge the latest changes anymore.
It fetches the new branches, but the HEAD remains unchanged.

I'm using the current version of git and StGIT (mast branches of both).
I don't have any local patches.

I've checked the log of StGIT changes and I see that StGIT does "git
fetch" instead of "git pull" now.  I don't have a .gitconfig file, so I
should get the new default behavior.  I don't see any changes to StGIT
documentations.

The problem is observed with the git repository.  It stays at
e4b0e4ab8ee68df0fa99100640ed5cb54b736141 although
refs/remotes/origin/master has advanced to
aacd404e775ad73188ae9157041d7cc530d5625c.

My guesses what may be happening:

1) "stg pull" is intended not to merge the changes.  In this case, I
expect changes to the documentation and a new command that would merge
the changes.

2) The there is a bug in the implementation of stgit.pull-does-rebase.
We are merging the local refs/heads/master instead of the one from
FETCH_HEAD.  This suspicion is confirmed by the fact that StGIT sources
have no references to FETCH_HEAD, and the only git command that reads it
is git-pull, which we are not calling by default now.

-- 
Regards,
Pavel Roskin
