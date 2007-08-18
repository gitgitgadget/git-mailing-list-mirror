From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: file disappears after git rebase (missing one commit)
Date: Sat, 18 Aug 2007 21:37:34 +0200
Message-ID: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 21:37:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMU7A-0000i4-US
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 21:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758168AbXHRThg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 15:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758145AbXHRThg
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 15:37:36 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:45322 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758032AbXHRThf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 15:37:35 -0400
Received: by wa-out-1112.google.com with SMTP id j4so291515wah
        for <git@vger.kernel.org>; Sat, 18 Aug 2007 12:37:34 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QWncYlr6qJM8epaZH2sWSSdFMv9HU1Nzept6Xd+FDjseL7F4MDk1RF7w1NCnQHetAe0CY9t7g/cxlJlLANCvxSkWCF5GhTuIlLrmSg1cZeOEMApYsCcZCJT2L4vPHbDVG6IRjLjhG0ABH8WbQ7aGLNpVc6dryTfbfHHDFFLdOzA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=W8a7mdsf/MLYzx5Sf6I/FYuvTZf5jB4DwazaTFpqFN2dViSTuPOWgSzQVO3ZP+CZDlg1CU/42zHEJS9i/2j9A5EpQzm6DA6JEj0ChvjgC+OwUzrEGB4PZcGnofe3Jkd29rH1IU8IPNkxuTeImhOUzFu1F9u7HEZf/vDmfU8pjEs=
Received: by 10.114.183.1 with SMTP id g1mr706610waf.1187465854579;
        Sat, 18 Aug 2007 12:37:34 -0700 (PDT)
Received: by 10.114.180.20 with HTTP; Sat, 18 Aug 2007 12:37:34 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56109>

Hi,

I'm trying to rebase a branch ("msmtp") on another branch ("devel").
The msmtp has a number of commits that are already in the devel branch
(but with different history) and one new commit that adds one file.

$ git clone git://repo.or.cz/msysgit.git
$ cd msysgit
$ git rev-parse origin/msmtp
b11cf4ce6262a7c3b243e3cfdc70e6b44682cb59
$ git rev-parse origin/devel
57aa8405103856106ec0e31453089c33c899c98b
$ git -b checkout devel origin/devel
$ git -b checkout msmtp origin/msmtp
$ git show-branch msmtp devel
* [msmtp] Added msmtp.exe SMTP client
 ! [devel] Add disk summarize tool (du.exe)
--
 + [devel] Add disk summarize tool (du.exe)
 + [devel^] gdb updated to v6.6
 + [devel~2] w32api updated to v3.10
 + [devel~3] Updated gcc to v3.4.5
 + [devel~4] Updated binutils to v2.17.50
 + [devel~5] Remove remnants of the c++ compiler
 + [devel~6] GitMe: only fetch 'master' of msysgit.git
 + [devel~7] GitMe: inline 7z's install script
 + [devel~8] GitMe: avoid dependency on cmd.exe
 + [devel~9] msysGit: adjust for submodule layout
 + [devel~10] msysGit: we have 7zip installed in /share/7-Zip/ now
 + [devel~11] msysGit: 7z cannot update existing installers
 + [devel~12] msysGit: move scripts to /share/msysGit/
 + [devel~13] WinGit: do not pack builtins, but copy them when unpacking
 + [devel~14] Update TODO: Marius squashed two
 + [devel~15] WinGit: strip executables (Issue 25)
 + [devel~16^2] GitMe: fix HTTP transport
 + [devel~16^2^] Undo hacky she-bang fixup
 + [devel~16^2~2] Issue 21: core.autocrlf should be set to true (at
least for end-users)
 + [devel~16^2~3] Add clear script, and remove the clear=clsb alias in profile
 + [devel~16^2~4] Make 7z functional
 + [devel~16^2~5] msys: support for Windows XP x64
 + [devel~16^2~6] Removed all SuperGitMe functionality Also propagated
latest fixes and made installer even smaller
 + [devel~16^2~7] Fixed Issue 37: Errors during install because repo
now has tags
 + [devel~18] Issue 21: core.autocrlf should be set to true (at least
for end-users)
 + [devel~19] Add clear script, and remove the clear=clsb alias in profile
 + [devel~20] Make 7z functional
 + [devel~21] msys: support for Windows XP x64
 + [devel~22] GitMe SuperFetch
 + [devel~23] Latest git submodule
*  [msmtp] Added msmtp.exe SMTP client
*  [msmtp^] gdb updated to v6.6
*  [msmtp~2] w32api updated to v3.10
*  [msmtp~3] Updated gcc to v3.4.5
*  [msmtp~4] Updated binutils to v2.17.50
*  [msmtp~5] Remove remnants of the c++ compiler
*+ [devel~24] GitMe: check if cygwin is in PATH; if so abort installer.
$ find bin -name "msmtp.exe"
bin/msmtp.exe

Note! that this file is added with the commit "*  [msmtp] Added
msmtp.exe SMTP client". After rebase I expect that this commit will be
on top of the devel branch.

$ cat .git/HEAD
ref: refs/heads/msmtp
$ git rebase devel
First, rewinding head to replay your work on top of it...
HEAD is now at 57aa840... Add disk summarize tool (du.exe)
Nothing to do.
$ git show-branch msmtp devel
* [msmtp] Add disk summarize tool (du.exe)
 ! [devel] Add disk summarize tool (du.exe)
--
*+ [msmtp] Add disk summarize tool (du.exe)
$ find bin -name "msmtp.exe"

And the msmtp commit + file is lost.

I've tested on windows (4msysgit.git):
$ git --version
git version 1.5.3.rc4.mingw.2.49.g3314

And on linux (git.git):
$ git --version
git version 1.5.2.5.g0734d

And on linux with next branch (git.git)
$ git version
git version 1.5.3.rc5.843.gdac75


Is this a bug?  Any ideas?

Best regards,

//Torgil
