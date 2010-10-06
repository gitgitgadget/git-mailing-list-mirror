From: Jeff King <peff@peff.net>
Subject: Re: 1e633418479926bc85ed21a4f91c845a3dd3ad66 breaks on OSX
Date: Tue, 5 Oct 2010 21:45:18 -0400
Message-ID: <20101006014518.GA8557@sigill.intra.peff.net>
References: <86r5g42wo8.fsf@red.stonehenge.com>
 <AANLkTinq7haFRs6h8W+ycDy5MzFgjty6LaD8syL+KnHX@mail.gmail.com>
 <86iq1g2vhq.fsf@red.stonehenge.com>
 <20101005213401.GA22845@sigill.intra.peff.net>
 <AANLkTimwRJ+X4Kom9_Nv-5Xjf1LKCPbkwavWYHqCdTaM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 03:45:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3J4a-0003mG-KU
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 03:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757725Ab0JFBpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 21:45:19 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:33221 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab0JFBpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 21:45:14 -0400
Received: (qmail 5168 invoked by uid 111); 6 Oct 2010 01:45:13 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 06 Oct 2010 01:45:13 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Oct 2010 21:45:18 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimwRJ+X4Kom9_Nv-5Xjf1LKCPbkwavWYHqCdTaM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158262>

On Wed, Oct 06, 2010 at 12:33:20AM +0200, Sverre Rabbelier wrote:

> On Tue, Oct 5, 2010 at 23:34, Jeff King <peff@peff.net> wrote:
> > +ifndef NO_PERL
> > +all:: perl/perl.mak
> > +endif
> > +
> 
> Regardless of whether that fixes the problem that looks like a sane
> patch, so maybe we just should apply it?

I'm not opposed, though the situation is confusing enough I'd like to
have somebody confirm that my previous analysis makes sense (otherwise,
this is just adding cruft to the Makefile :) ).

Sadly, I can't seem to replicate the original problem, even doing
something like:

  n=1
  while true; do
    make clean;
    if ! make -j4; then break; fi
    echo $n; n=$(($n+1))
  done

(and I tried several variations). It ran for 20 minutes without failing.
My suspicion is that there may be some particular state that triggers
the race condition, but I can't seem to figure it out.

-Peff
