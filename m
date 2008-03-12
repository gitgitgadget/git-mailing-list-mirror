From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] gc: call "prune --expire 2.weeks.ago"
Date: Wed, 12 Mar 2008 13:01:55 -0400
Message-ID: <20080312170155.GB11236@coredump.intra.peff.net>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <7vbq5k77z0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803121153160.1656@racer.site> <alpine.LFD.1.00.0803121143170.2947@xanadu.home> <FE263BF7-9948-463C-B9B2-833B068EB10B@ai.rug.nl> <alpine.LSU.1.00.0803121705330.1656@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 12 18:03:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZULf-0007Pz-B6
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 18:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbYCLRB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 13:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbYCLRB7
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 13:01:59 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4701 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbYCLRB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 13:01:58 -0400
Received: (qmail 17389 invoked by uid 111); 12 Mar 2008 17:01:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 12 Mar 2008 13:01:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2008 13:01:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803121705330.1656@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76967>

On Wed, Mar 12, 2008 at 05:05:51PM +0100, Johannes Schindelin wrote:

> > I'd really like it to be at least 2 weeks
> 
> Could you back that up with an explanation, as to why?

I assume it's "because I wouldn't want to lose work I had done within
the last two weeks." Yes, I know that this expiration is actually after
the reflog has already expired, but there is a loophole there: branches
that have been deleted have their reflogs deleted (some have argued that
this doesn't matter, since the HEAD reflog will still mention the
commits. In most cases, this is true, though there are still a few
exceptions).

I think being conservative here is a good idea. The big reason for this
is to fix the spurious "gc --auto" runs caused by needing to prune. So
there is no downside to increasing the time limit unless you think
people will generate enough objects in that limit to cause the problem
again. In which case they will continue to complain to the list, and we
can drop the time.

-Peff
