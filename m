Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FD751F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751139AbdBBIuw (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:50:52 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36061 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751129AbdBBIuv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:50:51 -0500
Received: by mail-pg0-f68.google.com with SMTP id 75so1251134pgf.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kNy3LEtzppLR/Ay+f0171RHlChC/Tkof3CxrMz7dfY=;
        b=PVk8Oa7pIGQcbRsciYXgTBYY6EJx5YYgrIwCZoxwjR1X+k4Zgn0wI7Ldlr08WMnyHh
         DEwrPmAu4L3X/vEWhTj9QCDeAvayt8D73IQ8E4ixAKs0jaTv5RAFstACTmUqJnPjccvs
         fGPLVu4vhRpiFuwJOnfTIqLac3RqI+VE03NWUEe5wI0kaiN5Skk4Z+Mvb6vUpE3uXTCZ
         R2KaSV1pU4/pF751hYtTpL/2NGAd1kzcityYczze7l7fds1XIXOlPBl7V4c5j3yaQAxm
         pfFDeFBSkPYPVnYG1p4BsVUZ0CP4sh6R3lIxbBAJLaVN36XCkiQzGGXDwdwxZqllUB14
         2SCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kNy3LEtzppLR/Ay+f0171RHlChC/Tkof3CxrMz7dfY=;
        b=RPy+y28NpkAqh5e/hplKNNWc9CQf8emOOjZBKL9cLhOlI3IdizzacEU8YJpLDY4Pr3
         A8vKy2U2+V8AGtU/U7VCjZlU+YEvq3aJvOJN5KbJ8tI0P6GI3sUaca/vd+v/SJLI1pgG
         ZpR00/bxMfjuXUJ/gGslN1a8hCMWHdTih9nrMS1ykmGZ0nBImS7cbjZD4rQX/Ymsx0WL
         KwuFEySMaJ9O8RQFQVbeLZNBCEM4gZzUCR4+154K1AcBNdNqWWNp1tf0ETQ/pLJuchgs
         H0gnEEYquiOgVnev2sdvv0fHIUsW6qnoljIIeKuAI/x/F26ttJO2nHl4lBRjimSAIRJ3
         Esiw==
X-Gm-Message-State: AIkVDXK1335YyKEs6W5QPBQZ7l1PY+0gnIDJ09Hcv68tdTRsbY09yLqThG/nP/dbpgo7yA==
X-Received: by 10.98.159.80 with SMTP id g77mr9077036pfe.34.1486025445223;
        Thu, 02 Feb 2017 00:50:45 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id c11sm56105051pfe.68.2017.02.02.00.50.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:39 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/11] worktree.c: add validate_worktree()
Date:   Thu,  2 Feb 2017 15:50:02 +0700
Message-Id: <20170202085007.21418-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170202085007.21418-1-pclouds@gmail.com>
References: <20170202085007.21418-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is later used by "worktree move" and "worktree remove"
to ensure that we have a good connection between the repository and
the worktree. For example, if a worktree is moved manually, the
worktree location recorded in $GIT_DIR/worktrees/.../gitdir is
incorrect and we should not move that one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 worktree.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 worktree.h |  5 +++++
 2 files changed, 68 insertions(+)

diff --git a/worktree.c b/worktree.c
index eb6121263b..929072ad89 100644
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
index d59ce1fee8..4433db2eb3 100644
--- a/worktree.h
+++ b/worktree.h
@@ -53,6 +53,11 @@ extern int is_main_worktree(const struct worktree *wt);
 extern const char *is_worktree_locked(struct worktree *wt);
 
 /*
+ * Return zero if the worktree is in good condition.
+ */
+extern int validate_worktree(const struct worktree *wt, int quiet);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
-- 
2.11.0.157.gd943d85

