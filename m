Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91F411FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762588AbdDSLDG (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:03:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33629 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762582AbdDSLDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:03:04 -0400
Received: by mail-pg0-f66.google.com with SMTP id 63so3597080pgh.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YZAanVWYtJEvlZpUrRCTMglkIKC8RxzfJvXGnFbzhpI=;
        b=K7/iIvmyLEacmerEdZIeLoKUo/vpnY6AeT5rEPLf8/RBagHdlMskHifYOZNVdjWfFw
         crKnjSV0bIhDS7+trDkz9bsl+wDtVIexgwggfHdjb8EGYzB9c1KHLXu1WKczw/Roc374
         hdLhLVMZmnhf42CeLnki8hR0sbx4x8BBaqMytgEWBEiQGvAOyLHGlULNxJ9o0h3769BU
         g4gABJSA4X4EsjgnYiUHQBHnQ8PnZ04dSZ4JsmPM9T+/bYxwxWGGvi7IJ81mkmsQldLz
         L254/jyAwFc7MwihOThIHGcSLHpkbZFBxROwOs+C0BwD6D8NNOymXZ/KovKmQArXWTY9
         AIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YZAanVWYtJEvlZpUrRCTMglkIKC8RxzfJvXGnFbzhpI=;
        b=PBUQPwS8LuTPD9AdfmlmiQ+9dDfMhoHGp2aGmFR7rAJobXUUqqITg6U1oNNnjeZXdB
         auP6nkILFdHhpFW9NHMWmYgleMfYml9hDiPwhwSrC4vbGxI5vtJ+wSv/YkfPjOW6H3SP
         lhKBz+ucMJ9DoUE5LW290kgV2PXLvyryF3+l90kp5Vzv+Ye7R9aEHM9NQF/UkK0skEgi
         ag207cCw4WIBxs5l/7wS75hzX01WjoUTiqNafVDfbcUoXnXf42XSagrszb4kR0zs6qM/
         EoNY6kJOM6kp+038G5IA4qG8hVj1DQvZEfi36kPsKAfm4jinnOI9JK5pH08BkCDtN5oE
         4W4A==
X-Gm-Message-State: AN3rC/6E5WI43igJGjf1kgadPCinSX+GZUWK2VvwAngh96n8Z2I1TUbC
        eorGWsagVDV7SA==
X-Received: by 10.98.138.150 with SMTP id o22mr2476826pfk.69.1492599778480;
        Wed, 19 Apr 2017 04:02:58 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id p16sm4024843pgc.4.2017.04.19.04.02.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:02:57 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 10/12] files-backend: make reflog iterator go through per-worktree reflog
Date:   Wed, 19 Apr 2017 18:01:43 +0700
Message-Id: <20170419110145.5086-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170419110145.5086-1-pclouds@gmail.com>
References: <20170419110145.5086-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

refs/bisect is unfortunately per-worktree, so we need to look in
per-worktree logs/refs/bisect in addition to per-repo logs/refs. The
current iterator only goes through per-repo logs/refs.

Ideally we should have something like merge_ref_iterator_begin (and
maybe with a predicate), but for dir_iterator. Since there's only one
use case for this pattern, let's not add a bunch more code for
merge_dir_iterator_begin just yet.

PS. Note the unsorted order of for_each_reflog in the test. This is
supposed to be OK, for now. If we enforce order on for_each_reflog()
then some more work will be required.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c          | 46 ++++++++++++++++++++++++++++++++-----------
 t/t1407-worktree-ref-store.sh | 30 ++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4149943a6e..fce380679c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1171,15 +1171,6 @@ static void files_reflog_path(struct files_ref_store *refs,
 			      struct strbuf *sb,
 			      const char *refname)
 {
-	if (!refname) {
-		/*
-		 * FIXME: of course this is wrong in multi worktree
-		 * setting. To be fixed real soon.
-		 */
-		strbuf_addf(sb, "%s/logs", refs->gitcommondir);
-		return;
-	}
-
 	switch (ref_type(refname)) {
 	case REF_TYPE_PER_WORKTREE:
 	case REF_TYPE_PSEUDOREF:
@@ -3368,6 +3359,7 @@ struct files_reflog_iterator {
 
 	struct ref_store *ref_store;
 	struct dir_iterator *dir_iterator;
+	struct dir_iterator *worktree_dir_iterator;
 	struct object_id oid;
 };
 
@@ -3388,6 +3380,21 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
+		if (iter->worktree_dir_iterator) {
+			const char *refname = diter->relative_path;
+
+			switch (ref_type(refname)) {
+			case REF_TYPE_PER_WORKTREE:
+			case REF_TYPE_PSEUDOREF:
+				continue;
+			case REF_TYPE_NORMAL:
+				break;
+			default:
+				die("BUG: unknown ref type %d of ref %s",
+				    ref_type(refname), refname);
+			}
+		}
+
 		if (refs_read_ref_full(iter->ref_store,
 				       diter->relative_path, 0,
 				       iter->oid.hash, &flags)) {
@@ -3401,7 +3408,11 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		return ITER_OK;
 	}
 
-	iter->dir_iterator = NULL;
+	iter->dir_iterator = iter->worktree_dir_iterator;
+	if (iter->worktree_dir_iterator) {
+		iter->worktree_dir_iterator = NULL;
+		return files_reflog_iterator_advance(ref_iterator);
+	}
 	if (ref_iterator_abort(ref_iterator) == ITER_ERROR)
 		ok = ITER_ERROR;
 	return ok;
@@ -3422,6 +3433,12 @@ static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
 	if (iter->dir_iterator)
 		ok = dir_iterator_abort(iter->dir_iterator);
 
+	if (iter->worktree_dir_iterator) {
+		int ok2 = dir_iterator_abort(iter->worktree_dir_iterator);
+		if (ok2 == ITER_ERROR)
+			ok = ok2;
+	}
+
 	base_ref_iterator_free(ref_iterator);
 	return ok;
 }
@@ -3442,10 +3459,17 @@ static struct ref_iterator *files_reflog_iterator_begin(struct ref_store *ref_st
 	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable);
-	files_reflog_path(refs, &sb, NULL);
+	strbuf_addf(&sb, "%s/logs", refs->gitcommondir);
 	iter->dir_iterator = dir_iterator_begin(sb.buf);
 	iter->ref_store = ref_store;
 	strbuf_release(&sb);
+
+	if (strcmp(refs->gitdir, refs->gitcommondir)) {
+		strbuf_addf(&sb, "%s/logs", refs->gitdir);
+		iter->worktree_dir_iterator = dir_iterator_begin(sb.buf);
+		strbuf_release(&sb);
+	}
+
 	return ref_iterator;
 }
 
diff --git a/t/t1407-worktree-ref-store.sh b/t/t1407-worktree-ref-store.sh
index 5df06f3556..8842d0329f 100755
--- a/t/t1407-worktree-ref-store.sh
+++ b/t/t1407-worktree-ref-store.sh
@@ -49,4 +49,34 @@ test_expect_success 'create_symref(FOO, refs/heads/master)' '
 	test_cmp expected actual
 '
 
+test_expect_success 'for_each_reflog()' '
+	echo $_z40 > .git/logs/PSEUDO-MAIN &&
+	mkdir -p     .git/logs/refs/bisect &&
+	echo $_z40 > .git/logs/refs/bisect/random &&
+
+	echo $_z40 > .git/worktrees/wt/logs/PSEUDO-WT &&
+	mkdir -p     .git/worktrees/wt/logs/refs/bisect &&
+	echo $_z40 > .git/worktrees/wt/logs/refs/bisect/wt-random &&
+
+	$RWT for-each-reflog | cut -c 42- | sort >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	PSEUDO-WT 0x0
+	refs/bisect/wt-random 0x0
+	refs/heads/master 0x0
+	refs/heads/wt-master 0x0
+	EOF
+	test_cmp expected actual &&
+
+	$RMAIN for-each-reflog | cut -c 42- | sort >actual &&
+	cat >expected <<-\EOF &&
+	HEAD 0x1
+	PSEUDO-MAIN 0x0
+	refs/bisect/random 0x0
+	refs/heads/master 0x0
+	refs/heads/wt-master 0x0
+	EOF
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

