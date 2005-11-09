From: Jon Loeliger <jdl@freescale.com>
Subject: Re: Expected Behavior?
Date: Tue, 08 Nov 2005 20:58:58 -0600
Message-ID: <E1EZgAs-0008B4-QZ@jdl.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 04:02:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZgB5-0000pv-OU
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 03:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbVKIC7H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 21:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbVKIC7H
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 21:59:07 -0500
Received: from mail.jdl.com ([66.118.10.122]:43725 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1030277AbVKIC7G (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Nov 2005 21:59:06 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1EZgAs-0008B4-QZ
	for git@vger.kernel.org; Tue, 08 Nov 2005 20:58:59 -0600
To: git@vger.kernel.org
In-Reply-To: 20051108210332.GB23265@c165.ib.student.liu.se
X-Spam-Score: -105.9 (---------------------------------------------------)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11384>

<Young Frankenstein> Froe-derick wrote: </Young Frankenstein>

> Jon: You could try to this merge with the recursive merge strategy
> (git merge -s recursive 'merge message' master dev) If you do, you
> _should_ get something like:
> 
>     CONFLICT (add/add): File file3 added non-identically in both
>     branches. Adding as file3_master and file3_dev instead.

Hmmm. That didn't go too well. Concisely:

    % git merge -s recursive "Grab dev stuff" master dev
    Trying really trivial in-index merge...
    fatal: Merge requires file-level merging
    Nope.
    Traceback (most recent call last):
      File "/usr/bin/git-merge-recursive", line 8, in ?
	from gitMergeCommon import *
    ImportError: No module named gitMergeCommon
    Automatic merge failed/prevented; fix up by hand

Full details below.

> You will then end up with file3_master and file3_dev in your working
> tree, which corresponds to file3 in the master branch and file3 in the
> dev branch, respectively.

That'd be cool, because the first thing I tend to want to do
after a failed file merge is look at clear versions of both files.
Gives me a global sense of where the file needs to go...  You know.

jdl





[ tail end of the make install output ]

install -d -m755 '/usr/share/git-core/templates/'
(cd blt && tar cf - .) | \
(cd '/usr/share/git-core/templates/' && tar xf -)
make[1]: Leaving directory `/usr/src/git-core/templates'
install -d -m755 '/usr/share/git-core/python'
install gitMergeCommon.py '/usr/share/git-core/python'



% git merge -s recursive "Grab dev stuff" master dev
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Traceback (most recent call last):
  File "/usr/bin/git-merge-recursive", line 8, in ?
    from gitMergeCommon import *
ImportError: No module named gitMergeCommon
Automatic merge failed/prevented; fix up by hand

% git -v
git version 0.99.9.GIT
% cat /usr/src/git-core/.git/HEAD
f8d294f0a44c4305a9f3a1c70beb6a1c7583f287


% ll /usr/share/git-core/python/
total 16
4 drwxr-xr-x  2 root root 4096 Nov  8 20:17 .
4 drwxr-xr-x  4 root root 4096 Sep 14 19:47 ..
8 -rwxr-xr-x  1 root root 6879 Nov  8 20:17 gitMergeCommon.py

% python
Python 2.3.5 (#2, May  4 2005, 08:51:39)
[GCC 3.3.5 (Debian 1:3.3.5-12)] on linux2
