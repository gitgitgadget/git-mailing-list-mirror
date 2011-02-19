From: Jeff King <peff@peff.net>
Subject: [PATCH 3/4] commit: stop setting rename limit
Date: Sat, 19 Feb 2011 05:21:57 -0500
Message-ID: <20110219102157.GC22508@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Feb 19 11:22:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqjwy-00048n-9G
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 11:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab1BSKWA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 05:22:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37598 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753810Ab1BSKV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 05:21:58 -0500
Received: (qmail 8665 invoked by uid 111); 19 Feb 2011 10:21:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 19 Feb 2011 10:21:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 19 Feb 2011 05:21:57 -0500
Content-Disposition: inline
In-Reply-To: <20110219101936.GB20577@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167267>

For its post-commit summary, commit was explicitly setting
the default rename limit to 100. Presumably when the code
was added, it was necessary to do so. These days, however,
it will fall back properly to the diff default, and that
default has long since changed from 100.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index d7f55e3..aa1510e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1215,7 +1215,6 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	get_commit_format(format.buf, &rev);
 	rev.always_show_header = 0;
 	rev.diffopt.detect_rename = 1;
-	rev.diffopt.rename_limit = 100;
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-- 
1.7.4.1.26.g5e991
