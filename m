Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE11C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 510AC61B31
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242050AbhKRA4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242041AbhKRA4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:56:48 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF44C061767
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:49 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id a26-20020a63bd1a000000b002fab31bc2d9so963139pgf.7
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LgFgP+WD92/iEa0tJxZQ4c9HWKaXoDGfMblEnM6LJUA=;
        b=e+HTANyg93h5zVjnNlKLX616IWLJ71SWdG/BnOEyspOCYUjs67A8hYmlp/sWb0I5vJ
         5TQ1/zeiuw6BjLhePvUzsbtXIAhX58GNrWqFWTDTL2ioTlQHpe9Do3K5aSNDU+8V7n5S
         S1fhOvVxMyaHbU2ymSQ/dyN0xNhBQlOokNP9xJJsj+mPNcDNULq7ty4zce5a5k/GWJEp
         2CbFbGqfVwHepHKR9cAtCTVDUkrKm/xqQB6shAxk1ygS30ClDRf7uQqHCOuIXx59FCU7
         TmXAZqaR/YYCEzX/BylrL9NjL9Oh2LXYXL5Vwqehwg7SaXYri1EHaSs1Cw1QyzN0tjDe
         A7Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LgFgP+WD92/iEa0tJxZQ4c9HWKaXoDGfMblEnM6LJUA=;
        b=MWJMhnNvXA4dpzAZ69v/mQpFRtuXG3h/gLkUsxEJ9J3fl+nQ2t9yHg2L1OzMqr8+HH
         4EtR7f5M/VpMzVwfGDqE1bA9gn2IcaR+lspOQu5cwzSFGs4MpUwKJpBCfEBs7xVOiIF/
         xxsLlPdG/PHsqHb3Lj0LywOLgMPwzUJ3Ctl0xBRx2jLIId8703Zng+osiMd0CjRv863h
         DKABk8L/XfhtsqIhwWoPt53u2YhyyDJwPOkF0e+lIw98XfbPTN4eU2GI0skui1T7ZL0M
         N/JYnRW82pEDPyCSVws9Ewx5BsituQ7Pvex8Tapb4NI+3kWUoe9XMDnE5YTkhiGEdzYB
         pMXQ==
X-Gm-Message-State: AOAM5322DJQogdDcwb7l9MQOfEUTp6c/EzSIzXrkeeqXIBS71WkhJXjR
        RVJ+Sf+NI3AokY5nc4MMKXkwtQN76kgLk44o5qE1sRyWDvk9nH46HTVzmp3FHHkC85liZHcU1rT
        T5X82CTWoCV3MGAAA0I9nhQIe+I12Z0DpA8M0hty9lpZMPowRe7zmBPkxrzzxnVI=
X-Google-Smtp-Source: ABdhPJy87J7HvYuYipaPio7mONrMDVxu88zDS81rPiNNYs1pyO/0t2RW1+obP8OUUhKzOawThePu3a1vZ/A4Ew==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:b83:b0:49f:b555:1183 with SMTP
 id g3-20020a056a000b8300b0049fb5551183mr53039958pfj.32.1637196828574; Wed, 17
 Nov 2021 16:53:48 -0800 (PST)
Date:   Wed, 17 Nov 2021 16:53:24 -0800
In-Reply-To: <20211118005325.64971-1-chooglen@google.com>
Message-Id: <20211118005325.64971-5-chooglen@google.com>
Mime-Version: 1.0
References: <id:20211028183101.41013-1-chooglen@google.com> <20211118005325.64971-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [PATCH v5 4/5] remote: remove the_repository->remote_state from
 static methods
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace all remaining references of the_repository->remote_state in
static functions with a struct remote_state parameter.

To do so, move read_config() calls to non-static functions and create a
family of static functions, "remotes_*", that behave like "repo_*", but
accept struct remote_state instead of struct repository. In the case
where a static function calls a non-static function, replace the
non-static function with its "remotes_*" equivalent.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 remote.c | 96 +++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 71 insertions(+), 25 deletions(-)

diff --git a/remote.c b/remote.c
index 48374cc0e2..88697e7e6d 100644
--- a/remote.c
+++ b/remote.c
@@ -483,7 +483,9 @@ static int valid_remote_nick(const char *name)
 	return 1;
 }
 
-const char *remote_for_branch(struct branch *branch, int *explicit)
+static const char *remotes_remote_for_branch(struct remote_state *remote_state,
+					     struct branch *branch,
+					     int *explicit)
 {
 	if (branch && branch->remote_name) {
 		if (explicit)
@@ -495,32 +497,55 @@ const char *remote_for_branch(struct branch *branch, int *explicit)
 	return "origin";
 }
 
-const char *pushremote_for_branch(struct branch *branch, int *explicit)
+const char *remote_for_branch(struct branch *branch, int *explicit)
+{
+	read_config(the_repository);
+	return remotes_remote_for_branch(the_repository->remote_state, branch,
+					 explicit);
+}
+
+static const char *
+remotes_pushremote_for_branch(struct remote_state *remote_state,
+			      struct branch *branch, int *explicit)
 {
 	if (branch && branch->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
 		return branch->pushremote_name;
 	}
-	if (the_repository->remote_state->pushremote_name) {
+	if (remote_state->pushremote_name) {
 		if (explicit)
 			*explicit = 1;
-		return the_repository->remote_state->pushremote_name;
+		return remote_state->pushremote_name;
 	}
-	return remote_for_branch(branch, explicit);
+	return remotes_remote_for_branch(remote_state, branch, explicit);
 }
 
+const char *pushremote_for_branch(struct branch *branch, int *explicit)
+{
+	read_config(the_repository);
+	return remotes_pushremote_for_branch(the_repository->remote_state,
+					     branch, explicit);
+}
+
+static struct remote *remotes_remote_get(struct remote_state *remote_state,
+					 const char *name);
+
 const char *remote_ref_for_branch(struct branch *branch, int for_push)
 {
+	read_config(the_repository);
 	if (branch) {
 		if (!for_push) {
 			if (branch->merge_nr) {
 				return branch->merge_name[0];
 			}
 		} else {
-			const char *dst, *remote_name =
-				pushremote_for_branch(branch, NULL);
-			struct remote *remote = remote_get(remote_name);
+			const char *dst,
+				*remote_name = remotes_pushremote_for_branch(
+					the_repository->remote_state, branch,
+					NULL);
+			struct remote *remote = remotes_remote_get(
+				the_repository->remote_state, remote_name);
 
 			if (remote && remote->push.nr &&
 			    (dst = apply_refspecs(&remote->push,
@@ -532,42 +557,58 @@ const char *remote_ref_for_branch(struct branch *branch, int for_push)
 	return NULL;
 }
 
-static struct remote *remote_get_1(const char *name,
-				   const char *(*get_default)(struct branch *, int *))
+static struct remote *
+remotes_remote_get_1(struct remote_state *remote_state, const char *name,
+		     const char *(*get_default)(struct remote_state *,
+						struct branch *, int *))
 {
 	struct remote *ret;
 	int name_given = 0;
 
-	read_config(the_repository);
-
 	if (name)
 		name_given = 1;
 	else
-		name = get_default(the_repository->remote_state->current_branch,
+		name = get_default(remote_state, remote_state->current_branch,
 				   &name_given);
 
-	ret = make_remote(the_repository->remote_state, name, 0);
+	ret = make_remote(remote_state, name, 0);
 	if (valid_remote_nick(name) && have_git_dir()) {
 		if (!valid_remote(ret))
-			read_remotes_file(the_repository->remote_state, ret);
+			read_remotes_file(remote_state, ret);
 		if (!valid_remote(ret))
-			read_branches_file(the_repository->remote_state, ret);
+			read_branches_file(remote_state, ret);
 	}
 	if (name_given && !valid_remote(ret))
-		add_url_alias(the_repository->remote_state, ret, name);
+		add_url_alias(remote_state, ret, name);
 	if (!valid_remote(ret))
 		return NULL;
 	return ret;
 }
 
+static inline struct remote *
+remotes_remote_get(struct remote_state *remote_state, const char *name)
+{
+	return remotes_remote_get_1(remote_state, name,
+				    remotes_remote_for_branch);
+}
+
 struct remote *remote_get(const char *name)
 {
-	return remote_get_1(name, remote_for_branch);
+	read_config(the_repository);
+	return remotes_remote_get(the_repository->remote_state, name);
+}
+
+static inline struct remote *
+remotes_pushremote_get(struct remote_state *remote_state, const char *name)
+{
+	return remotes_remote_get_1(remote_state, name,
+				    remotes_pushremote_for_branch);
 }
 
 struct remote *pushremote_get(const char *name)
 {
-	return remote_get_1(name, pushremote_for_branch);
+	read_config(the_repository);
+	return remotes_pushremote_get(the_repository->remote_state, name);
 }
 
 int remote_is_configured(struct remote *remote, int in_repo)
@@ -1654,7 +1695,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 	}
 }
 
-static void set_merge(struct branch *ret)
+static void set_merge(struct remote_state *remote_state, struct branch *ret)
 {
 	struct remote *remote;
 	char *ref;
@@ -1674,7 +1715,7 @@ static void set_merge(struct branch *ret)
 		return;
 	}
 
-	remote = remote_get(ret->remote_name);
+	remote = remotes_remote_get(remote_state, ret->remote_name);
 
 	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i = 0; i < ret->merge_nr; i++) {
@@ -1701,7 +1742,7 @@ struct branch *branch_get(const char *name)
 	else
 		ret = make_branch(the_repository->remote_state, name,
 				  strlen(name));
-	set_merge(ret);
+	set_merge(the_repository->remote_state, ret);
 	return ret;
 }
 
@@ -1772,11 +1813,14 @@ static const char *tracking_for_push_dest(struct remote *remote,
 	return ret;
 }
 
-static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
+static const char *branch_get_push_1(struct remote_state *remote_state,
+				     struct branch *branch, struct strbuf *err)
 {
 	struct remote *remote;
 
-	remote = remote_get(pushremote_for_branch(branch, NULL));
+	remote = remotes_remote_get(
+		remote_state,
+		remotes_pushremote_for_branch(remote_state, branch, NULL));
 	if (!remote)
 		return error_buf(err,
 				 _("branch '%s' has no remote for pushing"),
@@ -1834,11 +1878,13 @@ static const char *branch_get_push_1(struct branch *branch, struct strbuf *err)
 
 const char *branch_get_push(struct branch *branch, struct strbuf *err)
 {
+	read_config(the_repository);
 	if (!branch)
 		return error_buf(err, _("HEAD does not point to a branch"));
 
 	if (!branch->push_tracking_ref)
-		branch->push_tracking_ref = branch_get_push_1(branch, err);
+		branch->push_tracking_ref = branch_get_push_1(
+			the_repository->remote_state, branch, err);
 	return branch->push_tracking_ref;
 }
 
-- 
2.33.GIT

