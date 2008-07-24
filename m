From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/9] builtin-init-db.c: use parse_options()
Date: Thu, 24 Jul 2008 18:07:02 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241801030.8986@racer>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-7-git-send-email-barra_cuda@katamail.com> <4888AAB2.5050007@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Michele Ballabio <barra_cuda@katamail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Thu Jul 24 19:08:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM4IL-0003YK-74
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 19:08:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbYGXRHA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 13:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYGXRHA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 13:07:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:43838 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750991AbYGXRG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 13:06:59 -0400
Received: (qmail invoked by alias); 24 Jul 2008 17:06:57 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp056) with SMTP; 24 Jul 2008 19:06:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19EXl98BE9ECj0OFLPveFMH22+4LJqoytqs+5Zh9f
	7+G4f+ysJxM/W7
X-X-Sender: gene099@racer
In-Reply-To: <4888AAB2.5050007@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89914>

Hi,

On Thu, 24 Jul 2008, Olivier Marin wrote:

> Michele Ballabio a ??rit :
> 
> > +		OPT_BOOLEAN(0, "bare", &bare, "set up a bare repo"),
> 
> s/set up/setup/

No.  "setup" is a noun.

> > +		{ OPTION_CALLBACK, 0, "shared", &shared_repository,
> > +		  "type", "type of shared repository",
> 
> What about "permissions", "setup a shared repository"?
> 
> > +		  PARSE_OPT_OPTARG, parse_opt_shared_cb, PERM_GROUP },
> 
> Are you sure the default value is really used here?
> 
> Also, perhaps we can play it safer by avoiding changing "share_repository"
> directly.

I do not see how that would be any safer.

> $ git init -> shared_repository == PERM_UMASK
> $ git init --shared --no-shared -> shared_repository == 0
> 
> It works because PERM_UMASK == 0, but it is a side effect. Don't you think?

Then the callback is wrong, too.  I think, however, that it is by design, 
and correct.

We rely on shared_repository == 0 for non-shared repositories _almost 
everywhere_.

> > +		OPT_BIT('q', "quiet", &flags, "be quiet", INIT_DB_QUIET),
> 
> OPT__QUIET(&quiet),
> 
> if (quiet)
> 	flags |= INIT_DB_QUIET;
> 
> to use the same quiet option everywhere?

Why?  Doesn't make it more readable, I think.  I'd rather have 3 lines 
less.

Ciao,
Dscho
