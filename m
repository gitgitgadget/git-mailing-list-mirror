From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Announce: Git for Windows 1.6.3
Date: Thu, 7 May 2009 19:27:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905071554070.16585@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: msysgit@googlegroups.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 19:28:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M27Nq-0002gO-RH
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 19:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbZEGR1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 13:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbZEGR1i
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 13:27:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:58488 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751171AbZEGR1h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 13:27:37 -0400
Received: (qmail invoked by alias); 07 May 2009 17:27:36 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp036) with SMTP; 07 May 2009 19:27:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187aAd3h287+KeusNaWP9CHgA1Pd8uohgYju0lvQg
	RiHmBSRezI3Pik
X-X-Sender: schindel@intel-tinevez-2-302
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118496>

Hi,

this mail tries to inform you that a new version of Git for Windows has 
been released.  Overall, the differences to Git 1.6.3 have been reduced 
dramatically, thanks to the immense efforts of Johannes Sixt on the test 
suite.

There are two major modifications relative to git.git, though: Marius 
Storm-Olsen's readdir() and nedmalloc patches.  They are rather large, but 
well-contained changes, and we tested extensively in the last few weeks.

One consequence is that the test-suite no longer takes 45 minutes on the 
machine I test on, but less than 20 minutes.

And now, without further ado, the release notes:

Git Release Notes (Git-1.6.3-preview20090507)
Last update: 07 May 2009

Known issues

- Some commands are not yet supported on Windows and excluded from the 
  installation; namely: git archimport, git cvsexportcommit, git 
  cvsimport, git cvsserver, git instaweb, git send-email, git shell.
- The Logitec QuickCam software can cause spurious crashes. See "Why does 
  make often crash creating a sh.exe.stackdump file when I try to compile 
  my source code?" on the MinGW Wiki 
  (http://www.mingw.org/wiki/Environment_issues)
- The Quick Launch icon will only be installed for the user running setup 
  (typically the Administrator). This is a technical restriction and will 
  not change.
- Git Bash launched through the Explorer shell extension does not have the 
  git icon in its taskbar. This is a technical restriction and will not 
  change.
- git send-mail does not work properly (Issue 27).
- curl uses $HOME/_netrc instead of $HOME/.netrc.
- If you want to specify a different location for --upload-pack, you have 
  to start the absolute path with two slashes. Otherwise MSys will mangle 
  the path.
- git and bash have serious problems with non-ASCII file names (Issue 80, 
  108, 159, 188).
- If configured to use plink, you will have to connect with putty first, 
  as you cannot accept the host key due to the console window being 
  blocked (Issue 96).
- MinGW does not support IPv6 yet (Issue 182).
- When run from cmd.exe instead of Git Bash, some characters seem to be 
  "swallowed" from Git's output (Issue 192).
- There are a spurious write errors during rebase (Issue 200) that seem 
  not to be reproducible on most computers.
- As merge tools are executed using the MSys bash, options starting with 
  "/" need to be handled specially: MSys would interpret that as a POSIX 
  path, so you need to double the slash (Issue 226).  Example: instead of 
  "/base", say "//base".  Also, extra care has to be paid to pass Windows 
  programs Windows paths, as they have no clue about MSys style POSIX 
  paths -- You can use something like $(cmd //c echo "$POSIXPATH").

Changes since Git-1.6.2.2-preview20090408

New Features

- Comes with official git 1.6.3.
- Thanks to Marius Storm-Olsen, Git has a substantially faster readdir() 
  implementation now.
- Marius Storm-Olsen also contributed a patch to include nedmalloc, again 
  speeding up Git noticably.
- Compiled with GCC 4.4.0

Bugfixes

- Portable Git contains a README.portable.
- Portable Git now actually includes the builtins.
- Portable Git includes git-cmd.bat and git-bash.bat.
- Portable Git is now shipped as a .7z; it still is a self-extracting 
  archive if you rename it to .exe.
- Git includes the Perl Encode module now.
- Git now includes the filter-branch tool.
- There is a workaround for a Windows 7 regression triggering a crash in 
  the progress reporting (e.g. during a clone). This fixes issues 236 and 
  247.
- gitk tries not to crash when it is closed while reading references 
  (Issue 125, thanks Pat Thoyts).
- In some setups, hard-linking is not as reliable as it should be, so we 
  have a workaround which avoids hard links in some situations (Issues 222 
  and 229).
- git-svn sets core.autocrlf to false now, hopefully shutting up most of 
  the git-svn reports.

Ciao,
Dscho (on behalf of the msysGit team)
