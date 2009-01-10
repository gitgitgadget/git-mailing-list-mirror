From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Sat, 10 Jan 2009 12:36:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901101232130.30769@pacific.mpi-cbg.de>
References: <20090108195511.GA8734@chistera.yi.org> <7v7i552clz.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901091405460.30769@pacific.mpi-cbg.de> <7vvdsoyzej.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Clemens Buchacher <drizzd@aon.at>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:37:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLc9m-0002NQ-28
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZAJLgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZAJLgI
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:36:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:54745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751068AbZAJLgH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:36:07 -0500
Received: (qmail invoked by alias); 10 Jan 2009 11:36:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 10 Jan 2009 12:36:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9GucQnhz9Stda7pPICFSzViYzjeh8B7QQu2eSjH
	bnBgs1f5vV1uzS
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdsoyzej.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105093>

Hi,

On Fri, 9 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Thu, 8 Jan 2009, Junio C Hamano wrote:
> >
> >> If we find the "common" context lines that have only blank and 
> >> punctuation letters in Dscho output, turn each of them into "-" and "+", 
> >> and rearrange them so that all "-" are together followed by "+", it will 
> >> match Bzr output.
> >
> > So we'd need something like this (I still think we should treat curly 
> > brackets the same as punctuation, and for good measure I just handled 
> > everything that is not alphanumerical the same):
> 
> I meant by punctuation to include curlies (my wording may have been wrong
> but from the example with " }" line it should have been obvious).
> 
> But I agree with both points Linus raised.  The criteria to pick what to
> pretend unmatching should be "small insignificant lines" (small goes for
> both size and also number of consecutive "insignificant" lines), and the
> coallescing should be done to join a block of consecutive changed lines of
> a significant size (so you do not join two 1 or 2-line "changed line"
> blocks by pretending that a 1-line unchanged insignificant line in between
> them is unmatching).

Of course, the number should be configurable as with the inter-hunk 
context.

However, I'll not have much time to work on this feature, and it would 
definitely need some experimenting to find the best parameters, e.g. 
maximal number of inter-hunk lines, maybe even an inter-hunk/hunk ratio, 
alnums, or as Linus suggests the length of the line (of which I am still 
not convinced).

Ciao,
Dscho
