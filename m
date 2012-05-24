From: Jeff King <peff@peff.net>
Subject: Re: t4014 broken by 43ae9f47ab: format-patch: use default email for
 generating message ids
Date: Thu, 24 May 2012 19:25:15 -0400
Message-ID: <20120524232515.GA11054@sigill.intra.peff.net>
References: <4FBE2335.2090903@jpk.com>
 <20120524171640.GB3161@sigill.intra.peff.net>
 <7vtxz5wdg8.fsf@alter.siamese.dyndns.org>
 <20120524201553.GA19990@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <haggerty@jpk.com>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 01:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXhPM-0003RG-KM
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 01:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964885Ab2EXXZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 19:25:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54567
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964861Ab2EXXZR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 19:25:17 -0400
Received: (qmail 2046 invoked by uid 107); 24 May 2012 23:25:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 19:25:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 19:25:15 -0400
Content-Disposition: inline
In-Reply-To: <20120524201553.GA19990@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198443>

On Thu, May 24, 2012 at 04:15:53PM -0400, Jeff King wrote:

> > If you mean "why environment and not an API call?", then I would have to
> > agree.  ident_committer_email() call, that returns a sanitized version,
> > would have been a natural way to write this, if it were available.
> 
> I meant the latter. There is no such call, but I can make one. Let me
> see how awkward it is.

Here it is.

  [1/7]: ident: refactor empty ident error message

This one is only tangentially related. I was going to touch the message
more in patch 3, but decided not to (details in that patch).

  [2/7]: ident: refactor NO_DATE flag in fmt_ident
  [3/7]: ident: let callers omit name with fmt_indent
  [4/7]: format-patch: use GIT_COMMITTER_EMAIL in message ids

These ones should fix Michael's failing test and restore the original
behavior.

  [5/7]: ident: rename IDENT_ERROR_ON_NO_NAME to IDENT_STRICT
  [6/7]: ident: reject bogus email addresses with IDENT_STRICT
  [7/7]: format-patch: do not use bogus email addresses in message ids

These ones prevent bogus message ids from being generated at all
(which is an improvement over the previous state).

-Peff
