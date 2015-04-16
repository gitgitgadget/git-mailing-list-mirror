From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] compat/mingw: stubs for getpgid() and
 tcgetpgrp()
Date: Thu, 16 Apr 2015 14:44:56 +0200
Organization: gmx
Message-ID: <fac9a525a2fb2b09d176243659cbf3a7@www.dscho.org>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
 <CABPQNSZ-7FAgun8mxqXYWgy+Xc9xQMXKZonwujXb5WzLCKmNMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, Luke Mewburn <luke@mewburn.net>,
	Nicolas Pitre <nico@fluxnic.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>, git-owner@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 16 14:45:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YijAU-0008LP-4w
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 14:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757341AbbDPMpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 08:45:13 -0400
Received: from mout.gmx.net ([212.227.15.19]:61011 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757194AbbDPMpL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 08:45:11 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Md3li-1YzqJ93Lvu-00IDLe; Thu, 16 Apr 2015 14:44:57
 +0200
In-Reply-To: <CABPQNSZ-7FAgun8mxqXYWgy+Xc9xQMXKZonwujXb5WzLCKmNMw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:SNNgFBurn278EOu03FXQaRYhaI+IggKsjtIxcJcnzSWCYYfDNjl
 1J72sFBmMJbL8jSUKOjlymVwxAgTrlH70fpvaTkbpNYp+pf4crpmB68Hf+LBU8Ratd5o3EB
 O4FcARr9VyQ5zhz0YdyUrzUz752ZJhBN26th1AcEQoQsEi0ti+1YUp/ULFTh3rZmE46yoo7
 aYhcuQ2zSCTmkZTuay46Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267283>

Hi kusma,

On 2015-04-15 21:43, Erik Faye-Lund wrote:
> On Wed, Apr 15, 2015 at 8:29 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> Windows does not have process groups. It is, therefore, the simplest
>> to pretend that each process is in its own process group.
> 
> Windows does have some concept of process groups, but probably not
> quite what you want:
> 
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms682083%28v=vs.85%29.aspx

Yes, and we actually need that in Git for Windows anyway because shooting down a process does not kill its child processes:

https://github.com/git-for-windows/msys2-runtime/commit/15f209511985092588b171703e5046eba937b47b#diff-8753cda163376cee6c80aab11eb8701fR402

However, using this code for `getppid()` would be serious overkill (not to mention an unbearable performance hit because you have to enumerate *all* processes to get that information).

Ciao,
Dscho
