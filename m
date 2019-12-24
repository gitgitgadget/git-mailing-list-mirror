Return-Path: <SRS0=uLN7=2O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E84C2D0D0
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3846E20706
	for <git@archiver.kernel.org>; Tue, 24 Dec 2019 11:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzPcaI7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfLXLGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:06:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34016 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLXLF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Dec 2019 06:05:58 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so7369968qvf.1
        for <git@vger.kernel.org>; Tue, 24 Dec 2019 03:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jISNjuGpTicokuJp5vmp/6Rn7RrL3GkXj1JlnI6OnDY=;
        b=lzPcaI7eYXTAqGXDLneKQG6Av/FbrgMiRa4vBRvg/ZmHNaet1bBaOLQXYOcyPYN9A8
         ZBoDqPd2oJbYNntHKx633u1C9enJMi2xTK/ILSS0Od4LXOeUsjnb2YuBqZ6OEtM9Ce4S
         cHskYfbC9KC/XYEMW6o5u142No+q1BeqrAdzlLrbxVk2e9zqaIluy8oDuX47OqICwewf
         a12qhatCChzUjIiLP653GvEFD9b515Jp3Fx3vPRb9z2HgSCEkZ+M9QACeXNDMSo78XXJ
         9/ARcku/kESrUKRn+stgybbixBez3apeEOpL9NSBFTEkMsko416nd8KNGXfdV841AGjI
         npUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jISNjuGpTicokuJp5vmp/6Rn7RrL3GkXj1JlnI6OnDY=;
        b=ljDOgWhR4IU9nQD0ouOmYAHy6BzJkb5gOCOvo5OmF2925QWHuPm0bp/TulN7R4A4Ob
         BalkuH4wi8Xis9pkWlXTpB/Jnn3AuoRkjN3dHLquNDnnUuTqPfyH5uUrUmjh2BUrDrsn
         HhNRuh4jPVeYEjRcq5Eb3xysJvsHLZISUElJYCEsQXh34+74/wDI+LiE+2i1Wc+76/gL
         g+W0GNKkWYpKpoJPIvNa1HNa2C3gUvClQtXsojgV6RxckGkgWSxv3qEoCvYu+2v9jy0T
         ksIUKqiEmKoj/dum51po9Tajt+fmqXgB55KMVzjUiwJWOL3j8JiRdu6n3I4oHxYhaNId
         OyGQ==
X-Gm-Message-State: APjAAAWce6qArAQJn8dpdnXTWw8sr3LkEOQyCalExwv5vO6WhDUwwYyT
        1/5auvf8/vKh69QDaFvk3VB4VmD5
X-Google-Smtp-Source: APXvYqwep1CZwfQ6aJl1QoqRpGYVDDxD5fzCNcNSm74sNotGnn08mikNmaxCj8HbojpB7emC7mINGg==
X-Received: by 2002:ad4:444a:: with SMTP id l10mr28898817qvt.194.1577185557057;
        Tue, 24 Dec 2019 03:05:57 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id o19sm7446944qtb.43.2019.12.24.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2019 03:05:56 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 11/17] rebase: extract create_autostash()
Date:   Tue, 24 Dec 2019 06:05:08 -0500
Message-Id: <1b5bbe66dc4a6034f465ce565eef4d34f8db8124.1577185374.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577185374.git.liu.denton@gmail.com>
References: <cover.1571246693.git.liu.denton@gmail.com> <cover.1577185374.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will lib-ify this code. In preparation for
this, extract the code into the create_autostash() function so that it
can be cleaned up before it is finally lib-ified.

This patch is best viewed with `--color-moved` and
`--color-moved-ws=allow-indentation-change`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/rebase.c | 94 +++++++++++++++++++++++++-----------------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a6d7527f4c..b60be5c875 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1232,6 +1232,55 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
+static void create_autostash(struct rebase_options *options)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
+
+	fd = hold_locked_index(&lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
+	if (has_unstaged_changes(the_repository, 1) ||
+	    has_uncommitted_changes(the_repository, 1)) {
+		const char *autostash =
+			state_dir_path("autostash", options);
+		struct child_process stash = CHILD_PROCESS_INIT;
+		struct object_id oid;
+
+		argv_array_pushl(&stash.args,
+				 "stash", "create", "autostash", NULL);
+		stash.git_cmd = 1;
+		stash.no_stdin = 1;
+		strbuf_reset(&buf);
+		if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
+			die(_("Cannot autostash"));
+		strbuf_trim_trailing_newline(&buf);
+		if (get_oid(buf.buf, &oid))
+			die(_("Unexpected stash response: '%s'"),
+			    buf.buf);
+		strbuf_reset(&buf);
+		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
+
+		if (safe_create_leading_directories_const(autostash))
+			die(_("Could not create directory for '%s'"),
+			    options->state_dir);
+		write_file(autostash, "%s", oid_to_hex(&oid));
+		printf(_("Created autostash: %s\n"), buf.buf);
+		if (reset_head(the_repository, NULL, "reset --hard",
+			       NULL, RESET_HEAD_HARD, NULL, NULL,
+			       DEFAULT_REFLOG_ACTION) < 0)
+			die(_("could not reset --hard"));
+
+		if (discard_index(the_repository->index) < 0 ||
+			repo_read_index(the_repository) < 0)
+			die(_("could not read index"));
+	}
+	strbuf_release(&buf);
+}
 
 int cmd_rebase(int argc, const char **argv, const char *prefix)
 {
@@ -1832,50 +1881,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		die(_("could not read index"));
 
 	if (options.autostash) {
-		struct lock_file lock_file = LOCK_INIT;
-		int fd;
-
-		fd = hold_locked_index(&lock_file, 0);
-		refresh_cache(REFRESH_QUIET);
-		if (0 <= fd)
-			repo_update_index_if_able(the_repository, &lock_file);
-		rollback_lock_file(&lock_file);
-
-		if (has_unstaged_changes(the_repository, 1) ||
-		    has_uncommitted_changes(the_repository, 1)) {
-			const char *autostash =
-				state_dir_path("autostash", &options);
-			struct child_process stash = CHILD_PROCESS_INIT;
-			struct object_id oid;
-
-			argv_array_pushl(&stash.args,
-					 "stash", "create", "autostash", NULL);
-			stash.git_cmd = 1;
-			stash.no_stdin = 1;
-			strbuf_reset(&buf);
-			if (capture_command(&stash, &buf, GIT_MAX_HEXSZ))
-				die(_("Cannot autostash"));
-			strbuf_trim_trailing_newline(&buf);
-			if (get_oid(buf.buf, &oid))
-				die(_("Unexpected stash response: '%s'"),
-				    buf.buf);
-			strbuf_reset(&buf);
-			strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
-
-			if (safe_create_leading_directories_const(autostash))
-				die(_("Could not create directory for '%s'"),
-				    options.state_dir);
-			write_file(autostash, "%s", oid_to_hex(&oid));
-			printf(_("Created autostash: %s\n"), buf.buf);
-			if (reset_head(the_repository, NULL, "reset --hard",
-				       NULL, RESET_HEAD_HARD, NULL, NULL,
-				       DEFAULT_REFLOG_ACTION) < 0)
-				die(_("could not reset --hard"));
-
-			if (discard_index(the_repository->index) < 0 ||
-				repo_read_index(the_repository) < 0)
-				die(_("could not read index"));
-		}
+		create_autostash(&options);
 	}
 
 	if (require_clean_work_tree(the_repository, "rebase",
-- 
2.24.1.810.g65a2f617f4

