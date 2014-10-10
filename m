From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] "-x" tracing option for tests
Date: Fri, 10 Oct 2014 02:06:37 -0400
Message-ID: <20141010060636.GA15057@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 08:06:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcTLg-0005C2-Bk
	for gcvg-git-2@plane.gmane.org; Fri, 10 Oct 2014 08:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbaJJGGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2014 02:06:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:57064 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750905AbaJJGGk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2014 02:06:40 -0400
Received: (qmail 28116 invoked by uid 102); 10 Oct 2014 06:06:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 01:06:40 -0500
Received: (qmail 30613 invoked by uid 107); 10 Oct 2014 06:06:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 10 Oct 2014 02:06:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Oct 2014 02:06:37 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are pulled out of the prune-mtime series I posted
earlier[1]. The discussion veered off and there's no reason that the two
topics need to be part of the same series.

The first patch is the same cleanup as before.

The second one uses Michael's suggested "verbose" function, like:

  $ verbose test 1 = 2
  command failed: 'test' '1' '=' '2'

(you can see that I used rev-parse's --sq-quote, which is a little eager
to use quotes where they are not needed. I wonder if we should teach it
to produce prettier output when there is nothing outside of
[A-Za-z0-9=] or similar).

The third one is a cleanup of the "set -x" patch I posted earlier. I
made the implementation a little less gross, the output a little
cleaner, and wired it up to "-x". I think it's clean enough and useful
enough to add to our bag of test-debugging tricks.

  [1/3]: t5304: use test_path_is_* instead of "test -f"
  [2/3]: t5304: use helper to report failure of "test foo = bar"
  [3/3]: test-lib.sh: support -x option for shell-tracing

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/257850/focus=257859
