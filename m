Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9AEC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 23:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiFBXLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 19:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237072AbiFBXLx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 19:11:53 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276B7FC6
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 16:11:51 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id p2-20020a170902e74200b00164081f682cso3357181plf.16
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SFHHctJUyQ218uk2LN6PTKf7y4nAankHGCv9Ht915lc=;
        b=Otwt1xnNMPgkfplrxAgUXP9pV74Xrxn1xNrIgV3CeQ7xpbHiD1f3IOKAQ3CIW1G8pn
         zidQGdCsUCtFiOcHDUv0vaJ7a/OG4z1wEaEjYI3ow64r6F9nOJGCOeE0Dg3n9RkqHbPn
         52d6m7XAbolQhTSn4mYZ5XWBB0txNFcCOYF1IFM92k6pXeQ+aodeTfe4ILr59SCrOcQx
         fkymjCGqBEEZKBxjArN/7kZ3dtl6/aNcwvdtg2bk78vFauuZOm2PoQ6qzBi7BfBm2fx+
         rfbozccS8OzM5EhuucqxWFyUkVWrfl/H06Wct1cmielgyg4V9tSGqiqRkkaSEr5yKczO
         mwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SFHHctJUyQ218uk2LN6PTKf7y4nAankHGCv9Ht915lc=;
        b=wG0XzV7i5oSF9nGSgfs6Toqi/ntT+TPn6QcbeF0dEkXlvayVcDwhdyDw1XY0oRz5gL
         CgjyrzgMz1rOjfkWsoN5InDyNM5wULrRUtg+RWgP52tQIo7Ojl03B5PY+TI5z0OGNm9l
         6XYLxhsqyFYQB2rBduZq2saaIk2aptfJSfIxISd+wNZUoJxOHHAw/DZglyPVkkoml4sJ
         eML34E60tyfZXe77iAt5ReFcjLw3rl+shjNzQ4aT2iD8y9y+Uj9x1SKWp1nM/3CijOrC
         FTRhC1gRwPIDi08lglwu0yMxSjMo5rG25+eqJUohqeqq6I6s0gbMVJlLwsTKJ3IzbXIf
         koIg==
X-Gm-Message-State: AOAM532jPZisbVxwKuUk1tr3P2buu9weoOo66wIRU0EjumTtocaOrty3
        flUYqUF42Dwo1lKc/XkEn+hIwlfd+NlmTU14INK5Pabjy7SrB62XPhg5o46pvsdTBWJmznFQTAx
        uFuHY4tHuoXVfxgqXi/BAn6QaNw/uFmETMdX2wRJF7T+Yqcvptq7/a8X9qJfxu2tWoqR8nDqrWJ
        yQ
X-Google-Smtp-Source: ABdhPJyyMCzzJdhKlufrPN27pOPXMxCxabN9DcctZzPQnkU8kL28bAe3MHMgSxZNvs7ThTb6AtUuU/ogMaQPeiRBEA+m
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6a00:164c:b0:50a:472a:6b0a with
 SMTP id m12-20020a056a00164c00b0050a472a6b0amr7409734pfc.77.1654211510440;
 Thu, 02 Jun 2022 16:11:50 -0700 (PDT)
Date:   Thu,  2 Jun 2022 16:11:45 -0700
In-Reply-To: <20220323210803.1130790-1-jonathantanmy@google.com>
Message-Id: <20220602231145.310564-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220323210803.1130790-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2] commit,shallow: unparse commits if grafts changed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, derrickstolee@github.com,
        me@ttaylorr.com, gitster@pobox.com, bagasdotme@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a commit is parsed, it pretends to have a different (possibly
empty) list of parents if there is graft information for that commit.
But there is a bug that could occur when a commit is parsed, the graft
information is updated (for example, when a shallow file is rewritten),
and the same commit is subsequently used: the parents of the commit do
not conform to the updated graft information, but the information at the
time of parsing.

This is usually not an issue, as a commit is usually introduced into the
repository at the same time as its graft information. That means that
when we try to parse that commit, we already have its graft information.

But it is an issue when fetching a shallow point directly into a
repository with submodules. The function
assign_shallow_commits_to_refs() parses all sought objects (including
the shallow point, which we are directly fetching). In update_shallow()
in fetch-pack.c, assign_shallow_commits_to_refs() is called before
commit_shallow_file(), which means that the shallow point would have
been parsed before graft information is updated. Once a commit is
parsed, it is no longer sensitive to any graft information updates. This
parsed commit is subsequently used when we do a revision walk to search
for submodules to fetch, meaning that the commit is considered to have
parents even though it is a shallow point (and therefore should be
treated as having no parents).

Therefore, whenever graft information is updated, mark the commits that
were previously grafts and the commits that are newly grafts as
unparsed.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Thanks, once again, for all your comments.

I finally had time to get back to this. I've used the unparsing idea
that several people mentioned, and found a simpler test case that
reproduces the issue. (Well, simpler to read, but not simpler to
find...)

It has been a while since v1, so this is on master. (The branch
mentioned in v1, jt/reset-grafts-when-resetting-shallow, has since been
merged to master.)
---
 commit.c                 | 16 +++++++++++++++-
 shallow.c                |  7 +++++++
 t/t5537-fetch-shallow.sh |  9 +++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index 59b6c3e455..1537ea73d0 100644
--- a/commit.c
+++ b/commit.c
@@ -120,6 +120,17 @@ int commit_graft_pos(struct repository *r, const struct object_id *oid)
 		       commit_graft_oid_access);
 }
 
+static void unparse_commit(struct repository *r, const struct object_id *oid)
+{
+	struct commit *c = lookup_commit(r, oid);
+
+	if (!c->object.parsed)
+		return;
+	free_commit_list(c->parents);
+	c->parents = NULL;
+	c->object.parsed = 0;
+}
+
 int register_commit_graft(struct repository *r, struct commit_graft *graft,
 			  int ignore_dups)
 {
@@ -145,6 +156,7 @@ int register_commit_graft(struct repository *r, struct commit_graft *graft,
 			(r->parsed_objects->grafts_nr - pos - 1) *
 			sizeof(*r->parsed_objects->grafts));
 	r->parsed_objects->grafts[pos] = graft;
+	unparse_commit(r, &graft->oid);
 	return 0;
 }
 
@@ -253,8 +265,10 @@ void reset_commit_grafts(struct repository *r)
 {
 	int i;
 
-	for (i = 0; i < r->parsed_objects->grafts_nr; i++)
+	for (i = 0; i < r->parsed_objects->grafts_nr; i++) {
+		unparse_commit(r, &r->parsed_objects->grafts[i]->oid);
 		free(r->parsed_objects->grafts[i]);
+	}
 	r->parsed_objects->grafts_nr = 0;
 	r->parsed_objects->commit_graft_prepared = 0;
 }
diff --git a/shallow.c b/shallow.c
index 8ad5f22832..cf289a4c6d 100644
--- a/shallow.c
+++ b/shallow.c
@@ -97,6 +97,13 @@ int commit_shallow_file(struct repository *r, struct shallow_lock *lk)
 {
 	int res = commit_lock_file(&lk->lock);
 	reset_repository_shallow(r);
+
+	/*
+	 * Update in-memory data structures with the new shallow information,
+	 * including unparsing all commits that now have grafts.
+	 */
+	is_repository_shallow(r);
+
 	return res;
 }
 
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 92948de7a0..ba0a4c5d15 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -170,6 +170,15 @@ test_expect_success 'fetch --update-shallow into a repo with submodules' '
 	git -C repo-with-sub fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/*
 '
 
+test_expect_success 'fetch --update-shallow a commit that is also a shallow point into a repo with submodules' '
+	git init repo-with-unreachable-upstream-shallow &&
+	git -C repo-with-unreachable-upstream-shallow submodule add ../a-submodule a-submodule &&
+	git -C repo-with-unreachable-upstream-shallow commit -m "added submodule" &&
+
+	SHALLOW=$(cat shallow/.git/shallow) &&
+	git -C repo-with-unreachable-upstream-shallow fetch --update-shallow ../shallow/.git "$SHALLOW":refs/heads/a-shallow
+'
+
 test_expect_success 'fetch --update-shallow (with fetch.writeCommitGraph)' '
 	(
 	cd shallow &&
-- 
2.36.1.255.ge46751e96f-goog

