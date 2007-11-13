From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Tue, 13 Nov 2007 05:02:09 -0500
Message-ID: <20071113100209.GE14735@spearce.org>
References: <Pine.LNX.4.64.0711121715090.4362@racer.site> <18232.35893.243300.179076@lisa.zopyra.com> <Pine.LNX.4.64.0711121727130.4362@racer.site> <vpq7iknqrtp.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121755460.4362@racer.site> <vpqy7d3pck0.fsf@bauges.imag.fr> <Pine.LNX.4.64.0711121804400.4362@racer.site> <vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org> <vpqzlxiiii6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 13 11:02:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrsbQ-0007Qa-Uh
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 11:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXKMKC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 05:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbXKMKCZ
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 05:02:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60665 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462AbXKMKCY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 05:02:24 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Irsav-00072S-4t; Tue, 13 Nov 2007 05:02:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C0B3620FBAE; Tue, 13 Nov 2007 05:02:09 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <vpqzlxiiii6.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64779>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> I repeat the use-case I mentionned above :
> 
> ,----
> | a typical use-case is when I want to create a new project. I'd
> | like to initialize an empty bare repo on my backed up disk, and then
> | clone it to my local-fast-unreliable disk to get a working copy and do
> | the first commit there.
> `----
> 
> I find this quite natural, and up to now, no one gave me either a
> rationale not to do that, or a _simple_ way to achieve this. As I
> said, it's currently not _very_ hard to do, but I have to edit
> .git/config by hand, while git clone knows how to do this much faster
> than I for non-empty repositories.

Its a goal to redefine git-clone as the following, as that is
really all it does:

	mkdir foo && cd foo && git init &&
	git remote add -f origin $url &&
	git checkout -b master origin/master

So setting up an empty tree is basically that:

	mkdir foo && cd foo && git init &&
	git remote add origin $url

Is that really so difficult?  git-clone is a handy crutch for when
we didn't have things like git-remote.  Or remote tracking branches.
IMHO the above may seem a little low level but it may make it easier
to teach to newbies.  They are more likely to grasp the concept of
their repository being just like someone else's, and that they can
track other repositories beyond just their origin.

-- 
Shawn.
