From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH RESEND] git submodule add: make the <path> parameter
 optional
Date: Sun, 4 Oct 2009 23:05:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910042304060.4985@pacific.mpi-cbg.de>
References: <4AB8E8D4.40105@web.de> <7vbpl2srw9.fsf@alter.siamese.dyndns.org> <4AC8E0A8.4000901@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Oct 04 23:06:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuYHQ-0006tZ-M6
	for gcvg-git-2@lo.gmane.org; Sun, 04 Oct 2009 23:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758086AbZJDVED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Oct 2009 17:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758069AbZJDVED
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 17:04:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:40429 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758049AbZJDVEB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 17:04:01 -0400
Received: (qmail invoked by alias); 04 Oct 2009 21:03:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp032) with SMTP; 04 Oct 2009 23:03:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/u9DgOZDvuTJZwoEJUX8kPQjVfw6cacEWlyuPJeC
	uzBbHlv5uMQiKv
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4AC8E0A8.4000901@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.52
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129518>

Hi,

On Sun, 4 Oct 2009, Jens Lehmann wrote:

> Junio C Hamano schrieb:
> > Jens Lehmann <Jens.Lehmann@web.de> writes:
> > 
> >> When <path> is not given, use the "humanish" part of the source repository
> >> instead.
> >>
> >> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> >> ---
> >>
> >> With this patch, git submodule add behaves like git clone in this respect.
> >>
> >> Didn't get a response the last weeks, so here is a resend.
> >>
> >>
> >>  Documentation/git-submodule.txt |    8 ++++++--
> >>  git-submodule.sh                |    7 ++++++-
> >>  t/t7400-submodule-basic.sh      |   16 ++++++++++++++++
> >>  3 files changed, 28 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> >> index 5ccdd18..4ef70c4 100644
> >> --- a/Documentation/git-submodule.txt
> >> +++ b/Documentation/git-submodule.txt
> >> @@ -10,7 +10,7 @@ SYNOPSIS
> >>  --------
> >>  [verse]
> >>  'git submodule' [--quiet] add [-b branch]
> >> -	      [--reference <repository>] [--] <repository> <path>
> >> +	      [--reference <repository>] [--] <repository> [<path>]
> >>  'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
> >>  'git submodule' [--quiet] init [--] [<path>...]
> >>  'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
> >> @@ -69,7 +69,11 @@ add::
> >>  	to the changeset to be committed next to the current
> >>  	project: the current project is termed the "superproject".
> >>  +
> >> -This requires two arguments: <repository> and <path>.
> >> +This requires at least one argument: <repository>. The optional
> >> +argument <path> is the relative location for the cloned submodule
> >> +to exist in the superproject. If <path> is not given, the
> >> +"humanish" part of the source repository is used ("repo" for
> >> +"/path/to/repo.git" and "foo" for "host.xz:foo/.git").
> > 
> > I do not know if this is useful in practice nor even desired.  Comments?
> 
> As nobody commented until now, i'll explain my motivation for this patch.
> 
> When adding submodules i was surprised to find that i had to explicitly
> provide the pathname even though it could be easily generated from the
> reponame as git clone does it. And i see git clone and git submodule add
> as related commands from a users perspective, they both connect a remote
> repo to a working directory.
> 
> IMHO this patch makes the ui more consistent and doesn't break existing
> setups or scripts. And it is really useful because i don't do typos in
> the pathname anymore ;-)

So far, I started submodules by cloning them, doing everything in the 
other files needed to integrate, and then actually wondered why "git 
submodule add" could not simply take the (relative) path to the 
checked-out submodule and deduce the URL from the corresponding config?

So I would actually vote for making the <repository> parameter optional...

Ciao,
Dscho
