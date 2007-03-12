From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: using the same repo with different OS
Date: Mon, 12 Mar 2007 21:05:11 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703122100550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <906f26060702250913g41658be6mffea613f25f9a847@mail.gmail.com> 
 <Pine.LNX.4.63.0702251829530.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7v3b4ut7yq.fsf@assigned-by-dhcp.cox.net> 
 <Pine.LNX.4.63.0702251929170.22628@wbgn013.biozentrum.uni-wuerzburg.de> 
 <7vy7mmrspw.fsf@assigned-by-dhcp.cox.net>  <906f26060702281006l794173e8uea0f7174dd712e32@mail.gmail.com>
  <20070228181251.GG5924@spearce.org> <906f26060703121133o6de42d66y9f3ada50149a852c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Stefano Spinucci <virgo977virgo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 21:05:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQqll-0007Y5-Do
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 21:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbXCLUFQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 16:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbXCLUFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 16:05:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:35778 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752848AbXCLUFN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 16:05:13 -0400
Received: (qmail invoked by alias); 12 Mar 2007 20:05:11 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 12 Mar 2007 21:05:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lLHFQArrlMA9JFmhVi+frsOwTGVeJ31x9mzSFsm
	sNkp8Y+9W/Vssq
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <906f26060703121133o6de42d66y9f3ada50149a852c@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42079>

Hi,

On Mon, 12 Mar 2007, Stefano Spinucci wrote:

> On 2/28/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> > 
> > Stefano Spinucci <virgo977virgo@gmail.com> wrote:
> > > Than I'm asking how you'd setup repos to work on some linux/windows
> > > machines, transferring data only with an USB disk.
> > 
> > Just create a bare repository on the USB stick and push/fetch to it.
> > It won't have a checkout directory or an index, the two sticking
> > points with mmap() on Windows and with a FAT32 filesystem being
> > accessed through Git by both Linux and Windows.
> 
> Needing to have my repos backupped and only on fat32 usb keys, I was
> thinking to have the following layout:
> on usb key one --> repo.linux
> on usb key two --> repo.win
> 
> Then, on repo.win, I'll do:
> # before daily work on windows
> fetch from repo.linux
> # after daily work on windows
> push to repo.linux
> 
> Otherwise, on repo.linux:
> # before nightly work on linux
> fetch from repo.windows
> # after nightly work on linux
> push to repo.windows
> 
> It's possible, or I need a third bare repository between windows and 
> linux ???

No need for a third one. You can even use alternates to save space:

$ git clone -l -s repo.linux repo.windows

When git-gc'ing, the objects will be packed, but if they are present in 
both repo.linux and repo.windows, the objects from repo.linux will be 
reused in repo.windows.

Note: USB sticks are almost as fragile as disks used to be... So, try 
avoiding writes if you can...

Ciao,
Dscho
