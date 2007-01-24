From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 17:38:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241731400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org>
 <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45B78836.5080508@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9l8Y-0007Oq-Pb
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008AbXAXQiH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbXAXQiG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:38:06 -0500
Received: from mail.gmx.net ([213.165.64.20]:57655 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752009AbXAXQiF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:38:05 -0500
Received: (qmail invoked by alias); 24 Jan 2007 16:38:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 24 Jan 2007 17:38:02 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45B78836.5080508@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37651>

Hi,

On Wed, 24 Jan 2007, H. Peter Anvin wrote:

> Johannes Schindelin wrote:
> > 
> > To me, it seems like all boils down to caching parsed data structures. I.e.
> > parse the config, then serialize the parsed data to a file. Don't reparse
> > the config unless it is 1 hour older than the config.
> > 
> > Likewise, run for-each-ref, and serialize the parsed data into a file. Don't
> > rerun for-each-ref if that file is younger than 15 minutes.
> > 
> > Maybe the same for the first 200 commits of each branch.
> > 
> > (I made those times up, but you get the idea.)
> > 
> 
> A much better idea is to have that data structure updated on repository 
> updates, which is the whole point behind .git/info/refs.  On kernel.org, 
> at least, if you don't keep .git/info/refs up to date you need to get 
> your fingers whacked anyway, since it damages usability for one 
> particular class of users.

Granted, for some things this might work. However, I would not wreak havoc 
by changing the format of .git/info/refs, rather put the details you 
wanted into .git/info/refs-details.

However, for other things (like showing a certain number of commits), it 
_might_ make sense to cache them (e.g. when literally thousands of people 
look at the 100 last commits of linux-2.6.git), but not for others (e.g. 
the 100th last to the 200th last commit of git-tools.git).

Having said that, it should be relatively easy to store the (parsed, or at 
least easily parseable) 500 last commits of a branch into 
.git/info/commits-<branch>.

This would put the burden of publishing a branch higher, easening the 
overall load on the server.

Jakub?

Ciao,
Dscho
