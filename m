Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F10CCA482
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378275AbiFHCqk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383658AbiFHCiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:38:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4DB1F0A45
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so25689072wrg.12
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wUaY4m6wy616wCD/syXAC0m5N0p0jPsQ4bTjvZ2waTE=;
        b=lejIyonSwF8IqOndXWtGDlo7yRBpd67c7rXOBpMcJzL5LfRdyG3S1i1TsBcOUtWgNF
         g3PNqfPfjKH3oPJKpXCs1o68E89RTIYpERFgs9Qmv8yEMjngi0FY9WvbIyM1ZYKOcwoR
         9+RJ9pA5QVdAO0pWc8r7vXPDCqvatySBBrNyMjUARWf7V2yqEoXOVCjIp4uqnJ++3GC0
         8KE34e1gbi5IHHGwwxPREusfocZK73RZJ/Pv5vPEnxrjwTNDE4gFj316o/9qY0oozLyE
         PY58ohYqlDZEpbqU5wTacwQvS2OgNZkkIrN2ALjRPF4K7hSM0nNmOnmR2h5SXClAmkiP
         2AhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wUaY4m6wy616wCD/syXAC0m5N0p0jPsQ4bTjvZ2waTE=;
        b=Zb/yLHIXX+4JPzKK4ApyqGk5rJO6hVjwN2oQJFoqjTsixaXwCLP6eR4+ROM4dM3OxT
         uEvtPTjIeSRc0C7478VYi//O6yRJyGXUMRY1Y9VzRdFvtuwceWl2j6wQrMz2PoYH+Usi
         1IkA3izMNiN2tM8SoAPd1I1Xo80lqetPu6n+3XLv5khsOIKbaxWK4KNVc4p1wQRtffLU
         KkoefG0Kp6bVbQPJ8dVNuPopK+la3nUlqSbJITdzmgvpppOV+LFNoKzb35qZql/TFSB/
         Dn9wz+vVhUJbZpfVGDqWaNwsj2o3ASEmOSLi2mjn68MUDPDgFYYWQddZdkogwbEdjMzX
         Ptlg==
X-Gm-Message-State: AOAM531O0b/qBn18nuTXSs0kgjK8MLPo9KdXzv6qJs0pgyCLiII0BRF6
        Mf5RO67M7aLd0YEnBgr4znHicKcfxhp3MRzr
X-Google-Smtp-Source: ABdhPJxzHaru2ttN6e8+czq4G+VRJfnS/SVrUFbhD5GA4MFujN3CbLr05ulQ5fEkLr78JmsFGqhxaQ==
X-Received: by 2002:a5d:6da2:0:b0:20f:d9b6:fc6 with SMTP id u2-20020a5d6da2000000b0020fd9b60fc6mr28778992wrs.479.1654634578137;
        Tue, 07 Jun 2022 13:42:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m125-20020a1ca383000000b0039c5b4ab1b0sm2326931wme.48.2022.06.07.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:57 -0700 (PDT)
Message-Id: <68f8e51b19c024e1cb075dffd07f81cceaba5957.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:48 +0000
Subject: [PATCH v2 6/7] sequencer: implement 'update-refs' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change allowed 'git rebase --update-refs' to create 'label'
commands for each branch  among the commits being rewritten and add an
'update-refs' command at the end of the todo list. Now, teach Git to
update the refs during that final 'update-refs' command.

We need to create an array of new and old OIDs for each ref by iterating
over the refs/rewritten/for-update-refs/ namespace. We cannot update the
refs in-place since this will confuse the refs iterator.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 sequencer.c                   | 62 ++++++++++++++++++++++++++++++++++-
 t/t3404-rebase-interactive.sh | 24 ++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 94f8d52e041..a8f62ce8e5f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4061,11 +4061,71 @@ leave_merge:
 	return ret;
 }
 
-static int do_update_refs(struct repository *r)
+struct update_refs_context {
+	struct ref_store *refs;
+	char **ref_names;
+	struct object_id *old;
+	struct object_id *new;
+	size_t nr;
+	size_t alloc;
+};
+
+static int add_ref_to_context(const char *refname,
+			      const struct object_id *oid,
+			      int flags,
+			      void *data)
 {
+	int f = 0;
+	const char *name;
+	struct update_refs_context *ctx = data;
+
+	ALLOC_GROW(ctx->ref_names, ctx->nr + 1, ctx->alloc);
+	ALLOC_GROW(ctx->old, ctx->nr + 1, ctx->alloc);
+	ALLOC_GROW(ctx->new, ctx->nr + 1, ctx->alloc);
+
+	if (!skip_prefix(refname, "refs/rewritten/for-update-refs/", &name))
+		return 1;
+
+	ctx->ref_names[ctx->nr] = xstrdup(name);
+	oidcpy(&ctx->new[ctx->nr], oid);
+	if (!refs_resolve_ref_unsafe(ctx->refs, name, 0,
+				     &ctx->old[ctx->nr], &f))
+		return 1;
+
+	ctx->nr++;
 	return 0;
 }
 
+static int do_update_refs(struct repository *r)
+{
+	int i, res;
+	struct update_refs_context ctx = {
+		.refs = get_main_ref_store(r),
+		.alloc = 16,
+	};
+	ALLOC_ARRAY(ctx.ref_names, ctx.alloc);
+	ALLOC_ARRAY(ctx.old, ctx.alloc);
+	ALLOC_ARRAY(ctx.new, ctx.alloc);
+
+	res = refs_for_each_fullref_in(ctx.refs,
+				       "refs/rewritten/for-update-refs/",
+				       add_ref_to_context,
+				       &ctx);
+
+	for (i = 0; !res && i < ctx.nr; i++)
+		res = refs_update_ref(ctx.refs, "rewritten during rebase",
+				ctx.ref_names[i],
+				&ctx.new[i], &ctx.old[i],
+				0, UPDATE_REFS_MSG_ON_ERR);
+
+	for (i = 0; i < ctx.nr; i++)
+		free(ctx.ref_names[i]);
+	free(ctx.ref_names);
+	free(ctx.old);
+	free(ctx.new);
+	return res;
+}
+
 static int is_final_fixup(struct todo_list *todo_list)
 {
 	int i = todo_list->current;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 5e99ad7f3b6..72711efec28 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1815,6 +1815,30 @@ test_expect_success '--update-refs adds commands with --rebase-merges' '
 	)
 '
 
+compare_two_refs () {
+	git rev-parse $1 >expect &&
+	git rev-parse $2 >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success '--update-refs updates refs correctly' '
+	git checkout -B update-refs no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	test_commit extra2 fileX &&
+	git commit --amend --fixup=L &&
+	(
+		git rebase -i --autosquash --update-refs primary &&
+
+		compare_two_refs HEAD~3 refs/heads/first &&
+		compare_two_refs HEAD~3 refs/heads/second &&
+		compare_two_refs HEAD~1 refs/heads/third &&
+		compare_two_refs HEAD refs/heads/no-conflict-branch
+	)
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

