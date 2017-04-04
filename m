Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1891B20966
	for <e@80x24.org>; Tue,  4 Apr 2017 10:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbdDDKWV (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 06:22:21 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36562 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753253AbdDDKWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 06:22:19 -0400
Received: by mail-pg0-f67.google.com with SMTP id 81so36312292pgh.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EZp1w9YKHhZai6D7KgyL5KkugO/Yh/mUcmusrzeQ5fs=;
        b=aqUV3x4HZOu5ATri9eEmUL1BL/HYeTRHv5YQuBn8t9Wm1jPxhsFxAvqt+iu3d3uFgt
         yxyeRFnmY7xSBkfRFEhwuW5vf+zzjYgZWUM8OzYGWKvfgi8THbv6OKDyA606Cukf3F44
         JwyF5+djRS9Od+++4JIvFW4veteb3svhn4jcVxEphIJgQOIttfuj3icv9ffhyw9qGD1m
         nUmu3UiMmbyNb9MIjHAqrXbSYOjqFgduDsqWP8C0NEjuyzCVZHKCJ6ALEQtM6OABWatA
         SmBwPDGRJEFXIBCaCJRunCjWyb9qepK6w7Op2g7cq5EbjAqX52qSpliZzKA/A1ccGl8O
         wSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EZp1w9YKHhZai6D7KgyL5KkugO/Yh/mUcmusrzeQ5fs=;
        b=ssNJgS0llix+3VIg8/6XMfLd+pQapqh9laQVwdwMv5r8mXzF+s/oEQfG3OumJvoHjB
         83Uuo6XrUbU3c1yN9yN9k/TpNEWN64FsgzX3jW+tqazEhHvDBt3e2C3LszZEc7HYBhRi
         UqgxNdgYXy/lKeH4YxprNzPguHlz3oOvF/+Vv0YXQmiqhO8EbTBngLrelPnCapR0BTo2
         UlfC/e9CAf2KbVtFik8ZdWlyfdjSNs4DlcNFztQ48f+iKeBjquSgTXwPE7XGcB5jWt2a
         0wCNo9HV6mskneD2XmeY9hvk7MIe6wnUSa5W9ElQBj81ODh8ChJL5uGyDjYWDvVJcarg
         rOYA==
X-Gm-Message-State: AFeK/H1pUmpguOzwKgcNnRKe7OqEVxnG3PX06AoY8N3YSi22MLb+Fc9d7or77FukGVu4ig==
X-Received: by 10.98.105.134 with SMTP id e128mr21818827pfc.19.1491301333926;
        Tue, 04 Apr 2017 03:22:13 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id p18sm2965504pfj.23.2017.04.04.03.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Apr 2017 03:22:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Tue, 04 Apr 2017 17:22:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v4 5/5] refs: kill set_worktree_head_symref()
Date:   Tue,  4 Apr 2017 17:21:23 +0700
Message-Id: <20170404102123.25315-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170404102123.25315-1-pclouds@gmail.com>
References: <20170318100206.5980-1-pclouds@gmail.com>
 <20170404102123.25315-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

70999e9cec (branch -m: update all per-worktree HEADs - 2016-03-27)
added this function in order to update HEADs of all relevant
worktrees, when a branch is renamed.

It, as a public ref api, kind of breaks abstraction when it uses
internal functions of files backend. With the introduction of
refs_create_symref(), we can move back pretty close to the code before
70999e9cec, where create_symref() was used for updating HEAD.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 branch.c                      | 12 ++++++------
 refs.h                        | 10 ----------
 refs/files-backend.c          | 44 -------------------------------------------
 t/t1407-worktree-ref-store.sh | 12 ++++++++++++
 4 files changed, 18 insertions(+), 60 deletions(-)

diff --git a/branch.c b/branch.c
index 0b949b7fb2..69d5eea84b 100644
--- a/branch.c
+++ b/branch.c
@@ -353,18 +353,18 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 	int i;
 
 	for (i = 0; worktrees[i]; i++) {
+		struct ref_store *refs;
+
 		if (worktrees[i]->is_detached)
 			continue;
 		if (worktrees[i]->head_ref &&
 		    strcmp(oldref, worktrees[i]->head_ref))
 			continue;
 
-		if (set_worktree_head_symref(get_worktree_git_dir(worktrees[i]),
-					     newref, logmsg)) {
-			ret = -1;
-			error(_("HEAD of working tree %s is not updated"),
-			      worktrees[i]->path);
-		}
+		refs = get_worktree_ref_store(worktrees[i]);
+		if (refs_create_symref(refs, "HEAD", newref, logmsg))
+			ret = error(_("HEAD of working tree %s is not updated"),
+				    worktrees[i]->path);
 	}
 
 	free_worktrees(worktrees);
diff --git a/refs.h b/refs.h
index 6df69a2adb..447381d378 100644
--- a/refs.h
+++ b/refs.h
@@ -402,16 +402,6 @@ int refs_create_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
-/*
- * Update HEAD of the specified gitdir.
- * Similar to create_symref("relative-git-dir/HEAD", target, NULL), but
- * this can update the main working tree's HEAD regardless of where
- * $GIT_DIR points to.
- * Return 0 if successful, non-zero otherwise.
- * */
-int set_worktree_head_symref(const char *gitdir, const char *target,
-			     const char *logmsg);
-
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
 	UPDATE_REFS_DIE_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index a5b405436f..e428d1abff 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3161,50 +3161,6 @@ static int files_create_symref(struct ref_store *ref_store,
 	return ret;
 }
 
-int set_worktree_head_symref(const char *gitdir, const char *target, const char *logmsg)
-{
-	/*
-	 * FIXME: this obviously will not work well for future refs
-	 * backends. This function needs to die.
-	 */
-	struct files_ref_store *refs =
-		files_downcast(get_main_ref_store(),
-			       REF_STORE_WRITE,
-			       "set_head_symref");
-
-	static struct lock_file head_lock;
-	struct ref_lock *lock;
-	struct strbuf head_path = STRBUF_INIT;
-	const char *head_rel;
-	int ret;
-
-	strbuf_addf(&head_path, "%s/HEAD", absolute_path(gitdir));
-	if (hold_lock_file_for_update(&head_lock, head_path.buf,
-				      LOCK_NO_DEREF) < 0) {
-		struct strbuf err = STRBUF_INIT;
-		unable_to_lock_message(head_path.buf, errno, &err);
-		error("%s", err.buf);
-		strbuf_release(&err);
-		strbuf_release(&head_path);
-		return -1;
-	}
-
-	/* head_rel will be "HEAD" for the main tree, "worktrees/wt/HEAD" for
-	   linked trees */
-	head_rel = remove_leading_path(head_path.buf,
-				       absolute_path(get_git_common_dir()));
-	/* to make use of create_symref_locked(), initialize ref_lock */
-	lock = xcalloc(1, sizeof(struct ref_lock));
-	lock->lk = &head_lock;
-	lock->ref_name = xstrdup(head_rel);
-
-	ret = create_symref_locked(refs, lock, head_rel, target, logmsg);
-
-	unlock_ref(lock); /* will free lock */
-	strbuf_release(&head_path);
-	return ret;
-}
-
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 04d1e9d177..5df06f3556 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -37,4 +37,16 @@ test_expect_success 'resolve_ref(<per-worktree-ref>)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'create_symref(FOO, refs/heads/master)' '
+	$RWT create-symref FOO refs/heads/master nothing &&
+	echo refs/heads/master >expected &&
+	git -C wt symbolic-ref FOO >actual &&
+	test_cmp expected actual &&
+
+	$RMAIN create-symref FOO refs/heads/wt-master nothing &&
+	echo refs/heads/wt-master >expected &&
+	git symbolic-ref FOO >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

