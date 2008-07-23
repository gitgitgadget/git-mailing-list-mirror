From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git daemon: avoid waking up too often
Date: Wed, 23 Jul 2008 20:39:56 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807232038310.8986@racer>
References: <alpine.DEB.1.00.0807222251570.8986@racer>  <alpine.DEB.1.00.0807222302440.8986@racer>  <4886D503.7030106@viscovery.net> <32541b130807231226m73fcc874ub72f69adeb5d26c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 21:40:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkCl-0006PY-Is
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 21:40:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753305AbYGWTj4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 15:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbYGWTj4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 15:39:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:56538 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753293AbYGWTjz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 15:39:55 -0400
Received: (qmail invoked by alias); 23 Jul 2008 19:39:54 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp050) with SMTP; 23 Jul 2008 21:39:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19d3SBT8WNdYb6hN9NAu4kYX77UBjZhsI7JBAsHSw
	1IpJ0bBrtN5tcl
X-X-Sender: gene099@racer
In-Reply-To: <32541b130807231226m73fcc874ub72f69adeb5d26c3@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89757>

Hi,

On Wed, 23 Jul 2008, Avery Pennarun wrote:

> On 7/23/08, Johannes Sixt <j.sixt@viscovery.net> wrote:
> > This makes porting this beast to Windows practically impossible 
> > because we cannot have a poll() implementation that waits both on a 
> > listening socket and a pipe. :-(
> 
> I have worked around such problems in the past by having a thread whose 
> job it is to read from the pipe and simply write it to a socket. The 
> trick works for "console" objects, too, which in win32 are even less 
> agreeable than pipes.
> 
> (In case your life wasn't disgusting enough already today :))

Thanks.  I thought the code I looked at today was ugly, but you convinced 
me that there is no limit.

> Alternatively, you could use something like socketpair() instead of a 
> pipe for this purpose.  Naturally, Win32 helps you out here by somehow 
> forgetting to include socketpair() in winsock, although it's sort of 
> easy to emulate.

Or alternatively, you could read my response to Hannes where I explain 
that the pipe() is not even needed with threaded start_async() (as opposed 
to fork()ed one).

Ciao,
Dscho
