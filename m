Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D3341FEAA
	for <e@80x24.org>; Sat, 18 Jun 2016 04:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbcFREPs (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 00:15:48 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:58383 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751261AbcFREPq (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2016 00:15:46 -0400
X-AuditID: 12074412-51bff700000009f7-45-5764cae35afc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id D6.D6.02551.3EAC4675; Sat, 18 Jun 2016 00:15:31 -0400 (EDT)
Received: from michael.fritz.box (p4FEEA991.dip0.t-ipconnect.de [79.238.169.145])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u5I4FLJe029401
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Sat, 18 Jun 2016 00:15:29 -0400
From:	Michael Haggerty <mhagger@alum.mit.edu>
To:	Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
Cc:	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 03/13] refs: use name "prefix" consistently
Date:	Sat, 18 Jun 2016 06:15:09 +0200
Message-Id: <40561d596218a6c0d103dd1c514b9f95582ab615.1466222921.git.mhagger@alum.mit.edu>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1466222921.git.mhagger@alum.mit.edu>
References: <cover.1466222921.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsUixO6iqPv4VEq4wf4GeYv5m04wWnRd6Way
	aOi9wmxxe8V8ZovuKW8ZLX609DBbzLxqbXHmTSOjA4fH3/cfmDx2zrrL7vGsdw+jx8VLyh77
	l25j81j8wMtjwfP77B6fN8kFcERx2yQllpQFZ6bn6dslcGccWJVeMFOt4taqx0wNjD3yXYyc
	HBICJhI7315i6WLk4hAS2MoosW7ffVYI5ySTxOv5k5hAqtgEdCUW9TSD2SICERINr1oYQYqY
	BeYwSdx+2MkMkhAWsJOY//YaG4jNIqAq0fBsH1gDr0CUxLvDp5kh1slJXJ7+AKyGU8BCYsEW
	kBoOoG3mEnsXG05g5FnAyLCKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdMLzezRC81pXQTIyTk
	hHYwrj8pd4hRgINRiYc3wD4lXIg1say4MvcQoyQHk5Io75VKoBBfUn5KZUZicUZ8UWlOavEh
	RgkOZiUR3i0ngHK8KYmVValF+TApaQ4WJXHen4vV/YQE0hNLUrNTUwtSi2CyMhwcShK8S08C
	NQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDIiC+GBgDICkeoL1PQNp5iwsSc4Gi
	EK2nGBWlxHmfgSQEQBIZpXlwY2GJ5BWjONCXwrzKwLQixANMQnDdr4AGMwEN1pyXDDK4JBEh
	JdXAaL1IKsdYSPNE1eHobL3MrCLPmZ8uuC39/vl77MLEK1rzhXeq68+/dP5j4ey2BJnOZYvS
	/r85cHU+l/k3hozHEmzua6r5Pp4M8TNd9NPqg61ry2Xt6Fk+8x7rPN1qXy/JyJomt/Fs/Y1V
	HLKFDC7Tuw3XePaL2x9izraflXNvneTEyF9f4n+uVmIpzkg01GIuKk4EAFhdBIb/AgAA
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

In the context of the for_each_ref() functions, call the prefix that
references must start with "prefix". (In some places it was called
"base".) This is clearer, and also prevents confusion with another
planned use of the word "base".

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 24 ++++++++++++------------
 refs/refs-internal.h | 14 +++++++-------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8fa897b..d5c4789 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -542,7 +542,7 @@ static struct ref_entry *current_ref;
 typedef int each_ref_entry_fn(struct ref_entry *entry, void *cb_data);
 
 struct ref_entry_cb {
-	const char *base;
+	const char *prefix;
 	int trim;
 	int flags;
 	each_ref_fn *fn;
@@ -559,7 +559,7 @@ static int do_one_ref(struct ref_entry *entry, void *cb_data)
 	struct ref_entry *old_current_ref;
 	int retval;
 
-	if (!starts_with(entry->name, data->base))
+	if (!starts_with(entry->name, data->prefix))
 		return 0;
 
 	if (!(data->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
@@ -1824,12 +1824,12 @@ int peel_ref(const char *refname, unsigned char *sha1)
 
 /*
  * Call fn for each reference in the specified ref_cache, omitting
- * references not in the containing_dir of base.  fn is called for all
- * references, including broken ones.  If fn ever returns a non-zero
+ * references not in the containing_dir of prefix. Call fn for all
+ * references, including broken ones. If fn ever returns a non-zero
  * value, stop the iteration and return that value; otherwise, return
  * 0.
  */
-static int do_for_each_entry(struct ref_cache *refs, const char *base,
+static int do_for_each_entry(struct ref_cache *refs, const char *prefix,
 			     each_ref_entry_fn fn, void *cb_data)
 {
 	struct packed_ref_cache *packed_ref_cache;
@@ -1846,8 +1846,8 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	 * disk.
 	 */
 	loose_dir = get_loose_refs(refs);
-	if (base && *base) {
-		loose_dir = find_containing_dir(loose_dir, base, 0);
+	if (prefix && *prefix) {
+		loose_dir = find_containing_dir(loose_dir, prefix, 0);
 	}
 	if (loose_dir)
 		prime_ref_dir(loose_dir);
@@ -1855,8 +1855,8 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	packed_ref_cache = get_packed_ref_cache(refs);
 	acquire_packed_ref_cache(packed_ref_cache);
 	packed_dir = get_packed_ref_dir(packed_ref_cache);
-	if (base && *base) {
-		packed_dir = find_containing_dir(packed_dir, base, 0);
+	if (prefix && *prefix) {
+		packed_dir = find_containing_dir(packed_dir, prefix, 0);
 	}
 
 	if (packed_dir && loose_dir) {
@@ -1878,14 +1878,14 @@ static int do_for_each_entry(struct ref_cache *refs, const char *base,
 	return retval;
 }
 
-int do_for_each_ref(const char *submodule, const char *base,
+int do_for_each_ref(const char *submodule, const char *prefix,
 		    each_ref_fn fn, int trim, int flags, void *cb_data)
 {
 	struct ref_entry_cb data;
 	struct ref_cache *refs;
 
 	refs = get_ref_cache(submodule);
-	data.base = base;
+	data.prefix = prefix;
 	data.trim = trim;
 	data.flags = flags;
 	data.fn = fn;
@@ -1896,7 +1896,7 @@ int do_for_each_ref(const char *submodule, const char *base,
 	if (ref_paranoia)
 		data.flags |= DO_FOR_EACH_INCLUDE_BROKEN;
 
-	return do_for_each_entry(refs, base, do_one_ref, &data);
+	return do_for_each_entry(refs, prefix, do_one_ref, &data);
 }
 
 /*
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index b4dd545..8ad02d8 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -250,16 +250,16 @@ int rename_ref_available(const char *oldname, const char *newname);
 
 /*
  * Call fn for each reference in the specified submodule for which the
- * refname begins with base. If trim is non-zero, then trim that many
- * characters off the beginning of each refname before passing the
- * refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to include
- * broken references in the iteration. If fn ever returns a non-zero
- * value, stop the iteration and return that value; otherwise, return
- * 0.
+ * refname begins with prefix. If trim is non-zero, then trim that
+ * many characters off the beginning of each refname before passing
+ * the refname to fn. flags can be DO_FOR_EACH_INCLUDE_BROKEN to
+ * include broken references in the iteration. If fn ever returns a
+ * non-zero value, stop the iteration and return that value;
+ * otherwise, return 0.
  *
  * This is the common backend for the for_each_*ref* functions.
  */
-int do_for_each_ref(const char *submodule, const char *base,
+int do_for_each_ref(const char *submodule, const char *prefix,
 		    each_ref_fn fn, int trim, int flags, void *cb_data);
 
 /*
-- 
2.8.1

