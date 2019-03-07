Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65E8620248
	for <e@80x24.org>; Thu,  7 Mar 2019 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbfCGM3g (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 07:29:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36851 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfCGM3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 07:29:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id n22so11319170pfa.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 04:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=puRqpV1o7yuxTAlTCMZELyeOKL/ASvEVQ6x4Ef7Qxx0=;
        b=POknR4I+cFsBqq1c07yhMq3v5hQT0WcKyBNTbYxWFuLrPnVm+xavadpx7j1hw1pVRH
         jdDZGxZ/qgfaP5NOUzXyvj9EHqPDd2VJS2blugfgS78s6W59NJYvBGJycZCl+aLMmhL4
         E8O1Aomv7tl4c/OR8A09Igp7OkDWnlhsMLFwl20Ft45IZyzDtQhRwbdxx4iP3K+wYSMe
         WsLh+gpSp3sJmCExXNU93TfR+AbpP0PziZtYz5KSvN89Xa5eCnlMtqZMH0aNI+BnBLm2
         Fq7NCMbo7MpoGPF9ssnm/awydGLDkgBAvfXhIRqli/R5SRdYuzM6xo8cPU00iD/DY6l+
         U8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=puRqpV1o7yuxTAlTCMZELyeOKL/ASvEVQ6x4Ef7Qxx0=;
        b=StWGk59Nx+ijhrGEODJ/jEuUY7G5rSV1RCiKfIUmUxlAkJIzN8ZBB03/RiGbtK/N86
         +HD0ETGXCUDfRTtbMhh4EVNfKHy9/kiqfeUKyfIZca1RReF6Rza6mg4CgrPyEzE63xFg
         lImCpVbOe7a1pLAVV0aoo1siwfHAcw1mskq6oyj5jqT5ERkgHv0xXqSSNSCOjV/SW7gg
         5FpGixtbZEjl1387PbcUNjT2pwUsP5cM4ctRDhiMVr/z/TCdrrSeMNwGnBfZiM6KFY0x
         lFr50BKDY0h4YaXVdkDBfI7FtGFoh/y1z0XiBh10p9qXN07PLBNO4PWMc8t0PRFKqWpO
         b9bQ==
X-Gm-Message-State: APjAAAWi8avmEgfxuVnf35S/rhrpaP8OcR5XLhRm5zkBdJQvdytnEBSX
        FbGe84CojkLszAKls2WoY4s=
X-Google-Smtp-Source: APXvYqxJy9i+6vx0Ph/UQ5oNEc5o5P8qmF+gOXV1rXPrU8QjFuTbbTzjYwCr8UPC+ZD4F9iAC+83Rw==
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr12845781plo.52.1551961775303;
        Thu, 07 Mar 2019 04:29:35 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id q7sm14256018pfa.119.2019.03.07.04.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 04:29:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Mar 2019 19:29:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     phillip.wood123@gmail.com
Cc:     git@vger.kernel.org, pclouds@gmail.com, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] files-backend.c: reduce duplication in add_per_worktree_entries_to_dir()
Date:   Thu,  7 Mar 2019 19:29:16 +0700
Message-Id: <20190307122917.12811-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190307122917.12811-1-pclouds@gmail.com>
References: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
 <20190307122917.12811-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function is duplicated to handle refs/bisect/ and refs/worktree/
and a third prefix is coming. Time to clean up.

This also fixes incorrect "refs/worktrees/" length in this code. The
correct length is 14 not 11. The test in the next patch will also cover
this.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 26417893c8..3d0e06edcd 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -221,22 +221,22 @@ static void files_ref_path(struct files_ref_store *refs,
  */
 static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dirname)
 {
-	int pos;
+	const char *prefixes[] = { "refs/bisect/", "refs/worktree/" };
+	int ip;
 
 	if (strcmp(dirname, "refs/"))
 		return;
 
-	pos = search_ref_dir(dir, "refs/bisect/", 12);
-	if (pos < 0) {
-		struct ref_entry *child_entry =
-			create_dir_entry(dir->cache, "refs/bisect/", 12, 1);
-		add_entry_to_dir(dir, child_entry);
-	}
+	for (ip = 0; ip < ARRAY_SIZE(prefixes); ip++) {
+		const char *prefix = prefixes[ip];
+		int prefix_len = strlen(prefix);
+		struct ref_entry *child_entry;
+		int pos;
 
-	pos = search_ref_dir(dir, "refs/worktree/", 11);
-	if (pos < 0) {
-		struct ref_entry *child_entry =
-			create_dir_entry(dir->cache, "refs/worktree/", 11, 1);
+		pos = search_ref_dir(dir, prefix, prefix_len);
+		if (pos >= 0)
+			continue;
+		child_entry = create_dir_entry(dir->cache, prefix, prefix_len, 1);
 		add_entry_to_dir(dir, child_entry);
 	}
 }
-- 
2.21.0.rc1.337.gdf7f8d0522

