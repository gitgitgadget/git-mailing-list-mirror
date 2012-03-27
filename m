From: Jeff King <peff@peff.net>
Subject: Re: git://github.com/some/thing.git/?
Date: Tue, 27 Mar 2012 12:33:39 -0400
Message-ID: <20120327163339.GA5941@sigill.intra.peff.net>
References: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:33:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCZLB-0005yN-8Y
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 18:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab2C0Qdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 12:33:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34301
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333Ab2C0Qdl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 12:33:41 -0400
Received: (qmail 3866 invoked by uid 107); 27 Mar 2012 16:33:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Mar 2012 12:33:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Mar 2012 12:33:39 -0400
Content-Disposition: inline
In-Reply-To: <7vpqbyjbbx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194056>

On Tue, Mar 27, 2012 at 08:46:42AM -0700, Junio C Hamano wrote:

> I just noticed that
> 
> 	git ls-remote git://repo.or.cz/alt-git.git/
> 
> works, but neither of the following does:
> 
> 	git ls-remote git://git://github.com/gitster/git.git/
> 	git ls-remote git://git://github.com/gitster/git/
> 
> It is just a minor irritation but it would be really nice if you can fix
> it (please don't spend too much time on it if it is too involved, though).

Of course they don't work, they are malformed. :)

It took me a minute to figure it out, but I assume the interesting part
is the trailing slash?

Interestingly, this does work for http URLs, because we do some
normalization on the client side (and then append things like
"info/refs"). I wonder if we should do similar normalization for other
protocols.

Even with that, though, I think it would be good for the server to be
liberal in what it accepts.

-Peff
