Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 806532079D
	for <e@80x24.org>; Sat, 12 Nov 2016 02:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966346AbcKLCYo (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 21:24:44 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34683 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938558AbcKLCYg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 21:24:36 -0500
Received: by mail-pg0-f66.google.com with SMTP id e9so2826920pgc.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 18:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3QTHVpUtzI9+wfq+yECTHwiig7Ei6Hbn1N4xd98p9to=;
        b=vBfZdNvQym8pexnSEVllwLH+/w1MjxLI+8aUcS/xEBW9ViV1jPS7o405ZaWOMbxpKN
         2KWFZgbApMLU+WLekF7FS7PRIQ3LCgRf6v5kkZdQgU1WCKxjRUYIBb73M5z5gPvpg+Im
         YxDVhf+9TGP5xk2Mr/VyoOBkRdQ3fR6TAD7w0OK0Zz5XmpusOUTzDMc/pQVzwG0g/3oB
         MBDPieYE3pVcDdZrggoZKCsuhKzzdYxCI02rjK3w1taJPFYV9AJpdgqCSNuMWDiJ8zdv
         deYykT5WKgi7ESSeVCDaFjDYjLprTVJfmYDEALJ1pLsa5JC0Axq9/9pUm89VFjN0L/tU
         zOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3QTHVpUtzI9+wfq+yECTHwiig7Ei6Hbn1N4xd98p9to=;
        b=hJYNDmOPV+VPG8vuEjUNio5I8hT2fhm7+JONSeApQheZ7NSSEHRrCWTT2dRGK5OIIK
         sf1mzfJPIzEcL48yPnbFR5edz6xP2WxYyMAdKINla7lqQaYsmXpLDjJiAnPehQ5c56tO
         mgLUDKo0ikj6PbE1ZCvNCLzg3JxlRn6vaDqJ9ZWR93kvlOIJy8hjzbleeEq9UkQdn/bg
         JsOMFQVGDoqwrXR7CNdgl3r0Ae/GPZ7XISJohmrume34F1vkRVw4Qec19T1nNhDZ7yd5
         ivpXgCLc1Og+41xdWYZvlyca4GaF+xQJj1PYR3nox2ED/pWTpjCUb4BnMPCrTtkwjkXt
         JSpw==
X-Gm-Message-State: ABUngvcCR5bbvHOU+bX3KPY6XtL3WnQ2sbHNZjvJHWnVzq4zNIjNb/gubD1sxSwZyl3Zog==
X-Received: by 10.98.202.211 with SMTP id y80mr12950212pfk.154.1478917456716;
        Fri, 11 Nov 2016 18:24:16 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id j192sm17993142pfc.60.2016.11.11.18.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 18:24:16 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 12 Nov 2016 09:24:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/11] worktree.c: add update_worktree_location()
Date:   Sat, 12 Nov 2016 09:23:33 +0700
Message-Id: <20161112022337.13317-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161112022337.13317-1-pclouds@gmail.com>
References: <20161112022337.13317-1-pclouds@gmail.com>
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
index 7e15ec7..db63758 100644
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
2.8.2.524.g6ff3d78

