From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] credential-cache--daemon.c: Don't leave stale socket
 on --exit
Date: Sat, 22 Oct 2011 15:17:14 -0400
Message-ID: <20111022191711.GC1785@sigill.intra.peff.net>
References: <4EA2FC63.9060602@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 22 21:17:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHh4P-0003nP-RA
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 21:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab1JVTRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 15:17:21 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39602
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752319Ab1JVTRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 15:17:21 -0400
Received: (qmail 30349 invoked by uid 107); 22 Oct 2011 19:17:29 -0000
Received: from mc64036d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.64.198)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 22 Oct 2011 15:17:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 22 Oct 2011 15:17:14 -0400
Content-Disposition: inline
In-Reply-To: <4EA2FC63.9060602@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184118>

On Sat, Oct 22, 2011 at 06:24:51PM +0100, Ramsay Jones wrote:

> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> ---
>  credential-cache--daemon.c |   23 ++++++++++++-----------
>  1 files changed, 12 insertions(+), 11 deletions(-)

Looks sane, and I'll probably squash it in. Alternatively, we could also
set a signal/exit handler to clean up our socket when we die. That would
also cover the error exit cases.

In either case, I think we need to handle stale sockets better. They
will happen eventually due to power loss or kill -9, anyway.

-Peff
