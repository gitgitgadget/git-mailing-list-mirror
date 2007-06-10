From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 06/21] Refactor tag name verification loop to use index
 'i' instead of incrementing pointer 'tag_line'
Date: Sun, 10 Jun 2007 09:14:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100909211.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706090215.05318.johan@herland.net> <81b0412b0706091426x5cc496aft788376872fc56995@mail.gmail.com>
 <200706092334.32855.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:17:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIcW-000211-TY
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760413AbXFJIRz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760880AbXFJIRz
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:17:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:33117 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760250AbXFJIRx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:17:53 -0400
Received: (qmail invoked by alias); 10 Jun 2007 08:17:51 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp017) with SMTP; 10 Jun 2007 10:17:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ReVtPmraRxaquq0+xdRuJvLtsv4uTEo6g/avoLh
	3cJeOId4sB3fKP
X-X-Sender: gene099@racer.site
In-Reply-To: <200706092334.32855.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49672>

Hi,

On Sat, 9 Jun 2007, Johan Herland wrote:

> On Saturday 09 June 2007, Alex Riesen wrote:
> > On 6/9/07, Johan Herland <johan@herland.net> wrote:
> > > Signed-off-by: Johan Herland <johan@herland.net>
> > > ---
> > >  mktag.c |   29 ++++++++++++++++-------------
> > >  1 files changed, 16 insertions(+), 13 deletions(-)
> > 
> > What is this change good for?
> > How did you justify the type selection for your
> > loop index variable?
> > 
> > IOW,  the patch looks very useless.
> 
> I agree. By itself, the patch is useless.

Then it shouldn't be there.

It seems that you do not place the cuts between patches at the 
_conceptual_ layer. Therefore, they seem intrusive and often the meaning 
evades me.

So, if I understood the purpose of this patch series correctly, namely to 
use the same verification routines both for creation as for validation of 
tags, you could have

	- moved one function into the library (the stricter one), saying 
	  "move this_function() into libgit.a to make it usable from 
	   git-bla" in the commit body,

	- used that from the other program, removing the now-unused 
	  function,

	- and then changed the behaviour to be more chatty or some such.

As it is, you have a mix of conceptually different changes in almost every 
patch, and some changes that conceptually belong into the same patch, are 
not.

Be that as may, I think it is not a good change to reuse the same function 
like you did, exactly because one version _should_ be more forgiving than 
the other.

Ciao,
Dscho
