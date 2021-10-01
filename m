Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C42C433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BD66134F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353381AbhJAKHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353305AbhJAKGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:55 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED6C06177C
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:11 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u18so14617640wrg.5
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VcfVJ4dV5con/lrNmc4N1kdzm1Xh75SKejjks+zK+lw=;
        b=QzIXQgmNTprvCm96UQVunfjEylqQ5v3liHMomXfXn9ZyBXspQoM31NdWeXSSCtyI+P
         xwf6kRGQHALrnU7TrD5Nwc/plkb3juw+mcsXa7DWGh28EWJktJSDMjTyB4ITEU2mEddI
         0L/9N/nDHHo6SFrnHpnmVtG5TOPmMBBn6uzG1d7/gMyE7zRwmGEHY6iQaIJBeujDtQBD
         r0eQmV3zYfipV3uEulKInItuTJIFgHcdyg6e+t95bHiJdOfZySEGDQCRpu+9z4Sk2klO
         Qr+xzPJt3QcBlVKa2BwCcUpdoKLmMlHRDVQ1ZWCJrDU25K36SmLzgW7jxsJrUCgzfEYu
         dUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VcfVJ4dV5con/lrNmc4N1kdzm1Xh75SKejjks+zK+lw=;
        b=NQZnPW/zwqVoALsNSxu9+G4eZYCzi8QaH9YoGsWvu9mwVi5IGY2YLbgZuY258WA3rm
         7Dn4o9N1uESPw6x6apGICMQDtobGlWzc7ousFCw9Q30KivC2kdavrKf1j9H59bjUTzM4
         MnVqxW47GvjW57/3FwIyuc6CXEypV7caFP7y7v5pwCcOnTPjKH2c9jqJ9zgJvYSLQjDi
         tII2rPpMya4DO1jRZO0hy8TqXAkDNYUzD8U9J6AF3SVW/7W07usClasMJYOtO6awTado
         E439jl9k6/iCuJG6SWoXmtWmBpgCasY9Xz6T7HAN+XG933+QW5yTjp7cOh4vZIS8j5s0
         zxJQ==
X-Gm-Message-State: AOAM5337CMUzngkOLCi4MORDFjOPwLlIi99FqXYSZgxItaTDd+ikTJ6g
        YiyGgm4B2ln+lbadlHplpNvFS5nM5sY=
X-Google-Smtp-Source: ABdhPJyTv1+FstI3urzRv7GxIjDRgXtBdvtUy8LYIpfRGSN1sFCaVBdjXQOfkJFNuKW6UyENGeWTVg==
X-Received: by 2002:a5d:6d03:: with SMTP id e3mr11111920wrq.383.1633082709844;
        Fri, 01 Oct 2021 03:05:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15sm5443550wrg.58.2021.10.01.03.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:09 -0700 (PDT)
Message-Id: <cdb0de221d56d7087146a43a393cffd66c06a5e8.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:05:00 +0000
Subject: [PATCH 09/11] rebase --apply: fix reflog
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

move_to_original_branch() passes the message intended for the branch
reflog as `orig_head_msg`. Fix this by adding a `branch_msg` member to
struct reset_head_opts and add a regression test.  Note that these
reflog messages do not respect GIT_REFLOG_ACTION. They are not alone
in that and will be fixed in a future series.

The "merge" backend already has tests that check both the branch and
HEAD reflogs.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          |  8 ++++----
 reset.c                   | 12 ++++++++++--
 reset.h                   |  2 ++
 t/t3406-rebase-message.sh | 23 +++++++++++++++++++++++
 4 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index ae5de271e9a..c40a8b843f4 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -776,7 +776,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 
 static int move_to_original_branch(struct rebase_options *opts)
 {
-	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
+	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
 	struct reset_head_opts ropts = { 0 };
 	int ret;
 
@@ -786,17 +786,17 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&orig_head_reflog, "rebase finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
-	ropts.orig_head_msg = orig_head_reflog.buf;
+	ropts.branch_msg = branch_reflog.buf;
 	ropts.head_msg = head_reflog.buf;
 	ret = reset_head(the_repository, &ropts);
 
-	strbuf_release(&orig_head_reflog);
+	strbuf_release(&branch_reflog);
 	strbuf_release(&head_reflog);
 	return ret;
 }
diff --git a/reset.c b/reset.c
index e77a8ac423d..2c32600234d 100644
--- a/reset.c
+++ b/reset.c
@@ -15,6 +15,7 @@ static int update_refs(const struct reset_head_opts *opts,
 	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
 	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
 	const char *switch_to_branch = opts->branch;
+	const char *reflog_branch = opts->branch_msg;
 	const char *reflog_head = opts->head_msg;
 	const char *reflog_orig_head = opts->orig_head_msg;
 	const char *default_reflog_action = opts->default_reflog_action;
@@ -58,8 +59,9 @@ static int update_refs(const struct reset_head_opts *opts,
 				 detach_head ? REF_NO_DEREF : 0,
 				 UPDATE_REFS_MSG_ON_ERR);
 	else {
-		ret = update_ref(reflog_head, switch_to_branch, oid,
-				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+		ret = update_ref(reflog_branch ? reflog_branch : reflog_head,
+				 switch_to_branch, oid, NULL, 0,
+				 UPDATE_REFS_MSG_ON_ERR);
 		if (!ret)
 			ret = create_symref("HEAD", switch_to_branch,
 					    reflog_head);
@@ -90,6 +92,12 @@ int reset_head(struct repository *r, const struct reset_head_opts *opts)
 	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
 		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
 
+	if (opts->orig_head_msg && !update_orig_head)
+		BUG("ORIG_HEAD reflog message given without updating ORIG_HEAD");
+
+	if (opts->branch_msg && !opts->branch)
+		BUG("branch reflog message given without a branch");
+
 	if (!refs_only && repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
 		goto leave_reset_head;
diff --git a/reset.h b/reset.h
index 996d7f569b6..c0f4e99a3be 100644
--- a/reset.h
+++ b/reset.h
@@ -19,6 +19,8 @@ struct reset_head_opts {
 	const char *branch;
 	/* Flags defined above */
 	unsigned flags;
+	 /* Optional reflog message for branch, defaults to head_msg. */
+	const char *branch_msg;
 	 /*
 	  * Optional reflog message for HEAD, if this is not set then
 	  * default_reflog_action must be.
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 77a313f62eb..d17b450e811 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -105,6 +105,29 @@ test_expect_success 'GIT_REFLOG_ACTION' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --apply reflog' '
+	git checkout -b reflog-apply start &&
+	old_head_reflog="$(git log -g --format=%gs -1 HEAD)" &&
+
+	git rebase --apply Y &&
+
+	git log -g --format=%gs -4 HEAD >actual &&
+	cat >expect <<-EOF &&
+	rebase finished: returning to refs/heads/reflog-apply
+	rebase: Z
+	rebase: checkout Y
+	$old_head_reflog
+	EOF
+	test_cmp expect actual &&
+
+	git log -g --format=%gs -2 reflog-apply >actual &&
+	cat >expect <<-EOF &&
+	rebase finished: refs/heads/reflog-apply onto $(git rev-parse Y)
+	branch: Created from start
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase -i onto unrelated history' '
 	git init unrelated &&
 	test_commit -C unrelated 1 &&
-- 
gitgitgadget

