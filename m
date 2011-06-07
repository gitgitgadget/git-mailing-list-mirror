From: Peter Kleiweg <pkleiweg@xs4all.nl>
Subject: Re: old but persistent problem: bad line length character
Date: Wed, 8 Jun 2011 00:32:31 +0200
Organization: -= de Laatste Huismus =-
Message-ID: <alpine.DEB.1.10.1106072337500.11389@localhost>
References: <alpine.DEB.1.10.1106071832470.4175@localhost> <20110607180624.GA23752@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 00:45:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU51P-0008GV-3P
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 00:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab1FGWpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 18:45:08 -0400
Received: from lo.gmane.org ([80.91.229.12]:39208 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab1FGWpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 18:45:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QU51F-0008EY-F4
	for git@vger.kernel.org; Wed, 08 Jun 2011 00:45:05 +0200
Received: from pebbe.xs4all.nl ([80.101.76.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:45:05 +0200
Received: from pkleiweg by pebbe.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:45:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: pebbe.xs4all.nl
X-X-Sender: peter@localhost
In-Reply-To: <20110607180624.GA23752@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
X-Accept-Language: nl,af,da,de,en,ia,nds,no,sv,fr,it
X-Face: "K~X:~!ydgSdjNy;]_+BCb\OM^pqyg_q*Le84$l46M\-mL=.^,L4B}bDK>`o#r4_>O*
X-Mailer: Alpine 1.10 (DEB 962 2008-03-14), Linux 2.6.18-6-686, i686
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175276>

Jeff King schreef op de 7e dag van de zomermaand van het jaar 2011:

> On Tue, Jun 07, 2011 at 06:33:07PM +0200, Peter Kleiweg wrote:
> 
> > How do bugs in Git get solved? I can't find an issue tracker. 
> 
> You send an email to the mailing list and people work on it. :)

Is that git@vger.kernel.org ?


> > I added some debug code in pkt-line.c, function 
> > packet_read_line(). This tells me that 'buffer' that is passed 
> > to packet_read_line() contains nothing but null characters, 
> > while 'size' is set to 1000.
> 
> Yeah, it's expecting data to be written into it. You need to see what
> packet_read_line reads into linelen via safe_read (which is also printed
> in the error message, so it looks from the above like it contains NULs).

I made it read some more than 4 bytes. And this is what I get:

{27}]0;github git-receive-pack 'pebbe/Gabmap.git'{7}

Ah, I see! I have a wrapper set-up around ssh that sets the 
window title of the shell to the ssh command argument. That is 
what messes things up!

OK. Fixed now.





-- 
Peter Kleiweg
http://pkleiweg.home.xs4all.nl/
