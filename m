From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] receive-pack, fetch-pack: reject bogus pack that records
 objects twice
Date: Fri, 18 Nov 2011 05:33:55 -0500
Message-ID: <20111118103355.GA4854@sigill.intra.peff.net>
References: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 11:34:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRLll-0001x6-D6
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 11:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753004Ab1KRKeA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 05:34:00 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47267
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752536Ab1KRKd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 05:33:59 -0500
Received: (qmail 31050 invoked by uid 107); 18 Nov 2011 10:34:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Nov 2011 05:34:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Nov 2011 05:33:55 -0500
Content-Disposition: inline
In-Reply-To: <7v7h2znv36.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185647>

On Wed, Nov 16, 2011 at 10:04:13PM -0800, Junio C Hamano wrote:

> When receive-pack & fetch-pack are run and store the pack obtained over
> the wire to a local repository, they internally run the index-pack command
> with the --strict option. Make sure that we reject incoming packfile that
> records objects twice to avoid spreading such a damage.

If we are fixing a thin pack (which should be the case most of the
time), we are rewriting the packfile anyway. Shouldn't we just omit
the duplicate?

I guess I'm a little confused about what is generating these duplicates.
A buggy git? A malicious server? Bad luck?

-Peff
