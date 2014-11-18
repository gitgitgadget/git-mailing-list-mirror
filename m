From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v4 12/16] refs.c: make the *_packed_refs functions static
Date: Mon, 17 Nov 2014 17:44:53 -0800
Message-ID: <1416275097-3616-13-git-send-email-sbeller@google.com>
References: <1416275097-3616-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:46:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXrj-00040h-PH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:46:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbaKRBps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:45:48 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:59126 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753643AbaKRBpS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:45:18 -0500
Received: by mail-ie0-f176.google.com with SMTP id ar1so1144368iec.21
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/uKTiKWiQhDbisdHBUvv/lY1r2G/3nmaM9tFkmMgkjY=;
        b=I79/7RXWly4aGTjZXbxKkTj97F5X6ONKSWBDfwpcyJdSZUWiMEvJB77g6uNl/MqrbD
         jPAtr9RK+Lp1N+jqzkxAmkADCSxfn09FDTg2Hl9W462P/b8CDwREPPDlgiI47y3F6hUs
         3r0F7RTIUUM8TnrIbG816omrFcsz4w3KKsHkJ5QOthQRv/g1RNT5N1BlTuEUasuNcDd7
         vgW/LmneZwcf0UHbNYoKCbdXChqHnvr1mcmFcLD2tz7+R+wOSlao9kgIegYIQsV4fMFv
         2dCKXH02j/UCUBcgSpe75yJin4y1rROOjDyY3jOm5rcpTX6HVcR7V/x0ORELFiOEqyBL
         VLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/uKTiKWiQhDbisdHBUvv/lY1r2G/3nmaM9tFkmMgkjY=;
        b=MXBx5QEWBd3RIsSibYpx4c6JFizwEmGOvg+8UD3JDUI34XuXBS5zqb0qLxsCvJ16TD
         o3ugl/MgdMBAcpyBAT2vSSgk5HNgZ0DX+LgX4hsjiCW5I9JobFdEkotXZ7OZ2fhym+2+
         Goj1QhcWFXr/C0s5ApHyYJPYFtuVMjF00p3HtR/VeEdUS2XSkij+282IRHgcGnTmpfIp
         uCh+Lf7bH/ofHBOT7CgeQG3SDoA9jHUEUmZOGGkmjMpSBLpAt9dqSEyGgjPdeGWSvwdo
         Y2vjy4LcKGis1S637P+ASIink1wGuU03S5WHMPhGgF8Dc5Bt1Gf6Ovv1G0rP7LutaOLx
         YgFg==
X-Gm-Message-State: ALoCoQmalZnGGcac1Bokd+30noIEmK3ed/+PfWXhnY6sRvGSqxvoncMTFDzkDzCF4nswnxFeq5oi
X-Received: by 10.50.221.33 with SMTP id qb1mr565774igc.7.1416275117377;
        Mon, 17 Nov 2014 17:45:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id y9sm6866191igp.22.2014.11.17.17.45.16
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:45:16 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416275097-3616-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

We no longer need to expose the lock/add/commit/rollback functions
for packed refs anymore so make them static and remove them from the
public api.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c |  8 ++++----
 refs.h | 30 ------------------------------
 2 files changed, 4 insertions(+), 34 deletions(-)

diff --git a/refs.c b/refs.c
index 899c33e..49d62b0 100644
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
index ce290b1..70a2819 100644
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
2.2.0.rc2.5.gf7b9fb2
