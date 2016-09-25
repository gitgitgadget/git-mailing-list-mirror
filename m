Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A8D1F935
	for <e@80x24.org>; Sun, 25 Sep 2016 03:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936222AbcIYDQY (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Sep 2016 23:16:24 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35124 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754573AbcIYDQW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2016 23:16:22 -0400
Received: by mail-pa0-f68.google.com with SMTP id zl8so287611pac.2
        for <git@vger.kernel.org>; Sat, 24 Sep 2016 20:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWOdPNJHjNd9tUwYIATsWF6AbZkcvEU1ds/k/ylllaQ=;
        b=VEuFCAcKAvt7PcLwQoWtPaUpMbBErsvkzM8KtONG3118tLLuIUJNP42u4+HxnEeRbs
         6ie6Ii8toHTFUvArtlkSKM124Ap9R+awAuLm0yDiHA0u3LIM0A/j27JOal6ShtIg3mFD
         aUtxBZBjvYuW6HxK7Z2sy63yOYmdoPWSqLIw4OSt81xePFj9dKmEF98G/ljnR9PntEO8
         6DR2K5q9EUKfGzmuhSQd+lA37tUQgzYr3ayjnfBFomXomb0/446t/tgDuG6zxb3iaSCe
         QIlanjWt4pTW3LS4R9PPouE0kKLHAxrTyTsAKAZPjsdgvt8JIosiXyeLeQQq769PDLFG
         67Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWOdPNJHjNd9tUwYIATsWF6AbZkcvEU1ds/k/ylllaQ=;
        b=W3t6Bj3TLKM/sofiG4JPO7L31GKA9Awy0OZca/JnUeSsb2Yz1Uk8jMhf3oGB3CoHIP
         7lZa5NwoN4EV+MYzFDWZjkpegztQ3o8ItNfYdnv6UlU+BFLgtMFnTnYmvGWaU9csmCim
         6fYoEkUx4A/OPoHwazIE+Yo0kAO21TOAWUbEkz/jtCs0CQR5+rYkL12elCELWp5hjX0s
         IuF7PJ5JZGG9BUjZznXa05hJ73lrEWxTEGuXmjqvXD2RF9oYU0z7TF7TjvzGhU250Ewx
         3ATqujAK5c3rutyt9RsVJLvh/Y25Jp1e6QCqXIKvbumKW+E5NPHnr6NkOoXnpVFfJoul
         yZHA==
X-Gm-Message-State: AA6/9RmVYNQhiawd68hsYgAlpRfJCj2mr1aaSYmNfDx1TYFwt83kN4H74p67pom9NMa3Ig==
X-Received: by 10.66.25.199 with SMTP id e7mr8333526pag.90.1474773382190;
        Sat, 24 Sep 2016 20:16:22 -0700 (PDT)
Received: from ash ([115.76.130.63])
        by smtp.gmail.com with ESMTPSA id c26sm14051549pfe.20.2016.09.24.20.16.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Sep 2016 20:16:21 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Sep 2016 10:16:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@drmicha.warpmail.net,
        max.nordlund@sqore.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 3/5] init: kill set_git_dir_init()
Date:   Sun, 25 Sep 2016 10:14:38 +0700
Message-Id: <20160925031440.10435-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20160925031440.10435-1-pclouds@gmail.com>
References: <20160925031329.GA9124@ash>
 <20160925031440.10435-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a pure code move, necessary to kill the global variable git_link
later (and also helps a bit in the next patch).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/init-db.c | 50 +++++++++++++++++++++-----------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index 5cb05d9..68c1ae3 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -311,34 +311,6 @@ static void create_object_directory(void)
 	strbuf_release(&path);
 }
 
-static int set_git_dir_init(const char *git_dir,
-			    const char *real_git_dir,
-			    int exist_ok)
-{
-	if (real_git_dir) {
-		struct stat st;
-
-		if (!exist_ok && !stat(git_dir, &st))
-			die(_("%s already exists"), git_dir);
-
-		if (!exist_ok && !stat(real_git_dir, &st))
-			die(_("%s already exists"), real_git_dir);
-
-		/*
-		 * make sure symlinks are resolved because we'll be
-		 * moving the target repo later on in separate_git_dir()
-		 */
-		git_link = xstrdup(real_path(git_dir));
-		set_git_dir(real_path(real_git_dir));
-	}
-	else {
-		set_git_dir(real_path(git_dir));
-		git_link = NULL;
-	}
-	startup_info->have_repository = 1;
-	return 0;
-}
-
 static void separate_git_dir(const char *git_dir)
 {
 	struct stat st;
@@ -364,9 +336,29 @@ int init_db(const char *git_dir, const char *real_git_dir,
 	    const char *template_dir, unsigned int flags)
 {
 	int reinit;
+	int exist_ok = flags & INIT_DB_EXIST_OK;
 
-	set_git_dir_init(git_dir, real_git_dir, flags & INIT_DB_EXIST_OK);
+	if (real_git_dir) {
+		struct stat st;
 
+		if (!exist_ok && !stat(git_dir, &st))
+			die(_("%s already exists"), git_dir);
+
+		if (!exist_ok && !stat(real_git_dir, &st))
+			die(_("%s already exists"), real_git_dir);
+
+		/*
+		 * make sure symlinks are resolved because we'll be
+		 * moving the target repo later on in separate_git_dir()
+		 */
+		git_link = xstrdup(real_path(git_dir));
+		set_git_dir(real_path(real_git_dir));
+	}
+	else {
+		set_git_dir(real_path(git_dir));
+		git_link = NULL;
+	}
+	startup_info->have_repository = 1;
 	git_dir = get_git_dir();
 
 	if (git_link)
-- 
2.8.2.524.g6ff3d78

