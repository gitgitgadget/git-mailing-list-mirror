Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85275C43217
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C247610A1
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhJSWqK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSWqH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:46:07 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1BFC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:54 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id f9-20020a056a001ac900b0044c4f04a6b1so698454pfv.23
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0s4p9GfsGdlSLDH0e3+SR+Rhz32UmN8nIoPnEaE49O0=;
        b=CRpRAa98iBrYaJKRTHFLfBgcYldOCgIBVE5FXzB1+K0yk+ECOLgpa3LUkZCWFhw1R1
         Redig6OODqFtcRFGfdLhUh6FXkC7G49c1JsegzOp4HsbOVuUtl0vHNGvNQejS9Ox5xox
         AboMrZ+OiVctzezBHzG15YZRC8UWlKsri/1L3EIXf+qEECaAdGT3Sd6rl7DQBWqGqyO6
         F//buNsBSPHuFdXMmhmQANeMXL/pAnZDIktpRGepkBKOBsCzEAkn14lqI6SE9F7vl9gz
         s/FP5ivmvEgkQt8dQ/2nWqhtSWejgBwBbjoW2jlX/guqunxVW5qAEM1qyOUue/WcxWNF
         heLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0s4p9GfsGdlSLDH0e3+SR+Rhz32UmN8nIoPnEaE49O0=;
        b=8HK9N2l7EqE+H4/iVsX0Y6MekXESysx/2liOkkTiWO+uqJL6nZ5zb4DIRuZfrdO4GE
         N3IA62sUTEgt13z6NL7A0uepRpTK0ZrE3o62J7XI253ik3xrVVBvPj5IT3mw5BLXmRnU
         yDLnDFITLboiUdaVsdrKjRrWEvIlJHbWXRrM3MHrGV7rhQYtiINAPZrTsQB2OCYfTAYg
         hAoX4RIZajmE2cb30DnXeO49z+rAuafycbG0qjS8DFPhNyXMM2b44oU9AIEYW2CfWh3a
         H5iP0hYlEIHmiJDCaO93XFi2i+P3DyCkC03u/pvIaXGSwG6gG5/F+LVvX31b0q3E2fKD
         IhZw==
X-Gm-Message-State: AOAM530zQHqG5m7iCS4V2T+HtGjGehkMmkuNRvZ2RQcuqV0PMWUScC+A
        UWR7nOesA52rKFW/ZhCoeWygyukn0E5PZPbb1oLlRyNRyl6yRbACF/87b2faiS6rSCoygvhQo6B
        bw4++ygTBWsa12YAzZFdtyTb8ZnIv/tsIqk2W6XDLOV1kxF/KDkZi7+56QaIeG9w=
X-Google-Smtp-Source: ABdhPJyyJCCODrulqjNfDUuvQh0h5DxaoJ2BZcLZB4yUWchAdJPS7lwR74ON1ZjeTQhkbWIm6niyQlIGQTGuaA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:9789:0:b0:44d:3a4b:b2b1 with SMTP id
 o9-20020aa79789000000b0044d3a4bb2b1mr2647133pfp.66.1634683433467; Tue, 19 Oct
 2021 15:43:53 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:43:39 -0700
In-Reply-To: <20211019224339.61881-1-chooglen@google.com>
Message-Id: <20211019224339.61881-5-chooglen@google.com>
Mime-Version: 1.0
References: <20211013193127.76537-1-chooglen@google.com> <20211019224339.61881-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 4/4] remote: add struct repository parameter to external functions
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finish plumbing remote_state by adding a struct repository
parameter to repo_* functions. While this removes all references to
the_repository->remote_state, certain functions still use the_repository
to parse oids.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 29 ++++++++++++++---------------
 remote.h | 28 +++++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 20 deletions(-)

diff --git a/remote.c b/remote.c
index cf9cced5ed..179f0ff1ab 100644
--- a/remote.c
+++ b/remote.c
@@ -542,16 +542,16 @@ static inline struct remote *remotes_pushremote_get(struct remote_state *remote_
 	return remotes_remote_get_1(remote_state, name, pushremote_for_branch);
 }
 
-struct remote *remote_get(const char *name)
+struct remote *repo_remote_get(struct repository *repo, const char *name)
 {
-	read_config(the_repository);
-	return remotes_remote_get(the_repository->remote_state, name);
+	read_config(repo);
+	return remotes_remote_get(repo->remote_state, name);
 }
 
-struct remote *pushremote_get(const char *name)
+struct remote *repo_pushremote_get(struct repository *repo, const char *name)
 {
-	read_config(the_repository);
-	return remotes_pushremote_get(the_repository->remote_state, name);
+	read_config(repo);
+	return remotes_pushremote_get(repo->remote_state, name);
 }
 
 const char *pushremote_for_branch(struct branch *branch, int *explicit)
@@ -601,14 +601,14 @@ int remote_is_configured(struct remote *remote, int in_repo)
 	return !!remote->origin;
 }
 
-int for_each_remote(each_remote_fn fn, void *priv)
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn, void *priv)
 {
 	int i, result = 0;
-	read_config(the_repository);
-	for (i = 0; i < the_repository->remote_state->remotes_nr && !result;
+	read_config(repo);
+	for (i = 0; i < repo->remote_state->remotes_nr && !result;
 	     i++) {
 		struct remote *remote =
-			the_repository->remote_state->remotes[i];
+			repo->remote_state->remotes[i];
 		if (!remote)
 			continue;
 		result = fn(remote, priv);
@@ -1713,16 +1713,15 @@ static void set_merge(struct branch *ret)
 	}
 }
 
-struct branch *branch_get(const char *name)
+struct branch *repo_branch_get(struct repository *repo, const char *name)
 {
 	struct branch *ret;
 
-	read_config(the_repository);
+	read_config(repo);
 	if (!name || !*name || !strcmp(name, "HEAD"))
-		ret = the_repository->remote_state->current_branch;
+		ret = repo->remote_state->current_branch;
 	else
-		ret = make_branch(the_repository->remote_state, name,
-				  strlen(name));
+		ret = make_branch(repo->remote_state, name, strlen(name));
 	set_merge(ret);
 	return ret;
 }
diff --git a/remote.h b/remote.h
index d268a92ebb..e19cae2718 100644
--- a/remote.h
+++ b/remote.h
@@ -123,15 +123,28 @@ struct remote {
  * remote_get(NULL) will return the default remote, given the current branch
  * and configuration.
  */
-struct remote *remote_get(const char *name);
-
-struct remote *pushremote_get(const char *name);
+struct remote *repo_remote_get(struct repository *repo, const char *name);
+static inline struct remote *remote_get(const char *name)
+{
+	return repo_remote_get(the_repository, name);
+}
+
+struct remote *repo_pushremote_get(struct repository *repo, const char *name);
+static inline struct remote *pushremote_get(const char *name)
+{
+	return repo_pushremote_get(the_repository, name);
+}
 int remote_is_configured(struct remote *remote, int in_repo);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
 /* iterate through struct remotes */
-int for_each_remote(each_remote_fn fn, void *priv);
+int repo_for_each_remote(struct repository *repo, each_remote_fn fn,
+			 void *priv);
+static inline int for_each_remote(each_remote_fn fn, void *priv)
+{
+	return repo_for_each_remote(the_repository, fn, priv);
+}
 
 int remote_has_url(struct remote *remote, const char *url);
 
@@ -330,7 +343,12 @@ struct branch {
 	struct remote_state *remote_state;
 };
 
-struct branch *branch_get(const char *name);
+struct branch *repo_branch_get(struct repository *repo, const char *name);
+static inline struct branch *branch_get(const char *name)
+{
+	return repo_branch_get(the_repository, name);
+}
+
 const char *remote_for_branch(struct branch *branch, int *explicit);
 const char *pushremote_for_branch(struct branch *branch, int *explicit);
 const char *remote_ref_for_branch(struct branch *branch, int for_push);
-- 
2.33.GIT

