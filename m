From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] bundle: put strbuf_readline_fd in strbuf.c with
 adjustments
Date: Wed, 22 Feb 2012 15:51:08 -0500
Message-ID: <20120222205108.GC6781@sigill.intra.peff.net>
References: <4F451259.7010304@codethink.co.uk>
 <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:51:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0J9g-0007Ob-FI
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919Ab2BVUvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:51:11 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47358
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753309Ab2BVUvK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:51:10 -0500
Received: (qmail 31665 invoked by uid 107); 22 Feb 2012 20:51:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 15:51:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 15:51:08 -0500
Content-Disposition: inline
In-Reply-To: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191286>

On Wed, Feb 22, 2012 at 08:34:22PM +0100, Thomas Rast wrote:

> The comment even said that it should eventually go there.  While at
> it, match the calling convention and name of the function to the
> strbuf_get*line family.  So it now is strbuf_getwholeline_fd.
> [...]
>  bundle.c |   21 ++-------------------
>  strbuf.c |   16 ++++++++++++++++
>  strbuf.h |    1 +

Nit: no update to Documentation/technical/api-strbuf.txt.

You might want to also mention that this will read() one byte at a time,
and is therefore only a good idea if you really care about the position
of the fd. Otherwise, fdopen() + strbuf_getwholeline() is much more
efficient.

-Peff
