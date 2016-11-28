Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8738E1FC96
	for <e@80x24.org>; Mon, 28 Nov 2016 09:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbcK1Jo3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 04:44:29 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35679 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbcK1Jo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 04:44:27 -0500
Received: by mail-pf0-f193.google.com with SMTP id i88so6194126pfk.2
        for <git@vger.kernel.org>; Mon, 28 Nov 2016 01:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cVzz9lOcaffkwUtvkm6CQhPuAV9L+UWoDCAAdv9LR00=;
        b=QksZS5aYdbSdgL+4fX71H3UP94NKuVIxBx250q8NFaTHNL+pAW1UBID6OicQUG9ef5
         5EcvsKnLzZPw57KbZS+SM4U5S5bS+evUNAiBCabRvwfAeXJcppOxUI4Qusgv/4A46HxQ
         Fr5T/fFecmnRZnoBWQm8H1CmSf4lxWJktsOmHGSxqnfxwEUez2g8GPLFHysJ9ergwwsz
         UJODN9+DbWXiuv4BR2JcSTGk1zU1bl8akQs3qTatSluH4iqUzVkLKO/cz3wMUTuF+cJR
         X8aZS836SHpbZ61zCog0HPmxVyIoP0G/eDc9jby4N7ppaeVBquAQLcMtrlS6D9l31T2N
         xtew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cVzz9lOcaffkwUtvkm6CQhPuAV9L+UWoDCAAdv9LR00=;
        b=jmb8KiS7s8omM+WyLt8OsnaqdZCULgHSTuCbfnR6gYOd4ibHLXr8xoCkkmkfI3Rze7
         0m96im66QvKjQxF9NE8GNIfTwP563XQAw6o/ndMLjQCwiQFhXss7AH3hIp0mHq3MkJpQ
         ddmM4EWx7oqBBg2Z7c5viUv1B8r6Y/XVgdS6VB6eIe+FekoLGVRdTD9c/yNnXgeXBf35
         8C/cXvbJ1teD4+MeOMZtwQ3bdWkXvGYvtae3LHSL5GQMQNpYCqBaV0k76YSPMBRO1RSI
         6dVDaUSLFTldfYQNrT/93BI4SgwQLsQojUcHNi09tm4ky4ZLT3QbAbSG/5eoGBjnW1e9
         D2vA==
X-Gm-Message-State: AKaTC00WwPdK0WVZQIdMoWTqDg9R2BTjXo7rEfped4UfLdA3GxYx/1mR4eKlJnKNeoJKgQ==
X-Received: by 10.98.64.10 with SMTP id n10mr20873139pfa.168.1480326266918;
        Mon, 28 Nov 2016 01:44:26 -0800 (PST)
Received: from ash ([115.73.175.91])
        by smtp.gmail.com with ESMTPSA id z28sm67982434pgc.40.2016.11.28.01.44.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Nov 2016 01:44:26 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 28 Nov 2016 16:44:22 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 09/11] worktree move: accept destination as directory
Date:   Mon, 28 Nov 2016 16:43:17 +0700
Message-Id: <20161128094319.16176-10-pclouds@gmail.com>
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

Similar to "mv a b/", which is actually "mv a b/a", we extract basename
of source worktree and create a directory of the same name at
destination if dst path is a directory.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/worktree.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index f114965..f732a74 100644
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
 	/*
 	 * First try. Atomically move, and probably cheaper, if both
 	 * source and target are on the same file system.
-- 
2.8.2.524.g6ff3d78

