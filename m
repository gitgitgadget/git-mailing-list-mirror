From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 18:29:47 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241828160.4648@racer.site>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
 <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org>
 <Pine.LNX.4.64.0705241020450.21766@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>,
	Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu May 24 19:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrH8M-0001Kw-Po
	for gcvg-git@gmane.org; Thu, 24 May 2007 19:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXEXR3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 13:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbXEXR3w
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 13:29:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:35405 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750721AbXEXR3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 13:29:51 -0400
Received: (qmail invoked by alias); 24 May 2007 17:29:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 24 May 2007 19:29:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18B56opkJ4BR1FFfeAK6uAONySkRtQN9nBTg9lNXD
	MLkAvLElBVQxVH
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0705241020450.21766@asgard.lang.hm>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48278>

Hi,

On Thu, 24 May 2007, david@lang.hm wrote:

> On Thu, 24 May 2007, Shawn O. Pearce wrote:
> 
> > Now #3 is actually really important here.  Don't forget that we
> > *just* disabled the fancy "new loose object format".  It doesn't
> > exist.  We can read the packfile-like loose objects, but we cannot
> > write them anymore.  So lets say we explode a megablob into a loose
> > object, and its 800 MiB by itself.  Now we have to send that object
> > to a client.  Yes, that's right, we must *RECOMPRESS* 800 MiB for
> > no reason.  Not the best choice.  Maybe we shouldn't have deleted
> > that packfile formatted loose object writer...
> 
> when did the object store get changed so that loose objects aren't
> compressed?

That never happened. But we had a different file format for loose objects, 
which was meant to make it easier to copy as-is into a pack. That file 
format went away, since it was not as useful as we hoped.

Ciao,
Dscho
