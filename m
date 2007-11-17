From: Jeff King <peff@peff.net>
Subject: [PATCH v3 0/3] tracking per-ref errors on push
Date: Sat, 17 Nov 2007 07:53:24 -0500
Message-ID: <20071117125323.GA23125@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 13:53:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItNBB-0003Av-Kd
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 13:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbXKQMx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 07:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbXKQMx3
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 07:53:29 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1533 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXKQMx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 07:53:28 -0500
Received: (qmail 3848 invoked by uid 111); 17 Nov 2007 12:53:26 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sat, 17 Nov 2007 07:53:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Nov 2007 07:53:24 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65272>

Here are cleaned-up versions of the previous patches I sent. The
improvements are:

  1/3 send-pack: track errors for each ref
    - there was a t5404 regression because I removed the is_null_sha1()
      check before updating a tracking ref (but the replacement fix
      doesn't come until 2/3). Even though this check is not correct,
      it's better to fix it all at once correctly in 2/3.
    - clarified the desired git-push exit code in t5404
    - I renamed the struct elements to (hopefully) be a bit more obvious
    - readability cleanups (fixed some very long lines, hoisted some
      code into its own functions)

  2/3 send-pack: check ref->status before updating tracking refs
    - moved in fix from 1/3 mentioned above
    - add test for deleting tracking branches, which was broken in next
      but fixed by this patch

  3/3 send-pack: assign remote errors to each ref
    - squashed optimization patch
    - remove bogus parsing drawback in commit message
    - add test

I'm hoping to get feedback from the cc'd people:
  - Alex: please OK the modifications to t5404
  - Pierre: this should fix the tracking ref update issues you reported
  - Daniel: a general OK, since I am mangling your code :)

-Peff
