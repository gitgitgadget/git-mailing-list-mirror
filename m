From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] builtin-fast-export: Add importing and exporting of
 revision marks
Date: Wed, 11 Jun 2008 20:45:16 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806112043360.1783@racer>
References: <BEF1F17D-6F0F-4F09-9CC4-B193B8907901@ai.rug.nl> <1212663163-43064-1-git-send-email-pdebie@ai.rug.nl> <7v8wxirwi1.fsf@gitster.siamese.dyndns.org> <DB158BDE-70D1-4779-9B03-A85C60EB2FA7@ai.rug.nl> <alpine.DEB.1.00.0806071612460.1783@racer>
 <7vy75hnqu7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 21:48:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6WI7-000563-6X
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 21:47:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbYFKTqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 15:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752077AbYFKTqd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 15:46:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:51374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751912AbYFKTqb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 15:46:31 -0400
Received: (qmail invoked by alias); 11 Jun 2008 19:46:28 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 11 Jun 2008 21:46:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3chp+g6f37qJNuqofVfo0VzGbbeSSSkYXFA41Va
	TvN/xEdUINeZJr
X-X-Sender: gene099@racer
In-Reply-To: <7vy75hnqu7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84645>

Hi,

On Sat, 7 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, I looked again, and indeed, you _copied_ it.  Instead of using the 
> > functions mark_object() and get_object_mark() which are there only to be 
> > used by you.
> >
> > So please fix.
> >
> >> >Even if that is the case, doesn't "(uint32_t *)deco->decoration - 
> >> >(uint32_t *)NULL" mean the value range for deco->decoration is 
> >> >one-fourth of U32?
> >
> > It is.  But since every object needs already at least 20 bytes, and we do 
> > not even have the complete address space to put objects into, and we do 
> > not plan to support 64-bit only repositories, I think we are fine.
> 
> Oh, I was not complaining about the one-fourthness.  I was wondering why 
> "(uint32_t *)", which makes it look like the type itself has very deep 
> meaning for this computation, was used, instead of "(char *)" or 
> something that makes it much clearer that what could be pointed at by 
> the pointer does not matter and you are only using them as fake 
> integers.

Probably you are right.  I had the impression that you could not rely on 
(void *) having the full precision, but that was completely bogus.

It could be changed to (char *) safely.

Ciao,
Dscho
