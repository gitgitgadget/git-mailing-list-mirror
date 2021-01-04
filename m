Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F0C433E0
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD3E22473
	for <git@archiver.kernel.org>; Mon,  4 Jan 2021 16:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbhADQYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jan 2021 11:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbhADQXG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jan 2021 11:23:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59679C061798
        for <git@vger.kernel.org>; Mon,  4 Jan 2021 08:22:17 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jx16so37499837ejb.10
        for <git@vger.kernel.org>; Mon, 04 Jan 2021 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAZUxbYxxP993P+SZX2kUgkP5uykVNagpbF61jA3dLw=;
        b=tgYJpdtqelD0AZp4h+d5+xeouciwq82Z2wM2QFdAHNR/VvojzFgd/24Rs4A+NhNzLL
         IzM6k2XtGKoqlX78tmx+thgfU8k1pKV5nJL5lJT6bgGJXMGrufo+/w//At+62hVtiUTo
         H214hwmEdl7IjtlC1mM7GgRfSupDpuRGPutwHNhyZ1YA8jjphDX9VfZz0DThee98DWLm
         0zKA9HwNVg9RN9NMFo105VAcy8jhOoEhlN8qdTVpZFagAu6tRyDFys1DtLIFE+Ixb7Xr
         D13fjlgFKfTUpyCUU+ipqrSdFSiZ+99r0haJ7rSe/gbg/1UcOUYpdMBttB2VQTQW5fIr
         MYCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAZUxbYxxP993P+SZX2kUgkP5uykVNagpbF61jA3dLw=;
        b=uOp2X666AQOAJiPOees+oo1rZ6nYUYljL3UEPXAQQNx2LBHX1H3cBxG0Ayehk7A/9g
         T5QZulXKChQtsQG60kjupv1ExcAfpJL0JLe/TSKxNLkGyi1Km6QhasAr3j1Z2QijmWtR
         kybEcEcg6MBLQJg4lSAwCag449KMxfJ9nDrAaw/7I41T+vkP2tt1EL4Dkehbtr5AaiJC
         cmZUrtW22wr2/OWsjTJXOmel84I2OLqQOc42tPHoDIaHA91B4/Klw4YUDyl8Xi2bydJe
         aLUQqqsuQjHoFPSmpgiubN7WsLtVkVC0HZFBIxrSB2mfwJTztJ/vlhHDAdlUndQfI51J
         XdZg==
X-Gm-Message-State: AOAM5337s0QyYyeqriLzYc131LTRUfqfzHkpCweySJvOVG9opJ9KlR5t
        KP56MD9OIceclEGYrX5NrfFS8yoGt+s=
X-Google-Smtp-Source: ABdhPJzhidi+BQX3Rx9yp5qecRVohy2UIqBit4hZjsS4QsXG8zB8koQbF3QCOE/vLZaGV+RX3FKOLg==
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr36709411ejd.449.1609777335731;
        Mon, 04 Jan 2021 08:22:15 -0800 (PST)
Received: from localhost.localdomain ([79.140.115.191])
        by smtp.gmail.com with ESMTPSA id bn21sm23931677ejb.47.2021.01.04.08.22.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Jan 2021 08:22:15 -0800 (PST)
From:   Rafael Silva <rafaeloliveira.cs@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: [PATCH 1/7] worktree: move should_prune_worktree() to worktree.c
Date:   Mon,  4 Jan 2021 17:21:22 +0100
Message-Id: <20210104162128.95281-2-rafaeloliveira.cs@gmail.com>
X-Mailer: git-send-email 2.30.0.391.g469bf2a980
In-Reply-To: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
References: <20210104162128.95281-1-rafaeloliveira.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of teaching "git worktree list" to annotate worktree that is a
candidate for pruning, let's move should_prune_worktree() from
builtin/worktree.c to worktree.c in order to make part of the worktree
public API.

This function will be used by another API function, implemented in the
next patch that will accept a pointer to "worktree" structure directly
making it easier to implement the "prunable" annotations.

should_prune_worktree() knows how to select the given worktree for pruning
based on an expiration date, however the expiration value is stored on a
global variable and it is not local to the function. In order to move the
function, teach should_prune_worktree() to take the expiration date as an
argument.

Signed-off-by: Rafael Silva <rafaeloliveira.cs@gmail.com>
---
 builtin/worktree.c | 75 +---------------------------------------------
 worktree.c         | 73 ++++++++++++++++++++++++++++++++++++++++++++
 worktree.h         | 10 +++++++
 3 files changed, 84 insertions(+), 74 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 197fd24a55..eeb3ffaed0 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -67,79 +67,6 @@ static void delete_worktrees_dir_if_empty(void)
 	rmdir(git_path("worktrees")); /* ignore failed removal */
 }
 
-/*
- * Return true if worktree entry should be pruned, along with the reason for
- * pruning. Otherwise, return false and the worktree's path, or NULL if it
- * cannot be determined. Caller is responsible for freeing returned path.
- */
-static int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath)
-{
-	struct stat st;
-	char *path;
-	int fd;
-	size_t len;
-	ssize_t read_result;
-
-	*wtpath = NULL;
-	if (!is_directory(git_path("worktrees/%s", id))) {
-		strbuf_addstr(reason, _("not a valid directory"));
-		return 1;
-	}
-	if (file_exists(git_path("worktrees/%s/locked", id)))
-		return 0;
-	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
-		strbuf_addstr(reason, _("gitdir file does not exist"));
-		return 1;
-	}
-	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
-	if (fd < 0) {
-		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
-			    strerror(errno));
-		return 1;
-	}
-	len = xsize_t(st.st_size);
-	path = xmallocz(len);
-
-	read_result = read_in_full(fd, path, len);
-	if (read_result < 0) {
-		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
-			    strerror(errno));
-		close(fd);
-		free(path);
-		return 1;
-	}
-	close(fd);
-
-	if (read_result != len) {
-		strbuf_addf(reason,
-			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
-			    (uintmax_t)len, (uintmax_t)read_result);
-		free(path);
-		return 1;
-	}
-	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
-		len--;
-	if (!len) {
-		strbuf_addstr(reason, _("invalid gitdir file"));
-		free(path);
-		return 1;
-	}
-	path[len] = '\0';
-	if (!file_exists(path)) {
-		if (stat(git_path("worktrees/%s/index", id), &st) ||
-		    st.st_mtime <= expire) {
-			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
-			free(path);
-			return 1;
-		} else {
-			*wtpath = path;
-			return 0;
-		}
-	}
-	*wtpath = path;
-	return 0;
-}
-
 static void prune_worktree(const char *id, const char *reason)
 {
 	if (show_only || verbose)
@@ -195,7 +122,7 @@ static void prune_worktrees(void)
 		if (is_dot_or_dotdot(d->d_name))
 			continue;
 		strbuf_reset(&reason);
-		if (should_prune_worktree(d->d_name, &reason, &path))
+		if (should_prune_worktree(d->d_name, &reason, &path, expire))
 			prune_worktree(d->d_name, reason.buf);
 		else if (path)
 			string_list_append(&kept, path)->util = xstrdup(d->d_name);
diff --git a/worktree.c b/worktree.c
index f84ceae87d..5764b0dc7c 100644
--- a/worktree.c
+++ b/worktree.c
@@ -700,3 +700,76 @@ void repair_worktree_at_path(const char *path,
 	strbuf_release(&realdotgit);
 	strbuf_release(&dotgit);
 }
+
+/*
+ * Return true if worktree entry should be pruned, along with the reason for
+ * pruning. Otherwise, return false and the worktree's path, or NULL if it
+ * cannot be determined. Caller is responsible for freeing returned path.
+ */
+int should_prune_worktree(const char *id, struct strbuf *reason, char **wtpath, timestamp_t expire)
+{
+	struct stat st;
+	char *path;
+	int fd;
+	size_t len;
+	ssize_t read_result;
+
+	*wtpath = NULL;
+	if (!is_directory(git_path("worktrees/%s", id))) {
+		strbuf_addstr(reason, _("not a valid directory"));
+		return 1;
+	}
+	if (file_exists(git_path("worktrees/%s/locked", id)))
+		return 0;
+	if (stat(git_path("worktrees/%s/gitdir", id), &st)) {
+		strbuf_addstr(reason, _("gitdir file does not exist"));
+		return 1;
+	}
+	fd = open(git_path("worktrees/%s/gitdir", id), O_RDONLY);
+	if (fd < 0) {
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
+		return 1;
+	}
+	len = xsize_t(st.st_size);
+	path = xmallocz(len);
+
+	read_result = read_in_full(fd, path, len);
+	if (read_result < 0) {
+		strbuf_addf(reason, _("unable to read gitdir file (%s)"),
+			    strerror(errno));
+		close(fd);
+		free(path);
+		return 1;
+	}
+	close(fd);
+
+	if (read_result != len) {
+		strbuf_addf(reason,
+			    _("short read (expected %"PRIuMAX" bytes, read %"PRIuMAX")"),
+			    (uintmax_t)len, (uintmax_t)read_result);
+		free(path);
+		return 1;
+	}
+	while (len && (path[len - 1] == '\n' || path[len - 1] == '\r'))
+		len--;
+	if (!len) {
+		strbuf_addstr(reason, _("invalid gitdir file"));
+		free(path);
+		return 1;
+	}
+	path[len] = '\0';
+	if (!file_exists(path)) {
+		if (stat(git_path("worktrees/%s/index", id), &st) ||
+		    st.st_mtime <= expire) {
+			strbuf_addstr(reason, _("gitdir file points to non-existent location"));
+			free(path);
+			return 1;
+		} else {
+			*wtpath = path;
+			return 0;
+		}
+	}
+	*wtpath = path;
+	return 0;
+}
diff --git a/worktree.h b/worktree.h
index f38e6fd5a2..e5f4320725 100644
--- a/worktree.h
+++ b/worktree.h
@@ -73,6 +73,16 @@ int is_main_worktree(const struct worktree *wt);
  */
 const char *worktree_lock_reason(struct worktree *wt);
 
+/*
+ * Return true if worktree entry should be pruned, along with the reason for
+ * pruning. Otherwise, return false and the worktree's path, or NULL if it
+ * cannot be determined. Caller is responsible for freeing returned path.
+ */
+int should_prune_worktree(const char *id,
+			  struct strbuf *reason,
+			  char **wtpath,
+			  timestamp_t expire);
+
 #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
 
 /*
-- 
2.30.0.391.g469bf2a980

