From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] textconv support for "log -S"
Date: Sun, 28 Oct 2012 08:45:40 -0400
Message-ID: <20121028124540.GF11434@sigill.intra.peff.net>
References: <508C29E4.5000801@arcor.de>
 <20121028120104.GE11434@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 13:45:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSSFY-0001YG-3R
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 13:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117Ab2J1Mpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 08:45:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41325 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751551Ab2J1Mpn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 08:45:43 -0400
Received: (qmail 8360 invoked by uid 107); 28 Oct 2012 12:46:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 08:46:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 08:45:40 -0400
Content-Disposition: inline
In-Reply-To: <20121028120104.GE11434@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208541>

On Sun, Oct 28, 2012 at 08:01:04AM -0400, Jeff King wrote:

> -G operates on the munged data; you can see it feed the munged data to
> xdiff in diff_grep. But the optimization for handling added and removed
> files accidentally fed the wrong pointer. Fixing that is a no-brainer,
> since the optimization is inconsistent with the regular code path.
> 
> -S, however, predates the invention of textconv and has never used it.
> It is a little less clear that textconv is the right thing here, because
> it is not about grepping the diff, but about counting occurrences of the
> string inside the file content. I tend to think that doing so on the
> textconv'd data would be what people generally want, but it is a
> behavior change.

I prepared the earlier bugfix for "-G" for maint. Modifying "-S" would
be a separate feature topic, and would look like this (I built it on top
of the bugfix patch, since the tests are a follow-on).

  [1/2]: pickaxe: hoist empty needle check
  [2/2]: pickaxe: use textconv for -S counting

-Peff
