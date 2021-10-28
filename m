Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FE2C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6752610D2
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 18:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhJ1Sdv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 14:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhJ1Sdo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 14:33:44 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFC1C061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id kn11-20020a17090b480b00b001a4053c7510so3021371pjb.8
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LgFgP+WD92/iEa0tJxZQ4c9HWKaXoDGfMblEnM6LJUA=;
        b=sjPjRFGkoIdWR8uJvv4dYT0k6VlJM+ROcOeQLKtfxTiUY8qaaVE9Gf6na9+E3/mfye
         Vre8velhdCaABDOORwv+C1igBtYgOqtK3JtLxdVeZZI7nc3zI8S4CwrzEn3eV+vH5kT7
         FQIpPrn4I30fGE9m6G8co1XTuahExyvEsrNLg3S1vF+/P/C5S1RewvLFs9nmlv4zzqFB
         dxTU+bu09Jf0Zg3F23xe0bmiulmjpokvFzno+wsbl7YOPcM6YQ9xaRE/LWqlxN/haOT5
         hqStv9BGglYfdIvsefhB0iC8Y+T9Tx/9YEAjVHaVHhH9jg38EEPTnm0eTE2ByX58UWX4
         aANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LgFgP+WD92/iEa0tJxZQ4c9HWKaXoDGfMblEnM6LJUA=;
        b=Wh3zVGgQXTmehGFqiEC29ni//pZij1VFVbpywpGu8So9DqV5u55Lnl1zuQAI/Mi30U
         F9sKKInUKmq1E3aujtTyxc0WT7CZIa/scVBN0twtDHkaRXWdatM54M96FDIs2YDkHivu
         EYHMfa8E0gwyDblV8qd/s8wIYatSlr3/4zlmakAlxmcozhVvvY1PE/RNV1XcCs8rzAXz
         VgLt8/lzEHgOD9HhUOuQs7yhf+x/mx1x41AP90055MUPRMY7eVz25x3yPBeTD4xwApk0
         cHw4mlIPFmsWjRUQ4NcLo+AyPCxMZWKmxf9lClyqJ5rCk433skb7PFFAjoVxnKwTmxoH
         ZnHw==
X-Gm-Message-State: AOAM533Rp+/ZmAkUUgWVU9WzTcwMoAYrNfDHuPIXsnGFNENrIPQ9gDGY
        EZKFfhF0iJjnQ4EvxAuhe1V5LU7faE0WbRwwSy9AGOKut81F5ACJ/UOcwoBch67msA1ot4eaJBE
        LLTJTqxqEsu+HjEWFnYL/KoxU/4+nH9wUg6LSJf6ueBp74c87ORWssavUhKsrZNo=
X-Google-Smtp-Source: ABdhPJwyiGZOxmKB3UJCT/FXRLJvnXiu8HkClffUneSiPfM01ek1AbRy3MQRDfTQCaAXWqdq/Lsm6NDDqMHpHA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:aa08:b0:13f:eb2e:8ce8 with SMTP
 id be8-20020a170902aa0800b0013feb2e8ce8mr5417975plb.0.1635445876809; Thu, 28
 Oct 2021 11:31:16 -0700 (PDT)
Date:   Thu, 28 Oct 2021 11:30:59 -0700
In-Reply-To: <20211028183101.41013-1-chooglen@google.com>
Message-Id: <20211028183101.41013-5-chooglen@google.com>
Mime-Version: 1.0
References: <20211019224339.61881-1-chooglen@google.com> <20211028183101.41013-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v4 4/6] remote: remove the_repository->remote_state from
 static methods
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Glen Choo <chooglen@google.com>
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

