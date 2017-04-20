Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75826207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 10:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031183AbdDTKLb (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 06:11:31 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36539 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031176AbdDTKL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 06:11:29 -0400
Received: by mail-io0-f193.google.com with SMTP id x86so14613904ioe.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 03:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=blu2o44EoUX6e/at2ZKGZ9YXlXwKWfmnlZreQEBZWbM=;
        b=QL8ULHjL4gBXovApKPmz7bRimAMveCwM9xOzm17C2dg5LC6xGCiDOEn98tTu94k7r+
         HtqQQgfhmbO+/xGllsJcrK1UtYmHEfSy4MOytRi0u8+aTb19oW7QA85eDDsOhP+Lfbw+
         sfqct0h9g1E3IAwcbWsnnJzlubVw5fMCVyNUXprbEMeuqSP+Mixk26K1X68aFyBjIbtj
         TMIPTBKTR0pboNR1sa9uKhgLJt5kBxOdysoI/+BP9iJjJGZf3aHtD5S0+xu2euKVbF6a
         u6KN5t1u+/FUFguAKbOFQUV/HXE6VDVUpO8eEvuN246CJ8GsTrMvZieRdstYSyQQM2ee
         ZFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=blu2o44EoUX6e/at2ZKGZ9YXlXwKWfmnlZreQEBZWbM=;
        b=DlCm8+zixJlRrUvkEF6Q9Hh6JX6UNceROUsh/5supj231CrZX5IEDf/8abdaP66MQA
         0sNJNIJo6/hOSWk2KFz4PYnI6Y0lpIRtqIYBVXCxzwC0jpQLclRvJW+cdGP1SJHzogE5
         8DvmWXI2ZVonIq6B+CislQZ95MmBWSJZvqUn0jSM1oqTqZc/crpHBbCZUhXjIM7Drqyj
         ENOrswpdly83fES6hGqB+n8qOEn3gjqsYmtzNvJiUBCNmZB9Pp2HU7IXsLkXysTAU8+2
         QQCKScyTkpTGciVLCfC3MPKcQrarVIm6BUL/m52vAXylu61XJHycAOrcYVIhELN1v8bB
         xBdg==
X-Gm-Message-State: AN3rC/67IAiRHW6CuhGV2GSqFjKO7SXW3AUPDxYJ5VO803Z697QcgoRy
        bMyPQsdGUUmw+w==
X-Received: by 10.99.173.6 with SMTP id g6mr7186445pgf.75.1492683083205;
        Thu, 20 Apr 2017 03:11:23 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id c83sm9523042pfd.113.2017.04.20.03.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 03:11:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 20 Apr 2017 17:11:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/6] worktree.c: add update_worktree_location()
Date:   Thu, 20 Apr 2017 17:10:20 +0700
Message-Id: <20170420101024.7593-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170420101024.7593-1-pclouds@gmail.com>
References: <20170420101024.7593-1-pclouds@gmail.com>
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
index 40cc031ac9..c695dcf982 100644
--- a/worktree.c
+++ b/worktree.c
@@ -360,6 +360,27 @@ int validate_worktree(const struct worktree *wt, int quiet)
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
index 33f7405e33..b896bdec55 100644
--- a/worktree.h
+++ b/worktree.h
@@ -63,6 +63,12 @@ extern const char *is_worktree_locked(struct worktree *wt);
 extern int validate_worktree(const struct worktree *wt, int quiet);
 
 /*
+ * Update worktrees/xxx/gitdir with the new path.
+ */
+extern int update_worktree_location(struct worktree *wt,
+				    const char *path_);
+
+/*
  * Free up the memory for worktree(s)
  */
 extern void free_worktrees(struct worktree **);
-- 
2.11.0.157.gd943d85

