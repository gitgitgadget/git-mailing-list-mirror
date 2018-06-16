Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 300C21F403
	for <e@80x24.org>; Sat, 16 Jun 2018 05:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756826AbeFPFmK (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Jun 2018 01:42:10 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40716 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754008AbeFPFmF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jun 2018 01:42:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id q11-v6so17517247lfc.7
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 22:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4D47gEPdnxfyJNxvk3IArmPkBnco3cXQq8QM80z0wI0=;
        b=VnJmx7s5ayUZ8qs5d33RzpKjlb2W//NLhko9xq6eWuI7DdnvTYCoVPegG/u1k5mvql
         3YV06YNM8GTKLpoe/nz9fzBaZsHpyjwDsqHYgVBlMXA7tO4+HgUYnie/OKS+Hh7Ff/ek
         HpGP8MkkWDQR8qYRn4EaXrbA2wY5fNTtE6ctQvveNw9hr5oT9oRuQpA132vmo0VhSkWI
         CunfyYBoqfdomOQSNDAx9jNsHNMpzYYc6AxilZsShpPqrrR6UbkzjJM4OATWPaVlLjiO
         LBqI2/zwNqHTRY1D5JPUdI35bVz1yChWxmomlkrxuEUSddTZ+Ozg38CmYLgsYjaGkL6x
         xLxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4D47gEPdnxfyJNxvk3IArmPkBnco3cXQq8QM80z0wI0=;
        b=AOW8iWOchIeGICQXusRWF//nrBHg5kPtY37tg94wj8LMsWc5PgCu4skMMJpXf+8Lkh
         Wq9nb4KJXDTZgBPEwBjXqhU/ObMyRbCpqnNsSEDNvMeRJD4CLj0tLf/bfAUXjxl0TBFO
         p616W/DovZjrXq+d7c5pfi7PlXwZFCs+djbqZfEhUDD7aqmbtvfooUS5W6zspY7KEV4o
         9t+LLZwPRbWEj9wYGAik9u3OfX6HEuNc+tDFSFyYZyMFcaWyuckaNn7sW3ksVoW8wNaE
         w4DG4ASbRQ7z5A63f6BQCzC3419b5YJdwtsOihq/p20baMvVbEGCmgwRjRLCtf5lcBoa
         bbHQ==
X-Gm-Message-State: APt69E2IZl5jzGu9J0S3Upd36kGhIOdCTNiIbQP7AVEuLybtD9xTENdB
        JzHSE3vLIo05tjdogxuMx2Sgxg==
X-Google-Smtp-Source: ADUXVKITGY6+FzWVxIpRjYa5CagkY3eW0LjuByM18x15RNWW8hlglZb0oeEiqvw113pggkEzA/zQ1A==
X-Received: by 2002:a2e:4442:: with SMTP id r63-v6mr3180315lja.89.1529127723953;
        Fri, 15 Jun 2018 22:42:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g5-v6sm1745194lje.21.2018.06.15.22.42.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 22:42:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/15] blame.c: stop using index compat macros
Date:   Sat, 16 Jun 2018 07:41:45 +0200
Message-Id: <20180616054157.32433-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180616054157.32433-1-pclouds@gmail.com>
References: <20180616054157.32433-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 blame.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/blame.c b/blame.c
index 14d0e0b575..c357cf2f49 100644
--- a/blame.c
+++ b/blame.c
@@ -85,11 +85,11 @@ static void verify_working_tree_path(struct commit *work_tree, const char *path)
 			return;
 	}
 
-	pos = cache_name_pos(path, strlen(path));
+	pos = index_name_pos(&the_index, path, strlen(path));
 	if (pos >= 0)
 		; /* path is in the index */
-	else if (-1 - pos < active_nr &&
-		 !strcmp(active_cache[-1 - pos]->name, path))
+	else if (-1 - pos < the_index.cache_nr &&
+		 !strcmp(the_index.cache[-1 - pos]->name, path))
 		; /* path is in the index, unmerged */
 	else
 		die("no such path '%s' in HEAD", path);
@@ -159,7 +159,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	unsigned mode;
 	struct strbuf msg = STRBUF_INIT;
 
-	read_cache();
+	read_index(&the_index);
 	time(&now);
 	commit = alloc_commit_node();
 	commit->object.parsed = 1;
@@ -240,14 +240,14 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	 * bits; we are not going to write this index out -- we just
 	 * want to run "diff-index --cached".
 	 */
-	discard_cache();
-	read_cache();
+	discard_index(&the_index);
+	read_index(&the_index);
 
 	len = strlen(path);
 	if (!mode) {
-		int pos = cache_name_pos(path, len);
+		int pos = index_name_pos(&the_index, path, len);
 		if (0 <= pos)
-			mode = active_cache[pos]->ce_mode;
+			mode = the_index.cache[pos]->ce_mode;
 		else
 			/* Let's not bother reading from HEAD tree */
 			mode = S_IFREG | 0644;
@@ -259,7 +259,8 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	ce->ce_flags = create_ce_flags(0);
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
-	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD|ADD_CACHE_OK_TO_REPLACE);
+	add_index_entry(&the_index, ce,
+			ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
 
 	cache_tree_invalidate_path(&the_index, path);
 
-- 
2.18.0.rc0.333.g22e6ee6cdf

