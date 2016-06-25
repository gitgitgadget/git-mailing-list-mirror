Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5B91FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbcFYILG (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:11:06 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35265 "EHLO
	mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbcFYILB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:11:01 -0400
Received: by mail-lf0-f66.google.com with SMTP id w130so23923861lfd.2
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:11:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hosgfZUPjAQcp+TysWirZyVYIW/vU9IQQH4YPYjbXp0=;
        b=SEW0A/CwZpd1ykuN8k4EGSwAV6YiXw0JI+ux/F/v9gZROvYNcu8FRxsL4lMHJXfNnB
         S57iidABei4rk4sNjfRgbtkd2K6+mMwEgZlUuVYU24XOOoemrVFlCBhi65NcaI5aWkuc
         iZg62FNVEwl7ZOzjg5h90DxtMEESZeRPniV7Uy1GIFxEiui+kSk6BdqSGtxy66129FfV
         fNv6YjusYPnbOGITtLYhLQPJbVx9quGRdPlJE/bhkLFY2wjXgjiMg8lHAEZ/lVRQc9l8
         5tfQQ2YZfuIQVjBwEvH7J/vCbJPvxpOJlw+r+57xjn0R7Awgj+p6dsFFjj+9nZsNY7Bm
         GiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hosgfZUPjAQcp+TysWirZyVYIW/vU9IQQH4YPYjbXp0=;
        b=P6woqNgHiwLFBkknqD9j/VE/Ag6mHzDge/iXeY6q6mPM0VA8f9hLycZZDonnDPpAct
         eDzOxBT3aLxyZsN7Azia27YE5JrwgHvh64ZNZGyUE/iHvhEbb5xdOrxm06EX8yq1ZoUA
         1UrebYYFRgIJP7hx7aa8Lddmi2LS9TnGW06MT3utmKDLrw2Y7suWnR6790odW/BR6e7H
         McCMyjFgF0WtV2D06Jr+k6/3Um5TFHPkGyWZdoG2GgDHwzSwu+Pyw1kBRjIRAl7PS/qC
         RafNrICTkeHJbfp3jGJELQwlWkVZF7LL2aRPlGnHeHKbFCX1olRReq9P2s9A4FudXTYG
         E7sQ==
X-Gm-Message-State: ALyK8tKvvOxBYQL9kMnr29t6S3wYnhWle/IBISFvQxkMs19I7zFdE+YKkjvAn91UQVFbkg==
X-Received: by 10.25.207.5 with SMTP id f5mr2614825lfg.45.1466841286354;
        Sat, 25 Jun 2016 00:54:46 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:45 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 06/10] worktree.c: add validate_worktree()
Date:	Sat, 25 Jun 2016 09:54:29 +0200
Message-Id: <20160625075433.4608-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625075433.4608-1-pclouds@gmail.com>
References: <20160625075433.4608-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree. For example, if a worktree is moved manually, the
worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
incorrect and we should not move that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  5 +++++
 2 files changed, 68 insertions(+)

diff --git a/worktree.c b/worktree.c
index 03f8ce9..d5149d8 100644
--- a/worktree.c
+++ b/worktree.c
@@ -291,6 +291,69 @@ const char *is_worktree_locked(struct worktree *wt)
 	return wt->lock_reason;
 }
 
+static int report(int quiet, const char *fmt, ...)
+{
+	va_list params;
+
+	if (quiet)
+		return -1;
+
+	va_start(params, fmt);
+	vfprintf(stderr, fmt, params);
+	fputc('\n', stderr);
+	va_end(params);
+	return -1;
+}
+
+int validate_worktree(const struct worktree *wt, int quiet)
+{
+	struct strbuf sb = STRBUF_INIT;
+	const char *path;
+	int err;
+
+	if (is_main_worktree(wt)) {
+		/*
+		 * Main worktree using .git file to point to the
+		 * repository would make it impossible to know where
+		 * the actual worktree is if this function is executed
+		 * from another worktree. No .git file support for now.
+		 */
+		strbuf_addf(&sb, "%s/.git", wt->path);
+		if (!is_directory(sb.buf)) {
+			strbuf_release(&sb);
+			return report(quiet, _("'%s/.git' at main worktree is not the repository directory"),
+				      wt->path);
+		}
+		return 0;
+	}
+
+	/*
+	 * Make sure "gitdir" file points to a real .git file and that
+	 * file points back here.
+	 */
+	if (!is_absolute_path(wt->path))
+		return report(quiet, _("'%s' file does not contain absolute path to the worktree location"),
+			      git_common_path("worktrees/%s/gitdir", wt->id));
+
+	strbuf_addf(&sb, "%s/.git", wt->path);
+	if (!file_exists(sb.buf)) {
+		strbuf_release(&sb);
+		return report(quiet, _("'%s/.git' does not exist"), wt->path);
+	}
+
+	path = read_gitfile_gently(sb.buf, &err);
+	strbuf_release(&sb);
+	if (!path)
+		return report(quiet, _("'%s/.git' is not a .git file, error code %d"),
+			      wt->path, err);
+
+	if (fspathcmp(path, real_path(git_common_path("worktrees/%s", wt->id))))
+		return report(quiet, _("'%s' does not point back to"),
+			      wt->path, git_common_path("worktrees/%s", wt->id));
+
+	return 0;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 90e1311..e782ae5 100644
--- a/worktree.h
+++ b/worktree.h
@@ -50,6 +50,11 @@ extern int is_main_worktree(const struct worktree *wt);
  */
 extern const char *is_worktree_locked(struct worktree *wt);
 
+/*
+ * Return zero if the worktree is in good condition.
+ */
+extern int validate_worktree(const struct worktree *wt, int quiet);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.8.2.526.g02eed6d

