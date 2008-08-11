From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] checkout --track: make up a sensible branch name if '-b'
 was omitted
Date: Mon, 11 Aug 2008 13:01:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111256260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <alpine.DEB.1.00.0808091559460.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vtzdu6nb7.fsf@gitster.siamese.dyndns.org> <7vvdya55ur.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0808092302520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <7vsktd51wg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 12:58:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSV6E-0007nU-Je
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 12:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751419AbYHKK5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 06:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbYHKK5B
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 06:57:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:50181 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751419AbYHKK5A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 06:57:00 -0400
Received: (qmail invoked by alias); 11 Aug 2008 10:56:59 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 11 Aug 2008 12:56:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+WYGpYVo+WQDpWxvK2XmUkbMRLuXpHdUviZoPlv/
	KaEcN6YFvFpls0
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vsktd51wg.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91932>

Hi,

On Sat, 9 Aug 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 9 Aug 2008, Junio C Hamano wrote:
> > ...
> >> (2) If you work with somebody else, you might not want to have the name
> >>     mapping to be "s|^[^/]*/||" (i.e. drop "origin/"):
> >> 
> >>     $ git remote add -f jeff $url_to_his_repository
> >>     $ git checkout -b [--track] jeff-next jeff/next
> >>     $ git checkout -b [--track] origin-next origin/next
> >
> > As I said, I think you must not allow switching around the options -b 
> > and --track.
> 
> Oh, that was a typo.  "git checkout [--track] -b" was what I meant, but 
> the point was that with your patch "git checkout --track jeff/next" and 
> "git checkout --track origin/next" would create 'next' branch which will 
> not be useful for people who work with more than one repository.
> 
> Yes, you can of course explicitly name what you want to create with -b, 
> but that argument goes directly against the "usability enhancement" 
> theme of your patch.

Not necessarily:

$ git checkout --track jeff/next
Switched to a new branch "next"

[do a lot of work, even on that 'next' branch]

[weeks, months or centuries later, decide to do something on origin/next]

$ git checkout --track origin/next
fatal: A branch named 'next' already exists.

[Ah! Slap your head, remembering that 'next' tracks jeff's 'next']
$ git branch -m next jeff-next
Branch: next renamed to jeff-next
$ git checkout --track -b origin-next origin/next


Concluding, I do not see how the DWIMing of the normal case impacts the 
non-normal case negatively.

Don't get me wrong.  I do not need that patch in git.git desperately.  
But if it is rejected, I want it to be rejected for reasons I understand.

Ciao,
Dscho
