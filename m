From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] corner cases with "rev-list --use-bitmap-index -n"
Date: Thu, 2 Jun 2016 19:09:25 -0400
Message-ID: <20160602230925.GA11196@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 01:09:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8bk4-0004Vt-Pa
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933090AbcFBXJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 19:09:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:48107 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932942AbcFBXJ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 19:09:28 -0400
Received: (qmail 9323 invoked by uid 102); 2 Jun 2016 23:09:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:09:28 -0400
Received: (qmail 15301 invoked by uid 107); 2 Jun 2016 23:09:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 19:09:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 19:09:25 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296255>

This series fixes two corner-cases I found when using "-n" along with
bitmaps. The results do make _some_ sense if you interpret them
correctly, but are sufficiently confusing that I think it's worth
dealing with. See the commit messages for the gory details.

The good news is that in the first case, we can produce a more sensible
answer without spending any extra work.

The bad news is that the second case cannot, and must fall back to a
regular traversal. I doubt anybody even cares about this case in
practice, though, as "--objects -n" is somewhat nonsensical already (I
didn't run across it in practice; I only noticed while I fixing the
first one, which I did see in practice).

  [1/2]: rev-list: "adjust" results of "--count --use-bitmap-index -n"
  [2/2]: rev-list: disable bitmaps when "-n" is used with listing objects

-Peff
