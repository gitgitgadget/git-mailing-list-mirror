Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7866CC433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5233B60E8B
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhJMFUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhJMFUm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:20:42 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7B7C06174E
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so1326416pjb.3
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vucoq0/0s1EnRlZ3RZDRggQ9MYfsk7ZPh5/u+9Ud8Dc=;
        b=Do9eYQqq/HQSczPGQhR3tFtEUQAgJteOcvYajnlAmKz5FsPXvW30HkGbsGvLu0Ppfv
         P2EmNlNIyhhKpunQEjq6Ayl02aZY+0EZXIXdsKpC+hizuK8ddzB5mNsFB3Rghpk8rwkw
         Ma1dIR+tO0oUsE1cdySyiw65PvAwKn/+KkuVKH6Sm9wg3kzZULWhUX9WuE8hijFmO5CM
         6+wir+cCldImYTBSuwSCSFhluG2gRQ7XKETDSj60k/thVTUEIGM92/Z9AIQMGj8OPoWc
         OcgnPvj9ax6464xNlp5O+SBf7tgrLt08n46mpwHRWKf2C2gp9W/i+znGzWJGZKdcHkCJ
         Cb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vucoq0/0s1EnRlZ3RZDRggQ9MYfsk7ZPh5/u+9Ud8Dc=;
        b=L378cPBubn23GmbwsEF18HQNMsWXVoICQ/TggViXnXaNIJLwFaMh/hxpQTMRcoE5ik
         TFGbGhP/WrnD4gmTSxICwW9SmDWQ8wm1tE8qFfdyO6TcIX5WVsXr2qDLvui4SapcluEw
         pcyzpWQWn0jxPcwuXnKBS9Hf7VFUayTysKWL4Koipnu44Cdi7o0AMw8lClypu4azx/Df
         w/GWlIryD/2z77BTUGG80fqXMz+tiOwXLepZXwgE1kfRknPLJkbNcSrZamSSdF3J3x3T
         0gJWQDgXK8bLhmGXtVchEj6MSn3qlpA8MqY28rTOhpJFX6BwiFCnmFizlzSxHt38bQSy
         cFJw==
X-Gm-Message-State: AOAM53129T1KShjYgz65wTBlL7e3hc8opV11xwqiMLrVNZbqRfDIGx2k
        33mz5eXyZN47JmyazeT7pVI=
X-Google-Smtp-Source: ABdhPJxaQSa4dBMxaW07VVZjlv60CugxukjzAt8F2CDL9Rjre7YK6I/R2ys0DENtnvivuq+0Kf+zUA==
X-Received: by 2002:a17:90a:4306:: with SMTP id q6mr11160411pjg.17.1634102319051;
        Tue, 12 Oct 2021 22:18:39 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:38 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 2/9] submodule--helper: get remote names from any repository
Date:   Wed, 13 Oct 2021 10:47:58 +0530
Message-Id: <20211013051805.45662-3-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`get_default_remote()` retrieves the name of a remote by resolving the
refs from of the current repository's ref store.

Thus in order to use it for retrieving the remote name of a submodule,
we have to start a new subprocess which runs from the submodule
directory.

Let's instead introduce a function called `repo_get_default_remote()`
which takes any repository object and retrieves the remote accordingly.

`get_default_remote()` is then defined as a call to
`repo_get_default_remote()` with 'the_repository' passed to it.

Now that we have `repo_get_default_remote()`, we no longer have to start
a subprocess that called `submodule--helper get-default-remote` from
within the submodule directory.

So let's make a function called `get_default_remote_submodule()` which
takes a submodule path, and returns the default remote for that
submodule, all within the same process.

We can now use this function to save an unnecessary subprocess spawn in
`sync_submodule()`, and also in the next patch, which will require this
functionality.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 39 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 764fcb7dba..bbab43230b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -29,11 +29,10 @@
 typedef void (*each_submodule_fn)(const struct cache_entry *list_item,
 				  void *cb_data);
 
-static char *get_default_remote(void)
+static char *repo_get_default_remote(struct repository *repo, const char *refname)
 {
 	char *dest = NULL, *ret;
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -46,7 +45,7 @@ static char *get_default_remote(void)
 		die(_("Expecting a full ref name, got %s"), refname);
 
 	strbuf_addf(&sb, "branch.%s.remote", refname);
-	if (git_config_get_string(sb.buf, &dest))
+	if (repo_config_get_string(repo, sb.buf, &dest))
 		ret = xstrdup("origin");
 	else
 		ret = dest;
@@ -55,6 +54,23 @@ static char *get_default_remote(void)
 	return ret;
 }
 
+static char *get_default_remote_submodule(const char *module_path)
+{
+	const char *refname;
+	struct repository subrepo;
+
+	refname = refs_resolve_ref_unsafe(get_submodule_ref_store(module_path),
+					  "HEAD", 0, NULL, NULL);
+	repo_submodule_init(&subrepo, the_repository, module_path, null_oid());
+	return repo_get_default_remote(&subrepo, refname);
+}
+
+static char *get_default_remote(void)
+{
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
+	return repo_get_default_remote(the_repository, refname);
+}
+
 static int print_default_remote(int argc, const char **argv, const char *prefix)
 {
 	char *remote;
@@ -1341,9 +1357,8 @@ static void sync_submodule(const char *path, const char *prefix,
 {
 	const struct submodule *sub;
 	char *remote_key = NULL;
-	char *sub_origin_url, *super_config_url, *displaypath;
+	char *sub_origin_url, *super_config_url, *displaypath, *default_remote;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
 	char *sub_config_path = NULL;
 
 	if (!is_submodule_active(the_repository, path))
@@ -1382,21 +1397,15 @@ static void sync_submodule(const char *path, const char *prefix,
 	if (!is_submodule_populated_gently(path, NULL))
 		goto cleanup;
 
-	prepare_submodule_repo_env(&cp.env_array);
-	cp.git_cmd = 1;
-	cp.dir = path;
-	strvec_pushl(&cp.args, "submodule--helper",
-		     "print-default-remote", NULL);
-
 	strbuf_reset(&sb);
-	if (capture_command(&cp, &sb, 0))
+	default_remote = get_default_remote_submodule(path);
+	if (!default_remote)
 		die(_("failed to get the default remote for submodule '%s'"),
 		      path);
 
-	strbuf_strip_suffix(&sb, "\n");
-	remote_key = xstrfmt("remote.%s.url", sb.buf);
+	remote_key = xstrfmt("remote.%s.url", default_remote);
+	free(default_remote);
 
-	strbuf_reset(&sb);
 	submodule_to_gitdir(&sb, path);
 	strbuf_addstr(&sb, "/config");
 
-- 
2.32.0

