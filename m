From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] index-pack: never prune base_cache.
Date: Wed, 23 Jul 2008 14:46:38 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807231436440.8986@racer>
References: <20080722231745.GD11831@artemis.madism.org> <20080723101415.GA23769@atjola.homenet> <alpine.DEB.1.00.0807231246560.2830@eeepc-johanness> <20080723111931.GF15243@artemis.madism.org> <alpine.DEB.1.00.0807231235150.8986@racer> <20080723120045.GA21274@atjola.homenet>
 <20080723121118.GA20614@artemis.madism.org> <20080723125226.GA11679@atjola.homenet> <alpine.DEB.1.00.0807231407040.8986@racer> <20080723132031.GC20614@artemis.madism.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1217359027-1216820799=:8986"
Cc: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	spearce@spearce.org, Git ML <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 15:47:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLegs-0006Rg-IQ
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 15:47:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbYGWNqj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 09:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbYGWNqj
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 09:46:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:39948 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751222AbYGWNqi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 09:46:38 -0400
Received: (qmail invoked by alias); 23 Jul 2008 13:46:36 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp009) with SMTP; 23 Jul 2008 15:46:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9pQ8oS5C9tfe8oa0sQaVeWYc5Zle+AF88y/5XXo
	GD9TrdT0L4vS9a
X-X-Sender: gene099@racer
In-Reply-To: <20080723132031.GC20614@artemis.madism.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89652>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1217359027-1216820799=:8986
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 23 Jul 2008, Pierre Habouzit wrote:

> On Wed, Jul 23, 2008 at 01:09:40PM +0000, Johannes Schindelin wrote:
> > On Wed, 23 Jul 2008, Björn Steinbrink wrote:
> > > The patch itself should be fine.
> > 
> > No, since it opens the whole issue of memory explosion again, the same 
> > issue Shawn's original patch tried to fix.
> 
>   No it won't. Indeed the issue is with fix_unresolved_deltas that
> sometimes put at the root of the chain (in base_cache) something that
> comes from our store, not the pack we are writing. Then starts a delta
> chain resolution.

If it comes from our store, we should have _no_ problem reconstructing the 
object.

>   It won't explode in memory at all, we just keep the first data of a
> delta chain in memory, that's all. It indeed consumes more memory, but
> we talk about *one* single object per delta chain because we're too lazy
> to memorize where it comes from. It's probably not much of an explosion.

"Probably".

>   We also waste that object even when it's from our own pack. Well, I'd
> say "too bad".

And I say it's dirty, and since the pack code traditionally is one of the 
cleanest parts of Git, coming from Nico,  let's not change that, okay?

Ciao,
Dscho

--8323329-1217359027-1216820799=:8986--
