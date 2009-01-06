From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] unpack-trees: fix path search bug in verify_absent
Date: Tue, 6 Jan 2009 20:35:19 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901062031101.30769@pacific.mpi-cbg.de>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at> <1230843273-11056-2-git-send-email-drizzd@aon.at> <1230843273-11056-3-git-send-email-drizzd@aon.at> <alpine.DEB.1.00.0901022248070.27818@racer> <20090103103904.GA4479@localhost>
 <alpine.DEB.1.00.0901031353090.30769@pacific.mpi-cbg.de> <7vtz8fz8yd.fsf@gitster.siamese.dyndns.org> <20090104200133.GA2202@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jan 06 20:36:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKHik-0004om-Ui
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 20:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbZAFTer (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 14:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbZAFTer
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 14:34:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:57176 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751064AbZAFTeq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 14:34:46 -0500
Received: (qmail invoked by alias); 06 Jan 2009 19:34:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 06 Jan 2009 20:34:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9M6ZvjjD9Ux2Z4K3X27fV3T8kANbaw7js/pbBjM
	WykE2BCRjJxICx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090104200133.GA2202@localhost>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104712>

Hi,

On Sun, 4 Jan 2009, Clemens Buchacher wrote:

> On Sun, Jan 04, 2009 at 02:01:14AM -0800, Junio C Hamano wrote:
> >     The function's purpose is ....  Before entering the loop to count 
> >     the number of entries to skip, this check to detect if we do not 
> >     even have to count appears.  When this check triggers, we know we 
> >     do not want to skip anything, and returning constant 0 is much 
> >     clearer than returning a variable cnt that was initialized to 0 
> >     near the beginning of the function; we haven't even started using 
> >     it to count yet.
> > 
> > But the point is, if that is the reason the author thinks it is an 
> > improvement, that probably needs to be stated.
> 
> If you want to check the validity of the patch you have to view it in
> context anyways.

Umm.

You can make reviewing your patch attractive and easy, and you can make it 
unattractive and difficult.

If you explain in the commit message that you replaced "cnt" by "0" 
because it is initialized to 0 at that point anyway, it is a _much bigger_ 
pleasure to review your patch.

Let alone a much bigger pleasure for you, 6 months from now, when somebody 
says "why does this silly function return 0, when it should return cnt?"

BTW exactly for that reason, I'd like to leave it as "cnt".  Because code 
_will_ change, and it's quite possible that cnt will not be 0 at that 
point in the future.

> Compared to understanding the change to the code, it takes much longer 
> to parse and understand the above paragraph _plus_ verify its agreement 
> with the code. I think you will agree that there is a limit to the 
> amount of documentation that's still useful.

Just look at a concrete case: me.  I saw that part of the patch, even 
before coming to the real meat of it.  And that head-scratching already 
removed all the enthusiasm I had to look at unpack-trees.c again, so you 
lost a reviewer.

> What's sad, however, is that we are now discussing style and commenting 
> issues of a line of code, which, as by my analysis of [PATCH 3/3] never 
> actually gets executed in the first place. I would have been much more 
> curious about your comments on that.

Exactly,
Dscho
