From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add test-tr: poor-man tr
Date: Thu, 12 Jun 2008 08:01:52 +0200
Message-ID: <20080612060152.GA3798@steel.home>
References: <20080611182501.GA3344@steel.home> <20080611225448.GC19474@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 08:03:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fti-0003ba-2W
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 08:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbYFLGB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 02:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbYFLGB7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 02:01:59 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:34806 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075AbYFLGB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 02:01:58 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+C2Z1
Received: from tigra.home (Fab42.f.strato-dslnet.de [195.4.171.66])
	by post.webmailer.de (fruni mo8) (RZmta 16.42)
	with ESMTP id f0188ck5C1ugh9 ; Thu, 12 Jun 2008 08:01:52 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id AC82B277BD;
	Thu, 12 Jun 2008 08:01:52 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 6AE7056D28; Thu, 12 Jun 2008 08:01:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080611225448.GC19474@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84718>

Jeff King, Thu, Jun 12, 2008 00:54:48 +0200:
> On Wed, Jun 11, 2008 at 08:25:01PM +0200, Alex Riesen wrote:
> 
> > It offers a limited set of POSIX tr, in particular: no character class
> > support and no [n*m] operators. Only 8bit. C-escapes supported, and
> > character ranges. Deletion and squeezing should work, but -s does not
> > match the GNU tr from coreutils (which, in turn, does not match POSIX).
> > 
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> > ---
> > 
> > Rebased on top of current master. I still think it makes the test
> > suite more portable.
> 
> Having wrestled with Solaris tr, I can understand where you are coming
> from. However, does this _actually_ increase the portability of the test
> suite? That is, are there failing tests that this fixes, and if so, for
> which platforms (getting a successful run of the test suite on Solaris
> is still on my long-term todo, but I thought I had fixed all of the tr
> issues)?

Frankly, it started because I wanted to minimize use of Perl on
Windows (because I can't get around ActiveState Perl at work, and it
breaks almost everything it touches). Accidentally, it is also faster
there (maybe just because it's smaller).

But, as was already noted, tr does not behave the same for all
platforms (there were even differences in output, BSD or Solaris put
out a stray LF?).

> Or is your rationale "this will prevent people from screwing up the test
> scripts accidentally in the future"?

We just can't have that. Nothing can prevent people from screwing up
anything in any given point of time :)

In any case, I wont push this change too hard. I must admit, that
there is no real good reason besides one "screwed" company using
obsoleted tools in a weird way. And it is a maintenance effort (and
people will forget to use test-tr instead of perl and tr).
And maybe someday my employment situation improves and I wont push it
at all :)
