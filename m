From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/14] http: turn off curl signals
Date: Fri, 11 Nov 2011 15:54:42 -0500
Message-ID: <20111111205442.GC20515@sigill.intra.peff.net>
References: <20111110074330.GA27925@sigill.intra.peff.net>
 <20111110074803.GB27950@sigill.intra.peff.net>
 <alpine.DEB.2.00.1111100941380.27581@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Fri Nov 11 21:54:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROy7d-0007Y9-Uq
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 21:54:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757583Ab1KKUyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 15:54:45 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39714
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab1KKUyo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 15:54:44 -0500
Received: (qmail 6134 invoked by uid 107); 11 Nov 2011 20:54:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Nov 2011 15:54:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2011 15:54:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111100941380.27581@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185283>

On Thu, Nov 10, 2011 at 09:43:40AM +0100, Daniel Stenberg wrote:

> >I'm a little iffy on this one. If I understand correctly, depending
> >on the build and configuration, curl may not be able to timeout
> >during DNS lookups. But I'm not sure if it does, anyway, since we
> >don't set any timeouts.
> 
> Right, without a timeout set libcurl won't try to timeout name resolves.
> 
> To clarify: when libcurl is built to use the standard synchronous
> name resolver functions it can only abort them after a specified time
> by using signals (on posix systems).

OK, that matches with my understanding. I think this patch is a fine
thing to do for us, then. If we ever do start caring about timing out on
name lookups, we can rework it.

Thanks.

-Peff
