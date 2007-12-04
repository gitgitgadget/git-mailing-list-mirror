From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Tue, 4 Dec 2007 02:25:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712040224080.27959@racer.site>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com>
 <20071203040108.GS14735@spearce.org> <Pine.LNX.4.64.0712031146520.27959@racer.site>
 <20071204015108.GV14735@spearce.org> <Pine.LNX.4.64.0712040211270.27959@racer.site>
 <20071204022020.GA14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:26:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNUJ-0005JU-Rg
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXLDC0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbXLDC0A
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:26:00 -0500
Received: from mail.gmx.net ([213.165.64.20]:41551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750818AbXLDCZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:25:59 -0500
Received: (qmail invoked by alias); 04 Dec 2007 02:25:57 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp055) with SMTP; 04 Dec 2007 03:25:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19q3UlP2BVq+fCF7ZE4tOQbQL9lj7s/qsEAH7quPs
	dkQ/7ACAekBppi
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204022020.GA14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66997>

Hi,

On Mon, 3 Dec 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Mon, 3 Dec 2007, Shawn O. Pearce wrote:
> > > You failed to quote the part of my email where I talked about how
> > > we set an evironment variable to pass a hint to lockfile.c running
> > > within the git-update-ref subprocess to instruct it to perform a
> > > different style of locking, one that would work as a "recursive"
> > > lock.
> > > 
> > > Such a recursive lock could be useful for a whole lot more than just
> > > the update hook.  But it would at least allow the update hook to
> > > use git-update-ref to safely change the ref, without receive-pack
> > > losing its own lock on the ref.
> > 
> > Indeed, I even failed to read it fully ;-)
> > 
> > What do you propose, though?  <filename>.lock.<n>?
> 
> Sure.  :-)
> 
> I was also hand-waving.  Hoping someone else would fill in the
> magic details.
> 
> Actually <n> wouldn't be so bad.  We could do something like:
> 
> 	GIT_INHERITED_LOCKS="<ref> <depth> <ref> <depth> ..."

I am somewhat wary of using environment variables in that context, since 
the variables could leak to subprocesses, or (even worse), they could be 
set inadvertently by the user or other scripts.

Ciao,
Dscho
