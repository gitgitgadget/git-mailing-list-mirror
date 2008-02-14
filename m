From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 21:04:39 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802142054080.30505@racer.site>
References: <200802081828.43849.kendy@suse.cz> <m3ejbngtnn.fsf@localhost.localdomain> <200802091627.25913.kendy@suse.cz> <alpine.LFD.1.00.0802092200350.2732@xanadu.home> <alpine.LSU.1.00.0802101640570.11591@racer.site> <alpine.LSU.1.00.0802101845320.11591@racer.site>
 <alpine.LSU.1.00.0802122036150.3870@racer.site> <alpine.LSU.1.00.0802141917420.30505@racer.site> <m3y79nb8xk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 22:06:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPlHD-0000Cg-7Q
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 22:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758893AbYBNVEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 16:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756698AbYBNVEr
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 16:04:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:52382 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758629AbYBNVEp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 16:04:45 -0500
Received: (qmail invoked by alias); 14 Feb 2008 21:04:43 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp056) with SMTP; 14 Feb 2008 22:04:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199y/5VBv5990XGIRYb8lylUXQZCYNImOsn73BA7z
	WRb4dO2Ji5w+D/
X-X-Sender: gene099@racer.site
In-Reply-To: <m3y79nb8xk.fsf@localhost.localdomain>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73915>

Hi,

On Thu, 14 Feb 2008, Jakub Narebski wrote:

> Do you perchance know why OOo needs so large pack?

No.

> Perhaps you could try running contrib/stats/packinfo.pl on this pack to 
> examine it to get to know what takes most space.

$ ~/git/contrib/stats/packinfo.pl < \
objects/pack/pack-e4dc6da0a10888ec4345490575efc587b7523b45.pack 2>&1 | \
tee packinfo.txt
Illegal division by zero at /home/imaging/git/contrib/stats/packinfo.pl 
line 141, <STDIN> line 6330855.

> What is the size of checkout, by the way?

I work on a bare repository, but:

$ git archive origin/master | wc -c
2010060800

Or more precisely:

$ echo $(($(git ls-tree -l -r origin/master | sed -n 's/^[^ ]* [^ ]* [^ ]*  
*\([0-9]*\).*$/\1/p' | tr '\012' +)0))
1947839459

So yes, we still have the crown of the _whole_ repository being _smaller_ 
than a single checkout.

Yeah!

> Hmmm... I wonder if packv4 would help...

I could imagine that it does, what with it being so much better with 
strings.  But it would come at a price of performance, I guess, as the 
string table should be well over 64k.

Ciao,
Dscho
