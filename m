From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] show: turn on rename progress
Date: Wed, 23 Mar 2011 14:19:15 -0400
Message-ID: <20110323181915.GC17533@sigill.intra.peff.net>
References: <20110323181756.GA17415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 19:19:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2SeR-0005Uv-Dm
	for gcvg-git-2@lo.gmane.org; Wed, 23 Mar 2011 19:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754249Ab1CWSTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2011 14:19:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39353
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab1CWSTR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2011 14:19:17 -0400
Received: (qmail 8360 invoked by uid 107); 23 Mar 2011 18:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Mar 2011 14:19:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2011 14:19:15 -0400
Content-Disposition: inline
In-Reply-To: <20110323181756.GA17415@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169866>

For large commits, it is nice to have some eye candy for the
rename detection.

This makes sense for "show", which is showing a single diff,
since the progress reporting will be shown before the pager
shows any output.

We don't want to do the same for "log", though, because the
progress would be interspersed with the various commits.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 707fd57..cf68130 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -416,6 +416,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 	rev.diff = 1;
 	rev.always_show_header = 1;
 	rev.no_walk = 1;
+	rev.diffopt.show_rename_progress = 1;
 	memset(&opt, 0, sizeof(opt));
 	opt.def = "HEAD";
 	opt.tweak = show_rev_tweak_rev;
-- 
1.7.4.39.ge4c30
