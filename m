From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 1/2] Move run_hook() from builtin-commit.c into
	run-command.c (libgit)
Date: Fri, 16 Jan 2009 18:25:21 +0100
Message-ID: <20090116172521.GD28177@leksak.fem-net>
References: <1232031618-5243-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0901151637590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 16 18:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNsT8-00037g-Gg
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 18:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757571AbZAPRZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Jan 2009 12:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756839AbZAPRZa
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jan 2009 12:25:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:46387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756074AbZAPRZa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jan 2009 12:25:30 -0500
Received: (qmail invoked by alias); 16 Jan 2009 17:25:28 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp001) with SMTP; 16 Jan 2009 18:25:28 +0100
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/f+f0Jh+zfnW1M76mqG6XjlBKUZ0FimWqqU4SNOI
	9aqQiMzdeDHxIE
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1LNsRd-00049W-70; Fri, 16 Jan 2009 18:25:21 +0100
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901151637590.3586@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105981>

Hi,

> > -	ret = start_command(&hook);
> > -	if (ret) {
> > -		warning("Could not spawn %s", argv[0]);
> > -		return ret;
> > -	}
> > -	ret = finish_command(&hook);
> > -	if (ret == -ERR_RUN_COMMAND_WAITPID_SIGNAL)
> > -		warning("%s exited due to uncaught signal", argv[0]);
> 
> What are the side effects of replacing this with "ret = 
> run_command(&hook);"?  This has to be discussed and defended in the commit 
> message.

This is a very good point.
The consequences are that two warnings are missing, but these are
warnings that are useful enough to be included for all those hooks,
imho.

Thanks!

> Lots of improvements possible (I agree; _after_ this patch):
[...]
> - use ALLOC_GROW instead of having a fixed size argv,

Agreed.

> - use an strbuf for the index file

Is that useful in some way?
Currently it would only adds code to generate strbufs at the caller
side. And in the case the caller has a strbuf for the index file, it
can simply use the .buf member.

> - checking executability of argv[0] before filling argv,

Agreed.

Patch series v2 will follow.

Thanks,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
