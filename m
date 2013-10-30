From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 07/19] compat: add endianness helpers
Date: Wed, 30 Oct 2013 04:25:16 -0400
Message-ID: <20131030082516.GN11317@sigill.intra.peff.net>
References: <20131024175915.GA23398@sigill.intra.peff.net>
 <20131024180157.GG24180@sigill.intra.peff.net>
 <87txg4sbyf.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Wed Oct 30 09:25:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbR5i-0004SF-TR
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 09:25:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab3J3IZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 04:25:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:58321 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752168Ab3J3IZT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 04:25:19 -0400
Received: (qmail 18402 invoked by uid 102); 30 Oct 2013 08:25:19 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Oct 2013 03:25:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Oct 2013 04:25:16 -0400
Content-Disposition: inline
In-Reply-To: <87txg4sbyf.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237002>

On Sat, Oct 26, 2013 at 09:55:36AM +0200, Thomas Rast wrote:

> > The POSIX standard doesn't currently define a `nothll`/`htonll`
> 
> typo: ntohll

Thanks.

> > function pair to perform network-to-host and host-to-network
> > swaps of 64-bit data. These 64-bit swaps are necessary for the on-disk
> > storage of EWAH bitmaps if they are not in native byte order.
> [...]
> > +#		include <byteswap.h>
> 
> Do we need a hack on top similar to what ntoh_l and hton_l do, for
> platforms that do not support unaligned access?

Ugh, probably. I didn't even know about those. But we do use them when
reading the ewah bitmaps, which I believe can be at random offsets. We
should be able to use the same ntoh_l solution.

-Peff
