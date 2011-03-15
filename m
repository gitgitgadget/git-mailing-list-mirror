From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] tests: scrub environment of GIT_* variables
Date: Tue, 15 Mar 2011 16:01:03 -0400
Message-ID: <20110315200103.GA3953@sigill.intra.peff.net>
References: <20110315064909.GA25738@elie>
 <20110315070445.GC29530@elie>
 <20110315073718.GB11754@sigill.intra.peff.net>
 <20110315100846.GB3923@elie>
 <20110315101045.GD3923@elie>
 <7v4o74b8r5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent Marti <tanoku@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Petr Onderka <gsvick@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 21:01:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzaQg-0008AO-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 21:01:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738Ab1COUBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 16:01:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47183
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757474Ab1COUBG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 16:01:06 -0400
Received: (qmail 25585 invoked by uid 107); 15 Mar 2011 20:01:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 Mar 2011 16:01:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Mar 2011 16:01:03 -0400
Content-Disposition: inline
In-Reply-To: <7v4o74b8r5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169090>

On Tue, Mar 15, 2011 at 10:20:46AM -0700, Junio C Hamano wrote:

> I am perfectly fine with the use of perl but do we know the "perl" binary
> found on $PATH (as opposed to $PERL_PATH) is good to use for this purpose?
> The features used in the scriptlet seem so bread-and-butter that I don't
> think it would make too much of a difference, but we may want to be
> consistent.

We already make the assumption elsewhere in the tests that perl in $PATH
is some minimal sane version (which probably means some version of perl5
in practice). This little script looks like it should run under any
perl5 to me.

> I personally think USE_LOOKUP outlived its usefulness. It was meant to be
> an easy way to experiment if the sha1_entry_pos() lookup gives better
> performance while looking up a pack entry, to choose one implementation
> and discard the other, but I don't think anybody actually did meaningful
> benchmarks to decide which one to keep.
> 
> Perhaps we should discard the codepath USE_LOOKUP turns on, which I
> suspect hasn't been exercised since v1.5.6 days by anybody. An obvious
> alternative is for somebody to try using USE_LOOKUP and see if it really
> gives a better performance with large packs (and if so, always use it and
> discard the other codepath).

Vicent asked me about it the other day with respect to doing something
similar in libgit2. I tried a few basic things and never ended up
getting any substantially different timing (or even page faults) between
the two strategies. Vicent, did you do any timings where it made a
difference?

-Peff
