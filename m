From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: GIT on MinGW problem
Date: Fri, 25 May 2007 10:49:08 +0200
Organization: eudaptics software gmbh
Message-ID: <4656A304.AF39A0B6@eudaptics.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 25 10:48:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrVTX-0006bB-Fo
	for gcvg-git@gmane.org; Fri, 25 May 2007 10:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbXEYIsg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 04:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbXEYIsg
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 04:48:36 -0400
Received: from main.gmane.org ([80.91.229.2]:56088 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676AbXEYIsf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2007 04:48:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrVTC-0006Nk-Qd
	for git@vger.kernel.org; Fri, 25 May 2007 10:48:22 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 10:48:22 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 25 May 2007 10:48:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48346>

Han-Wen Nienhuys wrote:
> 
> Aaron Gray escreveu:
> > Hello,
> >
> > I have installed the git-1.5.1-1.mingw.exe from
> > http://lilypond.org/git/binaries/mingw/.
> >
> > On typing 'git' I get a message box saying :-
> >
> >        The procedure entry point libiconv could not be located in the
> > dynamic link library libiconv-2.dll.
> >
> > I cannot seem to find libiconv-2.dll anywhere either.
> 
> This should be fixed in
> 
> http://lilypond.org/git/binaries/mingw/git-1.5.1-2.mingw.exe
> 
> it should also set $PATH.

I gave this some more testing and it turns out to be a well working
toolset. Thank you very much!

There were still some issues remaining. These are the ones that should
be fixable easily:

* git version reports just:

	git version -dirty

Since git-gui parses the output of git version, but does not expect it
to be of this format, and fails with an error message that it cannot
parse the version.

* git without an correct git subcommand should list 20 or so commands,
but it doesn't. The list is just empty.

* I personally think that the files should go into

	$PROGRAMFILES/Git/{bin,share,lib}
instead of
	$PROGRAMFILES/Git/usr/{bin,share,lib}

The more difficult to solve problems are:

* git-gui and gitk don't work out of the box because they have the path
to wish hardcoded. They can't be started from CMD at all. I have written
wrappers gitk.cmd and git-gui.cmd with these 2 lines:

@echo off
start wish84 D:/MSYS/1.0/git/bin/gitk %*

But as you can see, the path is still hard-coded (but it is good enough
for me for the moment).

* perl scripts like git-remote contain a hard-coded path to the
installation directory and don't work for this reason.

-- Hannes
