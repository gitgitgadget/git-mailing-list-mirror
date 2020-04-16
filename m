Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13139C352BE
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9EF214AF
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 15:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALXBSviN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394915AbgDPPE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394909AbgDPPEX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 11:04:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ABFC061A0C
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:04:23 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id d17so5185089wrg.11
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 08:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GNubbwAzOO9SyK+N36JDsWCBCuiNySguwbHFoswbIRk=;
        b=ALXBSviN6z+4PHhb5Bj4u58qb8FzSQjbv1YteMoDOJencayZcZB7xEFJooOagxMAQP
         fzNZ4+cmBb/B2S86AIv9u7TNMZjqFESuTVh9moTdhtsWIa/nEfi/Lu/2CdEXKdnZ8OMS
         x5IVaIoSCbKO1szCrJJmrYJ+HljPIlz1sTNPPDuIOxc+hIzQqGQ/fKAfcWh/bumBU08l
         Sk6MIQCHQm09I5/GdBCcw8sgbBLa/5eY8DoFLiwuOq1zbb4wT3QTznGpMdwFkqLUFbJM
         OJLxYXH4cbiI3aKirGIY50U86Pa73N4jeG1HqCtmrGo7Xc+a9LkPlkMDSZhbOxAT5XR8
         0hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GNubbwAzOO9SyK+N36JDsWCBCuiNySguwbHFoswbIRk=;
        b=AIiopWw5izaxRHKLH17Y7ICHQopphWVnRkLmcK4LWqfwYy6vO587fuQclcHidH7Fex
         H+wNdJr7pIoETBhBpuPZRdS3Khre++Xsst1kErsticJonY/LjrBtUQKHNdOwXY2uHZgp
         H+ZJJVgD5WwGFcAPeVslVqP0grBXsjDbpSqJjxGbfCw/vbenYP0uJNlEk1OjD8AoaxVS
         NLyCpX8+bLRVqZQvgPaMuYMyL0J6NiIx2pGMfINuH8C15drTTDh6e5Tpx7o38zj7h7Qj
         u9r698bPuWqIfSYCuAY0zmdOK9ZIHqJBKv2MUKZBRgy6McktlHH3XYU6Z1fB98xTzFAo
         SRGg==
X-Gm-Message-State: AGi0PuYQMnWRqrH0y+XRNsETfVdo6PwQvkdIdw118hv+GKFRnwmKZ72h
        KavT/wHe+VhBpHeWDZ4WWgK+XaXGC3Q=
X-Google-Smtp-Source: APiQypI74St8GBQa8/561k0nUa+PMZlejM8zVVxhaqR5sbqcawiNb3jcmm6jSdBbYzE2Tb2slbX4yA==
X-Received: by 2002:adf:a509:: with SMTP id i9mr15430677wrb.20.1587049461429;
        Thu, 16 Apr 2020 08:04:21 -0700 (PDT)
Received: from localhost.localdomain (87-231-246-247.rev.numericable.fr. [87.231.246.247])
        by smtp.gmail.com with ESMTPSA id l5sm28033102wrm.66.2020.04.16.08.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:04:20 -0700 (PDT)
From:   Damien Robert <damien.olivier.robert@gmail.com>
X-Google-Original-From: Damien Robert <damien.olivier.robert+git@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: [PATCH v8 1/1] remote.c: fix handling of %(push:remoteref)
Date:   Thu, 16 Apr 2020 17:03:55 +0200
Message-Id: <20200416150355.635436-1-damien.olivier.robert+git@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200312164558.2388589-1-damien.olivier.robert+git@gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Looking at the value of %(push:remoteref) only handles the case when an
explicit push refspec is passed. But it does not handle the fallback
cases of looking at the configuration value of `push.default`.

In particular, doing something like

    git config push.default current
    git for-each-ref --format='%(push)'
    git for-each-ref --format='%(push:remoteref)'

prints a useful tracking ref for the first for-each-ref, but an empty
string for the second.

Since the intention of %(push:remoteref), from 9700fae5ee (for-each-ref:
let upstream/push report the remote ref name) is to get exactly which
branch `git push` will push to, even in the fallback cases, fix this.

To get the meaning of %(push:remoteref), `ref-filter.c` calls
`remote_ref_for_branch`. We simply add a new static helper function,
`branch_get_push_remoteref` that follows the logic of
`branch_get_push_1`, and call it from `remote_ref_for_branch`.

We also update t/6300-for-each-ref.sh to handle all `push.default`
strategies. This involves testing `push.default=simple` twice, once
where there is a matching upstream branch and once when there is none.

Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
---
 remote.c                | 94 +++++++++++++++++++++++++++++++----------
 t/t6300-for-each-ref.sh | 44 ++++++++++++++++---
 2 files changed, 111 insertions(+), 27 deletions(-)

diff --git a/remote.c b/remote.c
index c43196ec06..352ea240cd 100644
--- a/remote.c
+++ b/remote.c
@@ -516,28 +516,6 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit)
 	return remote_for_branch(branch, explicit);
 }
 
-const char *remote_ref_for_branch(struct branch *branch, int for_push)
-{
-	if (branch) {
-		if (!for_push) {
-			if (branch->merge_nr) {
-				return branch->merge_name[0];
-			}
-		} else {
-			const char *dst, *remote_name =
-				pushremote_for_branch(branch, NULL);
-			struct remote *remote = remote_get(remote_name);
-
-			if (remote && remote->push.nr &&
-			    (dst = apply_refspecs(&remote->push,
-						  branch->refname))) {
-				return dst;
-			}
-		}
-	}
-	return NULL;
-}
-
 static struct remote *remote_get_1(const char *name,
 				   const char *(*get_default)(struct branch *, int *))
 {
@@ -1656,6 +1634,64 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
+/**
+ * Return the local name of the remote tracking branch, as in
+ * %(push:remoteref), that corresponds to the ref we would push to given a
+ * bare `git push` while `branch` is checked out.
+ * See also branch_get_push_1 below.
+ */
+static const char *branch_get_push_remoteref(struct branch *branch)
+{
+	struct remote *remote;
+
+	remote = remote_get(pushremote_for_branch(branch, NULL));
+	if (!remote)
+		return NULL;
+
+	if (remote->push.nr) {
+		return apply_refspecs(&remote->push, branch->refname);
+	}
+
+	if (remote->mirror)
+		return branch->refname;
+
+	switch (push_default) {
+	case PUSH_DEFAULT_NOTHING:
+		return NULL;
+
+	case PUSH_DEFAULT_MATCHING:
+	case PUSH_DEFAULT_CURRENT:
+		return branch->refname;
+
+	case PUSH_DEFAULT_UPSTREAM:
+		if (branch && branch->merge && branch->merge[0] &&
+		    branch->merge[0]->dst)
+			return branch->merge[0]->src;
+		else
+			return NULL;
+
+	case PUSH_DEFAULT_UNSPECIFIED:
+	case PUSH_DEFAULT_SIMPLE:
+		{
+			const char *up, *cur;
+
+			up = branch_get_upstream(branch, NULL);
+			cur = tracking_for_push_dest(remote, branch->refname, NULL);
+			if (up && cur && !strcmp(cur, up))
+				return branch->refname;
+			else
+				return NULL;
+
+		}
+	}
+	BUG("unhandled push situation");
+}
+
+/**
+ * Return the tracking branch, as in %(push), that corresponds to the ref we
+ * would push to given a bare `git push` while `branch` is checked out.
+ * See also branch_get_push_remoteref above.
+ */
 static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
@@ -1735,6 +1771,20 @@ static int ignore_symref_update(const char *refname)
 	return (flag & REF_ISSYMREF);
 }
 
+const char *remote_ref_for_branch(struct branch *branch, int for_push)
+{
+	if (branch) {
+		if (!for_push) {
+			if (branch->merge_nr) {
+				return branch->merge_name[0];
+			}
+		} else {
+			return branch_get_push_remoteref(branch);
+		}
+	}
+	return NULL;
+}
+
 /*
  * Create and return a list of (struct ref) consisting of copies of
  * each remote_ref that matches refspec.  refspec must be a pattern.
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index b3c1092338..c89fd66083 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -875,12 +875,46 @@ test_expect_success ':remotename and :remoteref' '
 			git for-each-ref --format="${pair%=*}" \
 				refs/heads/master >actual &&
 			test_cmp expect actual
-		done &&
-		git branch push-simple &&
-		git config branch.push-simple.pushRemote from &&
-		actual="$(git for-each-ref \
+		done
+	)
+'
+
+test_expect_success ':push:remoteref' '
+	git init push-tests &&
+	(
+		cd push-tests &&
+		test_commit initial &&
+		git remote add from fifth.coffee:blub &&
+		git config branch.master.remote from &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/master)" &&
+		test from, = "$actual" &&
+		git config branch.master.merge refs/heads/master &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/master)" &&
+		test from,refs/heads/master = "$actual" &&
+		git config branch.master.merge refs/heads/other &&
+		actual="$(git -c push.default=simple for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/master)" &&
+		test from, = "$actual" &&
+		actual="$(git -c push.default=upstream for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/master)" &&
+		test from,refs/heads/other = "$actual" &&
+		actual="$(git -c push.default=current for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/master)" &&
+		test from,refs/heads/master = "$actual" &&
+		actual="$(git -c push.default=matching for-each-ref \
+			--format="%(push:remotename),%(push:remoteref)" \
+			refs/heads/master)" &&
+		test from,refs/heads/master = "$actual" &&
+		actual="$(git -c push.default=nothing for-each-ref \
 			--format="%(push:remotename),%(push:remoteref)" \
-			refs/heads/push-simple)" &&
+			refs/heads/master)" &&
 		test from, = "$actual"
 	)
 '
-- 
Patched on top of v2.26.1-107-gefe3874640 (git version 2.26.0)

