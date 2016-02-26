From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/2] fix some rev-parse options in non-repos
Date: Fri, 26 Feb 2016 18:25:08 -0500
Message-ID: <20160226232507.GA9404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 27 00:25:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRl8-00047D-IN
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755035AbcBZXZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 18:25:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:50406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752176AbcBZXZL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 18:25:11 -0500
Received: (qmail 9262 invoked by uid 102); 26 Feb 2016 23:25:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:25:10 -0500
Received: (qmail 8745 invoked by uid 107); 26 Feb 2016 23:25:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Feb 2016 18:25:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Feb 2016 18:25:08 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287633>

Michael Haggerty noticed recently (off-list) that "git rev-parse
--local-env-vars" doesn't work outside of a git repository. This turns
out to be a regression in v1.8.5, due to a patch by John Keeping that
lifted some other restrictions on how the option could be used.

This fixes it by reverting John's patch, which puts the original
restrictions back in place. I won't repeat the lengthy discussion from
patch 2's commit message here, but the gist of it is that probably
nobody cares about those restrictions, it's more important to fix the
original regression, and it's probably too hard to make both work.

The only thing that gives me pause (and hence the RFC) is that it has
been over 2 years since the original regression. So it's entirely
possible somebody will consider _this_ fix a regression.

  [1/2]: t1515: add tests for rev-parse out-of-repo helpers
  [2/2]: Revert "rev-parse: remove restrictions on some options"

-Peff
