Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8920FC433E0
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C84E2075B
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 09:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRF7M/Nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgFEJKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgFEJKj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 05:10:39 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71B0C08C5C2
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 02:10:39 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y5so3037173qto.10
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 02:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cGJMlQF6f7/+DSN2r/K2XS9Iz22M59B+KeFz1tqpm/k=;
        b=dRF7M/NjSgLiZMdPqq1LpObYvMnrAxR9qRCkCJgFYinnC+Zigb5rc2jd+rTU2AxD2T
         79Pl/p1lSdrOrqSxMwQQYHjWaGzx61lphGKq8HzNV3bDlATb/bh1vq1x8Wt2lCQrTx8c
         awYmJBNn2oQZQZ7DL8mvAvHj5r2H0nvYRbdQ1k3M/MM2m13YTsP8eU4hj47C5ppjKKea
         tFPnuuCNCPyH4LSXgD5N+eQykYbshtGDmD+XGFi8R7rml4ua/1dyGD8IEmKKB5z3g7SU
         wyj1RKc1wzmD6pyfzkt1Eus5KYwUcSUd1+I/Pn/Wq4hp/z9nTGE5X2/BHrQp3lk4mQaS
         LrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cGJMlQF6f7/+DSN2r/K2XS9Iz22M59B+KeFz1tqpm/k=;
        b=jYQmm1tUz/8cOZxA8R5ISf7WiUyOBnZTDR0nLA5wCIVmhlMl+YnTuFHhJ0Sw5oYCup
         rYTgtADj56S/ojWAZ5zQ/au8XDMvyo05M9DkoLOIp+5iTXZLw9BwDA72uthWui1W49/X
         /i3I7fh2bHckmCv7PDwxrIsZtYcyqzE/PdrLo228DcpF4reGOq7XaB30pZIpeC5/Ljz3
         U1NKl4zIfVWoGxgKNSLPdBzJnWLe2dT0en9azgzjyHNIaxRkVn48J4XDaBdhuJHwuDne
         5xfd9+P/eIz7icnBzsusqc0LF4UR+jBHJyICYPe4AE6FUaC/fwS9Vio+33MyRdilGNq8
         0IZg==
X-Gm-Message-State: AOAM532udwLslSk+nDN08J0X1t3GT9CW8JONiWrAaCSQ0xfHG7DfJgWS
        8PdbtQ4wza4mx8znbphqpvXbuxpYHlLXMaQrSWhGYaT72Oz1eqlrkfco2yZ360RZugYZLIrQXtO
        zPg8+zTUTHrLvBSTBKB5sQsliUt8o7v9FKlETl6UK34TzjAjm+8aDu3k3iN6L
X-Google-Smtp-Source: ABdhPJzuhmjYuqIKdWUHwkuBd1MQDodV301K4uu1Drx5fiavpWWyLcepxMS8Nt5U/x7fQw2SOEdOeROxGreS
X-Received: by 2002:a05:6214:170e:: with SMTP id db14mr8262826qvb.113.1591348238778;
 Fri, 05 Jun 2020 02:10:38 -0700 (PDT)
Date:   Fri,  5 Jun 2020 02:10:01 -0700
In-Reply-To: <20200605091004.208668-1-delphij@google.com>
Message-Id: <20200605091004.208668-2-delphij@google.com>
Mime-Version: 1.0
References: <20200528025359.20931-2-delphij@google.com> <xmqqsgfk3xtd.fsf@gitster.c.googlers.com>
 <20200528171924.GC58643@google.com> <CAOhzdugK7FQSnWruUrX8gQ98AF6kGvNWqPfHmE+qjGjBgzvmiQ@mail.gmail.com>
 <20200528191739.GA114915@google.com> <20200529000432.146618-1-delphij@google.com>
 <20200529010119.GE114915@google.com> <xmqqk10uzkcd.fsf@gitster.c.googlers.com>
 <20200605091004.208668-1-delphij@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v6 1/4] repository: add a helper function to perform
 repository format upgrade
From:   Xin Li <delphij@google.com>
To:     git@vger.kernel.org
Cc:     Xin Li <delphij@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In version 1 of repository format, "extensions" gained special meaning
and it is safer to avoid upgrading when there are pre-existing
extensions.

Make list-objects-filter to use the helper function instead of setting
repository version directly as a prerequisite of exposing the upgrade
capability.

Signed-off-by: Xin Li <delphij@google.com>
---
 cache.h                       |  1 +
 list-objects-filter-options.c |  3 ++-
 repository.h                  |  6 ++++++
 setup.c                       | 29 +++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/cache.h b/cache.h
index 0f0485ecfe..e5885cc9ea 100644
--- a/cache.h
+++ b/cache.h
@@ -1042,6 +1042,7 @@ struct repository_format {
 	int worktree_config;
 	int is_bare;
 	int hash_algo;
+	int has_extensions;
 	char *work_tree;
 	struct string_list unknown_extensions;
 };
diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
index 256bcfbdfe..3553ad7b0a 100644
--- a/list-objects-filter-options.c
+++ b/list-objects-filter-options.c
@@ -326,7 +326,8 @@ void partial_clone_register(
 
 	/* Check if it is already registered */
 	if (!promisor_remote_find(remote)) {
-		git_config_set("core.repositoryformatversion", "1");
+		if (upgrade_repository_format(1) < 0)
+			die(_("unable to upgrade repository format to support partial clone"));
 
 		/* Add promisor config for the remote */
 		cfg_name = xstrfmt("remote.%s.promisor", remote);
diff --git a/repository.h b/repository.h
index 6534fbb7b3..3c1f7d54bd 100644
--- a/repository.h
+++ b/repository.h
@@ -196,4 +196,10 @@ void repo_update_index_if_able(struct repository *, struct lock_file *);
 
 void prepare_repo_settings(struct repository *r);
 
+/*
+ * Return 1 if upgrade repository format to target_version succeeded,
+ * 0 if no upgrade is necessary, and -1 when upgrade is not possible.
+ */
+int upgrade_repository_format(int target_version);
+
 #endif /* REPOSITORY_H */
diff --git a/setup.c b/setup.c
index 65fe5ecefb..597b41b822 100644
--- a/setup.c
+++ b/setup.c
@@ -455,6 +455,7 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 	if (strcmp(var, "core.repositoryformatversion") == 0)
 		data->version = git_config_int(var, value);
 	else if (skip_prefix(var, "extensions.", &ext)) {
+		data->has_extensions = 1;
 		/*
 		 * record any known extensions here; otherwise,
 		 * we fall through to recording it as unknown, and
@@ -538,6 +539,34 @@ static int check_repository_format_gently(const char *gitdir, struct repository_
 	return 0;
 }
 
+int upgrade_repository_format(int target_version)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct strbuf repo_version = STRBUF_INIT;
+	struct repository_format repo_fmt = REPOSITORY_FORMAT_INIT;
+
+	strbuf_git_common_path(&sb, the_repository, "config");
+	read_repository_format(&repo_fmt, sb.buf);
+	strbuf_release(&sb);
+
+	if (repo_fmt.version >= target_version)
+		return 0;
+
+	if (verify_repository_format(&repo_fmt, &err) < 0 ||
+	    (!repo_fmt.version && repo_fmt.has_extensions)) {
+		warning("unable to upgrade repository format from %d to %d: %s",
+			repo_fmt.version, target_version, err.buf);
+		strbuf_release(&err);
+		return -1;
+	}
+
+	strbuf_addf(&repo_version, "%d", target_version);
+	git_config_set("core.repositoryformatversion", repo_version.buf);
+	strbuf_release(&repo_version);
+	return 1;
+}
+
 static void init_repository_format(struct repository_format *format)
 {
 	const struct repository_format fresh = REPOSITORY_FORMAT_INIT;
-- 
2.27.0.278.ge193c7cf3a9-goog

