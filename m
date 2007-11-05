From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] receive-pack: don't mention successful updates
Date: Mon, 5 Nov 2007 00:11:41 -0500
Message-ID: <20071105051140.GB13144@sigill.intra.peff.net>
References: <20071105050517.GA6244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 06:11:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IouFi-0002Mo-Go
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 06:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbXKEFLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 00:11:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbXKEFLo
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 00:11:44 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4711 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751112AbXKEFLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 00:11:43 -0500
Received: (qmail 21097 invoked by uid 111); 5 Nov 2007 05:11:42 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 00:11:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2007 00:11:41 -0500
Content-Disposition: inline
In-Reply-To: <20071105050517.GA6244@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63485>

The proposed updates are already shown to the user by
send-pack, so there's no point. We continue to show errors,
since they are unexpected.

Signed-off-by: Jeff King <peff@peff.net>
---
 receive-pack.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/receive-pack.c b/receive-pack.c
index 38e35c0..ed44b89 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -204,8 +204,6 @@ static const char *update(struct command *cmd)
 			error("failed to delete %s", name);
 			return "failed to delete";
 		}
-		fprintf(stderr, "%s: %s -> deleted\n", name,
-			sha1_to_hex(old_sha1));
 		return NULL; /* good */
 	}
 	else {
@@ -217,8 +215,6 @@ static const char *update(struct command *cmd)
 		if (write_ref_sha1(lock, new_sha1, "push")) {
 			return "failed to write"; /* error() already called */
 		}
-		fprintf(stderr, "%s: %s -> %s\n", name,
-			sha1_to_hex(old_sha1), sha1_to_hex(new_sha1));
 		return NULL; /* good */
 	}
 }
-- 
1.5.3.5.1530.g7353
