From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Aug 2011, #07; Wed, 24)
Date: Tue, 30 Aug 2011 22:20:17 -0400
Message-ID: <20110831022017.GA3340@sigill.intra.peff.net>
References: <7vk4a2mjx6.fsf@alter.siamese.dyndns.org>
 <20110825202057.GB6165@sigill.intra.peff.net>
 <7vhb55i11i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 04:20:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyaPm-00079f-Tc
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 04:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754829Ab1HaCUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 22:20:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60085
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754801Ab1HaCUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 22:20:19 -0400
Received: (qmail 32187 invoked by uid 107); 31 Aug 2011 02:21:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 22:21:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 22:20:17 -0400
Content-Disposition: inline
In-Reply-To: <7vhb55i11i.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180454>

On Thu, Aug 25, 2011 at 03:22:49PM -0700, Junio C Hamano wrote:

> > On Wed, Aug 24, 2011 at 05:09:09PM -0700, Junio C Hamano wrote:
> >
> >> * jk/add-i-hunk-filter (2011-07-27) 5 commits
> >>   (merged to 'next' on 2011-08-11 at 8ff9a56)
> >>  + add--interactive: add option to autosplit hunks
> >>  + add--interactive: allow negatation of hunk filters
> >>  + add--interactive: allow hunk filtering on command line
> >>  + add--interactive: factor out regex error handling
> >>  + add--interactive: refactor patch mode argument processing
> >> 
> >> Needs documentation updates.
> >
> > I think Duy already mentioned this, but you may want to update your
> > "what's cooking" note: it needs not just doc updates, but code to
> > actually pass the options along from real git commands that use
> > add--interactive, like add, checkout, reset, and stash.
> 
> Thanks. Also tests are lacking, too. Although I do not necessarily see the
> lack of integration with anything but "add" a show-stopper (I consider
> "-p" to chekout, reset and stash are "nice to have"), [...]

It is less ready than that. You cannot even use it from "git add" at
this point. It is _only_ the perl bits, as I was just providing them to
Duy, so he could write the C bits. So the patches as they are are
useless.  Hence no tests, since you can't even trigger the code without
artifically calling add--interactive directly with the new options.

So it probably makes sense to just drop them (or just leave them in pu)
for the next cycle until the other half materializes.

> you are correct that "add -i" and then choosing '[p]atch' gets very
> confused with

Hmm, that is a regression probably caused by my refactoring. Thanks for
pointing it out. I'll take a look.

> >> The initial "tag --contains" de-pessimization without need for generation
> >> numbers is already in; backburnered.
> >
> > So...what next? I don't really like leaving the contains traversal
> > as-is.
> 
> Hmm, honestly speaking, I do not see much problem with it. My knee-jerk
> reaction is to go with 1.a and if we really want to do something 1.b
> perhaps but I suspect "these are bogus" cache wouldn't be so useful by
> itself and we may need a bit more information.

OK. I'll clean up and submit a patch for that, but I'll wait for
post-1.7.7.

-Peff
