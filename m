From: Jody McIntyre <scjody@sun.com>
Subject: 'git pull' fails with 'not uptodate' message despite 'git reset	--hard'
Date: Tue, 28 Jul 2009 19:08:43 -0400
Message-ID: <20090728230842.GE22281@clouds>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 01:13:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVvrj-0005dk-Fz
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 01:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbZG1XJU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 19:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755900AbZG1XIt
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 19:08:49 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:45212 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755006AbZG1XIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 19:08:46 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n6SN8iEY011266
	for <git@vger.kernel.org>; Tue, 28 Jul 2009 16:08:45 -0700 (PDT)
Content-disposition: inline
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 id <0KNI00I00LH2JU00@fe-sfbay-10.sun.com> for git@vger.kernel.org; Tue,
 28 Jul 2009 16:08:44 -0700 (PDT)
Received: from shinkansen.modernduck.com ([unknown] [24.37.153.200])
 by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 with ESMTPSA id <0KNI00LVTLMIH7E0@fe-sfbay-10.sun.com> for
 git@vger.kernel.org; Tue, 28 Jul 2009 16:08:44 -0700 (PDT)
Received: by shinkansen.modernduck.com (sSMTP sendmail emulation); Tue,
 28 Jul 2009 19:08:43 -0400
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124289>

I am attempting to update my kernel tree but getting a 'not uptodate' error:

$ git fetch origin
[...]
$ git pull origin tags/v2.6.31-rc4
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * tag               v2.6.31-rc4 -> FETCH_HEAD
Updating 6847e15..4be3bd7
error: Entry 'CREDITS' not uptodate. Cannot merge.

'git diff' shows no changes, and neither 'git reset --hard' nor
'git checkout -f HEAD' fix the issue.  Simple 'git pull' doesn't work either:

$ git diff CREDITS
$ git reset --hard
Checking out files: 100% (27891/27891), done.
HEAD is now at 6847e15 Linux 2.6.31-rc3
$ git pull origin tags/v2.6.31-rc4
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * tag               v2.6.31-rc4 -> FETCH_HEAD
Updating 6847e15..4be3bd7
error: Entry 'CREDITS' not uptodate. Cannot merge.
$ git checkout -f HEAD
Checking out files: 100% (29096/29096), done.
Your branch is behind 'origin/master' by 484 commits, and can be fast-forwarded.
$ git pull origin tags/v2.6.31-rc4
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * tag               v2.6.31-rc4 -> FETCH_HEAD
Updating 6847e15..4be3bd7
error: Entry 'CREDITS' not uptodate. Cannot merge.
$ git pull
Updating 6847e15..7d3e91b
error: Entry 'CREDITS' not uptodate. Cannot merge.

I use quilt with this tree but no quilt patches are currently applied and it
should be clean.  It hasn't even been built (I rsync to another machine for
that.)

According to the documentation, I believe what I'm doing should work - even if
my tree was unclean, 'git checkout -f HEAD' or 'git reset --hard' would fix it.
What am I doing wrong?

Thanks,
Jody
