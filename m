Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 320091F97F
	for <e@80x24.org>; Wed, 14 Nov 2018 05:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbeKNP0f (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 10:26:35 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42320 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNP0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 10:26:35 -0500
Received: by mail-io1-f67.google.com with SMTP id h19-v6so10786412iog.9
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 21:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uVPq+k7fzn2aWkjdYWn9mxk3TChnXCXerFAxSKB2PFo=;
        b=n1nMRb3kL2xj0JPt9Je9DvrhM91cuEp8dayxjhGMd1S5M+BERErIv7MNeNUL3kChj+
         2laQXa8Efq6Nt2hemei2EOoAnuzfbjVRgevBZfDN1NVbrJmb88KH3Z1cYf/xFLgaTfJc
         gIoQNlZxFNebdeUJTIGHRbfOguvN2iFraeIxu419XnKXlCmKXUVP9RuXqwpfxX7O+GM+
         gO4fxl4K2d35FsMEf131yGMSVsMMigYONuHyffQQy5wTQD1f1t9az7DQJPQNaeOTGM6o
         R+wCrKGbLLciuxT3RWoe9cCUiydUv9axo9OT/urNndJAZsohpLERNBQOEbQKbG2o+tmI
         mxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVPq+k7fzn2aWkjdYWn9mxk3TChnXCXerFAxSKB2PFo=;
        b=XBp6Pg513u8wYgeR7w8PpHwM4F31csf5PDXlsAKfpo84ae7qLR3DIZNYWCZl3jBHjc
         u47w3JiTmElsON4aEcdiqnztTWNmEofmsCXv96P33An3vmxacnijDAqkSRJYS0C7gBNQ
         4H1k/Ovr/oS1j/OTtwltXsuWRdhVNMxtnOP+s0J7N7ObRKVrriFNJ1wv9S3mlXbuwAHo
         LH531ANPlwv5LzZZs+3xnV5VF0pxCc7/XpKguplJyRL2L6t9jcqNXPbwUprSUxwjyOu/
         ZUfq6xIq7IJB0mPafnAn1hmyroc/gQBX3bNgVU94qUfvuhHaO07aJ3s2vkG1BtJCdxhI
         qtqQ==
X-Gm-Message-State: AA+aEWazMt7hzHb0OZQN/6O4vkRgGtgC3XiTAW7tViLrOD5zMgYTCEL2
        E6dHNomLz80bs1wZ5Q4aHtSJJsEw
X-Google-Smtp-Source: AJdET5eglK69TGMr+Iumx8H/VKOJC8tflf/mbEH0vfrwy5I4cl+M7ChwCDVdsNhLfcumKnOeSZTocA==
X-Received: by 2002:a6b:1582:: with SMTP id 124-v6mr352820iov.204.1542173095263;
        Tue, 13 Nov 2018 21:24:55 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id u3-v6sm7393956iog.33.2018.11.13.21.24.54
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 21:24:54 -0800 (PST)
Date:   Wed, 14 Nov 2018 00:24:53 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 1/2] commit: don't add scissors line if one exists
Message-ID: <1c16b9497bd630f0636aa7729082da7a90ba42d9.1542172724.git.liu.denton@gmail.com>
References: <cover.1542172724.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542172724.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If commit.cleanup = scissors is specified, don't produce a scissors line
if one already exists in the commit message.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..e486246329 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -659,6 +659,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -742,6 +743,10 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		clean_message_contents = 0;
 	}
 
+	if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+		wt_status_locate_end(sb.buf, sb.len) != sb.len)
+	    contains_scissors = 1;
+
 	/*
 	 * The remaining cases don't modify the template message, but
 	 * just set the argument(s) to the prepare-commit-msg hook.
@@ -798,7 +803,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -824,7 +830,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
-			 whence == FROM_COMMIT)
+			 whence == FROM_COMMIT &&
+			 !contains_scissors)
 			wt_status_add_cut_line(s->fp);
 		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
-- 
2.19.1

