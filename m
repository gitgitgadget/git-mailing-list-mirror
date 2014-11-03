From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 13/17] refs.c: make the *_packed_refs functions static
Date: Mon,  3 Nov 2014 11:02:15 -0800
Message-ID: <1415041339-18450-14-git-send-email-sahlberg@google.com>
References: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 03 20:02:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMts-0001Xv-DZ
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 20:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbaKCTCl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 14:02:41 -0500
Received: from mail-ie0-f201.google.com ([209.85.223.201]:59175 "EHLO
	mail-ie0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbaKCTC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 14:02:26 -0500
Received: by mail-ie0-f201.google.com with SMTP id rd18so826024iec.2
        for <git@vger.kernel.org>; Mon, 03 Nov 2014 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1g2yl7aYluRSjBL7on6Q9AOS4s2E9QNCSM8HP9iX1qA=;
        b=DgvRTaFILOeOHWrLewJoShl9gHXT2r3UEf2Cud9AnTblxXUI0w7NOK9P3Hdj29Oj16
         14Wc+XkYVpgZ7QchiAQj10RDGTm/SWtAw1yNSKaWhioPKOgyHO2GyhGrEK/xACKBnnBH
         1De9efD8DyVIevBasw9Zv+5vosljHBBcbjXh1tgKh/H7XYdnVkDYpoYOoLftlz9COS0O
         lzQZxWg55E4kdy7uIqGuuSx6ZW8c7nZDPDNetegfFkyqXxwUE9hmZoEc5/fc4nCWrihw
         ukpgiOTR9U2b7PY1b56b6t5wr8kTzuACvoUcp/WJsmUIeVqX0fxrufN5/3wn2WOgEveT
         psJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1g2yl7aYluRSjBL7on6Q9AOS4s2E9QNCSM8HP9iX1qA=;
        b=cw1IS1A4caruPtHgjygmB2DtQuWmCDOgTPownFaQwWXj+0ABopk9t+SOrdu9ihGtty
         BbfRWp2uoe8567rvEQH+Wk7XuIhAXnXxSnINlMTX2TNAXbko+TXHD2ckrROv3w2UCfrU
         5jB+6XAvwu6RqkQDkRD/P3j8IHRmNPt17R5otq6oJu9vL1qpSHI6xJalFTPm74leKgZT
         sRMQNN3oYoBs9ceRDdVQCEK1ogMLnPhqJ3iFa5DB30kE76HKFkSpAIjZym45FemQ9pQw
         vGm3nmH8MN7ax1VDdq7an/PZ3WLeax0AsWOPP5DYt6fRt21I3Ev338okIYxodmzbnPC1
         VjVQ==
X-Gm-Message-State: ALoCoQmIKs/86a0XkNIByzFD+BzliloA//EbkdDPMwnD9FkDyrRqvNJH6w+mo3U2TwjFQpU6FmBw
X-Received: by 10.182.98.197 with SMTP id ek5mr32000008obb.30.1415041344812;
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id e24si975169yhe.3.2014.11.03.11.02.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2014 11:02:24 -0800 (PST)
Received: from sahlberg1.mtv.corp.google.com ([172.27.69.52])
	by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id pOuyTeWR.2; Mon, 03 Nov 2014 11:02:24 -0800
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 3A38EE117F; Mon,  3 Nov 2014 11:02:22 -0800 (PST)
X-Mailer: git-send-email 2.1.2.785.g8f5823f
In-Reply-To: <1415041339-18450-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the
public api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c |  8 ++++----
 refs.h | 30 ------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/refs.c b/refs.c
index 56b0360..c9c03f2 100644
--- a/refs.c
+++ b/refs.c
@@ -1229,7 +1229,7 @@ static struct ref_dir *get_packed_refs(struct ref_cache *refs)
 	return get_packed_ref_dir(get_packed_ref_cache(refs));
 }
 
-void add_packed_ref(const char *refname, const unsigned char *sha1)
+static void add_packed_ref(const char *refname, const unsigned char *sha1)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2398,7 +2398,7 @@ static int write_packed_entry_fn(struct ref_entry *entry, void *cb_data)
 }
 
 /* This should return a meaningful errno on failure */
-int lock_packed_refs(int flags)
+static int lock_packed_refs(int flags)
 {
 	struct packed_ref_cache *packed_ref_cache;
 
@@ -2421,7 +2421,7 @@ int lock_packed_refs(int flags)
  * Commit the packed refs changes.
  * On error we must make sure that errno contains a meaningful value.
  */
-int commit_packed_refs(void)
+static int commit_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
@@ -2450,7 +2450,7 @@ int commit_packed_refs(void)
 	return error;
 }
 
-void rollback_packed_refs(void)
+static void rollback_packed_refs(void)
 {
 	struct packed_ref_cache *packed_ref_cache =
 		get_packed_ref_cache(&ref_cache);
diff --git a/refs.h b/refs.h
index f5ba534..1747d5f 100644
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
