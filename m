From: mhagger@alum.mit.edu
Subject: [PATCH v2 04/51] clear_ref_array(): rename from free_ref_array()
Date: Mon, 12 Dec 2011 06:38:11 +0100
Message-ID: <1323668338-1764-5-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:39:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyc7-0000LO-77
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:39:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093Ab1LLFjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:39:40 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34549 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1LLFjg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:39:36 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aH015577;
	Mon, 12 Dec 2011 06:39:20 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186827>

From: Michael Haggerty <mhagger@alum.mit.edu>

Rename the function since it doesn't actually free the array object
that is passed to it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 9f7a5ec..7be91d1 100644
--- a/refs.c
+++ b/refs.c
@@ -149,7 +149,7 @@ static struct ref_entry *current_ref;
 
 static struct ref_array extra_refs;
 
-static void free_ref_array(struct ref_array *array)
+static void clear_ref_array(struct ref_array *array)
 {
 	int i;
 	for (i = 0; i < array->nr; i++)
@@ -162,14 +162,14 @@ static void free_ref_array(struct ref_array *array)
 static void clear_packed_ref_cache(struct ref_cache *refs)
 {
 	if (refs->did_packed)
-		free_ref_array(&refs->packed);
+		clear_ref_array(&refs->packed);
 	refs->did_packed = 0;
 }
 
 static void clear_loose_ref_cache(struct ref_cache *refs)
 {
 	if (refs->did_loose)
-		free_ref_array(&refs->loose);
+		clear_ref_array(&refs->loose);
 	refs->did_loose = 0;
 }
 
@@ -256,7 +256,7 @@ void add_extra_ref(const char *refname, const unsigned char *sha1, int flag)
 
 void clear_extra_refs(void)
 {
-	free_ref_array(&extra_refs);
+	clear_ref_array(&extra_refs);
 }
 
 static struct ref_array *get_packed_refs(const char *submodule)
-- 
1.7.8
