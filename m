From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/4] bump rename limit defaults (again)
Date: Sun, 20 Feb 2011 05:10:24 -0500
Message-ID: <20110220101024.GC988@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102128.GB22508@sigill.intra.peff.net>
 <AANLkTim2ETC0T8=8D5pWstZRZ95eo5V0+Pr62mNXRBH1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 11:10:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr6FL-0003nR-S6
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 11:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733Ab1BTKK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 05:10:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:44521 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab1BTKK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 05:10:26 -0500
Received: (qmail 16649 invoked by uid 111); 20 Feb 2011 10:10:26 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 20 Feb 2011 10:10:26 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Feb 2011 05:10:24 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTim2ETC0T8=8D5pWstZRZ95eo5V0+Pr62mNXRBH1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167412>

On Sat, Feb 19, 2011 at 06:54:47PM +0100, Piotr Krukowiecki wrote:

> On Sat, Feb 19, 2011 at 11:21 AM, Jeff King <peff@peff.net> wrote:
> > Let's bump the diff/merge default limits from 200/500 to
> > 400/1000. Those are 2 seconds and 10 seconds respectively on
> > my modern hardware.
> 
> Just curious - what is your modern hardware?

It's a Core i7 840QM. So it's a measly 1.8GHz, but it turboboosts up to
3.2GHz on a single-threaded process.  The multiple cores are irrelevant
for this timing, as it's very single-threaded[1].

The process used in the tens of megabytes of memory, so I think memory
size is irrelevant. It was very CPU bound in my tests.

-Peff

[1] Actually, this is one place where multi-threading the algorithm
would be very easy. It's literally an m*n double-loop, seeing which of
each "n" sources matches each "m" destination best, and the expensive
bit is comparing a source and dest. So you could parallelize score
calculation up to m*n ways, then just sort the result for each dest.
