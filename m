From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git pull is slow
Date: Fri, 11 Jul 2008 15:04:21 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111443280.8950@racer>
References: <g5570s$d5m$1@ger.gmane.org> <g57jkp$ekm$1@ger.gmane.org> <48776169.20705@op5.se>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-432674514-1215785063=:8950"
Cc: Stephan Hennig <mailing_list@arcor.de>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Jul 11 16:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHJFu-0000lw-8d
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 16:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760286AbYGKOE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 10:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760271AbYGKOE0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 10:04:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:51490 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760131AbYGKOE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 10:04:26 -0400
Received: (qmail invoked by alias); 11 Jul 2008 14:04:24 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp008) with SMTP; 11 Jul 2008 16:04:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/l0n1RZ1nljn4fxNeyi7BoJzmB4FAmCNzfUjuu9u
	laQ/yQej15MWmX
X-X-Sender: gene099@racer
In-Reply-To: <48776169.20705@op5.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88120>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-432674514-1215785063=:8950
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 11 Jul 2008, Andreas Ericsson wrote:

> Stephan Hennig wrote:
> > Stephan Hennig schrieb:
> > 
> > > I am observing very large data transfers when pulling from the
> > > repository at <URL:http://repo.or.cz/w/wortliste.git>.
> > 
> > Here's the output of a recent pull:
> > 
> > > unknown@COMMODORE ~/Themen/trennmuster/repository/wortliste (master)
> > > $ git pull
> > > Enter passphrase for key '/x/home/.ssh/id_rsa':
> > > remote: Counting objects: 15, done.←[K
> > > remote: Compressing objects: 100% (7/7), done.←[K)   ←[Kts:   8% (1/12)
> > > remote: Total 12 (delta 5), reused 12 (delta 5)←[K
> > > Unpacking objects: 100% (12/12), done.
> > > From git+ssh://xxx@repo.or.cz/srv/git/wortliste
> > >    d905095..d0c6a33  master     -> origin/master
> > > * [new tag]         dehyph-exptl-v0.13 -> dehyph-exptl-v0.13
> > > Updating d905095..d0c6a33
> > > Fast forward
> > >  wortliste←[m |   19 ←[32m+++++++++++←[m←[31m--------←[m
> > >  1 files changed, 11 insertions(+), 8 deletions(-)←[m
> > 
> > After the line containing "remote: Compressing objects:" had been
> > printed several MB have been transferred.
> > 
> 
> Seems like you're being bitten by a bug we had some months back,
> where the client requested full history for new tag objects.

I do not think so.  I think it is a problem with the pack.  The slowness 
is already there in the clone, in the resolving phase.

Judging from the output of "verify-pack -v", it seems that the delta 
chains are quite long.

I saw memory usage go up pretty quickly.  I thought that maybe 
eac12e2(Correct pack memory leak causing git gc to try to exceed ulimit)
would help things, since it fixes a place where memory usage grows out of 
bounds, but it did not.

Unfortunately, I do not have time to look into this further.

BTW there is a nasty usability bug when "Compressing objects:" and 
"Receiving objects:" messages 

Ciao,
Dscho
--8323329-432674514-1215785063=:8950--
