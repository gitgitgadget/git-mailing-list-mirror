Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9F551FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1168256AbdDXKCZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:02:25 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:34106 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166947AbdDXKCN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:02:13 -0400
Received: by mail-it0-f66.google.com with SMTP id c26so7955192itd.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1w72Hkkj0iebxSbDAJxHExIx52foGOFQ2RXhnT730s=;
        b=ABEtoMyMrqnaJoU7sdOn7CizpEBpkiRPmWg1VNGLlgzR3vYq7vvvM2sf/oyVHMsj1w
         EX2soDXaD1LbgGgFwwuN8yHNSD+ekvFwZnGqEyNlOunCmb8OzbtW20y5HwJ12Rq4CvoG
         5SigWx03Yu71/Ba2JkXeey3tOvckGmNE71rtTO4CWLeP4LKZvMYxnfm2/h406z4OTuf/
         ML4v5XSFiMXwWgKIiwzOXb8TlCHI30RVn2W7Nqm9Eu5/ECZYCswkjOIw6u1fcYvwcaXF
         QtvslXfHUJ6ASkm2eHt/cXR37la+SvsOx5QF0sFGXlWFEoSsI2T0ope/yR5pIM8UMrT1
         /HLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1w72Hkkj0iebxSbDAJxHExIx52foGOFQ2RXhnT730s=;
        b=WqTtYT72pS48PBV17U3W/RGjUmOXE/C5QvC7+OWecbtsMeDS7U5Kbb3edU7dIkCtRX
         khTBU/G21FS4aXG936/+VJ/4YYNyUsJ+nOw8wMhCWYD0o4LD2RNkAHvqqr5ANiArQv8v
         Np8+0dz55Bf/FgrGXTkMINdJgxWWtoVfOjjjKXU/b3JXI1jNgdr20hOtxycVRHi9LskD
         bek9cpQAORgiFPyARP+JyA/G4d2CCcEjEpHe4wcQlFpgmOr0DjACXQISWkzny6MmAC43
         gqjojZXDgjniMZy3c1upBbj6vraQaYdBA6jgHHZvmrH0okBQVi0Ndp6fP9LMQBq8yaqS
         dWcw==
X-Gm-Message-State: AN3rC/6noxFwlTA/NIYzN6ok4ZTSxXKZgrBvh5jL5TQNYzOQuTPB1HOa
        6sO+Adz0qJEgfUSc
X-Received: by 10.84.140.129 with SMTP id 1mr32008837plt.11.1493028132492;
        Mon, 24 Apr 2017 03:02:12 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id u23sm29920327pfd.63.2017.04.24.03.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 03:02:11 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Apr 2017 17:02:07 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 6/6] refs: kill set_worktree_head_symref()
Date:   Mon, 24 Apr 2017 17:01:24 +0700
Message-Id: <20170424100124.24637-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170424100124.24637-1-pclouds@gmail.com>
References: <20170404102123.25315-1-pclouds@gmail.com>
 <20170424100124.24637-1-pclouds@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
index 4d705b4037..4149943a6e 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3160,50 +3160,6 @@ static int files_create_symref(struct ref_store *ref_store,
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

