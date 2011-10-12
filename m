From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 1/7] invalidate_ref_cache(): rename function from invalidate_cached_refs()
Date: Wed, 12 Oct 2011 20:44:21 +0200
Message-ID: <1318445067-19279-2-git-send-email-mhagger@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:49:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sA-0006MY-NH
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754005Ab1JLStl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:41 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58195 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab1JLStj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:39 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mO-0008JO-Ni; Wed, 12 Oct 2011 20:43:48 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183390>

It is the cache that is being invalidated, not the references.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 9911c97..120b8e4 100644
--- a/refs.c
+++ b/refs.c
@@ -202,7 +202,7 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 	return refs;
 }
 
-static void invalidate_cached_refs(void)
+static void invalidate_ref_cache(void)
 {
 	struct cached_refs *refs = cached_refs;
 	while (refs) {
@@ -1228,7 +1228,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	ret |= repack_without_ref(refname);
 
 	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_cached_refs();
+	invalidate_ref_cache();
 	unlock_ref(lock);
 	return ret;
 }
@@ -1527,7 +1527,7 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
-	invalidate_cached_refs();
+	invalidate_ref_cache();
 	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
-- 
1.7.7.rc2
