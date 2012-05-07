From: Jeff King <peff@peff.net>
Subject: Re: post-fetch, tweak-fetch hook
Date: Mon, 7 May 2012 09:38:10 -0400
Message-ID: <20120507133810.GA4860@sigill.intra.peff.net>
References: <CAKLmikNaqVRb=pGUhbvVQTX2tYWT0HSS2R6Ezmico3X0rMgvYQ@mail.gmail.com>
 <201205062310.q46NAHnM022630@no.baka.org>
 <20120507072934.GC19874@sigill.intra.peff.net>
 <CAKLmikNuUB01xKSm9Skd2chXWw3BcWDHT23hqWtNBJPJfYqDKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Mitar <mmitar@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 15:38:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRO8r-00036u-7J
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 15:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756292Ab2EGNiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 09:38:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:32890
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756068Ab2EGNiP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 09:38:15 -0400
Received: (qmail 20985 invoked by uid 107); 7 May 2012 13:38:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 May 2012 09:38:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 May 2012 09:38:10 -0400
Content-Disposition: inline
In-Reply-To: <CAKLmikNuUB01xKSm9Skd2chXWw3BcWDHT23hqWtNBJPJfYqDKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197270>

On Mon, May 07, 2012 at 11:11:30AM +0200, Mitar wrote:

> On Mon, May 7, 2012 at 9:29 AM, Jeff King <peff@peff.net> wrote:
> > I would say the "most git" thing would be to implement "fetch
> > --porcelain", and use its output.
> 
> Yes, that would be also useful. It still makes two different
> interfaces for probably same post-processing (after push and after
> fetch), but still better than nothing, what is current state.

There is nothing to say that the output from "git fetch" could not look
exactly like the post-receive hook's input (in fact, that seems like a
very simple and sensible format). Then you could reuse the code easily.

They would still differ in that one is a hook and one is not, of course.
But at the same time, not being a hook leaves the caller of "git fetch"
with much more flexibility about deciding when to call the hook and when
not (whereas push does not have that luxury, because the code is running
on the remote side).

-Peff
