Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AC31FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 08:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbcFYINM (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 04:13:12 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34572 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFYINJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 04:13:09 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so23922638lfl.1
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 01:13:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QVh/nW3OhjU5pWkY3qdf6Cw9eryOJb6gVU7CFwJsXBU=;
        b=gs3GdlowIHvCRT5V5vg3hbSMsHNFPBa+EbJYlqepr0g5flbBKF5ukKooR+qC9TY3tJ
         DCsgnpqcZXCd9CFq5TMToAksUEen5D6xX1Hq2zWge4xeTO5eKkfQK281MPgStueoUemy
         S0ibVMepbnt90bEgjsUIMWLb70mmBwdUWnYlAKTrZr+hdQ+jdNP6RJUuw4H7kzrv6C4d
         zOy7Z+B/1ME9uapXIRYcNar9+Qb9DTIOYOpw/Pjy+OXdJg6Yj+hSCDJ6c6OfoCYwhqoA
         d9knZ9zteL3wl5/YKdvCvaAKLFaLmXTnY1CvrAkxxsmvdKiYuC0dKRg7IfD/+3o4L8Rn
         PwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QVh/nW3OhjU5pWkY3qdf6Cw9eryOJb6gVU7CFwJsXBU=;
        b=NAlrWDztelEvDTttSuHLsd6qludshprZfRZCuGOdtpRagNT1fG575arNvFwZlzEAKI
         F7IlEcQrT1bpeQluXAFgUjx2afh1rONd6eDf1zMOfu4wgSd7Tpt4hW79hTxWhI1x32x9
         3rFE1x6DqAhhubxRGq0Tr6BLY6ctsL15gUIjiBjOMpciMn1LB2q/sYfDVyf0Kkokn4Ua
         r3jbhbclZGIu8PVPqG3l/lRyrijuGwzn6Ub7NpomVWZ+lbk7m8fCGDkYQwZMg5sg9a4W
         SD1V78a6sSkOEyMEiI4uZeCPWPz6r6jN6NrHrYtNyUlOtOs2ozmWU16DlgaG5SoD73jF
         S6EA==
X-Gm-Message-State: ALyK8tLjrDJOFAnaK6cpehcM/Zf8xgYhj21+Ew/hVxZZiBYWtB34PbUudJXs0ye/WrMkpA==
X-Received: by 10.25.169.7 with SMTP id s7mr2726282lfe.57.1466841287329;
        Sat, 25 Jun 2016 00:54:47 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id g79sm1536122ljg.26.2016.06.25.00.54.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 25 Jun 2016 00:54:46 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 07/10] worktree.c: add update_worktree_location()
Date:	Sat, 25 Jun 2016 09:54:30 +0200
Message-Id: <20160625075433.4608-8-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 25 +++++++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 31 insertions(+)

diff --git a/worktree.c b/worktree.c
index d5149d8..9b227a4 100644
--- a/worktree.c
+++ b/worktree.c
@@ -354,6 +354,31 @@ int validate_worktree(const struct worktree *wt, int quiet)
 	return 0;
 }
 
+int update_worktree_location(struct worktree *wt, const char *path_)
+{
+	struct strbuf path = STRBUF_INIT;
+	int ret = 0;
+
+	if (is_main_worktree(wt))
+		return 0;
+
+	strbuf_add_absolute_path(&path, path_);
+	if (fspathcmp(wt->path, path.buf)) {
+		if (!write_file_gently(git_common_path("worktrees/%s/gitdir",
+						       wt->id),
+				       "%s/.git", real_path(path.buf))) {
+			free(wt->path);
+			wt->path = strbuf_detach(&path, NULL);
+			ret = 0;
+		} else
+			ret = error_errno(_("failed to update '%s'"),
+					  git_common_path("worktrees/%s/gitdir",
+							  wt->id));
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index e782ae5..0477a3d 100644
--- a/worktree.h
+++ b/worktree.h
@@ -55,6 +55,12 @@ extern const char *is_worktree_locked(struct worktree *wt);
  */
 extern int validate_worktree(const struct worktree *wt, int quiet);
 
+/*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern int update_worktree_location(struct worktree *wt,
+				    const char *path_);
+
 /*
  * Free up the memory for worktree(s)
  */
-- 
2.8.2.526.g02eed6d

