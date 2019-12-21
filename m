Return-Path: <SRS0=QBG1=2L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C502C2D0D3
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC779206D8
	for <git@archiver.kernel.org>; Sat, 21 Dec 2019 22:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAiHw+KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfLUWmF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Dec 2019 17:42:05 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39570 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfLUWmE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Dec 2019 17:42:04 -0500
Received: by mail-ed1-f66.google.com with SMTP id t17so12059012eds.6
        for <git@vger.kernel.org>; Sat, 21 Dec 2019 14:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9T6LE+5EnSBdDXCcJFTrmqEdd7ryIINlYjlHeORZ+Do=;
        b=MAiHw+KBL/9k+xeWGM5Fe6ZvXtHrvRaBFy1AY6Amyq8SOFrPFQsU+99LAD2/cw5/4m
         fE356y5igGS8dBcs1dErCHWkARLEtC1ACgkzi+ExX0AwQNTimtnualK3pp6O34TX0LI9
         OqQYQaIceYxj4/0UbYV2RHQZ3J5pDF7/3pXSKLOdqpcqAwL+m8iArJkYajpDYFuAfdR8
         JQ9MDN/82JGxc/FBn/Y5dmQtrKg/eLrRUYhtGRYVXs7/MNU/zVilJg+sMEhjeR9J3yal
         xlzgLc+E20zdONgJlfTgP/3cBVf6z5n5d6gAXg2iTDUtSbxhn7I1hi8nQH12+do+R8c7
         VEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9T6LE+5EnSBdDXCcJFTrmqEdd7ryIINlYjlHeORZ+Do=;
        b=FdX0eS9d6tCwkKrxcMX2C6/iZ7wvT5InOzBTYqy8uilnn9LH/hoSRFRVv2+Cc+jeX9
         vtYZCis2SdUmyiGIxeWPKqec2UHHYcXAvl7HAutq1wSMZTueMiyrLosk7Xk3C2BuKJpL
         PMkseBPjiskjLB8+KNfRCjEc+PiaAc1YG37/cqyCriYRcE6Jq4c6cA/fNo/Sj9fh/1qH
         40knXPQJBUDm+l7Bnxmi4jegdRXPG4b8UNuKrrpIIUMwmSRiM/XKxf7angyryLMfhXqS
         eaM4StfcAc6drE3/+AAmAoOztyiDlLBqUliBNVs8E9w74wpiLLtI4GcL/I3LwygnPH8k
         h6uA==
X-Gm-Message-State: APjAAAUKcAiPbsNAlsWT98HysIHzqhCb8BQSiB1qQMxxUhXeodeKeBen
        MSSEFhNdZxI7u51zZN4/s3DdpmdS
X-Google-Smtp-Source: APXvYqy6/lasfEZ1ZLynFh/3aiim6UU7evHUIoYIyn9EXiovP3N7PRlKl5URwQkShDnkIf43BRmovQ==
X-Received: by 2002:a17:906:7c5a:: with SMTP id g26mr22938030ejp.249.1576968123150;
        Sat, 21 Dec 2019 14:42:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c25sm1547083edy.39.2019.12.21.14.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Dec 2019 14:42:02 -0800 (PST)
Message-Id: <74958419f62ee5a04b5fbc3ce6b399353f0791c8.1576968120.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.git.1576968120.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Dec 2019 22:41:53 +0000
Subject: [PATCH 2/9] built-in add -p: handle diff.algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The Perl version of `git add -p` reads the config setting
`diff.algorithm` and if set, uses it to generate the diff using the
specified algorithm.

This patch ports that functionality to the C version.

Note: just like `git-add--interactive.perl`, we do _not_ respect this
config setting in `git add -i`'s `diff` command, but _only_ in the
`patch` command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 5 +++++
 add-interactive.h | 2 +-
 add-patch.c       | 3 +++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 00c3bc9a1b..77762d75d6 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -56,11 +56,16 @@ void init_add_i_state(struct add_i_state *s, struct repository *r)
 	FREE_AND_NULL(s->interactive_diff_filter);
 	git_config_get_string("interactive.difffilter",
 			      &s->interactive_diff_filter);
+
+	FREE_AND_NULL(s->interactive_diff_algorithm);
+	git_config_get_string("diff.algorithm",
+			      &s->interactive_diff_algorithm);
 }
 
 void clear_add_i_state(struct add_i_state *s)
 {
 	FREE_AND_NULL(s->interactive_diff_filter);
+	FREE_AND_NULL(s->interactive_diff_algorithm);
 	memset(s, 0, sizeof(*s));
 	s->use_color = -1;
 }
diff --git a/add-interactive.h b/add-interactive.h
index 7299cf6e04..21389851aa 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -16,7 +16,7 @@ struct add_i_state {
 	char file_old_color[COLOR_MAXLEN];
 	char file_new_color[COLOR_MAXLEN];
 
-	char *interactive_diff_filter;
+	char *interactive_diff_filter, *interactive_diff_algorithm;
 };
 
 void init_add_i_state(struct add_i_state *s, struct repository *r);
diff --git a/add-patch.c b/add-patch.c
index 73bf2caca2..fdfaa76c3c 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -359,6 +359,7 @@ static int is_octal(const char *p, size_t len)
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct argv_array args = ARGV_ARRAY_INIT;
+	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -368,6 +369,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	argv_array_pushv(&args, s->mode->diff);
+	if (diff_algorithm)
+		argv_array_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		argv_array_push(&args,
-- 
gitgitgadget

