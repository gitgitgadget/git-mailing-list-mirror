From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Tue, 4 Dec 2007 02:12:05 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712040211270.27959@racer.site>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com>
 <20071203040108.GS14735@spearce.org> <Pine.LNX.4.64.0712031146520.27959@racer.site>
 <20071204015108.GV14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 03:12:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzNHH-0002KS-0g
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 03:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbXLDCMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 21:12:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbXLDCMb
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 21:12:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:42254 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbXLDCMa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 21:12:30 -0500
Received: (qmail invoked by alias); 04 Dec 2007 02:12:29 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp004) with SMTP; 04 Dec 2007 03:12:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OANUwkHqObKrvnj669QTXf5v7XfxcdYmeKoEsZ+
	AMoazLL7h/uiIR
X-X-Sender: gene099@racer.site
In-Reply-To: <20071204015108.GV14735@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66993>

Hi,

On Mon, 3 Dec 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Sun, 2 Dec 2007, Shawn O. Pearce wrote:
> > 
> > > Steven Grimm <koreth@midwinter.com> wrote:
> > > > This is useful in cases where a hook needs to modify an incoming commit
> > > > in some way, e.g., fixing whitespace errors, adding an annotation to
> > > > the commit message, noting the location of output from a profiling tool,
> > > > or committing to an svn repository using git-svn.
> > > ...
> > > > +/* Update hook exit code: hook has updated ref on its own */
> > > > +#define EXIT_CODE_REF_UPDATED 100
> > > 
> > > Hmm.  I would actually rather move the ref locking to before we run
> > > the update hook, so the ref is locked *while* the hook executes.
> > 
> > Would that not mean that you cannot use update-ref to update the ref, 
> > since that wants to use the same lock?
> 
> You failed to quote the part of my email where I talked about how
> we set an evironment variable to pass a hint to lockfile.c running
> within the git-update-ref subprocess to instruct it to perform a
> different style of locking, one that would work as a "recursive"
> lock.
> 
> Such a recursive lock could be useful for a whole lot more than just
> the update hook.  But it would at least allow the update hook to
> use git-update-ref to safely change the ref, without receive-pack
> losing its own lock on the ref.

Indeed, I even failed to read it fully ;-)

What do you propose, though?  <filename>.lock.<n>?

Ciao,
Dscho
