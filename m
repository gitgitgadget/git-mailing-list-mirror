From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [VALGRIND PATCH for nth_last patch series] Fix invalid memory
 access
Date: Wed, 21 Jan 2009 12:56:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901211256370.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901210113500.19014@racer>
 <7vwscpgi7t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 12:58:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPbit-0007sN-EW
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 12:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758451AbZAUL4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 06:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbZAUL4y
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 06:56:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:54366 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756506AbZAUL4y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 06:56:54 -0500
Received: (qmail invoked by alias); 21 Jan 2009 11:56:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 21 Jan 2009 12:56:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Ra3VeM6aRn71o3IxW/auM9Iyazj9lnL3T9jQeqH
	L4hf+Bzu5nlP8+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vwscpgi7t.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106597>

Hi,

On Wed, 21 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >  sha1_name.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/sha1_name.c b/sha1_name.c
> > index 4d10705..803f9d2 100644
> > --- a/sha1_name.c
> > +++ b/sha1_name.c
> > @@ -735,7 +735,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
> >  	if ((target = strstr(match, " to ")) != NULL) {
> >  		len = target - match;
> >  		target += 4;
> > -		if (target[len] == '\n' && !strncmp(match, target, len))
> > +		if (len == strlen(target) && !strncmp(match, target, len))
> >  			return 0;
> >  	}
> >  	else
> 
> Actually, I think this patch to a884d0c (sha1_name: tweak @{-N} lookup,
> 2009-01-17) would make more sense.
> 
> -- >8 --
> Subject: [PATCH] Simplify parsing branch switching events in reflog
> 
> We only accept "checkout: moving from A to B" newer style reflog entries,
> in order to pick up A.  There is no point computing where B begins at
> after running strstr to locate " to ", nor adding 4 and then subtracting 4
> from the same pointer.

Yeah, you're right.

Ciao,
Dscho
