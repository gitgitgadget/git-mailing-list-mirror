From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/5] Remove the default_headers variable from http-push.c
Date: Mon, 10 Dec 2007 22:36:07 +0100
Message-ID: <1197322571-25023-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 22:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1qIq-0003Jj-Rp
	for gcvg-git-2@gmane.org; Mon, 10 Dec 2007 22:36:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753937AbXLJVgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 16:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754199AbXLJVgS
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 16:36:18 -0500
Received: from smtp28.orange.fr ([80.12.242.101]:13091 "EHLO smtp28.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753034AbXLJVgO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 16:36:14 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2818.orange.fr (SMTP Server) with ESMTP id 817AD70000A4
	for <git@vger.kernel.org>; Mon, 10 Dec 2007 22:36:12 +0100 (CET)
Received: from namakemono.glandium.org (APuteaux-153-1-79-219.w81-249.abo.wanadoo.fr [81.249.109.219])
	by mwinf2818.orange.fr (SMTP Server) with ESMTP id 681E770000A0;
	Mon, 10 Dec 2007 22:36:12 +0100 (CET)
X-ME-UUID: 20071210213612426.681E770000A0@mwinf2818.orange.fr
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1J1qIN-0006Vu-Ts; Mon, 10 Dec 2007 22:36:11 +0100
X-Mailer: git-send-email 1.5.3.7.1159.gdd4a4-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67758>

It appears that despite being initialized, it was never used.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 http-push.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/http-push.c b/http-push.c
index a69d0e3..2ef764c 100644
--- a/http-push.c
+++ b/http-push.c
@@ -75,7 +75,6 @@ static int aborted;
 static signed char remote_dir_exists[256];
 
 static struct curl_slist *no_pragma_header;
-static struct curl_slist *default_headers;
 
 static int push_verbosely;
 static int push_all = MATCH_REFS_NONE;
@@ -2286,11 +2285,6 @@ int main(int argc, char **argv)
 	http_init();
 
 	no_pragma_header = curl_slist_append(no_pragma_header, "Pragma:");
-	default_headers = curl_slist_append(default_headers, "Range:");
-	default_headers = curl_slist_append(default_headers, "Destination:");
-	default_headers = curl_slist_append(default_headers, "If:");
-	default_headers = curl_slist_append(default_headers,
-					    "Pragma: no-cache");
 
 	/* Verify DAV compliance/lock support */
 	if (!locking_available()) {
@@ -2470,7 +2464,6 @@ int main(int argc, char **argv)
 	free(remote);
 
 	curl_slist_free_all(no_pragma_header);
-	curl_slist_free_all(default_headers);
 
 	http_cleanup();
 
-- 
1.5.3.7.1159.gdd4a4
