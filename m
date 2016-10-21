Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B885620987
	for <e@80x24.org>; Fri, 21 Oct 2016 17:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbcJURzX (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 13:55:23 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33899 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755961AbcJURzV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 13:55:21 -0400
Received: by mail-pf0-f179.google.com with SMTP id r16so60489829pfg.1
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 10:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=try6c3OBY8tPk/BG+AITzl/iSMRntY/WL3OUOS6Ubqo=;
        b=GieI/blyZRyBQhPl13SAIlwb4YYpw9Lp+ZxIVCzXMOHn61gT+oYzrUTo+3+LSvCWwd
         dWHOX2Snvq860r5bFl4OUvV4GVoOprNHLbDjQo8lXrDCjyTXTPhGgiDnGBwfT9d71trc
         Vco0cuVtIa0QBWbyS5znsdLYBrjhpMnf2r1vNK3FyGZWgnuwbdT6kgF217aL5N7ogkEU
         0N2FrV9TuUwK45VcxCdZzZ9pwXySWBA0QZQKCdcFb1HKU/hiaUBmgZqBquH3BtBg4l5a
         /ziiSSYGiSd6NpbE5sqOT5+zaYWxWjsuy1+DBt69D0WfCXzUjhrUfru2YijwztnzYEWO
         nTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=try6c3OBY8tPk/BG+AITzl/iSMRntY/WL3OUOS6Ubqo=;
        b=GSS+qWgTnLTE6rfFW50ySP5A4wYQtYhhfmn6vLy4Ke9kCbcpJ60DVGM7zYi9QuIEU0
         lDnGXg3msxUj0Bb6GZCXBVU4/+XK1094Z53kum7AORzPbP91EroZGNvDkB1DgdCZUdue
         wSbkEJIhh5kblodSTLzjVyoWo7tduL7haiH5NgIYPtegzvIUZk21R4ZoLLVFySWAVCQe
         C+O2086V6zXsvpCfpz3+JdJNS3Lt/a2twJfMyU0OXGtbQTBYWBamvkmX1VMXtbHCFF2q
         d/TH9bVDDpJUWLAT90WCCO/DreF0szdiWzI/JY7V1PETRyX2ktcpyXH0ESnTF3kTtXmx
         /xfw==
X-Gm-Message-State: ABUngvcpJtdAd3ndZfYsRo5rWp3qwzr94IeI+T7AeoGx9jO6jwj8NixpOx0v4sZiGNcVPdr4
X-Received: by 10.98.206.1 with SMTP id y1mr3747397pfg.70.1477072519984;
        Fri, 21 Oct 2016 10:55:19 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id c75sm6714020pfb.23.2016.10.21.10.55.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 10:55:18 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sbeller@google.com,
        gitster@pobox.com
Subject: [PATCH v5 7/8] trailer: forbid leading whitespace in trailers
Date:   Fri, 21 Oct 2016 10:55:02 -0700
Message-Id: <8ed371ada381da782c3e296fe8987da0a380a7f1.1477072247.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.8.0.rc3.226.g39d4020
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1477072247.git.jonathantanmy@google.com>
In-Reply-To: <cover.1477072247.git.jonathantanmy@google.com>
References: <cover.1476232683.git.jonathantanmy@google.com> <cover.1477072247.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, interpret-trailers allows leading whitespace in trailer
lines. This leads to false positives, especially for quoted lines or
bullet lists.

Forbid leading whitespace in trailers.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-interpret-trailers.txt |  2 +-
 t/t7513-interpret-trailers.sh            | 15 +++++++++++++++
 trailer.c                                |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index cf4c5ea..4966b5b 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -55,7 +55,7 @@ The group must either be at the end of the message or be the last
 non-whitespace lines before a line that starts with '---'. Such three
 minus signs start the patch part of the message.
 
-When reading trailers, there can be whitespaces before and after the
+When reading trailers, there can be whitespaces after the
 token, the separator and the value. There can also be whitespaces
 inside the token and the value.
 
diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
index 003e90f..3d94b3a 100755
--- a/t/t7513-interpret-trailers.sh
+++ b/t/t7513-interpret-trailers.sh
@@ -241,6 +241,21 @@ test_expect_success 'with non-trailer lines only' '
 	test_cmp expected actual
 '
 
+test_expect_success 'line with leading whitespace is not trailer' '
+	q_to_tab >patch <<-\EOF &&
+
+		Qtoken: value
+	EOF
+	q_to_tab >expected <<-\EOF &&
+
+		Qtoken: value
+
+		token: value
+	EOF
+	git interpret-trailers --trailer "token: value" patch >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'with config setup' '
 	git config trailer.ack.key "Acked-by: " &&
 	cat >expected <<-\EOF &&
diff --git a/trailer.c b/trailer.c
index 199f86a..d978437 100644
--- a/trailer.c
+++ b/trailer.c
@@ -775,7 +775,7 @@ static int find_trailer_start(struct strbuf **lines, int count)
 		}
 
 		separator_pos = find_separator(lines[start]->buf);
-		if (separator_pos >= 1) {
+		if (separator_pos >= 1 && !isspace(lines[start]->buf[0])) {
 			struct list_head *pos;
 
 			trailer_lines++;
-- 
2.8.0.rc3.226.g39d4020

