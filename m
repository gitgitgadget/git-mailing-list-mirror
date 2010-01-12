From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/18] read-cache.c: mark file-local functions static
Date: Mon, 11 Jan 2010 23:52:51 -0800
Message-ID: <1263282781-25596-9-git-send-email-gitster@pobox.com>
References: <1263282781-25596-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 08:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUbZS-0004h8-7G
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 08:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439Ab0ALHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 02:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432Ab0ALHx2
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 02:53:28 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41076 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752589Ab0ALHxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 02:53:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0AD28E894
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=tL8C
	4jakBdSjrhvRdt6QaMKX5hM=; b=BLJ6f797xCZJrI1JdETWPwQUJEuvz3Pbrwbt
	Xrji0XWlm1KAcl+D3BR6vBqHh/ynd7QmNpOr+8q5nbwTNwx6NDMbAilvbJTNMt/U
	t17hiq+P9RgmF7Sfk+0G1fcN6YmP7Dw2ZzO38bH4DdqpamD4snL5BsSzwvRFBK2t
	KM500Z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=f+/nCj
	KGFs7T6F5PlAZoiok+DKTWMsMlZg9ttppPzdiICpNRVsGmtxxRpb6Mz5mNlZJDSH
	HqmzOmHmsZWhRFsoq/5npo2YAmzd+A6fPEP6TIGLiGLHVDaGku7RIVN4SMcHdvB4
	5RXtY0TY5p9g4+5dTwnGvrXIMnxRfOLpP4YZQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AC8C28E893
	for <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:24 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2955C8E892 for
 <git@vger.kernel.org>; Tue, 12 Jan 2010 02:53:24 -0500 (EST)
X-Mailer: git-send-email 1.6.6.280.ge295b7.dirty
In-Reply-To: <1263282781-25596-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 8FBD601E-FF4F-11DE-93EE-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136694>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * has conflicts when applied to 'pu' but nothing "am -3" cannot fix.
 * remove_index_entry_at() is left exported even though it can become
   static in 'master'; it is used in 'pu'.

 cache.h      |    2 --
 read-cache.c |    6 ++++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/cache.h b/cache.h
index 30b9048..e7bb6b7 100644
--- a/cache.h
+++ b/cache.h
@@ -445,7 +445,6 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
-extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 extern int remove_index_entry_at(struct index_state *, int pos);
 extern void remove_marked_cache_entries(struct index_state *istate);
@@ -615,7 +614,6 @@ static inline void hashclr(unsigned char *hash)
 {
 	memset(hash, 0, 20);
 }
-extern int is_empty_blob_sha1(const unsigned char *sha1);
 
 #define EMPTY_TREE_SHA1_HEX \
 	"4b825dc642cb6eb9a060e54bf8d69288fbee4904"
diff --git a/read-cache.c b/read-cache.c
index 9033dd3..9f4f44c 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -15,6 +15,8 @@
 #include "revision.h"
 #include "blob.h"
 
+static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
+
 /* Index extensions.
  *
  * The first letter should be 'A'..'Z' for extensions that are not
@@ -156,7 +158,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
 	return 0;
 }
 
-int is_empty_blob_sha1(const unsigned char *sha1)
+static int is_empty_blob_sha1(const unsigned char *sha1)
 {
 	static const unsigned char empty_blob_sha1[20] = {
 		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
@@ -1141,7 +1143,7 @@ int refresh_index(struct index_state *istate, unsigned int flags, const char **p
 	return has_errors;
 }
 
-struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
+static struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
 {
 	return refresh_cache_ent(&the_index, ce, really, NULL);
 }
-- 
1.6.6.280.ge295b7.dirty
