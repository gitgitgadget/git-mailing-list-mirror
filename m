From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] color: allow multiple attributes
Date: Sun, 28 Feb 2010 13:33:49 -0500
Message-ID: <20100228183349.GA24273@coredump.intra.peff.net>
References: <7vfx4mv0h9.fsf@alter.siamese.dyndns.org>
 <1267325798-8280-1-git-send-email-gitster@pobox.com>
 <20100228122019.GB24247@coredump.intra.peff.net>
 <7vhbp1cjkc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Mark Lodato <lodatom@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 19:34:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nlnxu-0004Ju-84
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 19:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab0B1Sdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 13:33:55 -0500
Received: from peff.net ([208.65.91.99]:45698 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754422Ab0B1Sdy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 13:33:54 -0500
Received: (qmail 31714 invoked by uid 107); 28 Feb 2010 18:34:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Feb 2010 13:34:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Feb 2010 13:33:49 -0500
Content-Disposition: inline
In-Reply-To: <7vhbp1cjkc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141260>

On Sun, Feb 28, 2010 at 10:16:19AM -0800, Junio C Hamano wrote:

> > Hmm. Just a thought on the bit-setting approach, but does the order of
> > attributes ever matter? We are going to lose the ordering information
> > the user specifies, obviously.
> 
> True, I don't know if it matters.  I don't know if "blue bold bold" would
> result in bolder blue than "blue bold" on some terminal emulators, either.
> 
> I'd suggest that we ignore the issue for now, and when somebody complains
> with an actual non-working case, we would assess the damage that comes
> from this reordering to decide what to do next.  Parhaps a "non-working

I'm fine with that. FWIW, I tested and blink-before-ul and
ul-before-blink look identical in an xterm. Certainly that's not the
only terminal emulator people will use, but I expect it to be
representative of the behavior of most emulators.  I can dig my VT100
out of the attic if we want a real answer. ;)

> We were already losing the order by emitting attr then fg then bg even
> though attr can come before any colors (an undocumented side effect of a
> sloppy parsing logic, but some of the existing tests insist on kepping it
> working), by the way.

True. I also tested attr-before-color, then color-before-attr for both
reverse and bold, and they look the same in an xterm. So I suspect it
doesn't matter, and I'm too lazy to do more research unless somebody
finds something that actually doesn't work.

-Peff
