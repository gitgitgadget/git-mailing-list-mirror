From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [SQUASHED PATCH] Add support for GIT_CEILING_DIRECTORIES
Date: Fri, 16 May 2008 11:20:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805161118160.30431@racer>
References: <482C85C8.90804@facebook.com> <alpine.DEB.1.00.0805151958180.30431@racer> <alpine.DEB.1.00.0805152055280.30431@racer> <482CA693.3060602@facebook.com> <alpine.DEB.1.00.0805152327440.30431@racer> <482CBCF2.6030202@facebook.com>
 <alpine.DEB.1.00.0805160012310.30431@racer> <482D2F9D.4080809@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, David Reiss <dreiss@facebook.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 16 12:21:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwx3Y-0000mH-3E
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 12:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbYEPKUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 06:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755063AbYEPKUH
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 06:20:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:46074 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754553AbYEPKUG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 06:20:06 -0400
Received: (qmail invoked by alias); 16 May 2008 10:20:04 -0000
Received: from R4f5c.r.pppool.de (EHLO racer.local) [89.54.79.92]
  by mail.gmx.net (mp016) with SMTP; 16 May 2008 12:20:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/8F8kHw5j8yy/ugXhEAoFpzvAfr1u7KHhu3MPnvE
	xvLybnpCsi1tdu
X-X-Sender: gene099@racer
In-Reply-To: <482D2F9D.4080809@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82265>

Hi,

On Fri, 16 May 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > +'GIT_CEILING_DIRECTORIES'::
> > +	If set (to a colon delimited list of absolute directories), Git
> > +	will refuse to look for the .git/ directory further when hitting
> > +	one of those directories (otherwise it would traverse the parent
> > +	directories until hitting the root directory).
> 
> Hmm.
> 
> Looking at the current implementation, this should be written as:
> 
> 	If set to a colon delimited list of absolute directories,
> 	and the current directory is in or below one of them, then
> 	these are the top-most directories in which Git will look for
> 	a .git/ directory (otherwise it would traverse the parent
> 	directories until hitting the root directory).

According to the test case

        GIT_CEILING_DIRECTORIES="$CWD/X:$CWD/subdir" &&
        export GIT_CEILING_DIRECTORIES &&
        (cd subdir && test_must_fail git rev-parse --git-dir)

this is not the case.  If you have something like /bla/subdir and you are 
in /bla/subdir, it will not look for .git/.

Ciao,
Dscho "who leaves it as an exercise to the reader to see why the code 
does what it does"
