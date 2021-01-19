Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF547C433DB
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79DFC23131
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbhASHqX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 02:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbhASHpI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 02:45:08 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8219EC061573
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:22 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so11727414pfu.8
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 23:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7mtNxIvW9ECJhIqOALaMt0Tbzox1k8/PQEZhG8Hwhvs=;
        b=u9kjGzeObf/PT0B1ClSt4k6LZLZOY8zsGbo/12nLx8KcO67J4+XTbyVkiesarRFLUf
         RCNkxT9OeiTxEd0+nFALepDnVoIvYzM5uvJA+c/oW2MEZBF7MQSdSGwUEH7bYBF7DCT/
         HyIAv6o1KqlVRAGJUTOdl2NA3/JcA5ZRe40q9RLmPeXeDX9ZZKeBzaOP12QfQjujpqst
         kgX24Tajv1mzbWlWY5W2Vg8qWDe+2Kt9fpIWkVUO01dyjndKQPNVysd3EwafAIO550Wl
         zxJoD7oaUbxGRbIBC6sYFE2L3JafVmroxROw3Qu+2fzJ4I0wiKhjf8xXog/qHO59HEv/
         L9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7mtNxIvW9ECJhIqOALaMt0Tbzox1k8/PQEZhG8Hwhvs=;
        b=mQVOUj8kC2j2fbnUzJhBIdB6zSNcaRPBkawfPMJrrAkSg/CN4IYX0OXThL1hmL777N
         gl0prjsiDqrxfQ9ctgRiaCOylrZF5kJTrTVPm2QleK0jMUQNZ2U4lv7R/bIgc2HOW3qB
         Gaph0msgveA+weUmOUG0pHhGYhPLxFHNff4W/1N8t4821sUdwV9bw6/qas60+z5HYEyB
         99Q9LkyPxcljvVuWGn8J8xNytF36akkji+Rryynp+rjVUaCmpxT4OfwhlnYY/JXt7MqF
         KBGAnsuoQsMQBo0t0aFJPdwTzD/akL1EW87KOr5rug1zpijVIhW82CMh6AF0schZcwRv
         ZCrA==
X-Gm-Message-State: AOAM531jgOK61WkB2mJ4EDm11c6+bDFc63p3B1fOwTN3yK0SqI79QVGo
        fU7vtS0BAcAsn0++skc7PTGkiMISYDn8aA==
X-Google-Smtp-Source: ABdhPJz8GMVeuEBYj0B3gIf11w8u049bzGd69SKzGseIAt3sm1wRd8HKN2QvnNPDWHT9EJHljKmm3w==
X-Received: by 2002:aa7:8550:0:b029:19e:46e7:913b with SMTP id y16-20020aa785500000b029019e46e7913bmr2892252pfn.58.1611042261818;
        Mon, 18 Jan 2021 23:44:21 -0800 (PST)
Received: from localhost.localdomain ([2409:4050:2d0e:58a:55d6:8648:6f7a:9f93])
        by smtp.googlemail.com with ESMTPSA id x1sm19201525pgj.37.2021.01.18.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:44:21 -0800 (PST)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     chriscool@tuxfamily.org, phillip.wood@dunelm.org.uk,
        me@ttaylorr.com, gitster@pobox.com,
        Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 5/9] sequencer: use const variable for commit message comments
Date:   Tue, 19 Jan 2021 13:11:00 +0530
Message-Id: <20210119074102.21598-6-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20210108092345.2178-1-charvi077@gmail.com>
References: <20210108092345.2178-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to use and reuse the comments.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Reviewed-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Charvi Mendiratta <charvi077@gmail.com>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 8a9adb6ff3..571000cf68 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1736,6 +1736,11 @@ static size_t subject_length(const char *body)
 	return blank_line ? len : i;
 }
 
+static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
+static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
+static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
+static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
+
 static void append_squash_message(struct strbuf *buf, const char *body,
 				  struct replay_opts *opts)
 {
@@ -1745,7 +1750,7 @@ static void append_squash_message(struct strbuf *buf, const char *body,
 	if (starts_with(body, "squash!") || starts_with(body, "fixup!"))
 		commented_len = subject_length(body);
 	strbuf_addf(buf, "\n%c ", comment_line_char);
-	strbuf_addf(buf, _("This is the commit message #%d:"),
+	strbuf_addf(buf, _(nth_commit_msg_fmt),
 		    ++opts->current_fixup_count + 1);
 	strbuf_addstr(buf, "\n\n");
 	strbuf_add_commented_lines(buf, body, commented_len);
@@ -1774,7 +1779,7 @@ static int update_squash_messages(struct repository *r,
 			buf.buf : strchrnul(buf.buf, '\n');
 
 		strbuf_addf(&header, "%c ", comment_line_char);
-		strbuf_addf(&header, _("This is a combination of %d commits."),
+		strbuf_addf(&header, _(combined_commit_msg_fmt),
 			    opts->current_fixup_count + 2);
 		strbuf_splice(&buf, 0, eol - buf.buf, header.buf, header.len);
 		strbuf_release(&header);
@@ -1798,9 +1803,9 @@ static int update_squash_messages(struct repository *r,
 		}
 
 		strbuf_addf(&buf, "%c ", comment_line_char);
-		strbuf_addf(&buf, _("This is a combination of %d commits."), 2);
+		strbuf_addf(&buf, _(combined_commit_msg_fmt), 2);
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addstr(&buf, _("This is the 1st commit message:"));
+		strbuf_addstr(&buf, _(first_commit_msg_str));
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_addstr(&buf, body);
 
@@ -1816,7 +1821,7 @@ static int update_squash_messages(struct repository *r,
 		append_squash_message(&buf, body, opts);
 	} else if (command == TODO_FIXUP) {
 		strbuf_addf(&buf, "\n%c ", comment_line_char);
-		strbuf_addf(&buf, _("The commit message #%d will be skipped:"),
+		strbuf_addf(&buf, _(skip_nth_commit_msg_fmt),
 			    ++opts->current_fixup_count + 1);
 		strbuf_addstr(&buf, "\n\n");
 		strbuf_add_commented_lines(&buf, body, strlen(body));
-- 
2.29.0.rc1

