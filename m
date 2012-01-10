From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 14:28:10 -0500
Message-ID: <20120110192810.GA16018@sigill.intra.peff.net>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
 <20120110182140.GB15273@sigill.intra.peff.net>
 <7vlipf9xbe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:28:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhMo-0001d8-1Q
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:28:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637Ab2AJT2N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:28:13 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33896
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175Ab2AJT2M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:28:12 -0500
Received: (qmail 13194 invoked by uid 107); 10 Jan 2012 19:35:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 14:35:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 14:28:10 -0500
Content-Disposition: inline
In-Reply-To: <7vlipf9xbe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188283>

On Tue, Jan 10, 2012 at 11:23:01AM -0800, Junio C Hamano wrote:

> > I'm not sure if the right solution is to change the popping loop to:
> >
> >   /* we will never run out of stack, because we always have the root */
> >   while (attr_stack->origin) {
> >           ...
> 
> Yeah, that makes sense, as that existing check "attr_stack &&" was a
> misguided defensive coding, that was _not_ defensive at all as we didn't
> do anything after we stop iterating from that loop and without checking
> dereferenced attr_stack->origin, which was a simple bogosity.
> 
> >
> > Or to be extra defensive and put:
> >
> >   if (!attr_stack)
> >           die("BUG: we ran out of attr stack!?");
> >
> > after the loop, or to somehow handle the case of an empty attr stack
> > below (which is hard to do, because it can't be triggered, so I have no
> > idea what it would mean).
> 
> And this is even more so.

I wasn't clear: the second one is "even more so" making sense, or "even
more so" misguided defensive coding?

-Peff
