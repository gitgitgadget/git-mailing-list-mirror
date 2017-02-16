Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D837C1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 12:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754648AbdBPMEP (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 07:04:15 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33804 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752983AbdBPMEO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 07:04:14 -0500
Received: by mail-pf0-f195.google.com with SMTP id o64so1515138pfb.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 04:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a6QVWv6J62m2sLwaE5KF3WcaP/W0uKwpxIk4ljU4YP0=;
        b=Masx5naBTC2Tf4tiRJFkSCtRq7dMtyb8kpWgjDp/waI/4wzNNW62wD1EXKITD/65Bf
         /ILcbKHFjt104rNoDP1+QPOazJg4sQVyuHA9AYyKyCqljrG5JVzs4j1ObZL8WYcWReSG
         ZtuPREylmLHh3SYzAdUX6XaZhLK5ap/5/tH7Nqq+3XHU3Z9aeHZ6BRq4ijFOJ5ggVfpA
         rf2mgRsYSD0D0y9i6EVFJH7NIizRIJ7SNYZ5TFG1Ci+bGYRwPGSJvLxhMju11MVd7KQU
         Ao40vz3aPLIkDbgAXpxIhjdhr/Y4pzxlpNy0O7Vz/a9njW+gZaB5HfZEGsqHtYIp+y9A
         XFdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a6QVWv6J62m2sLwaE5KF3WcaP/W0uKwpxIk4ljU4YP0=;
        b=LMm+S6S268DtLir6aLLgLeP1PzRBhjMTBOh7AM41OyEXlpXgxUarIqXBO+F2GLmIzZ
         4vG8mSyLwBBeIkv7aD0Jk+IzY5Bb93VctUhlgtXbaDvVJl+WMyJan4RjX1RPGATjber/
         Yn2y+ljhUL6r4UvpuN0imJfEQN1yrP8fbsIPUso5wnz8u6vflrQu8HEDJWThN15zB7PA
         sv6Lr/FFZr81s91Hy9vPgx85ls92Z+zzcwGJnHd594eC2QyWPlNN/WUf4fK0k9kdgWI4
         ibuc1+4zCDXx1OePSuaJmAeuvyUrc/rxWfl9scsfaV9+j1VxGbVXdHc1D2O5uJukhjLL
         1Jyw==
X-Gm-Message-State: AMke39lKXIYyBJaX5y8RymW4DOsKSDlIFQvOoscYf/TlKNUwLlOtYxIdRsLRAVVanCV/sQ==
X-Received: by 10.98.66.82 with SMTP id p79mr2264154pfa.10.1487246653257;
        Thu, 16 Feb 2017 04:04:13 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id t6sm13553096pgt.8.2017.02.16.04.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 04:04:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 16 Feb 2017 19:04:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 5/5] refs: kill set_worktree_head_symref()
Date:   Thu, 16 Feb 2017 19:03:02 +0700
Message-Id: <20170216120302.5302-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170216120302.5302-1-pclouds@gmail.com>
References: <20170208113144.8201-1-pclouds@gmail.com>
 <20170216120302.5302-1-pclouds@gmail.com>
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
 branch.c             | 12 ++++++------
 refs.h               |  9 ---------
 refs/files-backend.c | 41 -----------------------------------------
 3 files changed, 6 insertions(+), 56 deletions(-)

diff --git a/branch.c b/branch.c
index fcb4a765c..ad0cc0489 100644
--- a/branch.c
+++ b/branch.c
@@ -352,18 +352,18 @@ int replace_each_worktree_head_symref(const char *oldref, const char *newref)
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
-					     newref)) {
-			ret = -1;
-			error(_("HEAD of working tree %s is not updated"),
-			      worktrees[i]->path);
-		}
+		refs = get_worktree_ref_store(worktrees[i]);
+		if (refs_create_symref(refs, "HEAD", newref, NULL))
+			ret = error(_("HEAD of working tree %s is not updated"),
+				    worktrees[i]->path);
 	}
 
 	free_worktrees(worktrees);
diff --git a/refs.h b/refs.h
index 694769963..bce77891a 100644
--- a/refs.h
+++ b/refs.h
@@ -325,15 +325,6 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg);
 
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
-/*
- * Update HEAD of the specified gitdir.
- * Similar to create_symref("relative-git-dir/HEAD", target, NULL), but
- * this can update the main working tree's HEAD regardless of where
- * $GIT_DIR points to.
- * Return 0 if successful, non-zero otherwise.
- * */
-int set_worktree_head_symref(const char *gitdir, const char *target);
-
 enum action_on_err {
 	UPDATE_REFS_MSG_ON_ERR,
 	UPDATE_REFS_DIE_ON_ERR,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index f3be620ab..ba56e46d4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3108,47 +3108,6 @@ static int files_create_symref(struct ref_store *ref_store,
 	return ret;
 }
 
-int set_worktree_head_symref(const char *gitdir, const char *target)
-{
-	/*
-	 * FIXME: this obviously will not work well for future refs
-	 * backends. This function needs to die.
-	 */
-	struct files_ref_store *refs =
-		files_downcast(get_main_ref_store(), "set_head_symref");
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
-	ret = create_symref_locked(refs, lock, head_rel, target, NULL);
-
-	unlock_ref(lock); /* will free lock */
-	strbuf_release(&head_path);
-	return ret;
-}
-
 static int files_reflog_exists(struct ref_store *ref_store,
 			       const char *refname)
 {
-- 
2.11.0.157.gd943d85

