Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13969C433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 17:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFF55610E6
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 17:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhJFRqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhJFRqt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 13:46:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90892C08C5E7
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 10:42:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 207-20020a2503d8000000b005b6fc088578so4426361ybd.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v95BLknFysbLk+nVopLa55GP8VoLhV8EAaQA9UaUjV8=;
        b=B5eGiGRuYPi6EBCB+iUwo0q8NYeJJo8TljpAcIt0FtKy1xkjnf17pSyok7JYf1WKU3
         FE4uRcUnuxhh//VNooSiOXh4yiKxslAa4m2JhchjMTEaqU2ud81lYylPzIhDC+9bqxsM
         /rEwDGqkfdNVS9IyaLaUvQBUjKviwCpOkG2Oj0sxoPUt5xLD9wBuoXccGjz/vKWk29Hl
         Bib95OOMulBTyA9LDYPX4pjbrBMveFKijJRgsYb2RNt3RQLfVfjC5JJ2X9aIMiaQNAKr
         ySp/VK4WYykG5Zab5r/HJBPvpEdcu3H8kFM1+E83cSaSp25eaGBIQawS8wGzwPWjqmd4
         l26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v95BLknFysbLk+nVopLa55GP8VoLhV8EAaQA9UaUjV8=;
        b=4WUYE6fxQQcd553fpyb11K0aX8gi0LGLkHiJQN6f7jvR8hXa43SbmRaId2tcp+kXap
         GwWGJsJrhpyvx+EpF2S7vM/fQcGwiICzKet24QHsPKeFtGMKAS7TJVDQeYkSk0MKeHOf
         VvK7hLvuDhBnKbyT0Uyr6FPEMfOjz4ayAP24uN7OowaXERUT/+0mVgF9zF4xw/5Z6CFy
         pPHDDWo7kdxWDBTBVqauuEAYiE+1Ux/KZGBbf68wMJWFsKF5HRd1XdcZ9B9/VegwfKkw
         J2Z60gWPr1Flkz9+YirwFOjvG7Wbc/JWwpKLRR/rqxhOFIIlzCKmu9Fc0CGsuGCw3au7
         c9ag==
X-Gm-Message-State: AOAM530oIKz/XlAwtPfSimNgkYXwo+wcxewapOZvKp7XyU3tSxXLGbVz
        ttiodQgB+u2wzZ31wI2bI4h8zaOrc0eTk5INj8oSq1EMZLUx5Nmi5EIpuxq43aYhUmRa+H0uMSY
        7aw2JZkPMqLgTLgdipE9e++HyJAskVbv3JFq4+NoT4JlIQbmUmb9FcoI4B6+XJDY=
X-Google-Smtp-Source: ABdhPJyTxnWgicL93MDpYLXCcNOipd/bT6nBsF+pW+vXaFQVbY6VpbxvT+zflegCAMDmB8LrXRXr08IiliTrbQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:e792:: with SMTP id
 e140mr30049362ybh.416.1633542154712; Wed, 06 Oct 2021 10:42:34 -0700 (PDT)
Date:   Wed,  6 Oct 2021 10:42:31 -0700
In-Reply-To: <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
Message-Id: <20211006174231.80434-1-chooglen@google.com>
Mime-Version: 1.0
References: <80673975382af534cafaec3fdc034966d6f41105.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] fixup! refs: plumb repo into ref stores
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we are plumbing repo into ref stores, it makes sense to get rid of
the_repository in refs/files-backend.c and use ref_store.repo instead.

Signed-off-by: Glen Choo <chooglen@google.com>
---
In [1], I made some changes to refs/files-backend.c to get rid of
the_repository and accept struct repository as a parameter instead. But,
if we're changing ref stores to contain their own repository, it makes
sense to use this new interface.

I think the most natural place for this is this series. Let me know what
you think :)

[1] https://lore.kernel.org/git/20210921232529.81811-2-chooglen@google.com/

 refs/files-backend.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9d50fc91f8..0358268aba 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1347,7 +1347,7 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct ref_lock *lock,
+static int write_ref_to_lockfile(struct repository *repo, struct ref_lock *lock,
 				 const struct object_id *oid, struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
@@ -1465,7 +1465,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(ref_store->repo, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1485,7 +1485,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(ref_store->repo, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1720,14 +1720,14 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct ref_lock *lock,
+static int write_ref_to_lockfile(struct repository *repo, struct ref_lock *lock,
 				 const struct object_id *oid, struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 	int fd;
 
-	o = parse_object(the_repository, oid);
+	o = parse_object(repo, oid);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
@@ -2531,7 +2531,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, &update->new_oid,
+		} else if (write_ref_to_lockfile(refs->base.repo, lock,
+						 &update->new_oid,
 						 err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
-- 
2.33.0.800.g4c38ced690-goog

