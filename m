From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] add: respect add.updateroot config option
Date: Wed, 13 Mar 2013 05:27:54 -0400
Message-ID: <20130313092754.GA12658@sigill.intra.peff.net>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <vpqr4jjd5wp.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Mar 13 10:28:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFhz5-0000AE-Kj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 10:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab3CMJ2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 05:28:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50733 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653Ab3CMJ2C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 05:28:02 -0400
Received: (qmail 3335 invoked by uid 107); 13 Mar 2013 09:29:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Mar 2013 05:29:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2013 05:27:54 -0400
Content-Disposition: inline
In-Reply-To: <vpqr4jjd5wp.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218046>

On Wed, Mar 13, 2013 at 10:07:34AM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For users who have read and accepted the warning, there is no way to
> > jump directly to the future behavior and silence the warning.
> 
> I think the idea makes sense. The transition period is necessary for
> people who use different versions of Git (which includes anybody
> writting and distributing scripts), but for poor mortals who only use a
> single version of Git, it's nice to be able to jump to the future
> behavior once for all as soon as possible.

I think the biggest risk is from people who think they are safe to jump,
and then find out that some script they depend on is not ready. Even if
they do not even realize they are relying on it. Part of the point of
the transition period is to get script authors to update their scripts,
and to let the new versions trickle down to the users.

> Your patch doesn't advertise the option in the warning message, which I
> think is good. You may mention it the commit message that this is a
> deliberate choice.

Yes, it was deliberate. I can add a note.

> > +add.updateroot::
> 
> Detail: option names are normally camelCased => updateRoot.

Good point, thanks.

> I think the option name needs a bit more thinking. Without reading the
> doc,
> 
> [add]
> 	updateRoot = false
> 
> would be a very tempting thing to try. Perhaps explicitly warning when
> add.updateroot is set to false would avoid possible confusion.

Yeah, that occurred to me, too, hence the note in the doc. Since it
isn't advertised elsewhere, I had hoped that anybody who discovered it
would see the note. I suppose we can warn when we see add.updateRoot set
to anything but true. That feels a bit hacky, as it's possible the user
could be overriding an earlier setting (although that is getting kind of
crazy).

> I liked David's suggestion of using future.* to mean "start using
> behavior from the future right now".

I do like that idea, as it makes the meaning of the variable more clear.

I dunno. I am not all that excited about this patch, due to all of the
caveats that we need to communicate to the user. The current warning has
annoyed me a few times, but perhaps it is still too soon, and my fingers
and brain just need retraining. I think a config option could help some
people, but maybe it will end up hurting more.  I'm inclined at this
point to table the patch for now and see how I feel in a few weeks.

I do think patch 1/2 makes sense regardless.

-Peff
