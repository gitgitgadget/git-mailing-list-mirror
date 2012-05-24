From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: default to quiet if !isatty(2).
Date: Thu, 24 May 2012 02:10:00 -0400
Message-ID: <20120524061000.GA14035@sigill.intra.peff.net>
References: <20120524054506.GA3440@sigill.intra.peff.net>
 <1337839534-7760-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 08:10:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXRFT-0006Z4-4e
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 08:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab2EXGKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 02:10:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53429
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab2EXGKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 02:10:02 -0400
Received: (qmail 24756 invoked by uid 107); 24 May 2012 06:10:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 02:10:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 02:10:00 -0400
Content-Disposition: inline
In-Reply-To: <1337839534-7760-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198358>

On Thu, May 24, 2012 at 02:05:34AM -0400, Avery Pennarun wrote:

> It would probably be better to have progress.c check isatty(2) all the time,
> but that wouldn't allow things like 'git push --progress' to force progress
> reporting to on, so I won't try to solve the general case right now.

This looks better. There is a slight inaccuracy in your subject line,
though. We are not defaulting to quiet if !isatty(2) in all cases, but
rather only when we call into unpack_trees, which generates the progress
output. We will still print the ahead/behind line, detached HEAD info,
etc.

Which I think is the right behavior, but is not quite what is advertised
by your commit message.

-Peff
