From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 05/14] Change fetch_pack() and friends to take
 string_list arguments
Date: Mon, 17 Sep 2012 18:17:10 -0400
Message-ID: <20120917221710.GA555@sigill.intra.peff.net>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <1347171589-13327-6-git-send-email-mhagger@alum.mit.edu>
 <7vipblmwaq.fsf@alter.siamese.dyndns.org>
 <5057167A.6040403@alum.mit.edu>
 <7vd31ks3ls.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 00:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDjd8-00026m-Fc
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757334Ab2IQWRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:17:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46861 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329Ab2IQWRR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 18:17:17 -0400
Received: (qmail 13793 invoked by uid 107); 17 Sep 2012 22:17:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 17 Sep 2012 18:17:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 17 Sep 2012 18:17:10 -0400
Content-Disposition: inline
In-Reply-To: <7vd31ks3ls.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205761>

On Mon, Sep 17, 2012 at 03:10:07PM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > But how far should this policy be taken?  It seems to me that strict
> > adherence to the policy would dictate that *.h files should *never*
> > include other git project files.
> 
> I wouldn't call that a "policy".  It's something we think about when
> adding a new "#include" to see if it is worth adding and/or if it is
> the right place to add it to reduce code churn.
> 
> As I said, what policy to pick and stick to is open to discussion,
> and I wanted to leave it outside the scope of this series.  As it
> has been cooking in 'next', I do not think it is worth reverting the
> inclusion of "string-list.h" to delay this topic.  It is something
> that can and should be cleaned up when we decide to pick the
> inclusion policy and enforce it.  If we choose to go in the other
> direction, we would end up adding it back, so let's keep it as-is
> for now.

I will admit that I usually follow the opposite policy of what you have
suggested, and include dependent headers in the .h files. Mostly just
because it makes things simpler for the user of the header file, and
there aren't really downsides (yes, you can have weird dependency-order
issues, but in practice those are rare, and they generate very obvious
compile-time errors).

What I think would be much more productive is breaking apart gigantic
includes like cache.h into more reasonable modules, which would mean
less frequent recompilation when an uninteresting part of the header
changes. But git is reasonably fast to compile as it is, so I have never
quite decided that it is worth the human effort to go in that direction.

-Peff
