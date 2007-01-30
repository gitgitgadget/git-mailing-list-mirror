From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 11:07:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301105540.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291944290.20138@iabervon.org> <45BF0098.8FF978CE@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 11:07:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBpth-0001Af-Lt
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 11:07:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965451AbXA3KH0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 05:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965452AbXA3KH0
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 05:07:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:35918 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965451AbXA3KHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 05:07:25 -0500
Received: (qmail invoked by alias); 30 Jan 2007 10:07:23 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp047) with SMTP; 30 Jan 2007 11:07:23 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45BF0098.8FF978CE@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38145>

Hi,

On Tue, 30 Jan 2007, Johannes Sixt wrote:

> Daniel Barkalow wrote:
> > 
> > On Mon, 29 Jan 2007, Johannes Sixt wrote:
> > 
> > > (*) The reason is that on Windows read() and write() cannot operate on
> > > descriptors created by socket(). A work-around is to implement a (threaded)
> > > proxy, but that's almost the same as if netcat were used as
> > > GIT_PROXY_COMMAND.
> > 
> > Can you do
> > 
> > #define read(fd, buffer, len) recv(fd, buffer, len, 0)
> > #define write(fd, buffer, len) send(fd, buffer, len, 0)
> > 
> > in the appropriate file?
> 
> I doubt that recv and send can operate on regular file descriptors, as
> opened by _pipe(), open(), can they?

They can't. Thus, you'd break at least inetd mode.

Of course, you really could start a thread which gets two pipe()d fds, and 
the proper socket, and just shuffles things back & forth. Not that hard.

Ciao,
Dscho
