From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bug with .git file and aliases
Date: Tue, 11 Aug 2009 01:05:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908110101110.8306@pacific.mpi-cbg.de>
References: <7f9d599f0907200654q2e068e6aq3051c122f6596053@mail.gmail.com>  <20090720152117.GB5347@coredump.intra.peff.net> <7f9d599f0908101322i46384247m303e28955f88bbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2133827291-1249945540=:8306"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Aug 11 01:05:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Madvp-0005AG-Hr
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 01:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbZHJXFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2009 19:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751679AbZHJXFF
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 19:05:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:49422 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751339AbZHJXFE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Aug 2009 19:05:04 -0400
Received: (qmail invoked by alias); 10 Aug 2009 23:05:04 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp018) with SMTP; 11 Aug 2009 01:05:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1803KoZ/ys0qNtWLQNG1NloWJeuQioqeEoaSFuwPm
	D/3lYD7x7tWkQW
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7f9d599f0908101322i46384247m303e28955f88bbb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125502>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2133827291-1249945540=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Aug 2009, Geoffrey Irving wrote:

> On Mon, Jul 20, 2009 at 11:21 AM, Jeff King<peff@peff.net> wrote:
> > On Mon, Jul 20, 2009 at 09:54:12AM -0400, Geoffrey Irving wrote:
> >
> >> git 1.6.3.3 has a bug related to .git file support and aliases.
> >> Specifically, if you make an alias for status and call it from a
> >> subdirectory, git status chdirs into the true .git dir but then
> >> chdir's back to the wrong place in order to run the lstats for status.
> >>  The result is that git status thinks all files have disappeared.
> >
> > Yeah, this is a known problem. The problem is that the 'git' wrapper
> > sets up the environment only partially when running aliases, and then
> > the resulting command ends up confused about where the worktree is. I
> > really don't remember the specifics, but you can probably find some
> > discussion in the list archives.  Fixing it, IIRC, required some
> > refactoring of the setup code (which I had hoped to get to at some
> > point, but I am way behind on my git todo list).
> 
> The attached patch fixes the bug for me.  I'll leave it to others to
> determine whether this is a good way to fix the problem.

Note that you made it particularly hard to comment on your patch by not 
granting us the wish stated in Documentation/SubmittingPatches, namely to 
inline your patch.

I'll just forego inlining it myself, as I am way past my bed-time and 
cannot be bothered.

However, I think that it is necessary to comment on your patch.

There is a few style issues, such as declaring offset outside of the 
block that is the only user, and there is the issue that you go out of 
your way to append a slash if you're resetting the work tree, but not when 
not resetting it.

But the bigger issue is that you now broke overriding the work tree via 
the command line.

The proper fix, of course, is to avoid calling the function with the wrong 
path to begin with.

Ciao,
Dscho

--8323328-2133827291-1249945540=:8306--
