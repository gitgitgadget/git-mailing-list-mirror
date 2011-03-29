From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: introduce --notes-ref= to use one notes ref
 only
Date: Tue, 29 Mar 2011 16:53:08 -0400
Message-ID: <20110329205307.GA30959@sigill.intra.peff.net>
References: <e83f8b622fba5add563fc331ae3922b79a0af008.1301392999.git.git@drmicha.warpmail.net>
 <201103291439.17197.johan@herland.net>
 <20110329143357.GA10771@sigill.intra.peff.net>
 <7vwrjhrd53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:53:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4fuf-0001Ze-11
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 22:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185Ab1C2UxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 16:53:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57763
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003Ab1C2UxK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 16:53:10 -0400
Received: (qmail 32642 invoked by uid 107); 29 Mar 2011 20:53:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 16:53:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 16:53:08 -0400
Content-Disposition: inline
In-Reply-To: <7vwrjhrd53.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170320>

On Tue, Mar 29, 2011 at 11:32:24AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Speaking of which, it is kind of weird that --show-notes is negated by
> > --no-notes. So maybe it makes sense to introduce "--notes[=<ref>]" to do
> > what I wrote above, and deprecate --show-notes.
> 
> I think that is sensible.
> 
> I personally think that "notes" are way too premature to be used seriously
> by normal people yet, and if we want to fix UI and semantics warts (it is
> understandable if we had plenty of them, simply because we didn't know
> enough about possible use cases during the period we prototyped the notes
> feature), the time to do so is now.

It is tempting to kill off --show-notes and --standard-notes, as it
would clean up this code a bit. But even though they are probably not
being seriously used by normal people, they have been in several
released versions.

Here's the series I ended up with. Getting the refactoring just right
turned out to be non-trivial, but between several attempts and some
tests, I think the end result is correct. Hopefully the breakdown of the
changes into small patches helps make it easy to review.

  [1/6]: notes: make expand_notes_ref globally accessible
  [2/6]: revision.c: refactor notes ref expansion
  [3/6]: notes: refactor display notes extra refs field
  [4/6]: notes: refactor display notes default handling
  [5/6]: revision.c: support --notes command-line option
  [6/6]: revision.c: make --no-notes reset --notes list

-Peff
