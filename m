From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port - initial work uploaded
Date: Tue, 23 Jan 2007 20:18:58 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701232012440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701192148.20206.johannes.sixt@telecom.at> 
 <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com> 
 <200701222127.09601.johannes.sixt@telecom.at> 
 <Pine.LNX.4.63.0701231227200.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <46d6db660701230512l571d8c35k24e475c3fe0933cf@mail.gmail.com> 
 <Pine.LNX.4.63.0701231517290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <46d6db660701231055u63259fave0f33e9b52fc9bff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 20:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9RAl-0007LI-7c
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 20:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933034AbXAWTTH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 14:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933042AbXAWTTH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 14:19:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:36630 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933034AbXAWTTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 14:19:05 -0500
Received: (qmail invoked by alias); 23 Jan 2007 19:19:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 23 Jan 2007 20:19:04 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Christian MICHON <christian.michon@gmail.com>
In-Reply-To: <46d6db660701231055u63259fave0f33e9b52fc9bff@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37558>

Hi,

On Tue, 23 Jan 2007, Christian MICHON wrote:

> On 1/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > maybe I'm stuck with windows at work, but I still use vim inside mingw.
> > 
> > I don't:
> > 
> > $ vi
> > m.AllocationBase 0x0, m.BaseAddress 0x715B0000, m.RegionSize 0x4D0000,
> > m.State 0x10000
> > C:\msys1\bin\vim.exe: *** Couldn't reserve space for cygwin's heap
> > (0x715B0000 <0xB10000>) in child, Win32 error 487
> 
> interesting. which version of msys are you using ?
> I'm using this snapshot successfully:
> msysCORE-1.0.11-2007.01.19-1

I cannot find that file.

> > > it would be nice to fix the pager issue...
> > 
> > Go ahead!
> 
> well:
> 
> git log | less
> 
> :)
> 
> seriously enough, I do not know where to start. I guess we're
> close to mingw limitations of fork() ??

The problem seems to be more the console attachment. I think that the 
pager cannot run properly when fork()ed. Rather, the main process has to 
continue with the execl(pager), while the _child_ should continue to run.

See upload-pack.c for an example how to use _beginthread() to achieve 
something along those lines.

Hth,
Dscho
