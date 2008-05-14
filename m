From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] cvsexportcommit: chomp only removes trailing
 whitespace
Date: Wed, 14 May 2008 19:38:55 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805141936410.30431@racer>
References: <alpine.DEB.1.00.0805141526160.30431@racer> <7vskwkojhy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:40:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLtG-0002dc-0o
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759083AbYENSi4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757995AbYENSiz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:38:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:50048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757416AbYENSiz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:38:55 -0400
Received: (qmail invoked by alias); 14 May 2008 18:38:53 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO racer.local) [132.187.25.128]
  by mail.gmx.net (mp047) with SMTP; 14 May 2008 20:38:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19eZ5QLgB5eL1YdzVl4Gfcjf3+0dIen70c+8Ru/nj
	Ou3vfPF16148fN
X-X-Sender: gene099@racer
In-Reply-To: <7vskwkojhy.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82129>

Hi,

On Wed, 14 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > In commit fef3a7cc(cvsexportcommit: be graceful when "cvs status" 
> > reorders the arguments), caution was taken to get the status even for 
> > files with leading or trailing whitespace.
> >
> > However, the author of that commit missed that chomp() removes only 
> > trailing whitespace.  But the author realized his mistake.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	Really my fault.
> 
> I am not quite sure if I understand what is going on correctly.
> 
> Is this about a filename that has leading or trailing whitespace, or 
> lazily not parsing a protocol message but attempting to match with 
> possible whitespaces around the place where a filename should be?
> 
> If you are saying that the output from cvs status is so unreliable that 
> we can only strip all whitespaces from both ends and hope for the best 
> (e.g. files " a" (two leading spaces in the name), "a " (two trailing 
> spaces in the name), and "a" (no such funny spaces) cannot be 
> distinguished from cvs status output), then perhaps you would also need 
> to remove as many trailing whitespaces as you can?

Yes, that is the idea.  The point is: there are at least two different 
implementations of cvs, and I do not want to rely on a particular one.

To prevent bad things from happening, the status is checked on a set of 
files which have unique names with regard to the chomp()ed name (well, 
whatever we do to the name, really).

So yes, this patch needs an update.

Will do so in a couple of hours,
Dscho
