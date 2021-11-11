Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBF5C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B91461268
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 17:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhKKRTm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 12:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbhKKRTk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 12:19:40 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D484C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:51 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id l7-20020a622507000000b00494608c84a4so4247380pfl.6
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 09:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FW89CIOKZUnwHU3VszO13T0tsVm96lcWSMAnVySsm8g=;
        b=ri9sOmhg38gm1l1UxBIvrXGJtxDjY5HZacRfWQYlCteJ+IyYIy3vl4xDDaDzuxacL7
         tp9dUo4i3tjEgfBfkmwZ+IP65eS1NULDLiaxJapvdguk/ooQ8132x9Wmrpbp1NCYz1wL
         2du7bzlGdB5HOnOrzafNB0DHlAeSlOeEJG6v3Xlr7zLKmlTP3PkVHIgWDM5e3SF2KcfR
         x+EwuWKpRhn1tfAfR2ez/57SBuVGxdXIJw/jkZTwNI2999KYXP4Ze3N725aWangtaCLD
         Eo1rikF0rHmxNITmy2Qv+usA9qI/JPJOVAlJ/A/nb7HJP2RL26vKsl6iFiaV8chYzd5l
         xQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FW89CIOKZUnwHU3VszO13T0tsVm96lcWSMAnVySsm8g=;
        b=wEV3TcoQvzGlkygoEb5RgpoVRr7SSXbpl4r5UXKLTxeelpCAmUzuOE8RE2Gy+l/FwM
         +m92H9dGxJ1tz7m44H1Wd8fw/RygMa+AWQZp8eW/PjS0P6sT17q3G6dFiqzcJuIEqkYM
         YHJ+enmTGaQEAhGrbvjXuhdnkLTSwgIeUJumunrrX5hr48Fa0juh4k3eqy8Ytc9jTUS+
         9WsW/4eD5F872iywb2187NbjqQIJ7FCKjnTnO3enAze1G7/x4tUNDU+N4FqJLesMjWTN
         87iE881q5qWA3i9Ue/cUcRpuRaywjAWx1z9atgxaQe3TCNdkGBTF1xp9aIEf9o0zPxdi
         9j0g==
X-Gm-Message-State: AOAM531o/ZZRbDxV9GtDu8wSkzvPCkAn1KpbjDTQJoXbBugifewZusL/
        vAh3+MjQlluyn60DuMHtqGAU6BkLP1wIGijj/KTcyGtLsMjUJIfEFbheu4Cx+Kpzflp6MDeY6dY
        jWm50+FXS7KVdFePGpkaiZ7IuDbPM6ByVfvtbGARqCSkkNTQMMCF+E4Brvsztmz8=
X-Google-Smtp-Source: ABdhPJy7uYRoCj5OI8MoUk4MiLeyOee+WpSVmPGwiDBroVope5DlUTVqj8oInDInIYAJO1cWLG1y3DTvGNE4Nw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:224f:: with SMTP id
 hk15mr28284873pjb.173.1636651010795; Thu, 11 Nov 2021 09:16:50 -0800 (PST)
Date:   Thu, 11 Nov 2021 09:16:41 -0800
In-Reply-To: <20211111171643.13805-1-chooglen@google.com>
Message-Id: <20211111171643.13805-2-chooglen@google.com>
Mime-Version: 1.0
References: <20211111171643.13805-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v1 1/3] refs/files-backend: remove the_repository
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs/files-backend.c references the_repository in order to validate
object ids. However, 34224e14d6 (refs: plumb repo into ref stores,
2021-10-08), added repository pointers to ref stores, so we no longer
need to hardcode the_repository.

Replace the reference to the_repository with files_ref_store.base.repo.
This allows the files backend to work with in-core repositories other
than the_repository.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 refs/files-backend.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b14f30d48..10eac93cd4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1353,8 +1353,9 @@ static int rename_tmp_log(struct files_ref_store *refs, const char *newrefname)
 	return ret;
 }
 
-static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const struct object_id *oid, struct strbuf *err);
+static int write_ref_to_lockfile(struct repository *repo, struct ref_lock *lock,
+				 const struct object_id *oid,
+				 struct strbuf *err);
 static int commit_ref_update(struct files_ref_store *refs,
 			     struct ref_lock *lock,
 			     const struct object_id *oid, const char *logmsg,
@@ -1501,7 +1502,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	}
 	oidcpy(&lock->old_oid, &orig_oid);
 
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(refs->base.repo, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
 		error("unable to write current sha1 into %s: %s", newrefname, err.buf);
 		strbuf_release(&err);
@@ -1521,7 +1522,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	flag = log_all_ref_updates;
 	log_all_ref_updates = LOG_REFS_NONE;
-	if (write_ref_to_lockfile(lock, &orig_oid, &err) ||
+	if (write_ref_to_lockfile(refs->base.repo, lock, &orig_oid, &err) ||
 	    commit_ref_update(refs, lock, &orig_oid, NULL, &err)) {
 		error("unable to write current sha1 into %s: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1756,14 +1757,15 @@ static int files_log_ref_write(struct files_ref_store *refs,
  * Write oid into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and return -1.
  */
-static int write_ref_to_lockfile(struct ref_lock *lock,
-				 const struct object_id *oid, struct strbuf *err)
+static int write_ref_to_lockfile(struct repository *repo, struct ref_lock *lock,
+				 const struct object_id *oid,
+				 struct strbuf *err)
 {
 	static char term = '\n';
 	struct object *o;
 	int fd;
 
-	o = parse_object(the_repository, oid);
+	o = parse_object(repo, oid);
 	if (!o) {
 		strbuf_addf(err,
 			    "trying to write ref '%s' with nonexistent object %s",
@@ -2576,8 +2578,8 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * The reference already has the desired
 			 * value, so we don't need to write it.
 			 */
-		} else if (write_ref_to_lockfile(lock, &update->new_oid,
-						 err)) {
+		} else if (write_ref_to_lockfile(refs->base.repo, lock,
+						 &update->new_oid, err)) {
 			char *write_err = strbuf_detach(err, NULL);
 
 			/*
-- 
2.33.GIT

