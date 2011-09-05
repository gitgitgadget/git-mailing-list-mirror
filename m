From: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Overriding ~/.gitconfig using GIT_CONFIG
Date: Mon, 05 Sep 2011 20:29:50 +0100
Message-ID: <1315250990.1243.14.camel@ted>
References: <1313163498.14274.505.camel@rex>
	 <7vr54qmodf.fsf@alter.siamese.dyndns.org>
	 <7vmxfemnc4.fsf@alter.siamese.dyndns.org> <1313181853.14274.535.camel@rex>
	 <20110828130555.GA56765@gmail.com> <1314620166.5939.282.camel@rex>
	 <20110830031022.GA64106@gmail.com> <1314706381.5939.348.camel@rex>
	 <20110830155649.GA15790@sigill.intra.peff.net>
	 <1314729545.5939.391.camel@rex>
	 <20110830184951.GA19204@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Nguy?? n =?UTF-8?Q?Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 21:30:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0esP-00043X-0m
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 21:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495Ab1IETaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 15:30:22 -0400
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:55125 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753378Ab1IETaT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 15:30:19 -0400
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p85JTtmH001046;
	Mon, 5 Sep 2011 20:29:55 +0100
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 00906-05; Mon,  5 Sep 2011 20:29:52 +0100 (BST)
Received: from [192.168.1.40] (dynamic10.rpnet.com [192.168.1.40])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id p85JTofD001039
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 5 Sep 2011 20:29:50 +0100
In-Reply-To: <20110830184951.GA19204@sigill.intra.peff.net>
X-Mailer: Evolution 2.32.2 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180754>

On Tue, 2011-08-30 at 14:49 -0400, Jeff King wrote:
> On Tue, Aug 30, 2011 at 07:39:05PM +0100, Richard Purdie wrote:
> 
> > On Tue, 2011-08-30 at 11:56 -0400, Jeff King wrote:
> > > On Tue, Aug 30, 2011 at 01:13:01PM +0100, Richard Purdie wrote:
> > > 
> > > > We've gone through several iterations of this but as things stand now,
> > > > to initially clone things we're doing:
> > > > 
> > > > git clone --bare --mirror <url> <dir>
> > > > 
> > > > but if we already have some existing clone we'd update with:
> > > > 
> > > > git remote prune origin
> > > > git remote rm origin
> > > > git remote add --mirror origin <url>
> > > > git fetch --all -t
> > > >
> > > > [...]
> > > >
> > > > So if a user has an origin remote in their .gitconfig, can we ignore it?
> > > 
> > > Wouldn't:
> > > 
> > >   git fetch --prune <url> refs/heads/*:refs/remotes/origin/*
> > > 
> > > do what you want, and not look at config at all?
> > 
> > Since this is a bare/mirror clone, wouldn't that need to be:
> > 
> >  git fetch --prune <url> refs/heads/*:refs/heads/*
> 
> Sorry, yes, I forgot about the mirroring bit.
> 
> > That also wouldn't fetch tags?
> 
> It would only do autofollowing. You could use "-t", but if you really
> want a straight mirror, you could do:
> 
>   git fetch --prune refs/*:refs/*
> 
> to get everything.

Thanks. Just to updated, I've changed the code to do this so we'll see
how it goes...

Cheers,

Richard
