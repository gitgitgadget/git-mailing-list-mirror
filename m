From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] docs: add a basic description of the config API
Date: Wed, 8 Feb 2012 10:48:55 -0500
Message-ID: <20120208154855.GC8773@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
 <20120206095346.GA4300@sigill.intra.peff.net>
 <7vbopb61cd.fsf@alter.siamese.dyndns.org>
 <20120207180625.GA27189@sigill.intra.peff.net>
 <7vlioe1o1g.fsf@alter.siamese.dyndns.org>
 <CACsJy8AU3ZA1=Q3vahhP6Nr=FZNKd7oRJ04mtKVs+uvNqJeVaw@mail.gmail.com>
 <7vmx8tzv3l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 08 16:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rv9lW-0006Km-Tj
	for gcvg-git-2@plane.gmane.org; Wed, 08 Feb 2012 16:49:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756902Ab2BHPs6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Feb 2012 10:48:58 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59625
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756689Ab2BHPs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Feb 2012 10:48:57 -0500
Received: (qmail 16867 invoked by uid 107); 8 Feb 2012 15:56:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 08 Feb 2012 10:56:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Feb 2012 10:48:55 -0500
Content-Disposition: inline
In-Reply-To: <7vmx8tzv3l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190241>

On Tue, Feb 07, 2012 at 10:40:14PM -0800, Junio C Hamano wrote:

> What I was getting at is that we probably should officially declare that
> returning 1 to signal success is perfectly acceptable (and it probably
> should mean the caller who called the callback function as a sub callback
> should return immediately, taking it as a signal that the key has already
> been handled), as the primary purpose of this thread to discuss Peff's
> patch is to write these rules down.
> 
> Of course, all that relies on the audit of the git_config() machinery. I
> think it is written to accept non-negative as success, and that is why I
> said "I too think this should be acceptable" in the first place.

I looked through it the other day when this came up, and I believe that
is the case. There is another related rule that should be considered,
though: should the return value from callbacks be propagated via
git_config to its caller?

It is the case already for config files that are read, but not for
config options parsed from the command line. It would not be too hard to
change, but I do not think any current callers care (as I mentioned
earlier, these days with the "void *" data pointer, sane callers will
simply pass in a pointer to a modifiable data area).

-Peff
