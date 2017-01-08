Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF51D1FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934731AbdAHJkw (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:40:52 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33691 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934527AbdAHJkb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 04:40:31 -0500
Received: by mail-pf0-f194.google.com with SMTP id 127so22564129pfg.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 01:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH5QLiPm9FopJm+sQ/BfXm4mWN5fGXem4Uc8XMTwHL4=;
        b=C74Ka3guboOIMtNCNtXNDwWZd/yjJcFlraMteSmZijSBG2SscPke4E1KFRZtAVFXVM
         5DXE/J9GE+Knt5h2OxEqqkbVGRmpL7/rKK092PXG7Fx2aVrlPJAwVoRLyzV08xnkhwmG
         HXgcPxThTBFdfT97wxZDZGTmKTldT5LE4arBiBuSWCWkG/Jz+N/JwAzE90+Pgjc1LpZd
         aYn4kvqOFVDSHtyX86KXBjxV2wazC+7PaPkMaRYI+GyzV265ZOQgRx5pDi6/sSIHn5Hh
         g0HrklbabpeR8cleARtxTuzmsfBuiye99YgO9/6kc9OeQs9IVmy18ryj0Gg81i0sh+VD
         SVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH5QLiPm9FopJm+sQ/BfXm4mWN5fGXem4Uc8XMTwHL4=;
        b=L6iT1BrKsYDJfVDCrXbR9A898Nrak/+UUsE0ipm/+Ly5be5zOA4mZtILlK8lefWD6n
         wXGFBnU2CAIIV5BZ4usGcjTwpO8Id9ujdHLRN/2PiUhjelwDrDYzlqF5OCY+9Kjh6HW3
         wiCO3UAujIqd/bGEHBc0ch9tJaVreCV4wrECAofyYNmbLTWBCN8sqq9kAYn7ugg2+Tay
         sUQWfcBCQYk+ePVKLhkJPjp0FyxeyWGhPJclYiVUCv5VYh+pA19TGms5IR4ESbx+dXKB
         tV4Dj679geb1Df3cu0g7JLhau5vVp18vbQcAuZVi5tYRDbjC8bYXua8nNzu+VVuZtdyY
         4gCQ==
X-Gm-Message-State: AIkVDXJbu+njLF8BdaXC2NQrAPASDvMdyGE9+sepj/qo2Ce6Rkj0mixpffl/GzakjQDM0w==
X-Received: by 10.84.217.19 with SMTP id o19mr176015209pli.21.1483868431108;
        Sun, 08 Jan 2017 01:40:31 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id e184sm23976758pfc.28.2017.01.08.01.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 01:40:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 16:40:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/6] worktree.c: add update_worktree_location()
Date:   Sun,  8 Jan 2017 16:39:59 +0700
Message-Id: <20170108094003.637-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170108094003.637-1-pclouds@gmail.com>
References: <20170108094003.637-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 worktree.c | 21 +++++++++++++++++++++
 worktree.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/worktree.c b/worktree.c
index 929072a..7684951 100644
--- a/worktree.c
+++ b/worktree.c
@@ -354,6 +354,27 @@ int validate_worktree(const struct worktree *wt, int quiet)
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
+		write_file(git_common_path("worktrees/%s/gitdir",
+					   wt->id),
+			   "%s/.git", real_path(path.buf));
+		free(wt->path);
+		wt->path = strbuf_detach(&path, NULL);
+		ret = 0;
+	}
+	strbuf_release(&path);
+	return ret;
+}
+
 int is_worktree_being_rebased(const struct worktree *wt,
 			      const char *target)
 {
diff --git a/worktree.h b/worktree.h
index 4433db2..1ee03f4 100644
--- a/worktree.h
+++ b/worktree.h
@@ -57,6 +57,12 @@ extern const char *is_worktree_locked(struct worktree *wt);
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
2.8.2.524.g6ff3d78

