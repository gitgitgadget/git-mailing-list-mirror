From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] test: tests for the "double > from mailmap" bug
Date: Tue, 14 Feb 2012 16:14:02 -0500
Message-ID: <20120214211402.GC23291@sigill.intra.peff.net>
References: <1329235894-20581-1-git-send-email-felipe.contreras@gmail.com>
 <20120214203431.GB13210@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 22:14:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxPhV-0008PA-KB
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 22:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761087Ab2BNVOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 16:14:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35902
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757265Ab2BNVOH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 16:14:07 -0500
Received: (qmail 11471 invoked by uid 107); 14 Feb 2012 21:21:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 14 Feb 2012 16:21:17 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2012 16:14:02 -0500
Content-Disposition: inline
In-Reply-To: <20120214203431.GB13210@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190758>

On Tue, Feb 14, 2012 at 02:34:31PM -0600, Jonathan Nieder wrote:

> Felipe Contreras wrote:
> 
> > I sent both the fix and the tests. Another fix was applied, but we are still
> > missing the tests.
> >
> > These are good before, and after the fix.
> 
> To summarize the previous discussion[1]: some people had comments, and
> you seem to have found value in exactly none of them.  OK.  CC-ing
> Peff, since he at least probably has looked over this code before.

The short answer is that both patches look OK to me.

Here's a longer digression that you may feel free to ignore.

When I investigated this problem, I looked only at the code (and I think
Junio's fix is the right one). However, having just looked at your two
patches without having previously looked at those tests, I found them
quite painless to review.

Having participated in the bug-hunt, I knew they were probably related
to testing that bug, but it was very unclear to me from the original
series why there were two patches, and not one. Or why, when we have
mailmap tests, they did not catch this bug. And that is _now_, with the
context of having just participated in the discussion; six months from
now I would have even less hope of understanding the context.

My general review process is (in this order):

  1. Figure out why a change is needed. This should be explained in the
     commit message. And no, just adding tests is not assumed to be
     needed.  Why did the old tests not cover this case? The answer can
     be a simple "nobody bothered to write them", and that's OK. But
     some description of the current state can help reviewers understand
     the rationale (e.g., "we tested with shortlog, but not mailmap, and
     certain code paths are only exposed through mailmap").

  2. Figure out what the change should be doing. This should also be in
     the commit message, though at a high level. In the case of tests,
     obviously we're adding new tests. But are we properly covering all
     of the new cases? Does the "what" match the "why" from (1)?

  3. Look at the patch. Do the changes match what the commit message
     claimed in (2)?

  4. Look at the patch for style, implementation, etc. Is the code
     quality good enough to be included?

The steps are dependent on each other, and I usually quit if I can't get
past one step. Sometimes I will look at the patch to try to figure out
(1) or (2), especially if the patch is trivial. But in my ideal world,
every patch lets me just walk through those steps.

I won't claim that these steps create error-free reviews. Based on those
steps, your patches look good to me, and it seems from Felipe's response
that there might be some inaccuracies in your description. But it at
least gives us a starting point for discussion.

-Peff
