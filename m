From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Update tests to use test-chmtime
Date: Sun, 25 Feb 2007 16:20:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702251618380.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11723651923476-git-send-email-normalperson@yhbt.net>
 <11723651934078-git-send-email-normalperson@yhbt.net>
 <7vzm72vhl4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 16:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLLAl-00069y-Bo
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 16:20:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbXBYPUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 10:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbXBYPUH
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 10:20:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:52134 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964851AbXBYPUG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 10:20:06 -0500
Received: (qmail invoked by alias); 25 Feb 2007 15:20:04 -0000
X-Provags-ID: V01U2FsdGVkX19bymcHUy5bXnfPyhiOMqgjZifX6agNbWhHRf3/y6
	ODxg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vzm72vhl4.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40551>

Hi,

On Sat, 24 Feb 2007, Junio C Hamano wrote:

> Eric Wong <normalperson@yhbt.net> writes:
> 
> > -case "$(date -d @11111111 +%s 2>/dev/null)" in
> > -11111111)
> > ...
> > -	touch -m -t "$predate1" $rr/preimage
> > -	touch -m -t "$predate2" $rr2/preimage
> > ...
> > -esac
> > +now=$(date +%s)
> > +almost_15_days_ago=$(($now+60-15*86400))
> > +just_over_15_days_ago=$(($now-1-15*86400))
> > +almost_60_days_ago=$(($now+60-60*86400))
> > +just_over_60_days_ago=$(($now-1-60*86400))
> > +
> > +test-chmtime =$almost_60_days_ago $rr/preimage
> > +test-chmtime =$almost_15_days_ago $rr2/preimage
> 
> Very nice.
> I've been wanting to get rid of this part for quite a while.
> 
> However, is '+%s' output portable enough for this change to be
> an improvement?

It is not portable, but according to the man page:

	%s seconds since 00:00:00, Jan 1, 1970 (a GNU extension)

> I would suggest changing "test-chmtime =-200 file" to set the mtime of 
> the file to 200 seconds in the past, relative to present.

I wanted to propose the same, but without a patch :-)

Ciao,
Dscho
