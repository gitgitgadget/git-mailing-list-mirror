From: mhagger@alum.mit.edu
Subject: [PATCH v2 05/14] clear_ref_array(): rename from free_ref_array()
Date: Mon, 17 Oct 2011 09:39:14 +0200
Message-ID: <1318837163-27112-6-git-send-email-mhagger@alum.mit.edu>
References: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 09:40:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFhnj-0007mH-Oe
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 09:40:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850Ab1JQHjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 03:39:40 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33549 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab1JQHji (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2011 03:39:38 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RFhhW-0000eM-M8; Mon, 17 Oct 2011 09:33:34 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318837163-27112-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183777>

From: Michael Haggerty <mhagger@alum.mit.edu>

Rename the function since it doesn't actually free the array object
that is passed to it.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 87c8913..30e505a 100644
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
1.7.7.rc2
