Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E49C4332F
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92A361154
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 22:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhJSWqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 18:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhJSWqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 18:46:05 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B6EC06161C
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:52 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id l10-20020a17090ac58a00b001a04b92a5d4so661170pjt.8
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 15:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RK8CQc84tN6Wwg4rDYHsQ0Tw91F8B5aIaLcZEOgqg+M=;
        b=drgR94pXr7rRsBnV3VWnJsZzDfT82K8wpVxVrG671NoqyNG4nPNJgm2bsEiDHQ4ceQ
         mwxE8PiOX4Z606HhX0uymPi8mOcKzHfHLVfPSG1DyF3iJayryrFbRcjf91gfpUbDL971
         eGy6wjeIouLgo5uH9lq080NWLXdk4A0HD3tkMZp6CFf3tUHhMITjyZh5C1Mg5gnN4Ozm
         av8dLxysmwqBO+kvxbefgUfw22U/TmMpMAvBP8rriVtADWSuPIo4WfBF0L2xUGCqezWH
         T7lV5daqcHDPT1eATe0GTUKNqFWFX/hTUDts0qfbrCwLPzZzBjiLQdhORF4T6nkhfwyK
         pd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RK8CQc84tN6Wwg4rDYHsQ0Tw91F8B5aIaLcZEOgqg+M=;
        b=Z6y1F4AECi1GHdqt2za9akfKyPtJTjhCFJpd8+PU0u7mfY05hsALFbe1AMHpBikdvb
         uZLY493jbVAkWfa4gLbPDaJZ8zRUSVP1WxbyS+wBar9OwSyI5/CrAh87eRkSswJ0g6cl
         XuGH2PcIUTzucGfj8bTBzZVRipIZy2qeU8Lw2gmC+C9iWfbhWLXPwXfZxGV146317bPs
         nQyGZZ5e6vuPaHbDT46aCFzAVu2lIOcwzAh4UubGumwOWw7nVq2jFuG7q/rNyikh176G
         fWbOq53WjoWyLBfshSF5Gf3c+DB/jmaREFuTHh+9bRfxkmV2cfkOhV/uOmunb6phgd3L
         R+Og==
X-Gm-Message-State: AOAM530KPElscElRJ236Tk6zMRiKYsUTNRx3A6gvjtCiH9N9Hn881oVY
        zoN7fUYpCG92M0R5ek2yfQzamwegA6wTV1UhpNgOUe/PSVKt//OLhUt4oHz+dpI+pkwc8IwxFkA
        bLkX2uc4IdmZVuM2QoeJwPsdmb8Me0jQEB+BD+5EYTdT0kCUXAfn2M0eFyZEACJM=
X-Google-Smtp-Source: ABdhPJxrW9OVZMHGJ/vCX30iLjv7aaovAlKve10MYotR4Sznu8xucpC//IATUbRk1aSWoWeU+mSkaC17+T5TOg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:21c6:b0:44c:937:fbf3 with SMTP
 id t6-20020a056a0021c600b0044c0937fbf3mr2655472pfj.2.1634683431846; Tue, 19
 Oct 2021 15:43:51 -0700 (PDT)
Date:   Tue, 19 Oct 2021 15:43:38 -0700
In-Reply-To: <20211019224339.61881-1-chooglen@google.com>
Message-Id: <20211019224339.61881-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211013193127.76537-1-chooglen@google.com> <20211019224339.61881-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 3/4] remote: remove the_repository->remote_state from
 static methods
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all remaining references of the_repository->remote_state in
static methods with a struct remote_state parameter. To do so, introduce
a family of helper functions, "remotes_*", that behave like "repo_*",
but accept struct remote_state instead of struct repository, and move
read_config() calls to non-static functions.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 94 ++++++++++++++++++++++++++++++++------------------------
 1 file changed, 53 insertions(+), 41 deletions(-)

diff --git a/remote.c b/remote.c
index e3ca44f735..cf9cced5ed 100644
--- a/remote.c
+++ b/remote.c
@@ -505,6 +505,55 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 	return "origin";
 }
 
+static struct remote *remotes_remote_get_1(
+	struct remote_state *remote_state, const char *name,
+	const char *(*get_default)(struct branch *, int *))
+{
+	struct remote *ret;
+	int name_given = 0;
+
+	if (name)
+		name_given = 1;
+	else
+		name = get_default(remote_state->current_branch,
+				   &name_given);
+
+	ret = make_remote(remote_state, name, 0);
+	if (valid_remote_nick(name) && have_git_dir()) {
+		if (!valid_remote(ret))
+			read_remotes_file(ret);
+		if (!valid_remote(ret))
+			read_branches_file(ret);
+	}
+	if (name_given && !valid_remote(ret))
+		add_url_alias(ret, name);
+	if (!valid_remote(ret))
+		return NULL;
+	return ret;
+}
+
+static inline struct remote *remotes_remote_get(struct remote_state *remote_state, const char *name)
+{
+	return remotes_remote_get_1(remote_state, name, remote_for_branch);
+}
+
+static inline struct remote *remotes_pushremote_get(struct remote_state *remote_state, const char *name)
+{
+	return remotes_remote_get_1(remote_state, name, pushremote_for_branch);
+}
+
+struct remote *remote_get(const char *name)
+{
+	read_config(the_repository);
+	return remotes_remote_get(the_repository->remote_state, name);
+}
+
+struct remote *pushremote_get(const char *name)
+{
+	read_config(the_repository);
+	return remotes_pushremote_get(the_repository->remote_state, name);
+}
+
 const char *pushremote_for_branch(struct branch *branch, int *explicit)
 {
 	if (branch && branch->pushremote_name) {
@@ -530,7 +579,8 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 		} else {
 			const char *dst, *remote_name =
 				pushremote_for_branch(branch, NULL);
-			struct remote *remote = remote_get(remote_name);
+			struct remote *remote =
+				remotes_remote_get(branch->remote_state, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -542,44 +592,6 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
-static struct remote *remote_get_1(const char *name,
-				   const char *(*get_default)(struct branch *, int *))
-{
-	struct remote *ret;
-	int name_given = 0;
-
-	read_config(the_repository);
-
-	if (name)
-		name_given = 1;
-	else
-		name = get_default(the_repository->remote_state->current_branch,
-				   &name_given);
-
-	ret = make_remote(the_repository->remote_state, name, 0);
-	if (valid_remote_nick(name) && have_git_dir()) {
-		if (!valid_remote(ret))
-			read_remotes_file(ret);
-		if (!valid_remote(ret))
-			read_branches_file(ret);
-	}
-	if (name_given && !valid_remote(ret))
-		add_url_alias(ret, name);
-	if (!valid_remote(ret))
-		return NULL;
-	return ret;
-}
-
-struct remote *remote_get(const char *name)
-{
-	return remote_get_1(name, remote_for_branch);
-}
-
-struct remote *pushremote_get(const char *name)
-{
-	return remote_get_1(name, pushremote_for_branch);
-}
-
 int remote_is_configured(struct remote *remote, int in_repo)
 {
 	if (!remote)
@@ -1684,7 +1696,7 @@ static void set_merge(struct branch *ret)
 		return;
 	}
 
-	remote = remote_get(ret->remote_name);
+	remote = remotes_remote_get(ret->remote_state, ret->remote_name);
 
 	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i = 0; i < ret->merge_nr; i++) {
@@ -1786,7 +1798,7 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
 
-	remote = remote_get(pushremote_for_branch(branch, NULL));
+	remote = remotes_remote_get(branch->remote_state, pushremote_for_branch(branch, NULL));
 	if (!remote)
 		return error_buf(err,
 				 _("branch '%s' has no remote for pushing"),
-- 
2.33.GIT

