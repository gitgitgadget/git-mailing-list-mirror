Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E1CF211B9
	for <e@80x24.org>; Tue, 25 Dec 2018 13:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbeLYNzw (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Dec 2018 08:55:52 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:42437 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeLYNzv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Dec 2018 08:55:51 -0500
Received: by mail-io1-f65.google.com with SMTP id x6so10688120ioa.9
        for <git@vger.kernel.org>; Tue, 25 Dec 2018 05:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j8EjbI+hGXSn8IYB8+4OUotgdBXqBF/67vooZn9G8w8=;
        b=sdGjDZ1dAHWr7FY8V6T7UkpgUWouMbkWlDd5NrJbmA48aC1K+THs2kLZKxaFSjrzvD
         1mZhoWgPuQ0vuv2xCoiRpauMmF8pQfk1NTZ6dRO/ofE+pWzoCJqtlJzzdynpZI8oMWBp
         53q5PPXOINTsvR+gc+G0IUiF8aPZn9mlg1A9SD/bVpDypbIiSHOD0XL6U3roeDky6uEa
         DXCW8xyO3WEZDV9OzJihc1QsRLy6qFd0fFiEwXF8gb0b9zEcNhJWovispf9Wpe3Doa7I
         ZK4GJoABF3MkCgoF6nCZYgI3LgJzcfT8ECITgqJW4v5DbWxrZl21jV5kUuPwJjE8iqku
         Alvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j8EjbI+hGXSn8IYB8+4OUotgdBXqBF/67vooZn9G8w8=;
        b=eXufCsbFfhzh9dCwvKmi8aA8wrLe03G7XEE2E9VWg+cNklje0ZyjTCrJZzKVXWEPWd
         T5ybDcUYV0GvVwGfUB6zdpewBMOTXMCmlm166890LMcZsvY0fdVpaSvbBS73fW4bTqpq
         I151iTDz7f5r9fL8yU8o9priJIonbXhlHeXLVlhbat+AgXadvBq8foPyo9NAV7HeHZGg
         3Hp+XJDfQYvRjCRDPWCHWNrUrGB9gidZ/12rHqTHcYhiKOHk31r8mDYs1mBJhkBUqZuJ
         GYElt/Z9Vaj+HsSbRJcCFM0+72pZa+mRe6t7C9jcoK5OHuKBxX9jqrAIQ1iz2I2V6iIb
         gJKQ==
X-Gm-Message-State: AJcUukd3QqZU431L0/lOaFxLa8758nE2wAz89YQEBiSEWpPOo7Wtc1NJ
        MTXJwH0lxEBJqXh5bjwKVWnjoLg8
X-Google-Smtp-Source: ALg8bN6V3G3XzGFesMlhw6aTEiFnVtq/NE8BZ6GxPrK7hfIaTNzflMfDE82miH8hN71Cug2PrnI37A==
X-Received: by 2002:a6b:600b:: with SMTP id r11mr12021449iog.259.1545746150426;
        Tue, 25 Dec 2018 05:55:50 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [99.245.246.183])
        by smtp.gmail.com with ESMTPSA id n4sm2512387iog.36.2018.12.25.05.55.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Dec 2018 05:55:49 -0800 (PST)
Date:   Tue, 25 Dec 2018 08:55:47 -0500
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v5 1/4] commit: extract cleanup_mode functions to sequencer
Message-ID: <006f2a7039a6f370f7b84552d5d19526564229e9.1545745331.git.liu.denton@gmail.com>
References: <cover.1542768902.git.liu.denton@gmail.com>
 <cover.1545745331.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545745331.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/commit.c | 21 ++-------------------
 sequencer.c      | 29 +++++++++++++++++++++++++++++
 sequencer.h      |  4 ++++
 3 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index c021b119bb..9eb745b7ce 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1164,20 +1164,7 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		die(_("Only one of --include/--only/--all/--interactive/--patch can be used."));
 	if (argc == 0 && (also || (only && !amend && !allow_empty)))
 		die(_("No paths with --include/--only does not make sense."));
-	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_ALL :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "verbatim"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_NONE;
-	else if (!strcmp(cleanup_arg, "whitespace"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_SPACE;
-	else if (!strcmp(cleanup_arg, "strip"))
-		cleanup_mode = COMMIT_MSG_CLEANUP_ALL;
-	else if (!strcmp(cleanup_arg, "scissors"))
-		cleanup_mode = use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
-					    COMMIT_MSG_CLEANUP_SPACE;
-	else
-		die(_("Invalid cleanup mode %s"), cleanup_arg);
+	cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
 
 	handle_untracked_files_arg(s);
 
@@ -1614,11 +1601,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		die(_("could not read commit message: %s"), strerror(saved_errno));
 	}
 
-	if (verbose || /* Truncate the message just before the diff, if any. */
-	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
-		strbuf_setlen(&sb, wt_status_locate_end(sb.buf, sb.len));
-	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
-		strbuf_stripspace(&sb, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+	cleanup_message(&sb, cleanup_mode, verbose);
 
 	if (message_is_empty(&sb, cleanup_mode) && !allow_empty_message) {
 		rollback_index_files();
diff --git a/sequencer.c b/sequencer.c
index e1a4dd15f1..9c4eba06dc 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -506,6 +506,25 @@ static int fast_forward_to(const struct object_id *to, const struct object_id *f
 	return 0;
 }
 
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor)
+{
+	if (!cleanup_arg || !strcmp(cleanup_arg, "default"))
+		return use_editor ? COMMIT_MSG_CLEANUP_ALL :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "verbatim"))
+		return COMMIT_MSG_CLEANUP_NONE;
+	else if (!strcmp(cleanup_arg, "whitespace"))
+		return COMMIT_MSG_CLEANUP_SPACE;
+	else if (!strcmp(cleanup_arg, "strip"))
+		return COMMIT_MSG_CLEANUP_ALL;
+	else if (!strcmp(cleanup_arg, "scissors"))
+		return use_editor ? COMMIT_MSG_CLEANUP_SCISSORS :
+				    COMMIT_MSG_CLEANUP_SPACE;
+	else
+		die(_("Invalid cleanup mode %s"), cleanup_arg);
+}
+
 void append_conflicts_hint(struct strbuf *msgbuf)
 {
 	int i;
@@ -1003,6 +1022,16 @@ static int rest_is_empty(const struct strbuf *sb, int start)
 	return 1;
 }
 
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose)
+{
+	if (verbose || /* Truncate the message just before the diff, if any. */
+	    cleanup_mode == COMMIT_MSG_CLEANUP_SCISSORS)
+		strbuf_setlen(msgbuf, wt_status_locate_end(msgbuf->buf, msgbuf->len));
+	if (cleanup_mode != COMMIT_MSG_CLEANUP_NONE)
+		strbuf_stripspace(msgbuf, cleanup_mode == COMMIT_MSG_CLEANUP_ALL);
+}
+
 /*
  * Find out if the message in the strbuf contains only whitespace and
  * Signed-off-by lines.
diff --git a/sequencer.h b/sequencer.h
index 5071a73563..e6d937dd3c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -112,7 +112,11 @@ extern const char sign_off_header[];
  */
 void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 
+enum commit_msg_cleanup_mode get_cleanup_mode(const char *cleanup_arg,
+	int use_editor);
 void append_conflicts_hint(struct strbuf *msgbuf);
+void cleanup_message(struct strbuf *msgbuf,
+	enum commit_msg_cleanup_mode cleanup_mode, int verbose);
 int message_is_empty(const struct strbuf *sb,
 		     enum commit_msg_cleanup_mode cleanup_mode);
 int template_untouched(const struct strbuf *sb, const char *template_file,
-- 
2.20.1

