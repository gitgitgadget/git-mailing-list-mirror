From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:52:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241446070.4648@racer.site>
References: <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site> <20070524123936.GO942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241415050.4648@racer.site> <20070524132434.GQ942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 15:52:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrDk4-00050u-8l
	for gcvg-git@gmane.org; Thu, 24 May 2007 15:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbXEXNwd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 09:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbXEXNwd
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 09:52:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:43119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbXEXNwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 09:52:32 -0400
Received: (qmail invoked by alias); 24 May 2007 13:52:30 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 24 May 2007 15:52:30 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DCmtylRfDwmvb25LZ+jDYMsNoBS6cAXRwDrvJE+
	CfYfAwP2SvVjwv
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524132434.GQ942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48265>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 02:17:27PM +0100, Johannes Schindelin wrote:
> > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > I suppose we could just set it to 0.
> > > I also don't think the URL should be associated to a ref.
> > 
> > It does not need to be.
> > 
> > But then, it is sort of a "subref": You could just clone the submodule in 
> > its own right, correct?
> 
> Exactly, but the information we want is not associated to any
> particular revision of the submodule.  It just points to the repo.
> It's also not associated with any revision of the supermodule.
> That information should go in a tracked .gitmodules file.

It is not that expensive to just give the SHA-1 with the URL, and to 
introduce a new namespace, say

3f... submodule/path^{URL:blablub}

to say that the submodule which is connected in "HEAD:path" is available 
with the URL "blablub" and just so happens to be at commit "3f..." at the 
moment. Heck, you can even use this instead of expensive fetches to verify 
up-to-date, and even more, you can make sure that you are as up-to-date as 
the remote supermodule.

But then, I do not care about that deeply. Like I said, I haven't followed 
the discussions, but I really do not understand why an information as 
essential to a superproject is not contained in something like 
HEAD:.gitmodules. Git does not have to take it from there, it can still 
continue to take it from a local config in .git/, but .gitmodules can live 
in the tree happily, for the pleasure of the tools (if only to initialise 
the first version of the local config after clone).

Without some very intrusive surgery into the transport code of Git, in 22 
patches, which I am not at all comfortable with.

Ciao,
Dscho
