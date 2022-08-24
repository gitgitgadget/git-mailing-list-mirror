Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BEAC04AA5
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 21:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239611AbiHXVWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239719AbiHXVV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 17:21:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FE2167D6
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so1613974wmk.3
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=ikFQWEfRdIynsdVGW6fUd+BYEfs3PqfKzNFN9wLsLzY=;
        b=KyigMd3p6TIGFFzKnTb5CYHrt2hpeEqd1GjjiBXJ5RG/rVd/BXcDbN8w4Jq5WBF01K
         bNb4ZZOyjzx2QOA5mcRrKKUJ17/KhQYhBU9aWfNarQP2Nptv/nVGoueJP8hy+3iKhkHe
         D8YO1qmJwOVCPmD9382qyoAfPZlUGPvTNpwuRr6Zo4uE6+XHQi4L9dP/Axbv+5IFZmKM
         JGeZQq6LZvj7fuSSa5TujWAvTGjXkZb5YRxkwElXtO89UOojq+nshGt5ekDxSswRIRbD
         uufRhrF7kxH4BHbTEZl9ASmfs49a7g0k3EYJB3YFjwjN8d5qdKKbHj9bLXmmqNUQToPv
         YfKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=ikFQWEfRdIynsdVGW6fUd+BYEfs3PqfKzNFN9wLsLzY=;
        b=OuDsQij2/vIroMBD/zJW6ho7D+vo3kX9b+QJ3UKU+5hB2YzYDKDRbOx9j0UPa66EXt
         h0N1YeoPzrmhU1N/QX4vC5TcQslpplBLNNzmZI+fEtt4mWq8//aWzC3G09tzFMGdJ6Oe
         rGxrrY+aBOH7iJQ74smv8zGSj0Aww3Lnp9X5iJ1KSa9TpUmCkYURyyhRdasp8c11rgQP
         Zaaf3zqHZ1sC1rba3u13K1Biha9BLKHSpPnQacK39xL4Da2Z0JYjSBLdxUPZtJ74YTH8
         pJJG8BvFHPsai72BNKv0AfihVmQx7TddxVa051K14pS+rLuAllqMnlQJgpAvVjMd1VBp
         jQCw==
X-Gm-Message-State: ACgBeo1ypEnbSDDDOIF/3Uqg44EcQgKxKceuD/gmAzYnM79Ea46B3jxE
        AKQSqCUJO7v5+KDYPYi9zVXEkmDTLrU=
X-Google-Smtp-Source: AA6agR7u3VZMjUb9w13m0d/z4C574Yx2nHygCLpOTcjoVPrIb5iaPBIYmO+sR7kopfwPeJEJbpdtlQ==
X-Received: by 2002:a05:600c:2f88:b0:3a5:4014:4b47 with SMTP id t8-20020a05600c2f8800b003a540144b47mr6294358wmn.96.1661376115879;
        Wed, 24 Aug 2022 14:21:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdb92000000b0021eaf4138aesm22160088wri.108.2022.08.24.14.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 14:21:55 -0700 (PDT)
Message-Id: <9dac9f74d2e19899b3e6c1d28e83878ded4469d6.1661376112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
References: <pull.1336.git.1661277870.gitgitgadget@gmail.com>
        <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 24 Aug 2022 21:21:50 +0000
Subject: [PATCH v2 3/4] add -p: handle `diff-so-fancy`'s hunk headers better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `diff-so-fancy` diff colorizer produces hunk headers that look
nothing like the built-in `add -p` expects: there is no `@@ ... @@` line
range, and therefore the parser cannot determine where any extra
information starts, such as the function name that is often added to
those hunk header lines.

However, we can do better than simply swallowing the unparseable hunk
header. In the `diff-so-fancy` case, it shows something like `@ file:1
@`. Let's just show the complete hunk header because it probably offers
useful information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c                | 8 +++++++-
 t/t3701-add-interactive.sh | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index f2fffe1af02..1f3f3611ee9 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -8,6 +8,7 @@
 #include "diff.h"
 #include "compat/terminal.h"
 #include "prompt.h"
+#include "utf8.h"
 
 enum prompt_mode_type {
 	PROMPT_MODE_CHANGE = 0, PROMPT_DELETION, PROMPT_ADDITION, PROMPT_HUNK,
@@ -363,7 +364,7 @@ static int parse_hunk_header(struct add_p_state *s, struct hunk *hunk)
 		header->colored_extra_start = p + 3 - s->colored.buf;
 	else
 		/* could not parse colored hunk header, showing nothing */
-		header->colored_extra_start = hunk->colored_start;
+		header->colored_extra_start = line - s->colored.buf;
 	header->colored_extra_end = hunk->colored_start;
 
 	return 0;
@@ -649,6 +650,7 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 		size_t len;
 		unsigned long old_offset = header->old_offset;
 		unsigned long new_offset = header->new_offset;
+		int needs_extra_space = 0;
 
 		if (!colored) {
 			p = s->plain.buf + header->extra_start;
@@ -658,6 +660,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			p = s->colored.buf + header->colored_extra_start;
 			len = header->colored_extra_end
 				- header->colored_extra_start;
+			if (utf8_strnwidth(p, len, 1 /* skip ANSI */) > 0)
+				needs_extra_space = 1;
 		}
 
 		if (s->mode->is_reverse)
@@ -673,6 +677,8 @@ static void render_hunk(struct add_p_state *s, struct hunk *hunk,
 			strbuf_addf(out, ",%lu", header->new_count);
 		strbuf_addstr(out, " @@");
 
+		if (needs_extra_space)
+			strbuf_addch(out, ' ');
 		if (len)
 			strbuf_add(out, p, len);
 		else if (colored)
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 7e3c1de71f5..9deb7a87f1e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -772,7 +772,8 @@ test_expect_success 'gracefully fail to parse colored hunk header' '
 	echo content >test &&
 	test_config interactive.diffFilter "sed s/@@/XX/g" &&
 	printf y >y &&
-	force_color git add -p <y
+	force_color git add -p >output 2>&1 <y &&
+	grep XX output
 '
 
 test_expect_success 'diff.algorithm is passed to `git diff-files`' '
-- 
gitgitgadget

