Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A33451F453
	for <e@80x24.org>; Sat, 29 Sep 2018 19:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbeI3Bk1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 21:40:27 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:46842 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeI3Bk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 21:40:26 -0400
Received: by mail-lf1-f50.google.com with SMTP id q2-v6so7183228lfc.13
        for <git@vger.kernel.org>; Sat, 29 Sep 2018 12:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUV/xSrYy+WbCwmd5DanAD6l3yjLd9ZtNgqn5wslcFU=;
        b=uaY06nN5HinE0lDQtp8QjR4AFzSKaAC0NnhXgPY1rUypIkj8Y9mriB2j3610b+aW5L
         AiY++B1PWMzl2lcXjiXJD2x0xPER9fDzyIGzcT1B52GvESKkE4jnp4W4h/8hAamXigKv
         XQODNybiYYWGVc6srColzz/ZGSi8csv04zrUdHY/h5IcPYusTFBieMjLvMQNudx+XGk+
         ghGBsIDZbI5dGweazUzM5qYADvnOJr7wLJC50SxHYbCviZAX3WnkQ9P85uCkAeIlrTEf
         y1qi+vllNYmmQ99WAExpfkY/04mpLs8VtACKz95yKOLAJjmfojOrY/3h0k95J89d4oCJ
         tN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUV/xSrYy+WbCwmd5DanAD6l3yjLd9ZtNgqn5wslcFU=;
        b=PWkdG4aG/48PT8hZ7LfzLBalDwG28XtMilX3hqvVvKFtJ+sHelyv/HV0rCeVxrNurA
         puCoHlu8qq1mfCVkx9xNtxXtkXdcf3hxj+yjvcTqoXYTScrl0Td18o9puFYj5Kyvr3FJ
         /j+42JpjDHuYduSJNcV/Z/KFz8vVdAkXPF/LNPfycFCNOW7WAvdrcAGvpUIvQqgl1O7O
         OYKjmfXqQD16eW1quvnJZUFUNiJnHpKmlAoWT0VbAljLVIcW8k1mEzzZO+l9j0rVxw+h
         X8Oo1+nPjL5RCXpybk0C/c7xbieC7WO7Arx8ZrbU+xiTT0ZA4t7gTDJGN62pxBJmMzRo
         +v9A==
X-Gm-Message-State: ABuFfoiaHBO4f49wqcYaF7MJSX8RI4glbar+JhT3TZEk1sMhjWhaP7bv
        XMNDw+cBmY+huGCFUayt6dg=
X-Google-Smtp-Source: ACcGV63qKlepv3j0MKWqQQkdumzcdQyxsQQClXrKuGS2O1/EfPecx9q0N9TEa77+HbnX/8Cy2MaPgw==
X-Received: by 2002:a19:98c1:: with SMTP id a184-v6mr1906119lfe.94.1538248250160;
        Sat, 29 Sep 2018 12:10:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c14-v6sm1638494lfi.23.2018.09.29.12.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 12:10:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 7/8] fsck: check HEAD and reflog from other worktrees
Date:   Sat, 29 Sep 2018 21:10:28 +0200
Message-Id: <20180929191029.13994-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.341.g3acb95d729
In-Reply-To: <20180929191029.13994-1-pclouds@gmail.com>
References: <20180922180500.4689-1-pclouds@gmail.com>
 <20180929191029.13994-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsck is a repo-wide operation and should check all references no
matter which worktree they are associated to.

Reported-by: Jeff King <peff@peff.net>
Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c  | 55 ++++++++++++++++++++++++++++++++++---------------
 t/t1450-fsck.sh | 35 +++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 17 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 24f8a09a3c..71492c158d 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -19,6 +19,7 @@
 #include "packfile.h"
 #include "object-store.h"
 #include "run-command.h"
+#include "worktree.h"
 
 #define REACHABLE 0x0001
 #define SEEN      0x0002
@@ -444,7 +445,11 @@ static int fsck_handle_reflog_ent(struct object_id *ooid, struct object_id *noid
 static int fsck_handle_reflog(const char *logname, const struct object_id *oid,
 			      int flag, void *cb_data)
 {
-	for_each_reflog_ent(logname, fsck_handle_reflog_ent, (void *)logname);
+	struct strbuf refname = STRBUF_INIT;
+
+	strbuf_worktree_ref(cb_data, &refname, logname);
+	for_each_reflog_ent(refname.buf, fsck_handle_reflog_ent, refname.buf);
+	strbuf_release(&refname);
 	return 0;
 }
 
@@ -482,20 +487,34 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid);
 
 static void get_default_heads(void)
 {
+	struct worktree **worktrees, **p;
 	const char *head_points_at;
 	struct object_id head_oid;
 
-	fsck_head_link(&head_points_at, &head_oid);
-	if (head_points_at && !is_null_oid(&head_oid))
-		fsck_handle_ref("HEAD", &head_oid, 0, NULL);
 	for_each_rawref(fsck_handle_ref, NULL);
-	if (include_reflogs)
-		for_each_reflog(fsck_handle_reflog, NULL);
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+		struct strbuf ref = STRBUF_INIT;
+
+		strbuf_worktree_ref(wt, &ref, "HEAD");
+		fsck_head_link(ref.buf, &head_points_at, &head_oid);
+		if (head_points_at && !is_null_oid(&head_oid))
+			fsck_handle_ref(ref.buf, &head_oid, 0, NULL);
+		strbuf_release(&ref);
+
+		if (include_reflogs)
+			refs_for_each_reflog(get_worktree_ref_store(wt),
+					     fsck_handle_reflog, wt);
+	}
+	free_worktrees(worktrees);
 
 	/*
 	 * Not having any default heads isn't really fatal, but
@@ -584,34 +603,36 @@ static void fsck_object_dir(const char *path)
 	stop_progress(&progress);
 }
 
-static int fsck_head_link(const char **head_points_at,
+static int fsck_head_link(const char *head_ref_name,
+			  const char **head_points_at,
 			  struct object_id *head_oid)
 {
 	int null_is_error = 0;
 
 	if (verbose)
-		fprintf(stderr, "Checking HEAD link\n");
+		fprintf(stderr, "Checking %s link\n", head_ref_name);
 
-	*head_points_at = resolve_ref_unsafe("HEAD", 0, head_oid, NULL);
+	*head_points_at = resolve_ref_unsafe(head_ref_name, 0, head_oid, NULL);
 	if (!*head_points_at) {
 		errors_found |= ERROR_REFS;
-		return error("Invalid HEAD");
+		return error("Invalid %s", head_ref_name);
 	}
-	if (!strcmp(*head_points_at, "HEAD"))
+	if (!strcmp(*head_points_at, head_ref_name))
 		/* detached HEAD */
 		null_is_error = 1;
 	else if (!starts_with(*head_points_at, "refs/heads/")) {
 		errors_found |= ERROR_REFS;
-		return error("HEAD points to something strange (%s)",
-			     *head_points_at);
+		return error("%s points to something strange (%s)",
+			     head_ref_name, *head_points_at);
 	}
 	if (is_null_oid(head_oid)) {
 		if (null_is_error) {
 			errors_found |= ERROR_REFS;
-			return error("HEAD: detached HEAD points at nothing");
+			return error("%s: detached HEAD points at nothing",
+				     head_ref_name);
 		}
-		fprintf(stderr, "notice: HEAD points to an unborn branch (%s)\n",
-			*head_points_at + 11);
+		fprintf(stderr, "notice: %s points to an unborn branch (%s)\n",
+			head_ref_name, *head_points_at + 11);
 	}
 	return 0;
 }
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 0f2dd26f74..e97e6a7c6d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -101,6 +101,41 @@ test_expect_success 'HEAD link pointing at a funny place' '
 	grep "HEAD points to something strange" out
 '
 
+test_expect_success 'HEAD link pointing at a funny object (from different wt)' '
+	test_when_finished "mv .git/SAVED_HEAD .git/HEAD" &&
+	test_when_finished "rm -rf .git/worktrees wt" &&
+	git worktree add wt &&
+	mv .git/HEAD .git/SAVED_HEAD &&
+	echo $ZERO_OID >.git/HEAD &&
+	# avoid corrupt/broken HEAD from interfering with repo discovery
+	test_must_fail git -C wt fsck 2>out &&
+	grep "main/HEAD: detached HEAD points" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at a funny object' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo $ZERO_OID >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	grep "worktrees/other/HEAD: detached HEAD points" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at missing object' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo "Contents missing from repo" | git hash-object --stdin >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	grep "worktrees/other/HEAD: invalid sha1 pointer" out
+'
+
+test_expect_success 'other worktree HEAD link pointing at a funny place' '
+	test_when_finished "rm -rf .git/worktrees other" &&
+	git worktree add other &&
+	echo "ref: refs/funny/place" >.git/worktrees/other/HEAD &&
+	test_must_fail git fsck 2>out &&
+	grep "worktrees/other/HEAD points to something strange" out
+'
+
 test_expect_success 'email without @ is okay' '
 	git cat-file commit HEAD >basis &&
 	sed "s/@/AT/" basis >okay &&
-- 
2.19.0.341.g3acb95d729

