Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8F6C33CB3
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BA924672
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u5zYgKCD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgANT0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39266 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbgANT0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:10 -0500
Received: by mail-wm1-f67.google.com with SMTP id 20so15081302wmj.4
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pZfiKuP+ZYokjQ/zzNyJAyeZA0Owf2p0+YxHnqVezr8=;
        b=u5zYgKCD+NvjadtB+xDJ7xdJ7FFRu/Hg7AF7MWwqEDuC3KkKLaYLcPxIk/nQUjWMum
         H/UQmsaUqzgE2iX/jR6icWUGoVJaaHw53r+RiBKlVXmu0ksG9s/V8Ytd4mkNucKid/5t
         bhIGZTuZ9d1mJZP1vvxQq+fb53X91Qi+CklhDq+f3VFZghal98YbLiF2jKD6mlM+gfvf
         X+yPPyjkr4jf/DumuRMXnYgdLcEkAgCa4XFczKzIiw6H1fppbEoPYRpBqqEWACpdFL5h
         C7j2ykenhihLM6PzCOKzPMaZPJUgZQ1H8wZ0WPgkxwY3vmfGFUDLxqoDRkj89cnely6X
         ZMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pZfiKuP+ZYokjQ/zzNyJAyeZA0Owf2p0+YxHnqVezr8=;
        b=ODHBCgxExSc1zadFKMs/AZRJWNvJ2wuV6Gu+4zhvWayjTlJ8ZG3z8y+zS73Z+hwNOr
         ZuetU/TvGDRADvEoseDjGPC+P/0IrcdJkOOg11PQyexCk+HvTxjkeSxEV6eTAhDSj+t/
         6qv7l2pAOPXj1eeNBC/s8Vn6R1UQpOXawTPrDJzQRoGpebkQ/LUYv3zeL/2t1pu6HWqX
         jxDEsuE3jOGkzCure31k2z62X0G822rAFEl4cCe/AFtGuXD8NMR08XplbXtzfNN6pUql
         m9pyNJ4n861wWoxfM26UiHWh474u9mPXJX+PlE3HHIFXvQkso7BCe++ulAECPuHRYIfi
         nibg==
X-Gm-Message-State: APjAAAUmTGu/4QS41UE40r72f29S5wAwwFDIeHvMe2SqUCguhlUbwWmn
        +gwtoaVEvqLvvHXr0XO/5OAfylGT
X-Google-Smtp-Source: APXvYqxUSF6BUjh74gww33B48hssjmIm92duUvOikBvOxF7FrlIVpURwoyD13SDzwaqOvM7eND9x0A==
X-Received: by 2002:a05:600c:1103:: with SMTP id b3mr27737179wma.141.1579029968604;
        Tue, 14 Jan 2020 11:26:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18sm20528055wrt.26.2020.01.14.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:08 -0800 (PST)
Message-Id: <77a514f50bfb73c590aa1cab437d56d862069f66.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:26:00 +0000
Subject: [PATCH 6/8] sparse-checkout: warn on incorrect '*' in patterns
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
 dir.c                              | 30 ++++++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/dir.c b/dir.c
index 1c96ddf5e3..150c05f4de 100644
--- a/dir.c
+++ b/dir.c
@@ -635,6 +635,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	struct pattern_entry *translated;
 	char *truncated;
 	char *data = NULL;
+	const char *prev, *cur, *next;
 
 	if (!pl->use_cone_patterns)
 		return;
@@ -652,6 +653,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	}
 
 	if (given->patternlen <= 2 ||
+	    *given->pattern == '*' ||
 	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		pl->use_cone_patterns = 0;
@@ -659,6 +661,34 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
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
+		pl->use_cone_patterns = 0;
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
index 974a4fec8f..5b50be53a4 100755
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

