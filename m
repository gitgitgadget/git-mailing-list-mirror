Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4F66202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754020AbdJSQGV (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:06:21 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:49748 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753761AbdJSQGS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:06:18 -0400
Received: by mail-qt0-f196.google.com with SMTP id k31so15061111qta.6
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g3j1gWYaj3A4RBXY4TmZKvmK97wirY4dSUnx211x14Y=;
        b=UOOTcwwURZ8kqFid/sG81X0O5Wfa8SNQshtt34JFdpLsb2wKWp2xbbla4Rb+0Pihl6
         5yMNvMGVag641ZDHMhtB3I6cxalKEV5H/SZT2D9KtAm2ntYwuWjs0Halu5THFQxbmT3M
         +xWtrmkZ7GmyIhhQX9dgRW6+awBIiDwHlzMWboTgvoF7QfBG9HEbaYMmMeJwf4W7hVbh
         FA5fgZbI3c0ZxSyHzt8YlDiZBzSlDvMg55iu2tXQ5bsRegHZwCbiSPBvHat/1ncw2NSp
         +hJxzQZY5eIGxi3NEQvvktvjGstky3njBDB2UOT3flAjCIMSzOH7IkB/FLaDKCcTuYvL
         ISzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g3j1gWYaj3A4RBXY4TmZKvmK97wirY4dSUnx211x14Y=;
        b=FTqVLxE3VTJDFuhAQ94EhB85Ce4OhmeUDKQZ6G12wYORmHHw7cFp7PlIKHTZQmlEXC
         h/Vws6x4L6PSmAfKjGVoWAEN2KaqmQDGpqLiQh+HELuJyzTRCld9y+aA6vxjfv/PV+Di
         oEg7GCCAqBwfL5lfPk8/eRietjnYNqh5PdX1FOaHeitWrtSbghWa0oZN9YwGbi2NB67l
         hdB4UQX66MJcNVRl6DAxqxxE2+H86JJ8uT9DDNRIohgEQvvjKiGrt8N/nT0lPrh/GDIK
         Kt/7XBl4viX6Vfmj79YxSeI4X5Pd93vkUSJK7SrWYGmOyCYdBxe9P6NBUmIRaSbqPr8M
         oDew==
X-Gm-Message-State: AMCzsaXcJrudYQV+N0n/wLCupJbkjU6iyTTOcFlacw0YJ+FGTvr7x6bk
        F6ayEH89B8Q7O2xSYxhLZvU=
X-Google-Smtp-Source: ABhQp+ROPiUkEjS/PI36trjsOm/vr7rttVoXtDRFt+aYIPzDD/LU+jiqOI7z5MPdYPc7gHt4H9NwTg==
X-Received: by 10.200.34.71 with SMTP id p7mr2951840qtp.81.1508429178193;
        Thu, 19 Oct 2017 09:06:18 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id c13sm9377085qka.50.2017.10.19.09.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 09:06:17 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v3 2/4] status: report matching ignored and normal untracked
Date:   Thu, 19 Oct 2017 12:05:59 -0400
Message-Id: <20171019160601.9382-3-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171019160601.9382-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171019160601.9382-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach status command to handle `--ignored=matching` with
`--untracked-files=normal`

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 dir.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index b9af87eca9..20457724c0 100644
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
+		 * If 1) we only want to return directories that
+		 * match an exclude pattern and 2) this directory does
+		 * not match an exclude pattern but all of its
+		 * contents are excluded, then indicate that we should
+		 * recurse into this directory (instead of marking the
+		 * directory itself as an ignored path).
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

