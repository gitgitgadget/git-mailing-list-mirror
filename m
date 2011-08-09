From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] On Cygwin support both UNIX and DOS style path-names
Date: Tue, 09 Aug 2011 18:24:26 +0100
Message-ID: <4E416D4A.40602@ramsay1.demon.co.uk>
References: <1312560614-20772-1-git-send-email-pascal@obry.net> <1312560614-20772-3-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Tue Aug 09 20:31:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qqr5a-00036K-F9
	for gcvg-git-2@lo.gmane.org; Tue, 09 Aug 2011 20:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab1HISbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Aug 2011 14:31:36 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:63011 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751484Ab1HISbg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2011 14:31:36 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1Qqr5S-0002La-ab; Tue, 09 Aug 2011 18:31:35 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <1312560614-20772-3-git-send-email-pascal@obry.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179039>

Pascal Obry wrote:
> In fact Cygwin supports both, so make Git agree with this.
> The failing case is when a file is committed in a sub-dir of the
> repository using a log message from a file specified with a DOS
> style path-name. To reproduce:
> 
>    $ cd src
>    $ git commit -F c:\tmp\log.txt file.c
>    fatal: could not read log file 'src/c:\tmp\log.txt': No such file \
>    or directory.

Hmm, are you using bash or cmd.exe? Using bash I get the following:

    $ cd src
    $ git commut -F c:\tmp\log.txt file.c
    fatal: could not read file 'src/c:tmplog.txt': No such file or directory
    $ 

Which is what I would expect of (any) posix shell, viz:

    $ ls c:\
    > ^C
    $ ls c:\\
    AUTOEXEC.BAT*            NTDETECT.COM*               WATCOM/       msysgit/
    CMPNENTS/                Program Files/              WINDOWS/      msysgit-old/
    CONFIG.SYS*              RECYCLER/                   boot.ini*     ntldr*
    Documents and Settings/  SUPPORT/                    cygwin/       pagefile.sys
    I386/                    SWSTAMP.TXT*                cygwintemp/   ssl/
    IO.SYS*                  System Volume Information/  dm/           uname/
    MSDOS.SYS*               TOOLSCD/                    dm840/        zlib/
    MSOCache/                VALUEADD/                   hiberfil.sys
    $ 

If you want to use cmd.exe as your shell, I suspect msysGit (Git For Windows)
may be a better fit.

ATB,
Ramsay Jones
