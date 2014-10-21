From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 11/15] refs.c: make the *_packed_refs functions static
Date: Tue, 21 Oct 2014 13:36:56 -0700
Message-ID: <1413923820-14457-12-git-send-email-sahlberg@google.com>
References: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 21 22:46:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XggKR-0004zm-5V
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 22:46:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460AbaJUUqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 16:46:42 -0400
Received: from mail-ig0-f201.google.com ([209.85.213.201]:55313 "EHLO
	mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933351AbaJUUqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 16:46:39 -0400
Received: by mail-ig0-f201.google.com with SMTP id h15so358565igd.2
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 13:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ugUZI37+Aq3CTBuCDm7WKOkRZTBBHOjI+0MdE4nROMU=;
        b=RN+26ZHzIderFN8sVXHUQc8/xvPM4VNTuFPutLh1lURSsRzsoDZVsi/xZh+W5C2rf5
         EL88zJrXkvQjwJm5lRdv3ZJt4P8wxlT+bhkS6Ehpd9jI2brfTx3S76I/Pb0feCqIYex5
         xDYRpA69zCOwgy61J4cd4tav8BrVJTKYMcmtd1tXUEFFU8xkcy7JmITT3h3+4DyI8A+o
         dfHSv2XbQH0uVrExqF4m59bf5OHaQis1NDA2tAqTgs0mYMK/NkJCn1MXE0C4wVC683dy
         +YmvYm0XD297ZiEM5LH+SHGFh1+IaNP2YYmxMXfOLkyko7fazMFqRYXQvXorkUQT5kRy
         7L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ugUZI37+Aq3CTBuCDm7WKOkRZTBBHOjI+0MdE4nROMU=;
        b=kds7NgeNbYvYb8WGlKUBGnaJv37ozvjP4KMRvLMk1YRSAHO0KiKI2lcpJnRHwvRgM2
         6wYxKGSwjXI24jhbw60U+NN7RkrTUDALQzdih6lgAaPIlr2SjXvryVTNZpSEzXFJUeOk
         egI7uiIcBDekPFSl1T7dvaPXZu39qGaYm4VBxlgfPkgrkV1wIjRpw8mA13OFzHRecs5a
         9vpCmYx0pUvP4GmeYhl8kppzKuDs6NrZxF3UE+W+qjecj3HB1v3kU5dzLS+Z8JHqA/j0
         q5IPkO/0LnUIKmNfD9h9fD56bM5bnAtmKGM9dZ9o/v8BVMJSW4v0bRz7rFEIg4tKmgvz
         4/Sg==
X-Gm-Message-State: ALoCoQnBkIJgMWnPLW0z/rP8RoWP4JP6zyc6r0ZnMZar8CFAXZwq3xvhQBKpsV//37x13FCJUIcn
X-Received: by 10.50.61.206 with SMTP id s14mr511501igr.3.1413924399031;
        Tue, 21 Oct 2014 13:46:39 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si595717yhb.4.2014.10.21.13.46.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Oct 2014 13:46:39 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id IWXENJYk.1; Tue, 21 Oct 2014 13:46:38 -0700
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3F45CE1354; Tue, 21 Oct 2014 13:37:02 -0700 (PDT)
X-Mailer: git-send-email 2.1.2.738.gd04b95a
In-Reply-To: <1413923820-14457-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the
public api.

Change-Id: I1059f1690129f0232cb27872ef494024ef7f299e
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  8 ++++----
 refs.h | 30 ------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/refs.c b/refs.c
index fddd59c..1261a78 100644
--- a/refs.c
+++ b/refs.c
@@ -1224,7 +1224,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2393,7 +2393,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 }
 
 /* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+static int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
@@ -2416,7 +2416,7 @@ int lock_packed_refs(int flags)
  * Commit the packed refs changes.
  * On error we must make sure that errno contains a meaningful value.
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2445,7 +2445,7 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index db435bf..44ae7fe 100644
--- a/refs.h
+++ b/refs.h
@@ -120,36 +120,6 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
 extern void warn_dangling_symrefs(FILE *fp, const char *msg_fmt, const struct string_list *refnames);
 
 /*
- * Lock the packed-refs file for writing.  Flags is passed to
- * hold_lock_file_for_update().  Return 0 on success.
- * Errno is set to something meaningful on error.
- */
-extern int lock_packed_refs(int flags);
-
-/*
- * Add a reference to the in-memory packed reference cache.  This may
- * only be called while the packed-refs file is locked (see
- * lock_packed_refs()).  To actually write the packed-refs file, call
- * commit_packed_refs().
- */
-extern void add_packed_ref(const char *refname, const unsigned char *sha1);
-
-/*
- * Write the current version of the packed refs cache from memory to
- * disk.  The packed-refs file must already be locked for writing (see
- * lock_packed_refs()).  Return zero on success.
- * Sets errno to something meaningful on error.
- */
-extern int commit_packed_refs(void);
-
-/*
- * Rollback the lockfile for the packed-refs file, and discard the
- * in-memory packed reference cache.  (The packed-refs file will be
- * read anew if it is needed again after this function is called.)
- */
-extern void rollback_packed_refs(void);
-
-/*
  * Flags for controlling behaviour of pack_refs()
  * PACK_REFS_PRUNE: Prune loose refs after packing
  * PACK_REFS_ALL:   Pack _all_ refs, not just tags and already packed refs
-- 
2.1.0.rc2.206.gedb03e5
