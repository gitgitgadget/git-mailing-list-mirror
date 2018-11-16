Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31D2B1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 15:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbeKQBcL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 20:32:11 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37930 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQBcL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 20:32:11 -0500
Received: by mail-io1-f65.google.com with SMTP id e9-v6so2005855iob.5
        for <git@vger.kernel.org>; Fri, 16 Nov 2018 07:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ge7yOa4JJV0DrGx2ODgWc7YA6oTjf+BgTvxZEomCHrU=;
        b=Gf+RGp6i5pkvLZu77O36XIhJWapjmVQHZIqhPzZ2uLamKm9yqdsRFxtMqGBl2BZvXd
         yNIybHOep7PFn8ITSk9ciGdKYkN5JElbkOa9nCMOGgUq/1OU/pnDteKG77EyN152VvKo
         6Kb1YuG0mSJBx2Qk9OQIwbWfqky10jCpB+Wq5pW1IkdslpWmteoAhpt8zFpMjZNke4mK
         BJerOasQZk26ICAnIwzTZWdN+DTL5G73IByvpy6GjVNlx8/EU+bzd81lMQbGgYJR363g
         DzerIToukGjrjl1ZV4IdlhKyXsCufPhkmSqUkQfAxFnlbTO6J+rPy9QXndKOdvAyWl+a
         tLMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ge7yOa4JJV0DrGx2ODgWc7YA6oTjf+BgTvxZEomCHrU=;
        b=OTqgTfka94aXWgqnPWCWydMitpXXF1Pqj8AGI0qpntRH5FYbaZk0On+N0hVPEJLEYV
         I2cO+LfZKquR1dpLV0SMtneP9VLjr3gAJQRQq9eo6+DCPGuOVWwYjVx98gOQs/Mpfrsl
         fmSA9g/VwZHu0scUYxEuE2vsLACJHnnXUhhdvuJ6Tw6rG2s2TEc5QhqkhpIt+1ml0t2J
         NdF7Mw3OF1K8Ktjn342iAf4sl32doiXAcMwcE460BGW7DvXHXqh3hIr9GSaW7uPIDQ3t
         gvDka2qzAvkIKInMhDSkDlAd3ZNK5xtOg5FhKBU9w2lFkiF5gdPszP+e4RHd8Yic7ewh
         3CiA==
X-Gm-Message-State: AA+aEWajevCQ9doBCJF9idW/OUV41WWIyJoELQ/BAN1bRwYgHoEuQXyf
        nEeZLaGeAy3qzgwz9RukQxXD0Wpp
X-Google-Smtp-Source: AFSGD/WqcmrHYXf/B5UuoZy0S9PSgQ3iJC5fi8C5Ffh2wwLbVrN3V00nxBCfYdt/dVrwYKUZzRTmuw==
X-Received: by 2002:a6b:3b85:: with SMTP id i127mr4163682ioa.177.1542381562144;
        Fri, 16 Nov 2018 07:19:22 -0800 (PST)
Received: from archbookpro.localdomain (ktnron0919w-lp140-01-76-68-143-166.dsl.bell.ca. [76.68.143.166])
        by smtp.gmail.com with ESMTPSA id d7sm526063ioc.74.2018.11.16.07.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 07:19:21 -0800 (PST)
Date:   Fri, 16 Nov 2018 10:19:19 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 1/2] commit: don't add scissors line if one exists in
 MERGE_MSG
Message-ID: <1698fe0d7b7356ea1762f410767dcaf2807ea5c2.1542380865.git.liu.denton@gmail.com>
References: <cover.1542172724.git.liu.denton@gmail.com>
 <cover.1542380865.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1542380865.git.liu.denton@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If commit.cleanup = scissors is specified, don't produce a scissors line
if one already exists in the MERGE_MSG file.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..a74a324b7a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -659,6 +659,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	const char *hook_arg2 = NULL;
 	int clean_message_contents = (cleanup_mode != COMMIT_MSG_CLEANUP_NONE);
 	int old_display_comment_prefix;
+	int merge_contains_scissors = 0;
 
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
@@ -719,6 +720,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			strbuf_addbuf(&sb, &message);
 		hook_arg1 = "message";
 	} else if (!stat(git_path_merge_msg(the_repository), &statbuf)) {
+		size_t merge_msg_start;
+
 		/*
 		 * prepend SQUASH_MSG here if it exists and a
 		 * "merge --squash" was originally performed
@@ -729,8 +732,14 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			hook_arg1 = "squash";
 		} else
 			hook_arg1 = "merge";
+
+		merge_msg_start = sb.len;
 		if (strbuf_read_file(&sb, git_path_merge_msg(the_repository), 0) < 0)
 			die_errno(_("could not read MERGE_MSG"));
+
+		if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+		    wt_status_locate_end(sb.buf + merge_msg_start, sb.len - merge_msg_start) < sb.len - merge_msg_start)
+			merge_contains_scissors = 1;
 	} else if (!stat(git_path_squash_msg(the_repository), &statbuf)) {
 		if (strbuf_read_file(&sb, git_path_squash_msg(the_repository), 0) < 0)
 			die_errno(_("could not read SQUASH_MSG"));
@@ -798,7 +807,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct ident_split ci, ai;
 
 		if (whence != FROM_COMMIT) {
-			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+			if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
+				!merge_contains_scissors)
 				wt_status_add_cut_line(s->fp);
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 			    whence == FROM_MERGE
@@ -824,7 +834,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 				  " Lines starting\nwith '%c' will be ignored, and an empty"
 				  " message aborts the commit.\n"), comment_line_char);
 		else if (cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS &&
-			 whence == FROM_COMMIT)
+			 whence == FROM_COMMIT &&
+			 !merge_contains_scissors)
 			wt_status_add_cut_line(s->fp);
 		else /* COMMIT_MSG_CLEANUP_SPACE, that is. */
 			status_printf(s, GIT_COLOR_NORMAL,
-- 
2.19.1

