From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 14:45:29 -0500
Message-ID: <I5p8gPPuE_qW2RDhwiqxCWDuMtnuvvgtSkeTkxby6rlj_FKtpERaBA@cipher.nrlssc.navy.mil>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <vpqws9cd06b.fsf@bauges.imag.fr> <20090422190856.GB13424@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Nicolas Pitre <nico@cam.org>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 21:47:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiQ7-0007GJ-VV
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 21:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754018AbZDVTqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 15:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754006AbZDVTqO
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 15:46:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:37797 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770AbZDVTqO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 15:46:14 -0400
Received: by mail.nrlssc.navy.mil id n3MJjTAl031311; Wed, 22 Apr 2009 14:45:29 -0500
In-Reply-To: <20090422190856.GB13424@coredump.intra.peff.net>
X-OriginalArrivalTime: 22 Apr 2009 19:45:29.0435 (UTC) FILETIME=[E3F3F2B0:01C9C382]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117242>

Jeff King wrote:
> On Wed, Apr 22, 2009 at 08:15:56PM +0200, Matthieu Moy wrote:
> 
>> Nicolas Pitre <nico@cam.org> writes:
>>
>>> Why so?  Having fewer packs is always a good thing.  Having only one 
>>> pack is of course the optimal situation. 
>> Good and optimal wrt Git, but not wrt an incremental backup system for
>> example. I have a "git gc" running daily in a cron job in each of my
>> repositories, but to be nice with my sysadmin, I don't want to rewrite
>> tens of megabytes of data each night just because I commited a 2 lines
>> patch somewhere.
> 
> You can mark your "big" pack with a .keep, then do your nightly gc as
> usual. You'll have a smaller pack being rewritten each night. When it
> gets big enough, drop the .keep, gc, and then .keep the new pack.
> 
> Yes, it's a bit more work for you, but having "git gc" optimize by
> default for git's performance seems to be the only sensible course.
> Your idea of what is "big enough" above is somewhat outside the realm of
> git, so you have to pay the price to specify it by tweaking the
> keep-files.

But isn't git-gc supposed to be the "high-level" command that just does
the right thing?  It doesn't seem to me to be outside the scope of this
command to make a decision about trading off speed/io for optimal repo
layout.  In fact, it does do this already.  The default window, depth and
compression settings are chosen to be "good enough", not to produce the
absolute optimum repo.

I'm just pointing out that everything is a trade off.  So I think saying
something like "gc must optimize for git's performance" is not entirely
accurate.  We make tradeoffs now.  Other tradeoffs may be helpful.

Also, don't interpret my comments as me being convinced that a change to
gc should be made.  It's a trivial patch, but I'm not yet certain one
way or the other.

-brandon
