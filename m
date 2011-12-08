From: Jeff King <peff@peff.net>
Subject: Re: git auto-repack is broken...
Date: Wed, 7 Dec 2011 22:40:38 -0500
Message-ID: <20111208034038.GA2280@sigill.intra.peff.net>
References: <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
 <CA+sFfMdeVoz8XU5j4hNn1qCHHzaiDi0Bw=QbbuU3cwT9mMPZOA@mail.gmail.com>
 <alpine.LFD.2.02.1112071709250.2907@xanadu.home>
 <20111207225318.GA21852@sigill.intra.peff.net>
 <alpine.LFD.2.02.1112071912570.2907@xanadu.home>
 <20111208004515.GA23015@sigill.intra.peff.net>
 <alpine.LFD.2.02.1112072227510.2907@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Dec 08 04:40:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYUqi-0005wR-Ux
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 04:40:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757633Ab1LHDkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 22:40:40 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43020
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757092Ab1LHDkk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 22:40:40 -0500
Received: (qmail 23932 invoked by uid 107); 8 Dec 2011 03:47:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 07 Dec 2011 22:47:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Dec 2011 22:40:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1112072227510.2907@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186529>

On Wed, Dec 07, 2011 at 10:35:00PM -0500, Nicolas Pitre wrote:

> And I don't think this particular case is interesting anyway as the 
> reflogs for the various branches alre already involved.  I was thinking 
> more about the "git fetch git://some.random.repo foobar" case where the 
> summary also explicitly shows:
> 
> From: git://some.random.repo
>   ......  foobar   -> FETCH_HEAD
> 
> In that case the only reference to the fetched branch is stored in 
> FETCH_HEAD and that is what might be worthwile for a reflog.

I agree that is the interesting case. Perhaps we could just not bother
writing the other case into the reflog at all. So the reflog would be
sensible and contain only the set of things they had fetched or pulled
explicitly by URL. If they really want to do a multi-ref one-off fetch
from some URL, then we write multiple reflog entries. But at least the
user is very aware of what they've done, so they're not surprised by the
reflog advancing by more than 1 entry.

-Peff
