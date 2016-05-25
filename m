From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] daemon: enable SO_KEEPALIVE for all sockets
Date: Wed, 25 May 2016 17:42:36 -0500
Message-ID: <20160525224235.GE13776@sigill.intra.peff.net>
References: <20160525031505.5720-1-e@80x24.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 26 00:42:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5hVj-0001E6-Cb
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbcEYWmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:42:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:44292 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751492AbcEYWmj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:42:39 -0400
Received: (qmail 22806 invoked by uid 102); 25 May 2016 22:42:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:42:38 -0400
Received: (qmail 14750 invoked by uid 107); 25 May 2016 22:42:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:42:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 17:42:36 -0500
Content-Disposition: inline
In-Reply-To: <20160525031505.5720-1-e@80x24.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295603>

On Wed, May 25, 2016 at 03:15:05AM +0000, Eric Wong wrote:

> While --init-timeout and --timeout options exist and I've never
> run git-daemon without them, some users may forget to set them
> and encounter hung daemon processes when connections fail.
> Enable socket-level timeouts so the kernel can send keepalive
> probes as necessary to detect failed connections.

Makes sense. I wondered if there were any portability issues here, but
it looks like the same code is found on the client side (but we'd still
want it here for cases where the client thinks the connection is dead
but the server does not realize it).

-Peff
