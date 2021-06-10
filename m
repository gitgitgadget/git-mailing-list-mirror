Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DA9C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D771C613C9
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhFJNAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 09:00:50 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:42604 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhFJNAs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 09:00:48 -0400
Received: by mail-wm1-f46.google.com with SMTP id l7-20020a05600c1d07b02901b0e2ebd6deso6369074wms.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=u6yvYyGcHBFA4/2GUp92QUUDK4fk7qE5wkIjr4JBqGY=;
        b=VLpD4il8hxov6gllSoSHyMuyZzBqcOavK+r7YLP7WIGU7HZcIJvVawfYGLj66iPyTU
         mUORb5gxv4DhoOSyKD3q8dQbrulx2dIIhujakzE2UedstTj1YRgVASG2sf9ZwYprAcPX
         eTYtcVbp8SajF+rR31LbrlzTcsrf6BPYttyFB7uunszJwHOkOBoTCteYHzge9NmJlCYc
         SDRGPN87TSsnmvrek8tT2b+3LIg7A03yxCVfkhHVkM9YulZPVSDUGVrkpNxSinCM/ayQ
         S5tmoDdyZQOMyrAI1xblkkUtu6epmjUSJwM1m8m67Xtq0hGV8p6s3nJHo6o+Uv6JGMRS
         8Pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=u6yvYyGcHBFA4/2GUp92QUUDK4fk7qE5wkIjr4JBqGY=;
        b=g1DHIJUgau+0VSF84XP0hqYSlRaZQQ00eBGR2yOioChDBQvg6ZMg1OadkmHO4u/2Pn
         KCLwToXtkPpN3QFEhLuwBjm8nxWkD0kNkvl6XVDz2QXCtYrVR8q4CJlGCNYoYqCiBXj3
         PDxBI0XYuSCII6ikNF+dhPrq/Lyw51YcY77xNsFSAIwqohyUYbraZPQ5/aZh72tViWtb
         r0qk7PZY8G9gvvLNZumOIVfhLWsrdDAPlpNz+/sXyRNtwNJMgW3dVX9IOjhPS7ulcjQN
         QdsnI10gSphq0Yl7oT0+MHojK0swijH7GZW7/jsiUpMfTwjHoG7evqN0/9/JG7ywxPq7
         a+Gw==
X-Gm-Message-State: AOAM530FRLl9xjpzxzE5pQX7w83PU3Dr9CtGennvvAtJ4QJjHSS7IOTq
        tc63jFkg+cUcI8phkCin5gFAKpZanuM=
X-Google-Smtp-Source: ABdhPJyiL7lhxfnCQ2OdxkkgLc2Sz9sJ00o81k91/oEve1qUlkVekL4rRwfHo+EfFiRlc6U5G2lVpw==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr4976771wml.29.1623329871504;
        Thu, 10 Jun 2021 05:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y8sm10064180wmi.45.2021.06.10.05.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 05:57:51 -0700 (PDT)
Message-Id: <cbe09a48036c0befafa0f26f72d188dc765f5b7b.1623329869.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
References: <pull.1012.git.git.1619710329.gitgitgadget@gmail.com>
        <pull.1012.v2.git.git.1623329868.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Jun 2021 12:57:42 +0000
Subject: [PATCH v2 2/8] refs/files-backend: stop setting errno from
 lock_ref_oid_basic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

refs/files-backend.c::lock_ref_oid_basic() tries to signal how it failed
to its callers using errno.

It is safe to stop setting errno here, because the callers of this
file-scope static function are

* files_copy_or_rename_ref()
* files_create_symref()
* files_reflog_expire()

None of them looks at errno after seeing a negative return from
lock_ref_oid_basic() to make any decision, and no caller of these three
functions looks at errno after they signal a failure by returning a
negative value. In particular,

* files_copy_or_rename_ref() - here, calls are followed by error()
(which performs I/O) or write_ref_to_lockfile() (which calls
parse_object() which may perform I/O)

* files_create_symref() - here, calls are followed by error() or
create_symref_locked() (which performs I/O and does not inspect
errno)

* files_reflog_expire() - here, calls are followed by error() or
refs_reflog_exists() (which calls a function in a vtable that is not
documented to use and/or preserve errno)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
---
 refs/files-backend.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd2d..6aa0f5c41dd3 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -910,7 +910,6 @@ static int create_reflock(const char *path, void *cb)
 
 /*
  * Locks a ref returning the lock on success and NULL on failure.
- * On failure errno is set to something meaningful.
  */
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
@@ -922,7 +921,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
-	int last_errno = 0;
 	int mustexist = (old_oid && !is_null_oid(old_oid));
 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
 	int resolved;
@@ -949,7 +947,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		 * to remain.
 		 */
 		if (remove_empty_directories(&ref_file)) {
-			last_errno = errno;
 			if (!refs_verify_refname_available(
 					    &refs->base,
 					    refname, extras, skip, err))
@@ -962,7 +959,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 						     &lock->old_oid, type);
 	}
 	if (!resolved) {
-		last_errno = errno;
+		int last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
 						   extras, skip, err))
@@ -981,20 +978,17 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
 					  extras, skip, err)) {
-		last_errno = ENOTDIR;
 		goto error_return;
 	}
 
 	lock->ref_name = xstrdup(refname);
 
 	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
-		last_errno = errno;
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
 
 	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
-		last_errno = errno;
 		goto error_return;
 	}
 	goto out;
@@ -1005,7 +999,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
  out:
 	strbuf_release(&ref_file);
-	errno = last_errno;
 	return lock;
 }
 
-- 
gitgitgadget

