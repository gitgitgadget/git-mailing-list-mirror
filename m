Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CE8B1F6BD
	for <e@80x24.org>; Thu,  2 Feb 2017 08:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbdBBIvC (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 03:51:02 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33755 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdBBIvB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 03:51:01 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so1020309pfg.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 00:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dsms0nVJEXqFRV8MTror5bNQaatLxr5h59yAqZwyhmM=;
        b=AYgSlBxfvljmsub3o7/theTOrr/S7ivvIDre3Lc7VCkJTGwuI/IqaebUvz3MGePo/s
         Y7YgRFPWsYbS5hZdHP9IYG7yYgwG/EZ3AWt2NuochxmdflwL6ZyJVHRgZbhk7IR3x1q8
         wC02BrpjDQf47S8Z8MVlDC24m2RBkp8O48oU5ck6pQK3aWELMS+OzIHTYQyiueGvvIQY
         b5F0FqvNd78uBuCSZZlYQEZCfE2RW6X6DEYMP8cmraqKEr70BL37HYiSGq3enU8I1BpO
         uAa861mpWEY8c+db8SZGWcJTBpsRuQk3U/DeQna8+zfUtYE9Qguf5vPqVzYnvwLSg1g6
         /R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dsms0nVJEXqFRV8MTror5bNQaatLxr5h59yAqZwyhmM=;
        b=PDwq3dd1uYHaXmtMmyzNY3uKwpYUdZn2n7kpKUBDpVIGufJU1fYkAy97foX1jxowv3
         ogXwJ81Yx92OvJh4MgVXwgE63hR4EOb1aQIo+LJQTHsnQRDZGwtufisfZ09mB/wbrfn8
         s9cjIfKSGtmfaaEdoszY4uoowce1X1D0XhNki3We0gQowi/KO+kfIeNxogf2G1qGMGuJ
         E+dqzuqqYTg3OvebbypJ5iPB2I/Jek9DRDMkVl93Rt6bOji6B5qi4Erje+Ew6nuGtAXP
         u/XDCXrPE7UhKc0Mv552ZUtwPRf/aNhr43fJh+iYWqWCuWB2ZreGpfDRb+5lqHBaq72+
         CL6g==
X-Gm-Message-State: AIkVDXIG71kbIlpfVyJxxZGqkxQY/j7ruXE+Z0Ruphe0GHt9YHY2UF4K18TNDnKSYwxJOw==
X-Received: by 10.84.248.10 with SMTP id p10mr10616331pll.87.1486025460341;
        Thu, 02 Feb 2017 00:51:00 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id p26sm56142729pfj.23.2017.02.02.00.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Feb 2017 00:50:59 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 02 Feb 2017 15:50:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/11] worktree move: accept destination as directory
Date:   Thu,  2 Feb 2017 15:50:05 +0700
Message-Id: <20170202085007.21418-10-pclouds@gmail.com>
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

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0d8b57ceb3..900b68bb5d 100644
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
2.11.0.157.gd943d85

