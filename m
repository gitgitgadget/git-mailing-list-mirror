From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 17:52:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241746390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78836.5080508@zytor.com> <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78C55.2030204@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:52:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9lM8-0004vM-4u
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:52:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752023AbXAXQwM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbXAXQwM
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:52:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:55690 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752023AbXAXQwI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:52:08 -0500
Received: (qmail invoked by alias); 24 Jan 2007 16:52:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 24 Jan 2007 17:52:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45B78C55.2030204@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37655>

Hi,

On Wed, 24 Jan 2007, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > 
> > Granted, for some things this might work. However, I would not wreak 
> > havoc by changing the format of .git/info/refs, rather put the details 
> > you wanted into .git/info/refs-details.
> > 
> 
> It's not clear to me if it would be wrecking havoc.  After all, if a 
> format can't be expanded *at all*, there is something wrong, and adding 
> things to the end of a line is a common structured way of expansion. 
> Hence the original query

The idea of .git/info/refs is to enable dumb transports to fetch something 
akin to intelligently. They don't need that information, and frankly, I 
don't think they should need to understand it.

I also expect that they interpret everything after the sha1 as refname, 
what with our having become quite liberal with refnames (they can contain 
spaces, tabs, and even a small amount of special K). So I don't see a way 
to upgrade the file format.

But as should be clear by now, I'd prefer additional information -- that 
is of no interest to dumb transports anyway -- to be put in an own file.

That also opens the possibility of, say .git/info/perl/, which contains 
_only_ serialized perl objects! I imagine this could be a performance 
booster.

> > However, for other things (like showing a certain number of commits), 
> > it _might_ make sense to cache them (e.g. when literally thousands of 
> > people look at the 100 last commits of linux-2.6.git), but not for 
> > others (e.g. the 100th last to the 200th last commit of 
> > git-tools.git).
> 
> Any query that's within a repository is fairly easily cachable 
> post-generation.  The front page (and its RSS variant) is a bit of an 
> exception, because it involves all repositories at once.

... and here we have a problem, right? No single update hook can update 
the _whole_ information.

Ciao,
Dscho
