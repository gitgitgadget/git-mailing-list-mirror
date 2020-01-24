Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70E7C35243
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B823C2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhKMlI28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgAXVTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52821 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387408AbgAXVTv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:51 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so817276wmc.2
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XNhZKH2DWroFtn02NgQ9WdR9JWMJu16ac61ekE1F9EM=;
        b=NhKMlI28oGnlllRLzR7QuWytdaSJ5O0XktS7QB3wayRn7qhgmMaKJGNdhRROk7KNdk
         wLBK1DqanCy3dzEIOACN2yJo9n9tEa7bRv+RAqP8JVm9wU8VpBDTPCP+9PutVDRGnN3a
         DyKopN6DGNYyTtxw23pcahvqHA4LX8BCwb5uJjB0e4ezS0Jk+SSEvd5dZ5Xlz9aeTsfR
         7HQeYhmF6GdJBLMTng9zaUHIKW4GSAJHyIP6z3qhtUxpN5bnGQOQqFda4OXLIWbSKhiW
         HUGAes0M6bqb/xKTwBjdQt60bEMc/iBmgj+9A7jcdnqzcJ9b6Amm2hxIqsqJiaK7M7ZV
         8X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XNhZKH2DWroFtn02NgQ9WdR9JWMJu16ac61ekE1F9EM=;
        b=FNeazlgl8M+ymILc7O7WqJsA6xS+DkSlmwmckDT4+kWoI+dWM3A2opPnqj/iEeBX6+
         CJ3P6a/6um1oRmwoC7xoD3uvZCBrs8MG0MaJ9iRmGyz9OPKXLppCTdw/TDsuqA1RpKZE
         otgyEtp/rn89B9+7aP2YNqNeCc6lmUdIR77gwGKynDR+/yTKOkThfBYMtD54W4QKebqH
         XD8mWXltGsu8eQJpWmP4voiSDFBoAmT93+YXzYSJd8WYg8Q2l917Vw7fsWg3FkGxZ9Tu
         Pe1qg2Urbj9+zs2UleUZ+FEDiA5yZ3qUDz5dza1aOatAMNCBKsLS2QJRU4zCDo1YkNKK
         FQbg==
X-Gm-Message-State: APjAAAViBTYfwIr/o7z6slPmi4gDW75bgJ1oZA6090Ptma1wzBAgTTcY
        dzQtTztp5d5umbQdnbyqZXSS0bCS
X-Google-Smtp-Source: APXvYqynH/vS+bMXSe8GTQpLLy1ZLfihnP2x+MNtmEBEy56kmP87I9aYodXGK6Wo7ACBgcNS7XeJ1g==
X-Received: by 2002:a05:600c:1003:: with SMTP id c3mr997126wmc.120.1579900789378;
        Fri, 24 Jan 2020 13:19:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm8632093wrs.8.2020.01.24.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:49 -0800 (PST)
Message-Id: <d2a510a3bb76db4c432187d631d5f6f8085af7e8.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:38 +0000
Subject: [PATCH v2 08/12] sparse-checkout: warn on incorrect '*' in patterns
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

