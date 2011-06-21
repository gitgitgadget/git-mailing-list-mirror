From: Jeff King <peff@peff.net>
Subject: Re: git checkout running very slowly (>12s)
Date: Tue, 21 Jun 2011 10:34:37 -0400
Message-ID: <20110621143437.GB18700@sigill.intra.peff.net>
References: <loom.20110615T213016-856@post.gmane.org>
 <4DF9363F.6080009@op5.se>
 <loom.20110616T010709-333@post.gmane.org>
 <loom.20110620T221426-685@post.gmane.org>
 <20110621004452.GA3064@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andrew Cameron <andrew@worksmartlabs.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:34:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ22P-00059t-GX
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756768Ab1FUOek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 10:34:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44272
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756754Ab1FUOej (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 10:34:39 -0400
Received: (qmail 2980 invoked by uid 107); 21 Jun 2011 14:34:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 10:34:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 10:34:37 -0400
Content-Disposition: inline
In-Reply-To: <20110621004452.GA3064@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176157>

On Mon, Jun 20, 2011 at 08:44:52PM -0400, Jeff King wrote:

> > In other words, it appears that an efficient lstat implementation
> > was not the key factor in this problem.  The root cause remains a
> > mystery, but in my case, the solution was to upgrade Git.
> 
> If you can reliably trigger the problem by switching versions and you
> are still curious and want to spend a little more time on it, you may
> be able to bisect the fix to solve the mystery.

I was curious, and your issue was easy to replicate, so I bisected it
myself. The fix was:

  commit e53e6b4433f264250c2e586167caf61721b0185c
  Author: Brian Downing <bdowning@lavos.net>
  Date:   Thu Jun 10 21:59:07 2010 -0500

      unpack-trees: Make index lookahead less pessimal

which went into v1.7.1.1.

-Peff
