From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary
 commits
Date: Wed, 22 Feb 2012 15:55:00 -0500
Message-ID: <20120222205500.GD6781@sigill.intra.peff.net>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch>
 <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:55:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0JDU-0001iu-31
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:55:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241Ab2BVUzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:55:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47365
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520Ab2BVUzD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:55:03 -0500
Received: (qmail 31717 invoked by uid 107); 22 Feb 2012 20:55:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 22 Feb 2012 15:55:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Feb 2012 15:55:00 -0500
Content-Disposition: inline
In-Reply-To: <fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191287>

On Wed, Feb 22, 2012 at 08:34:23PM +0100, Thomas Rast wrote:

> +# If "ridiculous" is at least 1004 chars, this traps a bug in old
> +# versions where the resulting 1025-char line (with --pretty=oneline)
> +# was longer than a 1024-char buffer
> +test_expect_success 'ridiculously long subject in boundary' '
> +
> +	: > file4 &&
> +	test_tick &&
> +	git add file4 &&
> +	printf "abcdefghijkl %s\n" $(seq 1 100) | git commit -F - &&

Seq is not portable. I usually use either

  perl -le "print for (1..100)"

or just do:

  z16=zzzzzzzzzzzzzzzz
  z256=$z16$z16$z16$z16$z16$z16$z16$z16
  z1024=$z256$z256$z256$z256$z256$z256$z256$z256

-Peff
