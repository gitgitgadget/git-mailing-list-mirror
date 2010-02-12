From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 11:10:47 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1002120923060.14365@iabervon.org>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com>  <20100212080620.GA31719@dcvr.yhbt.net> <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>  <fabb9a1e1002120103j3f37d417ka5b7b7ca3ae8edd@mail.gmail.com>  <20100212091635.GA22942@glandium.org>
 <alpine.DEB.1.00.1002121034320.20986@pacific.mpi-cbg.de> <fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mike Hommey <mh@glandium.org>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 17:10:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfy6Y-0008Mc-Lb
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 17:10:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755742Ab0BLQKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 11:10:49 -0500
Received: from iabervon.org ([66.92.72.58]:40196 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab0BLQKs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 11:10:48 -0500
Received: (qmail 12595 invoked by uid 1000); 12 Feb 2010 16:10:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Feb 2010 16:10:47 -0000
In-Reply-To: <fabb9a1e1002120132q157d2d4dqd7c81d766bd933f6@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139718>

On Fri, 12 Feb 2010, Sverre Rabbelier wrote:

> Heya,
> 
> On Fri, Feb 12, 2010 at 10:35, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > On Fri, 12 Feb 2010, Mike Hommey wrote:
> >> It is already mentioned on the wiki that this would probably be a
> >> problem, license-wise. (the svn library is Apache license, which is
> >> incompatible with GPLv2)
> 
> Yeah, guess who put that there ;).
> 
> > So git-remote-svn would have to be under an Apache-compatible license, so
> > what? It is not as if git-remote-svn was a derivative work of Git, just
> > because it abides by a very simple command-line interface that happens to
> > be defined in Git, but would work anywhere else, too.
> 
> Excellent point, I think we could safely argue that if we only expose
> 'import' and 'export' (so adhere to the fast-import/fast-export format
> that is already widely used), that it is indeed not a derative work.
> Also, becaus of how we set up the remote helpers (as drop in
> binaries), we shouldn't have to worry too much about distributing?

It was intentional on my part that the mode where the helper only talks to 
the remote system and to its parent be not a derived work of the parent, 
under the usual analysis that something is not covered by copyright if it 
has to be a particular way for functional or interoperability reasons.

This does not strictly mean that helpers won't be derived works of git, 
simply because they may use git code internally (strbuf, for example), and 
because it's currently much easier to do incremental imports by looking up 
the current state from the git object database than to be completely 
agnostic.

Also note that the current helper protocol is definitely insufficient to 
replace git-svn ('export' isn't actually specified, although I think 
everyone who guesses how it works guesses the same thing), and the 
transport code needs to be extended to handle the "dcommit" situation 
(when you push a commit, the state that you see on the remote changes 
based on the semantics of what you sent, but it does not change to have 
the same hash as what you pushed).

Distribution of binaries shouldn't be a problem (the GPL specifically 
states that just coming in the same package doesn't matter for licensing, 
and this is generally what copyright laws say anyway); the main issue is 
that packages would have to specify which things have which license, since 
it won't just be obvious.

	-Daniel
*This .sig left intentionally blank*
