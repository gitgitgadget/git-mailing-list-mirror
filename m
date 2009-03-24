From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 9/9] refs: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:17 +0100
Message-ID: <f6b2ede9af2bd40ce89f0251b32861098af46aad.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
 <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
 <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
 <5e3412be5d72bce2bf36fdcc2734b89386fdfc21.1237856682.git.vmiklos@frugalware.org>
 <607f1ab07464931305b62599805f898e2bf2ca98.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9h-0006Vh-I7
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbZCXBIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755043AbZCXBIo
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:44 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57066 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652AbZCXBI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:26 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 53F5B294074;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2B243186229; Tue, 24 Mar 2009 02:09:19 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <607f1ab07464931305b62599805f898e2bf2ca98.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114375>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 refs.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8d3c502..aeef257 100644
--- a/refs.c
+++ b/refs.c
@@ -996,7 +996,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 
 	err = unlink(git_path("logs/%s", lock->ref_name));
 	if (err && errno != ENOENT)
-		fprintf(stderr, "warning: unlink(%s) failed: %s",
+		warning("unlink(%s) failed: %s",
 			git_path("logs/%s", lock->ref_name), strerror(errno));
 	invalidate_cached_refs();
 	unlock_ref(lock);
@@ -1438,8 +1438,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
-					fprintf(stderr,
-						"warning: Log %s has gap after %s.\n",
+					warning("Log %s has gap after %s.",
 						logfile, show_date(date, tz, DATE_RFC2822));
 				}
 			}
@@ -1451,8 +1450,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 				if (get_sha1_hex(rec + 41, logged_sha1))
 					die("Log %s is corrupt.", logfile);
 				if (hashcmp(logged_sha1, sha1)) {
-					fprintf(stderr,
-						"warning: Log %s unexpectedly ended on %s.\n",
+					warning("Log %s unexpectedly ended on %s.",
 						logfile, show_date(date, tz, DATE_RFC2822));
 				}
 			}
-- 
1.6.2
