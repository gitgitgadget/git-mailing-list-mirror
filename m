From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] tag: die when listing missing or corrupt objects
Date: Mon, 6 Feb 2012 03:38:32 -0500
Message-ID: <20120206083832.GA9425@sigill.intra.peff.net>
References: <20120206081119.GA3939@sigill.intra.peff.net>
 <20120206081342.GB3966@sigill.intra.peff.net>
 <7vk4408ir6.fsf@alter.siamese.dyndns.org>
 <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Grennan <tmgrennan@gmail.com>, git@vger.kernel.org,
	jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 06 09:38:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuK5v-0001xL-0F
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 09:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab2BFIie (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 03:38:34 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58703
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849Ab2BFIie (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 03:38:34 -0500
Received: (qmail 25534 invoked by uid 107); 6 Feb 2012 08:45:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 03:45:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 03:38:32 -0500
Content-Disposition: inline
In-Reply-To: <7vfweo8ikq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190049>

On Mon, Feb 06, 2012 at 12:36:05AM -0800, Junio C Hamano wrote:

> > For that matter, shouldn't we make sure that the type is OBJ_TAG? It might
> > make sense to allow OBJ_COMMIT (i.e. lightweight tag to a commit) as well,
> > because the definition of "first N lines" is compatible between tag and
> > commit for the purpose of the -n option.
> 
> Ahh, Ok, your 3/3 addresses this exact issue.
> 
> I do not object to silently return when the object is not OBJ_TAG (even
> though I slightly prefer showing the first N lines of commit log contents
> for OBJ_COMMIT lightweight tag), but I still think it should be warned
> just like a corruption when we see (type == OBJ_TAG && !size).

OK, that's easy enough to do. Should we show lightweight tags to commits
for backwards compatibility (and just drop the parse_signature junk in
that case)? The showing of blobs or trees is the really bad thing, I
think.

-Peff
