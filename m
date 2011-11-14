From: Jeff King <peff@peff.net>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Mon, 14 Nov 2011 08:04:07 -0500
Message-ID: <20111114130407.GA24156@sigill.intra.peff.net>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
 <20111113182757.GA15194@elie.hsd1.il.comcast.net>
 <20111114113235.GE10847@sigill.intra.peff.net>
 <20111114124851.GB21854@victor>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: Jonathan Nieder <jrnieder@gmail.com>,
	vinassa vinassa <vinassa.vinassa@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 14:04:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPwCt-0000dw-3B
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 14:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753936Ab1KNNEK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 08:04:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41100
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751417Ab1KNNEJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 08:04:09 -0500
Received: (qmail 29264 invoked by uid 107); 14 Nov 2011 13:04:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 08:04:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 08:04:07 -0500
Content-Disposition: inline
In-Reply-To: <20111114124851.GB21854@victor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185383>

On Mon, Nov 14, 2011 at 01:48:51PM +0100, Victor Engmark wrote:

> > Fortunately we have such a thing:
> > 
> >   http://article.gmane.org/gmane.comp.version-control.git/184243
> > 
> > That one actually has 40 bits of hash entropy, so you'd expect to
> > generate 2^20 (about a million) commits before accidentally colliding.
> > If you want an easier experiment, you could truncate it even further.
> 
> Would it be helpful to truncate this to something ludicrous like a
> single byte of entropy, to be able to write tests for the various tools
> and options?

That's probably too small. Obviously any implementation like this is not
going to be usable for interacting with existing repositories, but if
you have too many collisions, then you won't even be able to create a
few new commits for your test.

Something like 20 bits means you can brute-force a collision for a
particular blob, commit, tree, or whatever in a few seconds, but you
won't be having accidental ones all the time.

-Peff
