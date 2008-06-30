From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 21:46:22 +0200
Message-ID: <200806302146.23120.J.Wielemaker@uva.nl>
References: <200806301149.18115.J.Wielemaker@uva.nl> <200806301420.12872.J.Wielemaker@uva.nl> <alpine.LNX.1.00.0806301528500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 21:56:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDPUf-0000hN-Po
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 21:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762190AbYF3T4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 15:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762021AbYF3T4A
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 15:56:00 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:2528 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYF3Tz7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 15:55:59 -0400
X-Greylist: delayed 572 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Jun 2008 15:55:59 EDT
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id m5UJkN9m094549;
	Mon, 30 Jun 2008 21:46:24 +0200 (CEST)
	(envelope-from J.Wielemaker@uva.nl)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <alpine.LNX.1.00.0806301528500.19665@iabervon.org>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86935>

On Monday 30 June 2008 21:33:50 Daniel Barkalow wrote:
> On Mon, 30 Jun 2008, Jan Wielemaker wrote:
> > On Monday 30 June 2008 14:03, Jakub Narebski wrote:
> > > Jan Wielemaker wrote:
> > > > Summarising, I think the conclusion is that git pack-refs has somehow
> > > > been run on this repository, and being a bare one this is not a
> > > > particulary good idea right now. I have the impression I should
> > > > `unpack' them by putting the appriate files in heads (done) and tags
> > > > (now still) and (re)move packed-refs.
> > >
> > > If you use new enough git both on server and on clients it should
> > > not have problems with packed-refs. I would rather check permissions
> > > of $GIT_DIR and $GIT_DIR/packed-refs.
> >
> > There is no permission problem, as a I proved by doing a recursive copy
> > of the whole repo (cp -a, no errors) and the problem prevails on the
> > copy. A serious scan for permission errors was my first step. Almost
> > looks like something in the environment, but I can't find anything weird
> > there either.
>
> That's a "cp -a" as somebody else, I assume? (If it were as you or root,
> you'd generate a copy of the repository with any permission problem
> unchanged, since -a includes -p.)

I'm an old time Unix guy :-).  The failing user has a git-shell.  I did
(reconstructing from memory):

	% sudo -u failinguser /bin/bash
	<passwd>
	% Use whoami to validate I was this user
	% git clone /home/git/pl.git
	<failed (no remote branches)>
	% cp -a /home/git/pl.git tmp.git
	<ok, no errors>
	% git clone tmp.git
	<failed (no remote branches)>

Funny enough, as myself I can clone tmp.git!?  I have only one git 
installation
in /usr/local/bin.

	Cheers --- Jan
