From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH] Add git-squash tool and tests
Date: Tue, 10 Jun 2008 01:26:33 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806100121150.1783@racer>
References: <484D47C9.9050509@gnu.org> <1213043398-30524-1-git-send-email-s-beyer@gmx.net> <alpine.DEB.1.00.0806092133260.1783@racer> <484D984F.20700@gnu.org> <alpine.DEB.1.00.0806092232480.1783@racer> <20080609234208.GE8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:28:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5rjF-0005eh-GK
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 02:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbYFJA1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 20:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753149AbYFJA1x
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 20:27:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:59404 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752671AbYFJA1w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 20:27:52 -0400
Received: (qmail invoked by alias); 10 Jun 2008 00:27:50 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 10 Jun 2008 02:27:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18skoFnncAsyhfmy8B+EE9xQstHV7eFKdBCM2WWNk
	YluusOGPRLm5E1
X-X-Sender: gene099@racer
In-Reply-To: <20080609234208.GE8079@leksak.fem-net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84461>

Hi,

On Tue, 10 Jun 2008, Stephan Beyer wrote:

> > Except that zucchini is meant for the sequencer, which can implement it 
> > much more efficiently (i.e. it does not have to check out HEAD~$n).  Also, 
> > it must not rely on reflogs being enabled.
> > 
> > sequencer is plumbing, while the reset mantra is porcelain.
> 
> Do I get you right, that the builtin sequencer must not use any of the 
> porcelain like cherry-pick, reset and even commit?

AFAIAC cherry-pick and reset, and even commit, are not "pure" porcelain: 
you can rely on their exit code and to a certain extent on their output.  
Although I would rather use commit-tree from a script than commit.

I'd probably even use git update-ref instead of reset --soft, but then, I 
_would_ use cherry-pick.

So there is a lot of gray.

> (Perhaps I got it wrong, but it doesn't seem "right" to me, if a 
> plumbing uses porcelain.)
> 
> Currently my prototype *uses* these porcelain, so is it a porcelain in 
> its current state? ;)

I would say as long as it is meant to be used by a human, it is porcelain.  
And I do not think that git-sequencer falls into that category.

So it should avoid pure porcelains, such as "git show", and use the 
(robust) low-level tools instead.

But I feel quite silly talking about that at length; I think that you can 
use whatever gets a prototype done, and then go on and make it a builtin.

Ciao,
Dscho
