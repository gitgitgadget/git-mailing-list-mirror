Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40C741FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbdJKNfa (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:35:30 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:38543 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752465AbdJKNfX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:35:23 -0400
Received: by mail-qt0-f193.google.com with SMTP id k31so2419732qta.5
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MIWVf6B0zB0JouipJbXRNOwkfq8OfTVamG7foaiEj38=;
        b=u3I5moFmq2SpPVnOR5VzahtCtykctnC6hAt//wZHyOL04odOngBsDbZKqLMmzNCWDn
         V+mIdcHz5boYoElvaR07zVY9LzYNxOHB6qh+2i6eliObumHy0tHYRC3c0Vjl4/si1JGE
         nvbZkZ90Huw/E7froQfuNWmZi52HkkIijv3DV99ACHoVKprR1w/eyOc5gqMWJxvH++o2
         ZnoTWF9sszwaBE5+V2tU+xUks67QdR8X/23cOlpHpJK1rC4ugj6s+lz4GlRqYjLybXFj
         Nkg4yzgpFr8Jvmvi9Rq4iJA+5cJwZ9e6+AmjEaR8FZtpz/AMtfI6AutlNIEzjacYk4ui
         quyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MIWVf6B0zB0JouipJbXRNOwkfq8OfTVamG7foaiEj38=;
        b=BW4xaEbw/uFb4FzVGaP1R0+zXMttWPRpS1NdUrKkxnKeA7x0ADGbMzTocWqjv1fldA
         /gnXX2qCszgGSH1Dx+GK84FL9PU6Dh9PEACvP1JVoO11Q5UVnJxhU+zVSoGsyJS+904X
         Pcevw7nSecY5QsD6ZLsVTcXeyTIMGKFWtHl7+KnWZQtHSEJqNvVEXrkyBMhlEMHyFos+
         15CWwH61BbS/urNUO/9zWhZHAIFz1qNOwTVt3SMD3GaC50VOEqY4quW0CXy5VH32Grh9
         +OqVUWV+4nYO5QP59boflWmkWYDz21KIzKq+7Ab0iHHHBAewT/JBDhPB8qQm1ukkd2He
         cecA==
X-Gm-Message-State: AMCzsaWDpOshe9gmVe65953MoWwWd+0iciOkvpO4ppBX0einynT7bMW8
        BWQh1rQfwfLLZIMhJxTYiGM=
X-Google-Smtp-Source: AOwi7QAf8FnSLmXxyZaP+ifxGQm3M8PlPNZ9gid0PHpyo3avd1S0OvYzOtOfWgeFXPKqCoZPTihfeQ==
X-Received: by 10.55.91.199 with SMTP id p190mr19057598qkb.291.1507728922614;
        Wed, 11 Oct 2017 06:35:22 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id i1sm8192685qta.19.2017.10.11.06.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 06:35:22 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v2 4/5] Expand support for ignored arguments on status
Date:   Wed, 11 Oct 2017 09:35:03 -0400
Message-Id: <20171011133504.15049-5-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171011133504.15049-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach status command to handle matching ignored mode when showing
untracked files with the normal option.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 dir.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index b9af87eca9..8636d080b2 100644
--- a/dir.c
+++ b/dir.c
@@ -1585,6 +1585,7 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 {
 	int exclude;
 	int has_path_in_index = !!index_file_exists(istate, path->buf, path->len, ignore_case);
+	enum path_treatment path_treatment;
 
 	if (dtype == DT_UNKNOWN)
 		dtype = get_dtype(de, istate, path->buf, path->len);
@@ -1631,8 +1632,23 @@ static enum path_treatment treat_one_path(struct dir_struct *dir,
 		return path_none;
 	case DT_DIR:
 		strbuf_addch(path, '/');
-		return treat_directory(dir, istate, untracked, path->buf, path->len,
-				       baselen, exclude, pathspec);
+		path_treatment = treat_directory(dir, istate, untracked,
+						 path->buf, path->len,
+						 baselen, exclude, pathspec);
+		/*
+		 * If we are only want to return directories that
+		 * match an exclude pattern, and this directories does
+		 * not match an exclude pattern but all contents are
+		 * excluded, then indicate that we should recurse into
+		 * this directory (instead of marking the directory
+		 * itself as an ignored path)
+		 */
+		if (!exclude &&
+		    path_treatment == path_excluded &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO) &&
+		    (dir->flags & DIR_SHOW_IGNORED_TOO_MODE_MATCHING))
+			return path_recurse;
+		return path_treatment;
 	case DT_REG:
 	case DT_LNK:
 		return exclude ? path_excluded : path_untracked;
-- 
2.13.6

