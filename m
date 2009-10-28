From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 0/4] Cygwin MSVC patches
Date: Wed, 28 Oct 2009 22:21:49 +0000
Message-ID: <4AE8C3FD.2020300@ramsay1.demon.co.uk>
References: <4AE7410D.3030109@ramsay1.demon.co.uk> <4AE7EB06.10305@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>, mstormo@gmail.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:11:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZSv-000077-DP
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:11:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753805AbZJ2SLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbZJ2SLH
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:11:07 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:52509 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751972AbZJ2SLG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Oct 2009 14:11:06 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N3ZSn-0003nM-cP; Thu, 29 Oct 2009 18:11:10 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4AE7EB06.10305@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131642>

Johannes Sixt wrote:
> Ramsay Jones schrieb:
>> With these patches, the msvc build on cygwin seems to be working fine.
> 
> What is "the msvc build on cygwin"?

The same as the msvc build on msys-MinGW, but replace msys-MinGW
with Cygwin ;-)

> Is it "git built with msvc, then run in cygwin"?

Yes, but... *in theory* the cygwin msvc-built binaries could be transferred
to an msys system and they should work (exactly as the msvc build on msys).
Since I don't have an msys installation, I can't test that... so I won't
guarantee it will work!

Any git needs a (bash-like) shell, perl, Tcl/Tk, ... etc.

Note the difference in the cygcheck output on the (cygwin) msvc-built git:

    $ cygcheck ./git.exe
    .\git.exe
      C:\WINDOWS\system32\ADVAPI32.dll
        C:\WINDOWS\system32\ntdll.dll
        C:\WINDOWS\system32\KERNEL32.dll
        C:\WINDOWS\system32\RPCRT4.dll
          C:\WINDOWS\system32\Secur32.dll
      C:\WINDOWS\system32\SHELL32.dll
        C:\WINDOWS\system32\GDI32.dll
          C:\WINDOWS\system32\USER32.dll
        C:\WINDOWS\system32\msvcrt.dll
        C:\WINDOWS\system32\SHLWAPI.dll
      C:\WINDOWS\system32\WS2_32.dll
        C:\WINDOWS\system32\WS2HELP.dll
      C:\WINDOWS\system32\zlib1.dll
    $ 

rather than the cygwin git:

    $ cygcheck ./git.exe
    .\git.exe
      C:\cygwin\bin\cygcrypto-0.9.8.dll
        C:\cygwin\bin\cygwin1.dll
          C:\WINDOWS\system32\ADVAPI32.DLL
            C:\WINDOWS\system32\ntdll.dll
            C:\WINDOWS\system32\KERNEL32.dll
            C:\WINDOWS\system32\RPCRT4.dll
              C:\WINDOWS\system32\Secur32.dll
      C:\cygwin\bin\cygiconv-2.dll
      C:\cygwin\bin\cygz.dll
    $ 

[Actually, one difference between the msys and cygwin msvc builds
is that I have dynamically linked to the zlib1.dll rather than
using the static library from the msvcgit.git dependencies repo.]

ATB,
Ramsay Jones
