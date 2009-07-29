From: Jody McIntyre <scjody@sun.com>
Subject: Re: 'git pull' fails with 'not uptodate' message despite 'git	reset
 --hard'
Date: Wed, 29 Jul 2009 16:36:37 -0400
Message-ID: <20090729203637.GF22281@clouds>
References: <20090728230842.GE22281@clouds>
 <32541b130907281719y57862c25w524f5bbf1df11c40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 22:37:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWFte-00084c-Of
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 22:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540AbZG2Ugr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 16:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbZG2Ugr
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 16:36:47 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:49146 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbZG2Ugq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 16:36:46 -0400
Received: from fe-sfbay-09.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n6TKah8c023908
	for <git@vger.kernel.org>; Wed, 29 Jul 2009 13:36:43 -0700 (PDT)
Content-disposition: inline
Received: from conversion-daemon.fe-sfbay-09.sun.com by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 id <0KNK00M008Y9U900@fe-sfbay-09.sun.com> for git@vger.kernel.org; Wed,
 29 Jul 2009 13:36:43 -0700 (PDT)
Received: from shinkansen.modernduck.com ([unknown] [24.37.153.200])
 by fe-sfbay-09.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 with ESMTPSA id <0KNK006GN991DQ00@fe-sfbay-09.sun.com>; Wed,
 29 Jul 2009 13:36:39 -0700 (PDT)
Received: by shinkansen.modernduck.com (sSMTP sendmail emulation); Wed,
 29 Jul 2009 16:36:37 -0400
In-reply-to: <32541b130907281719y57862c25w524f5bbf1df11c40@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124385>

On Tue, Jul 28, 2009 at 08:19:54PM -0400, Avery Pennarun wrote:
> I've run into this problem when I rsync a tree from one system to
> another.  The inodes will be different, so merge will think files in
> the work tree have changed, but then diff (of course) won't see
> anything because it looks at the actual file contents, which are
> identical.

Interesting.  Now that I think about it, I do rsync this tree between my
desktop and laptop.  This would explain why I only just started seeing this
problem - I probably originally pulled the tree to my desktop, but this week
I'm working on my laptop.

> Usually a 'git status' will fix it.  In any case, if it doesn't,
> please send the output of 'git status' :)

This is again a bit strange:

$ git status
# On branch master
# Your branch is behind 'origin/master' by 484 commits, and can be fast-forwarded.
#
nothing to commit (working directory clean)
$ git status CREDITS > /tmp/git_status.txt
$ wc -l /tmp/git_status.txt
26063 /tmp/git_status.txt
$ head /tmp/git_status.txt 
# On branch master
# Your branch is behind 'origin/master' by 484 commits, and can be fast-forwarded.
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working directory)
#
#       modified:   .gitignore
#       modified:   .mailmap
#       modified:   COPYING

There appears to be an entry for every file in my tree minus things that
are in .gitignore.  git_status.txt is available at:

http://www.modernduck.com/files/git_status.txt

> I believe this cache out-of-dateness issue was fixed in a recent version of git.

I'll try that in the next few days and report back.

Thanks,
Jody

> 
> Have fun,
> 
> Avery
