Return-Path: <SRS0=LPWw=2P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F5C2D0DD
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D5B2075E
	for <git@archiver.kernel.org>; Wed, 25 Dec 2019 11:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hn6uAHYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfLYL5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Dec 2019 06:57:05 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33138 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfLYL5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Dec 2019 06:57:05 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so19776182edq.0
        for <git@vger.kernel.org>; Wed, 25 Dec 2019 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wts3H8nhhEz2jG17zS1qC1FJL1l+mQIfLvzo4D7CRNg=;
        b=hn6uAHYBZP6AoJ/6gRQSoLJt+Vc5c2OvwBrk4VnBcjwyM3t83zJFJGihC3freQdYjp
         kJ7h3HiCeepox+AirbJvL75aZcNNvXQZ0FX3do+dsHtZ/FeHjI8bZoGfjnkBaYWPW29t
         kg/cyjw/cguJkaWT6Mt+3uSGTIvS5wof7hXtd6LIviA0zxJDtUytXsbpJNBKzz2XqjKX
         ro9V3qBZ37WcWp/gcitt/Pi26261x3i2ljnY03d3y3a4rYJSHprtTIiuFtt15PfcbelC
         rGSglVbda7FOcOERMB7TP1RDuofFwC80Yd3nhl+IyYmAZ13lu3jB3IWKbfQ0LEdjLvnI
         Y+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wts3H8nhhEz2jG17zS1qC1FJL1l+mQIfLvzo4D7CRNg=;
        b=guHVnNHdtWoPxl7S2fNi073ZqGmfD2bBPpDtL0vbrs0rQTKsjrFQ9ktxqKk8xih0Tc
         tCITFOGqW3LQollNRwP1jDJVz3VaR5RAbmvKRGb3naym2bSHLAbq/+QSUna+v5WkCR/r
         m6jhKrBFqmg0RJEO8/DsgsldF5WBZABssR9csUU2NM9Djhhf9S1BXkk9keX7EoluKLJJ
         9uvDr1abq4jjU6+LxnqGxid55kBXfwEQYwllOg8FOKS4MovGy8wFxc+HUasbQbUGdYFo
         5dl4uBruZDvVRnLhcH+xDCg8n+pHUTF0a1YFU/sdp9p99/eiVltVf4iM6xHHyICjyhbx
         jWWA==
X-Gm-Message-State: APjAAAXQtztMZ1eFpDgFogE2y4yWLIxOsbAUPQXdhATdOMgMbLc28LLh
        3vbGo43tKCEpUumreU5Ba3xkjZEo
X-Google-Smtp-Source: APXvYqyINZWB8OQZ14YnG/V4uZNSSrY0mPemoSlfxtevH7GUjAj8AMcLiAyAt2k5ohxnMjvR4PPczA==
X-Received: by 2002:a05:6402:1804:: with SMTP id g4mr26334586edy.78.1577275023495;
        Wed, 25 Dec 2019 03:57:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id be18sm3074182edb.19.2019.12.25.03.57.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Dec 2019 03:57:02 -0800 (PST)
Message-Id: <e9c4a13cbfc6921cf7fbf98af9cc914a42bb5e9c.1577275020.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
References: <pull.175.git.1576968120.gitgitgadget@gmail.com>
        <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Dec 2019 11:56:53 +0000
Subject: [PATCH v2 2/9] built-in add -p: handle diff.algorithm
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
index 1786ea29c4..9e4bcb382c 100644
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
index 46c73867ad..923efaf527 100644
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
index 78bde41df0..8f2ee8688b 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -360,6 +360,7 @@ static int is_octal(const char *p, size_t len)
 static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 {
 	struct argv_array args = ARGV_ARRAY_INIT;
+	const char *diff_algorithm = s->s.interactive_diff_algorithm;
 	struct strbuf *plain = &s->plain, *colored = NULL;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *p, *pend, *colored_p = NULL, *colored_pend = NULL, marker = '\0';
@@ -369,6 +370,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
 	int res;
 
 	argv_array_pushv(&args, s->mode->diff_cmd);
+	if (diff_algorithm)
+		argv_array_pushf(&args, "--diff-algorithm=%s", diff_algorithm);
 	if (s->revision) {
 		struct object_id oid;
 		argv_array_push(&args,
-- 
gitgitgadget

