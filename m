From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Implement fast hash-collision detection
Date: Tue, 29 Nov 2011 17:05:07 -0500
Message-ID: <20111129220507.GF1793@sigill.intra.peff.net>
References: <1322546563.1719.22.camel@yos>
 <CAJo=hJtFT55Ucyij9esr3Hd9yJ6XCxatK7vjPOLMKow57HqBoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Zaumen <bill.zaumen+git@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, pclouds@gmail.com, torvalds@linux-foundation.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 23:05:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVnf-0004Xs-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 23:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab1K2WFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 17:05:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55872
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754668Ab1K2WFK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 17:05:10 -0500
Received: (qmail 3419 invoked by uid 107); 29 Nov 2011 22:11:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Nov 2011 17:11:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2011 17:05:07 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJtFT55Ucyij9esr3Hd9yJ6XCxatK7vjPOLMKow57HqBoQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186092>

On Tue, Nov 29, 2011 at 09:08:27AM -0800, Shawn O. Pearce wrote:

> As Peff pointed out elsewhere in this thread, the odds of a SHA-1
> collision in a project are low, on the order of 1/(2^80).

Minor nit: it's actually way less than that. You have to do on the order
of 2^80 operations to get a 50% chance of a collision. But that's not
the probability for a collision given a particular number of
operations[1].

The probability for a SHA-1 collision on 10 million hashes (where
linux-2.6 will be in a decade or two) is about 1/(2^115).

That doesn't change the validity of any of your points, of course. 1 in
2^80 and 1 in 2^115 are both in the range of "impossibly small enough
not to care about".

To continue our astronomy analogies, NASA estimates[2] the impact
probability of most tracked asteroids in the 10^6 range (around 2^20).
So getting a collision in linux-2.6 in the next decade has roughly the
same odds as the Earth being hit by 5 or 6 large asteroids.

-Peff

[1] http://en.wikipedia.org/wiki/Birthday_problem#Cast_as_a_collision_problem

[2] http://neo.jpl.nasa.gov/risk/
