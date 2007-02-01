From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git repack -a -d is not safe
Date: Fri, 2 Feb 2007 00:26:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702020023170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070201112545.GA19855@moooo.ath.cx> <20070201205934.GA19057@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 02 00:26:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HClKD-0007c4-7e
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 00:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422857AbXBAX0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 18:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbXBAX0i
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 18:26:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:47368 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422857AbXBAX0h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 18:26:37 -0500
Received: (qmail invoked by alias); 01 Feb 2007 23:26:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 02 Feb 2007 00:26:35 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070201205934.GA19057@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38428>

Hi,

On Thu, 1 Feb 2007, Shawn O. Pearce wrote:

> Matthias Lederhofer <matled@gmx.net> wrote:
> > First the object is unpacked, start something using read_sha1_file.
> > read_sha1_file: try packed object (fails)
> > run git repack -a -d
> > read_sha1_file: try to read the loose object (fails)
> > read_sha1_file: reread list of packs
> > run git repack -a -d so it will create a new pack
> > read_sha1_file: tries to open the old packs, not the new one, and
> >                 fails
> 
> My 4 patch series that I just posted should (partially) fix this
> problem.  We cannot close it completely however as there always
> exists the potential of the OS to starve the reader and allow 2
> full repacks between the time the reader notices a .idx file and
> the time the reader could open the .pack.

I may be misunderstanding the problem, but can't we just keep looking for 
a new pack until either there is _no_ new pack to be mapped, or the object 
is found?

Ciao,
Dscho
