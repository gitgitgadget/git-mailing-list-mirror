From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
 merges
Date: Mon, 24 Mar 2008 14:08:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803241406530.4353@racer.site>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803232334130.4353@racer.site>
 <20080324111413.GA18488@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1996726902-1206364101=:4353"
Cc: git@vger.kernel.org, B.Steinbrink@gmx.de
To: =?ISO-8859-15?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 14:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdmQ9-0004lz-3z
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 14:09:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbYCXNIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 09:08:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757430AbYCXNIS
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 09:08:18 -0400
Received: from mail.gmx.net ([213.165.64.20]:54789 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757418AbYCXNIR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 09:08:17 -0400
Received: (qmail invoked by alias); 24 Mar 2008 13:08:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 24 Mar 2008 14:08:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1++JfETn8K+hRCruPqJd4EVJt1AucFahVHvyZdgli
	WlB+kld2nV+14G
X-X-Sender: gene099@racer.site
In-Reply-To: <20080324111413.GA18488@alea.gnuu.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78029>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1996726902-1206364101=:4353
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 24 Mar 2008, Jörg Sommer wrote:

> Johannes Schindelin schrieb am Sun 23. Mar, 23:41 (+0100):
> > On Sun, 23 Mar 2008, Jörg Sommer wrote:
> > 
> > > @@ -150,7 +152,18 @@ pick_one () {
> > >  		sha1=$(git rev-parse --short $sha1)
> > >  		output warn Fast forward to $sha1
> > >  	else
> > > -		output git cherry-pick "$@"
> > > +		if test t = "$LINEAR_HISTORY" &&
> > > +			other_parents="$(parents_of_commit $sha1 | cut -s -d' ' -f2-)" &&
> > > +			test -n "$other_parents"
> > > +		then
> > > +			if test a"$1" = a-n
> > > +			then
> > > +				merge_opt=--no-commit
> > > +			fi
> > > +			redo_merge $sha1 $no_commit $other_parents
> > > +		else
> > > +			output git cherry-pick "$@"
> > > +		fi
> > 
> > Now, that is funny.  In case of --preserve-merges, I would have 
> > expected you to touch pick_one_preserving_merges(), not pick_one().
> > 
> > I would find it highly illogical to try to redo merges _without_ -p.
> 
> Me too, but I think it's not possible to do what I want with -p.

But that is not a reason to mess up the source code.  If you do a thing as 
--linear-history (or --first-parents, as I would prefer it), that should 
be in the code path of --preserve-merges (and actually _imply_ that 
option).

--linear-history makes no sense at all without --preserve-merges.

Ciao,
Dscho
--8323584-1996726902-1206364101=:4353--
