Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D5131FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762590AbdDSLDI (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:03:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35970 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762583AbdDSLDE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:03:04 -0400
Received: by mail-pf0-f194.google.com with SMTP id v14so2088157pfd.3
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1HnRU+E3wHL4WJ6TGkjKmRDf6SQwLvEjMmSS3kIyis=;
        b=E7qzRYOpJPaaLP3Ksv54EpY1e6TDiFg7y2QJ7NJhVIqfOJWzKffrSiC5R+Q/xGO8ot
         sJcdYVTQgcbvNfyRWIan+QaBbZiy5xaQtPG4bwFxxpKnuLm8Nj91WA3kQcHid0ApllDZ
         dj82GpVa41fvWagF3dydsO3g4a3cTmscu+Uqef2z5PXCKgS+GYUqKTBKAbArKkCeoPzI
         zBXxwoMvR+n586u7Nf3uIsfmvuxknwrAzPNhR4RUqGh1+5tkhYeha3ixvGopdKxYSTew
         mTEiauxyEVsWnT+42vVzQNAhcWGs1vkKtE3cUK8OU//LEjfekEWskE/Mn1hni97TroEa
         ZErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1HnRU+E3wHL4WJ6TGkjKmRDf6SQwLvEjMmSS3kIyis=;
        b=igLu+WzBcSSHTaypsuKUGZtqmnyvnHRrY23CiS0ahQLR+vSfdYTKumSzlj5X9GxZ4+
         QKW//yP1kq6Xlvo9eye8zebtxgiNfXXmqo4k7M+Mdvo+IsOEpPLkneOfGY18ngJZkYUp
         qLnwnuXBmQHMUPzFDYpz3+0dUYFLHu1bAaCtswVakXjtyXepQ8I1uxruSpmFaYPTdp5H
         QthqqT3dZu4lwOBmvEzjZTgNkH5mRpeP92jkF+LpQKDEa3og3zj5u68i4XoQ4qf29JKB
         +Z5SDCgOthTGLRxJanXH/b/oiA3uTJcBqYzkGQ5lal55qQaCWiGFLRF0d0Ztd1LilnPt
         9YQA==
X-Gm-Message-State: AN3rC/50VdukhN0Df94HJwsTT/yNX0ZJw5bhxfvjQSSlgitvA5LC+KuX
        0WsPWtDuPp71Vg==
X-Received: by 10.99.125.18 with SMTP id y18mr2614359pgc.32.1492599784251;
        Wed, 19 Apr 2017 04:03:04 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id 206sm3963821pfu.132.2017.04.19.04.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:03:03 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:02:58 +0700
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
Subject: [PATCH v3 11/12] revision.c: --reflog add HEAD reflog from all worktrees
Date:   Wed, 19 Apr 2017 18:01:44 +0700
Message-Id: <20170419110145.5086-12-pclouds@gmail.com>
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

Note that add_other_reflogs_to_pending() is a bit inefficient, since
it scans reflog for all refs of each worktree, including shared refs,
so the shared ref's reflog is scanned over and over again.

We could update refs API to pass "per-worktree only" flag to avoid
that. But long term we should be able to obtain a "per-worktree only"
ref store and would need to revert the changes in reflog iteration
API. So let's just wait until then.

add_reflogs_to_pending() is called by reachable.c so by default "git
prune" will examine reflog from all worktrees.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c       | 28 +++++++++++++++++++++++++++-
 t/t5304-prune.sh | 16 ++++++++++++++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 040a0064f6..f4bc9bc65c 100644
--- a/revision.c
+++ b/revision.c
@@ -1134,6 +1134,7 @@ struct all_refs_cb {
 	int warned_bad_reflog;
 	struct rev_info *all_revs;
 	const char *name_for_errormsg;
+	struct ref_store *refs;
 };
 
 int ref_excluded(struct string_list *ref_excludes, const char *path)
@@ -1169,6 +1170,7 @@ static void init_all_refs_cb(struct all_refs_cb *cb, struct rev_info *revs,
 {
 	cb->all_revs = revs;
 	cb->all_flags = flags;
+	cb->refs = NULL;
 }
 
 void clear_ref_exclusion(struct string_list **ref_excludes_p)
@@ -1237,17 +1239,41 @@ static int handle_one_reflog(const char *path, const struct object_id *oid,
 	struct all_refs_cb *cb = cb_data;
 	cb->warned_bad_reflog = 0;
 	cb->name_for_errormsg = path;
-	for_each_reflog_ent(path, handle_one_reflog_ent, cb_data);
+	refs_for_each_reflog_ent(cb->refs, path,
+				 handle_one_reflog_ent, cb_data);
 	return 0;
 }
 
+static void add_other_reflogs_to_pending(struct all_refs_cb *cb)
+{
+	struct worktree **worktrees, **p;
+
+	worktrees = get_worktrees(0);
+	for (p = worktrees; *p; p++) {
+		struct worktree *wt = *p;
+
+		if (wt->is_current)
+			continue;
+
+		cb->refs = get_worktree_ref_store(wt);
+		refs_for_each_reflog(cb->refs,
+				     handle_one_reflog,
+				     cb);
+	}
+	free_worktrees(worktrees);
+}
+
 void add_reflogs_to_pending(struct rev_info *revs, unsigned flags)
 {
 	struct all_refs_cb cb;
 
 	cb.all_revs = revs;
 	cb.all_flags = flags;
+	cb.refs = get_main_ref_store();
 	for_each_reflog(handle_one_reflog, &cb);
+
+	if (!revs->single_worktree)
+		add_other_reflogs_to_pending(&cb);
 }
 
 static void add_cache_tree(struct cache_tree *it, struct rev_info *revs,
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 683bdb031c..6694c19a1e 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -304,4 +304,20 @@ test_expect_success 'prune: handle HEAD in multiple worktrees' '
 	test_cmp third-worktree/blob actual
 '
 
+test_expect_success 'prune: handle HEAD reflog in multiple worktrees' '
+	git config core.logAllRefUpdates true &&
+	echo "lost blob for third-worktree" >expected &&
+	(
+		cd third-worktree &&
+		cat ../expected >blob &&
+		git add blob &&
+		git commit -m "second commit in third" &&
+		git reset --hard HEAD^
+	) &&
+	git prune --expire=now &&
+	SHA1=`git hash-object expected` &&
+	git -C third-worktree show "$SHA1" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.11.0.157.gd943d85

