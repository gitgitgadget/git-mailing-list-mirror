From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] filter-branch: support skipping of commits more
 easily
Date: Fri, 8 Jun 2007 05:17:17 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080455440.4046@racer.site>
References: <Pine.LNX.4.64.0706080058160.4046@racer.site>
 <7v7iqfnuo3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 06:19:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwVwn-0007mL-Rr
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 06:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXFHETa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 00:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbXFHETa
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 00:19:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:45787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752864AbXFHET3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 00:19:29 -0400
Received: (qmail invoked by alias); 08 Jun 2007 04:19:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp026) with SMTP; 08 Jun 2007 06:19:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wH9E8OnZwyxFOczOMy+eQNSr10ZAZ6zPbaEwraY
	D627PGBmpgypmv
X-X-Sender: gene099@racer.site
In-Reply-To: <7v7iqfnuo3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49428>

Hi,

On Thu, 7 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When commit-filter echoes just "skip", just skip that commit by mapping 
> > its object name to the same (possibly rewritten) object name(s) its 
> > parent(s) are mapped to.
> >
> > IOW, given A-B-C, if commit-filter says "skip" upon B, the rewritten 
> > branch will look like this: A'-C'.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	Of course, if you think of "patchsets", this behaviour might
> > 	be unexpected, since the children will still contain everything
> > 	which was changed in the skipped revisions, and not changed in
> > 	_them_.
> 
> I think that is fine; in effect, by saying "skip" B, you are
> squashing B-C into C'.
> 
> Does this mean that, given
> 
>           C---D---E
>          /   /
> 	A---B
> 
> and if commit-filter says "skip" on D, the written history would
> look like this?
> 
>           C'------E'
>          /       /
> 	A'--B'--'
> 
> The new commit E' would become an evil merge that has difference
> between D and E in the original history?
> 
> I am not objecting; just trying to get a mental picture.

Yeah, but you called it "squash" instead of "skip". So, maybe it should 
accept "squash" to do that operation instead?

Ciao,
Dscho
