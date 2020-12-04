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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1DEC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EF5E22597
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgLDGRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgLDGRz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:55 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D895BC08E862
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:48 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id f16so4191713otl.11
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8EztL/JZzp/gZlPO5jFEmtoX5Nst/sXN7Rl9t6LdYGQ=;
        b=YFGKBJKq8H4K/J6z67Ns3InbQOdzRb7IC3XuyBvZ5iRue4supf7zRyfOk5xsmzX+8l
         JpqoayPSuYhRdmj/kI+eVdHWyYpnlp1lbb+ju9ZDvKCMlJ35OzfkVRV20qRpeovtCQBf
         KnOYtuxqFcaMwKTZLE4GrQQrQBQO8vo/KOKLlgxwjNm3IHVwvbyjnm/pcxkmEJxEe4w/
         /k4/YKmSoqRJwkHHx5SjnUXuGcF5U/aq1nH7mhvAWJj5HbXVKMunKe5dU7boGMKO02wu
         LnQJCQKfvAqG/9BUp7izZlkYplMS9e9FHZIvdnaywY1l1y/V2LWiCgycyxbGJprlJnWb
         67eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8EztL/JZzp/gZlPO5jFEmtoX5Nst/sXN7Rl9t6LdYGQ=;
        b=rL5ee/IR/KiKT3JFJOpX11iEjLKSIZIt7QI5mJGQimx5XZKtfQINIbA8xJnHpWvLU0
         Bk5r0XfKzf8EZdxuveT/snHo0+pWLjiZZRntnVltA5wXFDoQo00OlXtbRpq+eaUPO+Ua
         KNkGX9Wbxs9xBMpzLgJz7ozqrS+aQEPkAQc7vu/H/MT4tUUkPORLwSnH/pCkTDN7+2Hn
         4aRjkWTMwPOaOLlgQjYBc8awV6Dju9dTSSgKUJO/Gr9o5uAFy+Hd8g0Hn7hru+y7sUXK
         4WVB0qk8Kh85dIIWXEy/OuOhpLCBBZHv4O0hAr+8mWd2sB4l+0iCMDTuQeJsGVmYhvYO
         Gpbw==
X-Gm-Message-State: AOAM531zw/syZKwxWzxJk5S6pIUMjZPJGyY0BSBxUj0UVGe9V8hvxvv1
        Z6gaiS+7YdmFF7RCZdxa+HzMWEeJAAPCxw==
X-Google-Smtp-Source: ABdhPJz4GyxkaNlLGwc2lD/Az5LpEXAFeSN+S7tKoJgmVSqgxtUhL9GhhxzKamhh0SZ21C8W6gQLNQ==
X-Received: by 2002:a05:6830:131a:: with SMTP id p26mr2433252otq.237.1607062608074;
        Thu, 03 Dec 2020 22:16:48 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id s189sm454662oia.7.2020.12.03.22.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:47 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 12/14] pull: show warning with --ff
Date:   Fri,  4 Dec 2020 00:16:21 -0600
Message-Id: <20201204061623.1170745-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's unclear why --ff should remove the warning, since:

  git pull --ff

Is implicitly the same as:

  git pull

Unless of course pull.ff is specified otherwise.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/pull.c               | 2 +-
 t/t7601-merge-pull-config.sh | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index ebf2ac687b..e389ffcdc3 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -1020,7 +1020,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			die(_("The pull was not fast-forward, please either merge or rebase.\n"
 				"If unsure, run \"git pull --merge\"."));
 		}
-		if (opt_verbosity >= 0 && !opt_ff) {
+		if (opt_verbosity >= 0 && (!opt_ff || !strcmp(opt_ff, "--ff"))) {
 			advise(_("Pulling without specifying how to reconcile divergent branches is\n"
 				"discouraged; you need to specify if you want a merge, or a rebase.\n"
 				"You can squelch this message by running one of the following commands:\n"
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 1de64e6cc5..d709799f8b 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -46,7 +46,7 @@ test_expect_success 'pull.rebase not set and pull.ff=true' '
 	git reset --hard c2 &&
 	test_config pull.ff true &&
 	git pull . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and pull.ff=false' '
@@ -78,7 +78,7 @@ test_expect_success 'pull.rebase not set and --merge given' '
 test_expect_success 'pull.rebase not set and --ff given' '
 	git reset --hard c2 &&
 	git pull --ff . c1 2>err &&
-	test_i18ngrep ! "Pulling without specifying how to reconcile" err
+	test_i18ngrep "Pulling without specifying how to reconcile" err
 '
 
 test_expect_success 'pull.rebase not set and --no-ff given' '
-- 
2.29.2

