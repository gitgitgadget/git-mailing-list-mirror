Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E0541FEB3
	for <e@80x24.org>; Sun,  8 Jan 2017 09:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934805AbdAHJlM (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 04:41:12 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33612 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934644AbdAHJkk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 04:40:40 -0500
Received: by mail-pg0-f65.google.com with SMTP id 194so4169550pgd.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 01:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GTRUZxYjX9INppNnDV/G+HpuktZBuplhaODnu/t0c8=;
        b=YOdNJe9Tr6Q6rOTeaAk2XdwCxYSdQOQoj95fD0C098Tlaw5Oymsjydt3uCoTAFl6vC
         qIeStW+CdlpO6KVUnch3Pjs/3h+KdRLCHJjJgjvE5dUrfxz9MpYHC4DD51sqeGTFWN/9
         qB47B7WsQM871YDMOF35S9pU1wGw6gT+4s1aEn1kS9wZhR0vNLNxO9QQhGc/K95nZnBO
         /IfWwisTS1cxHePfVYa5nRZim6okkFmcNA5vWZ4lw6otKHYRJrwVowLUWE88n59WxjgM
         Fz7cQfSXU00PbiZQya5que6+MYbdho8Reibm1qmS7dB9SPQBMZhBkB4Mk7rnpGZC9dZy
         wC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GTRUZxYjX9INppNnDV/G+HpuktZBuplhaODnu/t0c8=;
        b=GJUrKjDZgXDFrl53meeWBgRDnBxa+sfCWm3rYVUVTuHoZ2bS5eVtGcQxAAI69l3ZPg
         T7qE4mEHZOxu/hX5beQ+BOsWvLYr5zK5upc1OLZ3eESii3uIGS9K2tmI6JO2TpxWqtTg
         +wYwCi5nIdInHTSELbREQpyI6MNVkhUVAmzxE8PROTyTLRNoYumFErNJcIWybZAwSzn8
         TMuCxh1fcEjJBHBx3IXJaeuand8hUuazlxypX6ckufO5MwnVha4fjTimz2qP07ffhDO9
         FUMrf1H0RM1vHzPcC/K8OtCoMtzzmAZhxt0cLs8Mv3L97ubDP24KfiOoYV2QngqVabM1
         i9yQ==
X-Gm-Message-State: AIkVDXKlkKT1wCe47R90IFHNrKY0us5RbJBf6cgSOF6RuztNhbrSBDcVAO1m14G0sOfqVQ==
X-Received: by 10.99.228.5 with SMTP id a5mr155656085pgi.1.1483868440177;
        Sun, 08 Jan 2017 01:40:40 -0800 (PST)
Received: from ash ([115.72.187.80])
        by smtp.gmail.com with ESMTPSA id u64sm164545840pgc.39.2017.01.08.01.40.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jan 2017 01:40:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 08 Jan 2017 16:40:35 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/6] worktree move: accept destination as directory
Date:   Sun,  8 Jan 2017 16:40:01 +0700
Message-Id: <20170108094003.637-5-pclouds@gmail.com>
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

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0d8b57c..900b68b 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -541,7 +541,13 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	strbuf_addstr(&dst, prefix_filename(prefix,
 					    strlen(prefix),
 					    av[1]));
-	if (file_exists(dst.buf))
+	if (is_directory(dst.buf))
+		/*
+		 * keep going, dst will be appended after we get the
+		 * source's absolute path
+		 */
+		;
+	else if (file_exists(dst.buf))
 		die(_("target '%s' already exists"), av[1]);
 
 	worktrees = get_worktrees(0);
@@ -559,6 +565,17 @@ static int move_worktree(int ac, const char **av, const char *prefix)
 	if (validate_worktree(wt, 0))
 		return -1;
 
+	if (is_directory(dst.buf)) {
+		const char *sep = find_last_dir_sep(wt->path);
+
+		if (!sep)
+			die(_("could not figure out destination name from '%s'"),
+			    wt->path);
+		strbuf_addstr(&dst, sep);
+		if (file_exists(dst.buf))
+			die(_("target '%s' already exists"), dst.buf);
+	}
+
 	if (rename(wt->path, dst.buf) == -1)
 		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
 
-- 
2.8.2.524.g6ff3d78

