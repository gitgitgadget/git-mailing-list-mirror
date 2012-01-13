From: Jeff King <peff@peff.net>
Subject: Re: thin packs ending up fat
Date: Thu, 12 Jan 2012 20:51:17 -0500
Message-ID: <20120113015117.GA8245@sigill.intra.peff.net>
References: <20120112221523.GA3663@sigill.intra.peff.net>
 <20120112223234.GA4949@sigill.intra.peff.net>
 <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 13 02:51:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlWIf-0005Eu-Tp
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 02:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756918Ab2AMBvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 20:51:21 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36413
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413Ab2AMBvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 20:51:20 -0500
Received: (qmail 5888 invoked by uid 107); 13 Jan 2012 01:58:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jan 2012 20:58:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jan 2012 20:51:17 -0500
Content-Disposition: inline
In-Reply-To: <7vwr8wz8u9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188491>

On Thu, Jan 12, 2012 at 05:31:42PM -0800, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> Subject: [PATCH] thin-pack: try harder to create delta against preferred base

I just sat down to write a nicer commit message, and behold, it was done
for me. Thanks.

> When creating a thin-pack to transfer recent history, it is likely that we
> will try to send an object that is recorded in full, as it is newer.  But
> the heuristics to avoid recomputing futile delta effectively forbids us
> from attempting to express such an object as a delta based on another
> object. Sending an object in full is often more expensive than sending a
> suboptimal delta based on other objects, and it is even more so if we
> could use an object we know the receiving end already has (i.e. referred
> base object) as the delta base.

s/referred/preferred/

> Tweak the recomputation avoidance logic, so that we do not punt on
> computing delta against a preferred base object.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Other than that, it looks good to me.

Signed-off-by: Jeff King <peff@peff.net>

I'll try to deploy this to GitHub in the near future. I doubt we'll see
much of a dent in our bandwidth, though, as small fetches that this
helps are probably lost in the noise of clones.

-Peff
