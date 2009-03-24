From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 1/9] http-push: using error() and warning() as appropriate
Date: Tue, 24 Mar 2009 02:09:09 +0100
Message-ID: <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:12:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlvBn-000760-3B
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:12:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbZCXBIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754214AbZCXBI2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:28 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57049 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbZCXBIY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:24 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 132E029406D;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 4FD3118620C; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114382>

Change three occurences of using inconsistent error/warning reporting by
using the relevant error() / warning() calls to be consitent with the
rest of the code.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 http-push.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/http-push.c b/http-push.c
index 48e5f38..e6bd01a 100644
--- a/http-push.c
+++ b/http-push.c
@@ -759,7 +759,7 @@ static void finish_request(struct transfer_request *request)
 			}
 		} else {
 			if (request->http_code == 416)
-				fprintf(stderr, "Warning: requested range invalid; we may already have all the data.\n");
+				warning("requested range invalid; we may already have all the data.");
 
 			git_inflate_end(&request->stream);
 			git_SHA1_Final(request->real_sha1, &request->c);
@@ -1616,7 +1616,7 @@ static int locking_available(void)
 			}
 			XML_ParserFree(parser);
 			if (!lock_flags)
-				error("Error: no DAV locking support on %s",
+				error("no DAV locking support on %s",
 				      remote->url);
 
 		} else {
@@ -2225,7 +2225,7 @@ int main(int argc, char **argv)
 		if (info_ref_lock)
 			remote->can_update_info_refs = 1;
 		else {
-			fprintf(stderr, "Error: cannot lock existing info/refs\n");
+			error("cannot lock existing info/refs");
 			rc = 1;
 			goto cleanup;
 		}
-- 
1.6.2
