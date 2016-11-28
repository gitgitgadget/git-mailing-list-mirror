Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB2121FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932400AbcK1JoU (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:20 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36266 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbcK1JoS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:18 -0500
Received: by mail-pg0-f65.google.com with SMTP id x23so12689800pgx.3
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GH5QLiPm9FopJm+sQ/BfXm4mWN5fGXem4Uc8XMTwHL4=;
        b=hNhgm/y9yGn1onnDNfZFtlvrLnIaDPehnD68Rx5j2bGZuVDtCwaTgdL2w/g8s3rcWA
         BPTBskVqVv03r3Mm2i7J/9sc7y2KlLMHk7OyxrYRjppDyzowgenbb8UO25CAsSETi7il
         cdHLdeBNs17rc2QIwSa6KFV8zwseODfdot/ZafcGQ8+O3SXRs4QUCWDfXci2LnCG9pWC
         SqD4PUFK2x+VCXg3X6wmJ7n/ISZkliOtXRosoYBYQCqw6q3gB2IwIhQpMxiP6drx0AaA
         qNK2Hf/mSno9QlaGDmQqEUlpPTtxa1q/m8uabRwxNZP6xlKBV0ZvcJn0SpIjyIsSjPlA
         daYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GH5QLiPm9FopJm+sQ/BfXm4mWN5fGXem4Uc8XMTwHL4=;
        b=SARujRt+xCR4tUkQa4zJoYKZpx/7iIVEimwXDqGRb/4uBpPcfYDI/efOUPCoOXuA2q
         ERliah8AKMAcjJsIAQFQmzDQRBe7szVHidl/N8hxdj8eyHmwecBoqeXPRVAYQY1yZyq2
         pEnc9ZxLJs1j5JOKqfP3NAjSIh5aEIfggqdyl4xtoWa2fs0DYR9Io/DJE1U5gilOiZHc
         l3tXmniWQtbTLBwWyY3BTtofPRzo+S5SP4y5hVZWuR0X2ahoDmNJPnmzWHdDLPLSTN11
         UI4DCQQR13m361etvwm1WcyeNDdR3cxsDMtOrCxlBeZAxecPt7+Z2IfbmNXIT1dSw3b1
         sNrA==
X-Gm-Message-State: AKaTC03MNXLHqQSPzU1fFsgz1CeN7+cn+NKSTZoV/1KHeOzZGNi6ekU2VVQCcO1jeRHcgw==
X-Received: by 10.99.63.135 with SMTP id m129mr38134554pga.16.1480326258074;
        Mon, 28 Nov 2016 01:44:18 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id t20sm85781791pfk.48.2016.11.28.01.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:44:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:44:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 07/11] worktree.c: add update_worktree_location()
Date:   Mon, 28 Nov 2016 16:43:15 +0700
Message-Id: <20161128094319.16176-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161128094319.16176-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
 <20161128094319.16176-1-pclouds@gmail.com>
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

