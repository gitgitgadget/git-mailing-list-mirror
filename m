From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3 3/7] show: honor --textconv for blobs
Date: Sat, 11 May 2013 02:25:05 +0200
Message-ID: <20130511002504.GA4849@sigill.intra.peff.net>
References: <7vy5c1l6nb.fsf@alter.siamese.dyndns.org>
 <c4ed1e0b67877e6453b8c269290e09e1672ce37d.1368197380.git.git@drmicha.warpmail.net>
 <7vy5bm22f8.fsf@alter.siamese.dyndns.org>
 <20130510173434.GA3154@sigill.intra.peff.net>
 <7vfvxu1zla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 11 02:25:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uaxcz-0004vD-GM
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 02:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab3EKAZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 20:25:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:52484 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753356Ab3EKAZK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 20:25:10 -0400
Received: (qmail 26317 invoked by uid 102); 11 May 2013 00:25:33 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (213.221.117.228)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 May 2013 19:25:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2013 02:25:05 +0200
Content-Disposition: inline
In-Reply-To: <7vfvxu1zla.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223923>

On Fri, May 10, 2013 at 11:04:01AM -0700, Junio C Hamano wrote:

> One thing to notice is that those accessing rev->pending before
> calling prepare_revision_walk(), as opposed to those receiving
> objects in rev->commits via get_revision(), are the only ones that
> care about the context and wants to act differently depending on
> where these came from and how they were specified.
> 
> That suggests at least two possibilities to me:
> 
>  - Perhaps we can place the context in rev->pending and clear them
>    when prepare_revision_walk() moves them to rev->commits, without
>    introducing rev->keep_object_context?
> 
>  - Perhaps instead of extending object-array, we can move this kind
>    of information to rev_cmdline and enrich that structure?

Without looking too closely to see whether it is feasible, I would think
the latter would end up being much more elegant, since I think it
already deals with some allocation issues already.

-Peff
