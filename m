From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: MinGW binary installer available
Date: Thu, 08 Feb 2007 09:09:14 +0100
Organization: eudaptics software gmbh
Message-ID: <45CADAAA.74058D21@eudaptics.com>
References: <45C9E470.7030609@xs4all.nl> <Pine.LNX.4.63.0702071552470.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45C9EB54.3040406@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 08 09:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HF4O9-0002tE-6p
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 09:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161544AbXBHIMM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 03:12:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161543AbXBHIML
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 03:12:11 -0500
Received: from main.gmane.org ([80.91.229.2]:34715 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161544AbXBHIMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 03:12:10 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HF4Ly-00061S-1G
	for git@vger.kernel.org; Thu, 08 Feb 2007 09:10:02 +0100
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:10:02 +0100
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 08 Feb 2007 09:10:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39042>

Han-Wen Nienhuys wrote:
> Indeed: for now, this is intended for people clueful enough to install
> bash and perl on their own.  Adding bash itself should be easy, but
> I have no idea how to make cmd open the scripts with bash automatically.

I've thought about renaming git-commit to git-commit.cmd and add this
preamble:

@echo off
rem () { :; } ; : \
sh %0 %1 %2 %3 %4 %5 %6 %7 %8 %9
rem ; : \
exit /B %ERRORLEVEL%


in place of the usual "#!/bin/sh". It requires you to have a command
named @echo.exe in the path that is a noop. Also, it is limited to 9
command line arguments.

What a hack! (*)

-- Hannes

(*) Here's how it works:
- cmd.exe will ignore all but the sh and exit lines, effectively
invoking the script under bash and exiting with bash's exit code.
- Bash will execute @echo, define a function named rem, ignore the sh
and exit lines because they are continuations of the : noop on the
previous line. It will also run the second rem, but it is a noop, too.
