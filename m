From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Do not change the file type if the filesystem does not
 support symlinks.
Date: Wed, 28 Feb 2007 18:53:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702281846360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11726125012895-git-send-email-johannes.sixt@telecom.at>
 <1172612504272-git-send-email-johannes.sixt@telecom.at>
 <Pine.LNX.4.63.0702272352080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702281840.07893.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Feb 28 18:53:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMSzn-0007Sk-Aa
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 18:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbXB1RxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 12:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbXB1RxP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 12:53:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:37430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751030AbXB1RxP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 12:53:15 -0500
Received: (qmail invoked by alias); 28 Feb 2007 17:53:13 -0000
X-Provags-ID: V01U2FsdGVkX1972BBMvJl7zKoxDOAYgu5Qhx2ET/TZ/iYzbSAJi9
	bGvQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702281840.07893.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40977>

Hi,

On Wed, 28 Feb 2007, Johannes Sixt wrote:

> On Tuesday 27 February 2007 23:54, Johannes Schindelin wrote:
> > On Tue, 27 Feb 2007, Johannes Sixt wrote:
> >
> > > @@ -125,7 +126,8 @@ static int ce_match_stat_basic(struct cache_entry
> > > *ce, struct stat *st) changed |= MODE_CHANGED;
> > >  		break;
> > >  	case S_IFLNK:
> > > -		changed |= !S_ISLNK(st->st_mode) ? TYPE_CHANGED : 0;
> > > +		if (trust_symlink_fmt && !S_ISLNK(st->st_mode))
> > > +			changed |= TYPE_CHANGED;
> >
> > This does not handle the case symlink->directory, right?
> 
> Something like:
> 
> 		if (!S_ISLNK(st->st_mode) &&
> 		    (trust_symlink_fmt || !S_ISREG(st->st_mode)))
> 			changed |= TYPE_CHANGE;

Yes.

> BTW, considering the size of the entire patch series, I'm thinking of 
> submitting it in a single patch.

Makes sense.

Ciao,
Dscho
