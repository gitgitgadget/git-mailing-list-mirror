From: Jeff King <peff@peff.net>
Subject: [PATCH 02/16] daemon: mark some strings as const
Date: Wed, 18 Jun 2014 15:41:58 -0400
Message-ID: <20140618194158.GB22622@sigill.intra.peff.net>
References: <20140618194117.GA22269@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 21:42:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLkE-0005jv-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754767AbaFRTmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:42:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:46936 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754664AbaFRTmA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:42:00 -0400
Received: (qmail 29889 invoked by uid 102); 18 Jun 2014 19:42:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 18 Jun 2014 14:42:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jun 2014 15:41:58 -0400
Content-Disposition: inline
In-Reply-To: <20140618194117.GA22269@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252034>

None of these strings is modified; marking them as const
will help later refactoring.

Signed-off-by: Jeff King <peff@peff.net>
---
 daemon.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/daemon.c b/daemon.c
index f9c63e9..18818c3 100644
--- a/daemon.c
+++ b/daemon.c
@@ -39,8 +39,8 @@ static int strict_paths;
 static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
-static char *base_path;
-static char *interpolated_path;
+static const char *base_path;
+static const char *interpolated_path;
 static int base_path_relaxed;
 
 /* Flag indicating client sent extra args. */
@@ -106,12 +106,12 @@ static void NORETURN daemon_die(const char *err, va_list params)
 	exit(1);
 }
 
-static const char *path_ok(char *directory)
+static const char *path_ok(const char *directory)
 {
 	static char rpath[PATH_MAX];
 	static char interp_path[PATH_MAX];
 	const char *path;
-	char *dir;
+	const char *dir;
 
 	dir = directory;
 
@@ -131,7 +131,7 @@ static const char *path_ok(char *directory)
 			 * "~alice/%s/foo".
 			 */
 			int namlen, restlen = strlen(dir);
-			char *slash = strchr(dir, '/');
+			const char *slash = strchr(dir, '/');
 			if (!slash)
 				slash = dir + restlen;
 			namlen = slash - dir;
@@ -253,7 +253,7 @@ static int daemon_error(const char *dir, const char *msg)
 	return -1;
 }
 
-static char *access_hook;
+static const char *access_hook;
 
 static int run_access_hook(struct daemon_service *service, const char *dir, const char *path)
 {
@@ -318,7 +318,7 @@ error_return:
 	return -1;
 }
 
-static int run_service(char *dir, struct daemon_service *service)
+static int run_service(const char *dir, struct daemon_service *service)
 {
 	const char *path;
 	int enabled = service->enabled;
-- 
2.0.0.566.gfe3e6b2
