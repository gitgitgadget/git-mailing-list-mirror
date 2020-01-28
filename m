Return-Path: <SRS0=aR3Y=3R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDA1C2D0DB
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2282020716
	for <git@archiver.kernel.org>; Tue, 28 Jan 2020 18:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOk4jeN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgA1S1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:27:02 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40032 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgA1S0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jan 2020 13:26:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id j104so1312836wrj.7
        for <git@vger.kernel.org>; Tue, 28 Jan 2020 10:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XNhZKH2DWroFtn02NgQ9WdR9JWMJu16ac61ekE1F9EM=;
        b=EOk4jeN0vrUxFLtEGRsUqODqVFkNOZriQ4mIJbpZyA6mdCCQOWRhPm4GUAEBxvZ+kT
         9GFnAYBPC9TgMz+HwJ5ph/MwZJr4yMZ3/vuUsUaif7EZ249uuDhkwKGfSPA4W/deo+zA
         6klsjchX4mvqGs/Tj23qizILiqyzrTWuYaDqb6CR0x0fvNohiXdiVs3ydVoe43tzKm/h
         gK/8yl6baJk9pU7wuqUXEZ80YF3Q+hA82Guco3aSRib31eIwExKe7fhmGJ6i0v2OmUXr
         FUabuiGSjEXwTvqvwIjJb0HbWwK3Ww767+czG6is3ZHGH27rG1J/c/vl854I0199ZpKL
         0fJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XNhZKH2DWroFtn02NgQ9WdR9JWMJu16ac61ekE1F9EM=;
        b=ZWwEUVlgV+LUxJq4+BJb3VOYKL1nFADkr+0aBu+WiHMLF2AT2s/KaEj84kzDNQFXt0
         82uUjhnWHfQXNldKG+di6g+k4FhQgTiHZEl1K7GHMDdMcppUin7o+gUH03IBzrNf/4PU
         16PKxo4GPQifbJs8eSGAugh7UBz5gLHzdbhaQHKqt3SSvB2RpbgR05iMOK+SdS5yEitK
         66FnmtL9KAOgB9C/Cgw1OQZHqB9ZKxgChioOErlNhUTOXLAewNoFyXRg4dazjuT4LSYz
         WM4KNjLiSxSdPBuQ0xQ0rwBUg44kkBQzhKZ1nrD3WhC5ObD9W8FuYyGBlveXVWWektN1
         UpUg==
X-Gm-Message-State: APjAAAU8DqtDlI6nBZzUBuXPuaQ6rRBHHw7v2sZECk6g03fuoNNnI0sB
        UTe8BKIdxCzZwLr2ZSsqZYWfQhUz
X-Google-Smtp-Source: APXvYqz6pAPjnY2OnKSrLA1GUBrYRHeGienEiChvsPDuEuPi4zxRMtMZ8Wjr+YOibDBdnlHArLDbeg==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr30226562wrm.135.1580236010743;
        Tue, 28 Jan 2020 10:26:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k16sm29045891wru.0.2020.01.28.10.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:26:50 -0800 (PST)
Message-Id: <d2a510a3bb76db4c432187d631d5f6f8085af7e8.1580236003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
        <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Jan 2020 18:26:39 +0000
Subject: [PATCH v3 08/12] sparse-checkout: warn on incorrect '*' in patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the sparse-checkout commmand will write patterns that
allow faster pattern matching. This matching only works if the patterns
in the sparse-checkout file are those written by that command. Users
can edit the sparse-checkout file and create patterns that cause the
cone mode matching to fail.

The cone mode patterns may end in "/*" but otherwise an un-escaped
asterisk is invalid. Add checks to disable cone mode when seeing these
values.

A later change will properly handle escaped asterisks.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 29 +++++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/dir.c b/dir.c
index c2e585607e..7cb78c8b87 100644
--- a/dir.c
+++ b/dir.c
@@ -635,6 +635,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	struct pattern_entry *translated;
 	char *truncated;
 	char *data = NULL;
+	const char *prev, *cur, *next;
 
 	if (!pl->use_cone_patterns)
 		return;
@@ -652,12 +653,40 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	}
 
 	if (given->patternlen <= 2 ||
+	    *given->pattern == '*' ||
 	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
 		goto clear_hashmaps;
 	}
 
+	prev = given->pattern;
+	cur = given->pattern + 1;
+	next = given->pattern + 2;
+
+	while (*cur) {
+		/* We care about *cur == '*' */
+		if (*cur != '*')
+			goto increment;
+
+		/* But only if *prev != '\\' */
+		if (*prev == '\\')
+			goto increment;
+
+		/* But a trailing '/' then '*' is fine */
+		if (*prev == '/' && *next == 0)
+			goto increment;
+
+		/* Not a cone pattern. */
+		warning(_("unrecognized pattern: '%s'"), given->pattern);
+		goto clear_hashmaps;
+
+	increment:
+		prev++;
+		cur++;
+		next++;
+	}
+
 	if (given->patternlen > 2 &&
 	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
 		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 2e57534799..470900f6f4 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -348,4 +348,31 @@ test_expect_success 'pattern-checks: too short' '
 	check_read_tree_errors repo "a" "disabling cone pattern matching"
 '
 
+test_expect_success 'pattern-checks: trailing "*"' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/a*
+	EOF
+	check_read_tree_errors repo "a" "disabling cone pattern matching"
+'
+
+test_expect_success 'pattern-checks: starting "*"' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	*eep/
+	EOF
+	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
+'
+
+test_expect_success 'pattern-checks: escaped "*"' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/does\*not\*exist/
+	EOF
+	check_read_tree_errors repo "a" ""
+'
+
 test_done
-- 
gitgitgadget

