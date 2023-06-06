Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8912DC77B73
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 14:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjFFOUY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjFFOUX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 10:20:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590F139
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 07:20:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6da07feb2so61623185e9.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 07:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686061220; x=1688653220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUbr/Joz5JtKw8l7ovCakoxOWUFuxb2GxmbdziE2S6g=;
        b=LT/Vt9k/f4MHkNh94bknPs2Dh4uMOplGNKi26HhDfnLRzzlQA4NuexmBgpRKRmyeux
         nTM730PLW/gfaNgQxKoz/hhR5l/fgY1z96Dkh+JHvHONlspI1EAYeuEvuX/PgnjT+Zbq
         i1qzsx7e5VFeLI+4sfVNqZsc2TF2n7vmgzz6aFQoS+MbgZ/+Jt9UcTNaifUZWNrbdbgK
         g3s6/Ey/XbOxRcq91EFJqUsKRu8KbVy4fy6ggLNpDwS6m14xTioxJ7eHiCqMHMTBbkl1
         4AgwucDECNX080ZX1Ir+3zJpnLzE3kxcVClAmpUjxyvyIQbVGI/hKe3oWVPbEWQtLZAH
         fvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061220; x=1688653220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUbr/Joz5JtKw8l7ovCakoxOWUFuxb2GxmbdziE2S6g=;
        b=EZHdwBO29F5AATj+FU3NNe56lRyCbQRpDbneq/hivBZlsU41RbKGfLVWfzxQYaynFL
         7iWiFiz0c2HjZKKe2uE19mAc4o7H/YptwKS9n91G0zh6gU58eDkAG2yi3whyvTci89QP
         Uk2lHF1ap2qJ9xHEJ6XSl174fWzKsQDhrc8eWVxrpmAM4hVZiQCEgb8HHyoLCpBeNdZP
         v/I7dEZy85XidedcZLKNHUC18qLEHXBWFFUxx1JKFzsOOMQ59Uapm7X1NuP/oy5/7Oy9
         knVNvf+FUxvCRKola0kbeqVS8tGpC5Aaf9skgKSUUwzD+rJCcFNf4Va6BqoQQqtSSN/4
         UZdQ==
X-Gm-Message-State: AC+VfDwmOkmYt7iPn4KPrmGwsFvkz6gpX0z7lWXIuP5j177BA/7j0a6N
        3IQsUWQd2khRLX43D/NMIu1ZppyqKZE=
X-Google-Smtp-Source: ACHHUZ6W0785PfheZkYLQv1xkwA/4xYO2uxTdFYU0bK8g/zxY/ch7VKJMA7vcf9HoIOGIbWdY2BpKg==
X-Received: by 2002:a05:600c:2947:b0:3f6:1377:8b15 with SMTP id n7-20020a05600c294700b003f613778b15mr2251897wmd.21.1686061220080;
        Tue, 06 Jun 2023 07:20:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4c89000000b002fe96f0b3acsm12799287wrs.63.2023.06.06.07.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 07:20:19 -0700 (PDT)
Message-Id: <pull.1541.v2.git.1686061219078.gitgitgadget@gmail.com>
In-Reply-To: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 14:20:18 +0000
Subject: [PATCH v2] add: check color.ui for interactive add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When 'git add -i' and 'git add -p' were converted to a builtin, they
introduced a color bug: the 'color.ui' config setting is ignored.

The included test demonstrates an example that is similar to the
previous test, which focuses on customizing colors. Here, we are
demonstrating that colors are not being used at all by comparing the raw
output and the color-decoded version of that output.

The fix is simple, to use git_color_default_config() as the fallback for
git_add_config(). A more robust change would instead encapsulate the
git_use_color_default global in methods that would check the config
setting if it has not been initialized yet. Some ideas are being
discussed on this front [1], but nothing has been finalized.

[1] https://lore.kernel.org/git/pull.1539.git.1685716420.gitgitgadget@gmail.com/

This test case naturally bisects down to 0527ccb1b55 (add -i: default to
the built-in implementation, 2021-11-30), but the fix makes it clear
that this would be broken even if we added the config to use the builtin
earlier than this.

Reported-by: Greg Alexander <gitgreg@galexander.org>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    add: check color.ui for interactive add
    
    This was reported by Greg Alexander gitgreg@galexander.org during Git
    IRC Standup [2].
    
    [2]
    https://colabti.org/irclogger/irclogger_log/git-devel?date=2023-06-05
    
    This is also a reoccurrence of the "config not loaded" bug from [3].
    
    [3]
    https://lore.kernel.org/git/pull.1530.git.1683745654800.gitgitgadget@gmail.com/
    
    I linked above to my RFC on lazy-loading global Git config, and these
    are the same "root cause" (not loading something early enough in the
    process) and my RFC proposes to fix this by changing our access
    patterns. By encapsulating these globals, we can make sure they are
    initialized from config before they are accessed.
    
    But that's a discussion for another thread. For now, fix the bug and
    we'll worry about the "better" (and bigger) thing to do another time.
    
    
    Update in v2
    ============
    
     * The test is simplified to compare the raw output to the color-decoded
       output. This makes the test more robust to possible future changes to
       interactive add.
    
    Thanks, -Stolee
    
    P.S. This fails the whitespace check due to the necessary left-padding
    spaces in the expected output in the test file.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1541%2Fderrickstolee%2Fadd-interactive-color-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1541/derrickstolee/add-interactive-color-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1541

Range-diff vs v1:

 1:  a76893de8a7 ! 1:  6d3e34d51c5 add: check color.ui for interactive add
     @@ Commit message
      
          The included test demonstrates an example that is similar to the
          previous test, which focuses on customizing colors. Here, we are
     -    demonstrating that colors are not being used at all.
     +    demonstrating that colors are not being used at all by comparing the raw
     +    output and the color-decoded version of that output.
      
          The fix is simple, to use git_color_default_config() as the fallback for
          git_add_config(). A more robust change would instead encapsulate the
     @@ t/t3701-add-interactive.sh: test_expect_success 'colors can be overridden' '
      +		-c color.ui=false \
      +		add -i >actual.raw <input &&
      +	test_decode_color <actual.raw >actual &&
     -+	cat >expect <<-\EOF &&
     -+	           staged     unstaged path
     -+	  1:        +3/-0        +2/-1 color-test
     -+
     -+	*** Commands ***
     -+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
     -+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
     -+	What now> status        - show paths with changes
     -+	update        - add working tree state to the staged set of changes
     -+	revert        - revert staged set of changes back to the HEAD version
     -+	patch         - pick hunks and update selectively
     -+	diff          - view diff between HEAD and index
     -+	add untracked - add contents of untracked files to the staged set of changes
     -+	*** Commands ***
     -+	  1: [s]tatus	  2: [u]pdate	  3: [r]evert	  4: [a]dd untracked
     -+	  5: [p]atch	  6: [d]iff	  7: [q]uit	  8: [h]elp
     -+	What now> Bye.
     -+	EOF
     -+	test_cmp expect actual
     ++	test_cmp actual.raw actual
      +'
      +
       test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '


 builtin/add.c              |  2 +-
 t/t3701-add-interactive.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/add.c b/builtin/add.c
index 76cc026a68a..6137e7b4ad7 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -365,7 +365,7 @@ static int add_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
-	return git_default_config(var, value, cb);
+	return git_color_default_config(var, value, cb);
 }
 
 static const char embedded_advice[] = N_(
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 3982b6b49dc..a93fe54e2ad 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -734,6 +734,21 @@ test_expect_success 'colors can be overridden' '
 	test_cmp expect actual
 '
 
+test_expect_success 'colors can be skipped with color.ui=false' '
+	git reset --hard &&
+	test_when_finished "git rm -f color-test" &&
+	test_write_lines context old more-context >color-test &&
+	git add color-test &&
+	test_write_lines context new more-context another-one >color-test &&
+
+	test_write_lines help quit >input &&
+	force_color git \
+		-c color.ui=false \
+		add -i >actual.raw <input &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp actual.raw actual
+'
+
 test_expect_success 'colorized diffs respect diff.wsErrorHighlight' '
 	git reset --hard &&
 

base-commit: fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
-- 
gitgitgadget
