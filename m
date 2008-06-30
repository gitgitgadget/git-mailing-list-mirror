From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Mon, 30 Jun 2008 12:37:45 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806301236110.9925@racer>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl> <alpine.DEB.1.00.0806271353350.9925@racer> <alpine.LNX.1.00.0806271149580.19665@iabervon.org> <7vvdzuo61b.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer> <7vwsk730mm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 13:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDHkR-0004WA-Vv
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 13:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234AbYF3Ljp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 07:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYF3Ljp
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 07:39:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:49419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754806AbYF3Ljp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 07:39:45 -0400
Received: (qmail invoked by alias); 30 Jun 2008 11:39:43 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp029) with SMTP; 30 Jun 2008 13:39:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18COK0yKmkC+Fmc3VW3voQyXyK28NBpas7EkcyEh5
	HCl0s4n6dVKimH
X-X-Sender: gene099@racer
In-Reply-To: <7vwsk730mm.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86907>

Hi,

On Sun, 29 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 29 Jun 2008, Daniel Barkalow wrote:
> >
> >> Did we even make a commitment on whether:
> >> 
> >> GIT_CONFIG=foo git clone bar
> >> 
> >> must ignore the environment variable, or simply doesn't necessarily 
> >> obey it?
> >
> > I'd rather strongly argue that no matter what is the answer to this 
> > question, we _HAVE TO_ unsetenv() GIT_CONFIG at some stage, otherwise 
> > no .git/config will be written.
> >
> > So, this is a NACK on your patch.
> 
> True.  We are creating the config file for the new repository, so the
> initial setenv() would make sense.  We _could_ save away end user's
> GIT_CONFIG and restore it where you unsetenv() in your patch,

No.  That would break again, since then,

- $HOME/.gitconfig would be ignored again (which was the single issue my 
  patch addressed), and
- the remote information would be written into the wrong file.

Ciao,
Dscho
