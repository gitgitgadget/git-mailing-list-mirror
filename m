From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Libification project (SoC)
Date: Mon, 19 Mar 2007 15:57:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703191556210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vejnpycu1.fsf@assigned-by-dhcp.cox.net> <20070316060033.GD31606@spearce.org>
 <7vps79wueu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703161251200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070316130958.GD1783@peter.daprodeges.fqdn.th-h.de>
 <Pine.LNX.4.63.0703161509560.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070318140816.GG4489@pasky.or.cz> <Pine.LNX.4.63.0703190045520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319012111.GS18276@pasky.or.cz> <Pine.LNX.4.63.0703190235330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070319025636.GE11371@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Rocco Rutte <pdmef@gmx.net>,
	git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Mar 19 15:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTJJ4-0007Qy-Pr
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 15:57:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbXCSO5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 10:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbXCSO5x
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 10:57:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:49235 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932279AbXCSO5w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 10:57:52 -0400
Received: (qmail invoked by alias); 19 Mar 2007 14:57:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 19 Mar 2007 15:57:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/hDXc42kjhLWTI9wLrALHkz1wMm2vbrinixqhk2S
	RlgyUMmJFMnKWU
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070319025636.GE11371@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42624>

Hi,

On Sun, 18 Mar 2007, Theodore Tso wrote:

> On Mon, Mar 19, 2007 at 02:43:54AM +0100, Johannes Schindelin wrote:
> > >   I was talking about the API. The API has to be designed to be 
> > > reentrant. And you get pretty much stuck with the API. And requiring 
> > > reentrance isn't that far off once libgit is there, as I tried to point 
> > > out; it's not really any obscure requirement.
> > 
> > - it is easy enough to extend the API later, _retaining_ the small and 
> >   beautiful functions.
> 
> Um, look at what we had to do with gethostbyname() and 
> gethostbyname_r().  It wasn't possible to sweep through and fix all of 
> the programs that used gethostbyname(), despite the fact that if a 
> program called gethostbyname(), then called library function which 
> unknowingly to application, could possibly do a DNS or YP lookup (and 
> whose behavior could change depending on some config file like 
> /etc/nsswitch.conf), which would blow away the static information.  So 
> if the application tryied to use the information returned by _its_ call 
> to gethostbyname after calling some other library function, it could get 
> some completely random hostname that wasn't what it expected.
> 
> Yelch!  And so we have two API's that libc has to support, 
> gethostbyname(), and gethostbyname_r(), with the ugly _r() suffix, and 
> which in a sane world most programs should use since otherwise they can 
> be incredibly fragile unless the _first_ thing they do after calling 
> gethostbyname is to copy the information to someplace stable, instead of 
> relying on the static buffer to remain sane.  (And yet they don't, which 
> means bugs that only show up if optional YP or Hesiod lookups are 
> enabled, etc.)
> 
> Berkely got it horribly wrong when it tried to start with the "small and 
> beautiful" functions that were non-reentrant, and we've been paying the 
> price ever since.  Do we really want to support two versions of the API 
> forever?  Is it really that hard to support a reentrant API from the 
> beginning?  I'd submit the answer to these two questions are no, and no, 
> respectively.

You make a good case why gethostbyname() was wrong, and should have been 
defined as gethostbyname_r() to begin with.

However, as I wrote in another reply in this thread, I am not prepared to 
sink more time in this discussion, _unless_ somebody who cares about it 
enough shows me some code and/or numbers.

Ciao,
Dscho
