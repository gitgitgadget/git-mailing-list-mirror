From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] interpret-trailers: don't duplicate option strings
Date: Mon, 13 Jun 2016 01:39:20 -0400
Message-ID: <20160613053920.GB23880@sigill.intra.peff.net>
References: <20160613053203.GB3950@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 07:39:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCKat-0004Kp-L2
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 07:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933312AbcFMFjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 01:39:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:53624 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932127AbcFMFjX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 01:39:23 -0400
Received: (qmail 26402 invoked by uid 102); 13 Jun 2016 05:39:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:39:22 -0400
Received: (qmail 10365 invoked by uid 107); 13 Jun 2016 05:39:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Jun 2016 01:39:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jun 2016 01:39:20 -0400
Content-Disposition: inline
In-Reply-To: <20160613053203.GB3950@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297156>

There's no need to do so; the argv strings will last until
the end of the program.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/interpret-trailers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index b99ae4b..175f147 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -20,7 +20,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 {
 	int in_place = 0;
 	int trim_empty = 0;
-	struct string_list trailers = STRING_LIST_INIT_DUP;
+	struct string_list trailers = STRING_LIST_INIT_NODUP;
 
 	struct option options[] = {
 		OPT_BOOL(0, "in-place", &in_place, N_("edit files in place")),
-- 
2.9.0.rc2.149.gd580ccd
