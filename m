From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Remove empty directories when checking out a commit with
 fewer submodules
Date: Mon, 11 Jan 2010 10:45:20 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001111044140.4985@pacific.mpi-cbg.de>
References: <1263178794-3140-1-git-send-email-peter@pcc.me.uk> <alpine.DEB.1.00.1001110954410.4985@pacific.mpi-cbg.de> <201001111032.45637.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Peter Collingbourne <peter@pcc.me.uk>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jan 11 10:40:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUGkd-0001lI-18
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 10:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752994Ab0AKJjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 04:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752613Ab0AKJjv
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 04:39:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:49478 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752562Ab0AKJjv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 04:39:51 -0500
Received: (qmail invoked by alias); 11 Jan 2010 09:39:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 11 Jan 2010 10:39:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4kEVvE574CGjXNBQ0mBvOn7kba1inheUsYMzx68
	HCcZkAouGhvFx6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <201001111032.45637.johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136626>

Hi,

On Mon, 11 Jan 2010, Johan Herland wrote:

> On Monday 11 January 2010, Johannes Schindelin wrote:
> > Hi,
> >
> > On Mon, 11 Jan 2010, Peter Collingbourne wrote:
> > > Change the unlink_entry function to use rmdir to remove submodule
> > > directories.
> >
> > NAK.  We should not even try to _unlink_ submodule subdirectories; it
> > would be _way_ too easy to lose data that way.  Remember, submodules
> > are a totally different beast from regular files.  They can contain
> > valuable, yet uncommitted data, that is not even meant to be
> > committed.
> >
> > So you say if the submodule directories are empty, it is safe?  Not
> > so. They will never be empty: there is always .git/, and _that_ can
> > contain valuable information that you do not want to throw away, too.
> >  Think of unpushed branches, for example.  That would be _fatal_ if
> > you rmdir() that for me.
> >
> > So please, no,
> 
> I believe what Peter is referring to is the _empty_ directories (and 
> that includes no .git/) that are placeholders for submodules that are 
> deliberately not cloned/checked out. This lets you do things like:
> 
> 	git clone url:to/some/project
> 	cd project
> 	git checkout some-other-branch-with-different-submodules
> 	git submodule update --init
> 
> Of course, once you clone/checkout a submodule, there will be contents 
> in that directory (including the .git/), and Git should not try to 
> remove it.

Yes, this might very well have been my confusion.  Peter, could you please 
refer to such submodules as "uninitialized" rather than "empty" in the 
future?  This would help simple minds like mine to understand you better.

Ciao,
Dscho
