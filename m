Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67EC8200B9
	for <e@80x24.org>; Sun,  6 May 2018 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeEFOLN (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 10:11:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35457 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751232AbeEFOLN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 10:11:13 -0400
Received: by mail-wr0-f193.google.com with SMTP id i14-v6so22210267wre.2
        for <git@vger.kernel.org>; Sun, 06 May 2018 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJt3dTOsKHiG8zRE9Kq6h5LqGxqriWCO3kEmiCV44Ac=;
        b=n4dYmCIydEMwXe6f9R8EH8wSbPURBF26FL8ml3nPwOW2EroLumzU+qHVt+pWf8FhWr
         gPgZOZbgVJBTDZnjr+CCZB6ZbxOhK/kHlScYySnGdDoIgWZOUvpKvp84LpeC81Gj1Byo
         rZTY3DnTg75MciHm650O7jp1/qfN9hBxApCD5n4Yks9h5BaShYKbKgVUtHdCe3B9zMHp
         zI985r6VXYAR/DkpX5E9slvIZH28cXgioqNUjFa7odT5okJPNnzP9nmxK+/ZYsRJB8GA
         IoIbChlNzLbRJNk/KoIvxdQJUNNucq+CfCpuuWA4v1EOS5yoSsLiAXlxIYl5tRJ5rsEr
         0/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jJt3dTOsKHiG8zRE9Kq6h5LqGxqriWCO3kEmiCV44Ac=;
        b=MoRRRc0L0kfxT5J5/j5XAtWyJ8LZfA9Otmihqdjq9HRpJquHNN9TI01hCn6GT4gurq
         ZnteJawD4y+EI/Gm5akcdlLZTD6LtttYFcQHmpS3ZdTnm21G9DQLoFco/gP1XEq6H1ae
         ERCtiKf5iHjTd9/XyUMcueFlm7AbnVdmUwOLl9M+DKPq4VEIu3rXW5BanNT05LXtkkX5
         pYIiu21xv4Ob4DgiwKSyXoIuAvnJP7kBtXroYaZ/JKURTEdEEW2IkwedtI0PLTo58YXo
         UMOMydy7kYqB6a12VjuThMdavr7sAoIVGDf1lBvdXB6gz2pT3a9HJLM2BMoVfGxEjsJ6
         XR+Q==
X-Gm-Message-State: ALQs6tAL3j0Z09orCOumz0q5eXJUX1wDKm92CNntZPgzSDS5UK2v+nDR
        k2ZZrdbkErkhKex+2GV4isIeG6LI
X-Google-Smtp-Source: AB8JxZpDl9rexxbJQ3Z+dMqz/BrPgjXeykqxTJ0XiafERFtuca1OrMCrQKvuq3PdPjPd9YUmtJChEA==
X-Received: by 2002:adf:8df7:: with SMTP id o110-v6mr28310807wrb.251.1525615871506;
        Sun, 06 May 2018 07:11:11 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id p17sm4914857wmc.17.2018.05.06.07.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 May 2018 07:11:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     David Turner <novalis@novalis.org>
Subject: [PATCH 3/5] refs.c: drop dead code checking lock status in `delete_pseudoref()`
Date:   Sun,  6 May 2018 16:10:29 +0200
Message-Id: <20180506141031.30204-4-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.411.g9fd64c8e46
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After taking the lock we check whether we got it and die otherwise. But
since we take the lock using `LOCK_DIE_ON_ERROR`, we would already have
died.

Unlike in the previous patch, this function is not prepared for
indicating errors via a `strbuf err`, so let's just drop the dead code.
Any improved error-handling can be added later.

While at it, make the lock non-static and reduce its scope.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 refs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 8c50b8b139..7abd30dfe1 100644
--- a/refs.c
+++ b/refs.c
@@ -689,20 +689,17 @@ static int write_pseudoref(const char *pseudoref, const struct object_id *oid,
 
 static int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
 {
-	static struct lock_file lock;
 	const char *filename;
 
 	filename = git_path("%s", pseudoref);
 
 	if (old_oid && !is_null_oid(old_oid)) {
-		int fd;
+		struct lock_file lock = LOCK_INIT;
 		struct object_id actual_old_oid;
 
-		fd = hold_lock_file_for_update_timeout(
+		hold_lock_file_for_update_timeout(
 				&lock, filename, LOCK_DIE_ON_ERROR,
 				get_files_ref_lock_timeout_ms());
-		if (fd < 0)
-			die_errno(_("Could not open '%s' for writing"), filename);
 		if (read_ref(pseudoref, &actual_old_oid))
 			die("could not read ref '%s'", pseudoref);
 		if (oidcmp(&actual_old_oid, old_oid)) {
-- 
2.17.0.411.g9fd64c8e46

