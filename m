Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302211F404
	for <e@80x24.org>; Sat,  3 Mar 2018 03:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932082AbeCCDjf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Mar 2018 22:39:35 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34449 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932079AbeCCDje (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Mar 2018 22:39:34 -0500
Received: by mail-pl0-f68.google.com with SMTP id u13-v6so6798052plq.1
        for <git@vger.kernel.org>; Fri, 02 Mar 2018 19:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SOexYiPbUmIAPfzfY6+wtGwGckGHYKN8PQQGQdgmnUA=;
        b=FJp/ydhD/9afqNwThAEqYtQ/EZo6kA9jkaKZwVijooJCMFxVHjrght5UknhJy1QME/
         zpbG01fYFr/qdrqmxCC9gLZ5ZkmhOvj4SMHtHvmuYY9z2TLJqgo/sPY0VUJP2gfWvC97
         BbUMLswb72CMzRU8jpPdT/Pvj/gOaQdi0NrJkC8xFEXyVtFIJJzQi3JNnuvU+FQUfqjU
         Q0iII/XOlOVdjxpZgZqoegEL1Ucff0oJRzwFDh8uFQG8ZHG9oWG1YH6FouZ8LedgqFBj
         BLcmm/ZXLDcqnkvMAC5dlfI5gDhGHwr/3UyUW+uNPCbGajqu5KtE9ZER1BCoUHJtZFsc
         6Ofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SOexYiPbUmIAPfzfY6+wtGwGckGHYKN8PQQGQdgmnUA=;
        b=laS6/5DJFUK2k3iD0b8uwHvCmh8t0lCo49frNNOh//9ZC0G6keYAVBoAEf3VAw+dvD
         7CFB5ku3hxMowH8V97jVaT7sXWgWgCSExiZBfWxgq/rK5BsoADC8OGx4DmZBG/xrIxJo
         afckrzyShiLs44/mvw4va+D6d2kUSrXs//qcZ1pCQMGM1x+WMkjULdh84SjJbtlvulc+
         0kOy4hSXXk0xCDUb3HVe8W4EMpDKHxvHTYdZhKW855iDxsLPOMwMQk+9rGfgLXrTa7C0
         hshwMUYeuDseT5Q1JAtQaPZiLZ13lT5XvQtpPWxAygwMRMlOn98KA8qoO8nzt9zbLZi4
         aldA==
X-Gm-Message-State: APf1xPDToqAGvTrnVojRKaH2Uf1DtsTIPRcefgfZpqfxzxU7RB0zPEtA
        +nS7ceK/RPrDS5L+iyBlepm3AQ==
X-Google-Smtp-Source: AG47ELvnU8bYRP/+3TC1Qyi13UtsPXD3MDI231yYpeAHIk/C+7qWeCZF5/tsuVgBqa/+kUHjsFeErg==
X-Received: by 2002:a17:902:a588:: with SMTP id az8-v6mr7335451plb.10.1520048373540;
        Fri, 02 Mar 2018 19:39:33 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id a67sm11951360pgc.6.2018.03.02.19.39.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Mar 2018 19:39:33 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 03 Mar 2018 10:39:29 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/3] worktree: delete dead code
Date:   Sat,  3 Mar 2018 10:39:17 +0700
Message-Id: <20180303033918.15751-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180303033918.15751-1-pclouds@gmail.com>
References: <20180303033918.15751-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This "link" was a feature in early iterations of multiple worktree
functionality but for some reason it was dropped. Since nobody creates
this "link", there's no need to check it.

This is mostly used to let the user moves a worktree manually [1]. If
you move a worktree within the same file system, this hard link count
lets us know the worktree is still there even if we don't know where it
is.

We're having proper worktree move support now and don't need this
anymore.

[1] 23af91d102 (prune: strategies for linked checkouts - 2014-11-30)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/gitrepository-layout.txt | 5 -----
 builtin/worktree.c                     | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index c60bcad44a..e85148f05e 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -275,11 +275,6 @@ worktrees/<id>/locked::
 	or manually by `git worktree prune`. The file may contain a string
 	explaining why the repository is locked.
 
-worktrees/<id>/link::
-	If this file exists, it is a hard link to the linked .git
-	file. It is used to detect if the linked repository is
-	manually removed.
-
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 4e7c98758f..60440c4106 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -99,15 +99,7 @@ static int prune_worktree(const char *id, struct strbuf *reason)
 	}
 	path[len] = '\0';
 	if (!file_exists(path)) {
-		struct stat st_link;
 		free(path);
-		/*
-		 * the repo is moved manually and has not been
-		 * accessed since?
-		 */
-		if (!stat(git_path("worktrees/%s/link", id), &st_link) &&
-		    st_link.st_nlink > 1)
-			return 0;
 		if (st.st_mtime <= expire) {
 			strbuf_addf(reason, _("Removing worktrees/%s: gitdir file points to non-existent location"), id);
 			return 1;
-- 
2.16.1.435.g8f24da2e1a

