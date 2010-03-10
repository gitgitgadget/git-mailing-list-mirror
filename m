From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git interix support
Date: Wed, 10 Mar 2010 13:32:29 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1003101319350.14365@iabervon.org>
References: <4B962456.20600@salomon.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Markus Duft <markus.duft@salomon.at>
X-From: git-owner@vger.kernel.org Wed Mar 10 19:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpQi2-0005mQ-Pn
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 19:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932655Ab0CJScb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 13:32:31 -0500
Received: from iabervon.org ([66.92.72.58]:38650 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932690Ab0CJSca (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 13:32:30 -0500
Received: (qmail 26700 invoked by uid 1000); 10 Mar 2010 18:32:29 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 Mar 2010 18:32:29 -0000
In-Reply-To: <4B962456.20600@salomon.at>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141910>

On Tue, 9 Mar 2010, Markus Duft wrote:

> Hey.
> 
> i have "ported" git to interix (haha, wasn't so much of a problem after
> all ;)). i have a small patch (attached). i know that it sure doesn't
> have production quality yet, but i try gathering ideas/input here.
> 
> additionally to the patch i'm setting:
> 
> 147     if [[ ${CHOST} == *-interix* ]] ; then
> 148         myopts="${myopts} NO_IPV6=YesPlease"
> 149         myopts="${myopts} NO_MEMMEM=YesPlease"
> 150         myopts="${myopts} NO_MKDTEMP=YesPlease"
> 151         myopts="${myopts} NO_STRTOUMAX=YesPlease"
> 152         myopts="${myopts} NO_STRTOULL=YesPlease"
> 153         myopts="${myopts} NO_INET_NTOP=YesPlease"
> 154         myopts="${myopts} NO_INET_PTON=YesPlease"
> 155         myopts="${myopts} NO_NSEC=YesPlease"
> 156         myopts="${myopts} NO_MKSTEMPS=YesPlease"
> 157     fi
> 
> interix lacks propper poll() support (poll is there but broken), so some
> of the things in git have to be disabled for now, or replaced by a
> select() code (but that'd take precious time of mine to implement (argh)).
> 
> any comments on the patch? any chance to get stuff upstream?

If you've got programs that don't work at all without some library 
function that you don't have, it's better to not build them at all (by not 
having them in the make targets) than build binaries that refuse to run. 
Doing it that way means you don't need to get the rest of the file to 
compile, and makes it more clear before runtime what functionality will be 
missing.

Also, if you make a NO_POLL and use that, someone else might make a 
compat_poll(). Or maybe not, but a workaround certainly won't get done if 
you just use __INTERIX.

	-Daniel
*This .sig left intentionally blank*
