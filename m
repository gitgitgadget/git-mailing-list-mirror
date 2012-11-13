From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] send-email: add proper default sender
Date: Mon, 12 Nov 2012 22:40:10 -0500
Message-ID: <20121113034010.GA8879@sigill.intra.peff.net>
References: <1352653610-2090-1-git-send-email-felipe.contreras@gmail.com>
 <20121112233546.GG10531@sigill.intra.peff.net>
 <CAMP44s0emar-C27SX-FDsUVB6Sevuy4fBFHuO2OD6xELCEjmGg@mail.gmail.com>
 <20121113000217.GH10531@sigill.intra.peff.net>
 <CAMP44s16y9WSmnTdb04EMSzXVgzfYP7pSMo6qZi0HY0bjouA0w@mail.gmail.com>
 <20121113032727.GA8387@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 04:40:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY7MV-0000g9-MS
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 04:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab2KMDkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 22:40:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45444 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab2KMDkP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 22:40:15 -0500
Received: (qmail 18299 invoked by uid 107); 13 Nov 2012 03:41:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 12 Nov 2012 22:41:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2012 22:40:10 -0500
Content-Disposition: inline
In-Reply-To: <20121113032727.GA8387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209563>

On Mon, Nov 12, 2012 at 10:27:27PM -0500, Jeff King wrote:

> On Tue, Nov 13, 2012 at 01:54:59AM +0100, Felipe Contreras wrote:
> 
> > > But we use the environment to default the field, so the distinction
> > > doesn't make much sense to me.  Plus, it has always been the case that
> > > you can use git without setting user.*, but instead only using the
> > > environment. I don't see any reason not to follow that principle here,
> > > too.
> > 
> > And that's why a lot of commits end up like michael
> > <michael@michael-laptop.(none)>.
> 
> No, it's not. Those broken names do not come from the environment, but
> from our last-resort guess of the hostname. We long ago switched to
> printing the name as a warning when we have made such a guess (bb1ae3f),
> then more recently started rejecting them outright (8c5b1ae).
> 
> And I have proposed exactly the same behavior here: respect the
> environment and the config, but do not trust the implicit guesses.

Re-reading this, I think "them" at the end of the second paragraph is
slightly unclear. Let me rephrase.

The lack of a name or the presence of an obviously bogus email address
(e.g., with "(none)") is disallowed by commit. We still allow implicit
idents on commit as long they are not obviously wrong, but show them to
the user so that they can notice and correct via "commit --amend".

So if it dies on an implicit ident, send-email would actually be taking
an even stronger stance against bogus idents. Which makes sense, since
there is no "--amend" for fixing a broken email that has been sent.

-Peff
