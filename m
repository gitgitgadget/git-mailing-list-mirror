Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C80FC33CB7
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7311215A4
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUTwIiqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgAaUQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:27 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37754 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbgAaUQY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:24 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so10173262wmf.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AtBqI6CCf+VMZOgmlvqj7UaYj+NRy62oNWe9942dw00=;
        b=JUTwIiqnLl4aDt+tACumX8r1RkY5P6lvJ1HdTWKVwsaOAs6X2kGW5q8LT3i9Mx/WVb
         sZOwvqYkvfEgRsTDxZPMzsjin1j/Y9Ml1RT8+1v7kyWcMtaN42KK+ysmlSPwBlRgMpNv
         mxR8Qotz8nqurtnm1wS/f8ev+ObGUQkdgTWiWfpsSOH5PrWV7s7xGK3cxvbw5mxjtPx/
         pV7api1W2XDfTZ8p4uEypczbSPtsSJwFffvnOWMuN3OuI8qWKsY5yoXi4BIt31JmNauc
         A7vHtDZ4I0BYj3KdoBi9nVX7suzsUJGFGcIHk/OfsGdXSoNpgtnqHl1NgbFaf1swr+GJ
         9DCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AtBqI6CCf+VMZOgmlvqj7UaYj+NRy62oNWe9942dw00=;
        b=Ogns9SZmGAI//6p0u9vZpdpU6mNYtWZ3k5QYN7CNUrLa9dcVrOhhULw6OG2L3Hl+8l
         8KqadzBnoiJnfCU12xy55DFayR7NZynVM2Kf/qs9pLA3/QF0Zhz9VGz4EwfQ220mrIi7
         fcvc7lRAYvWEalGONCFaInDBBvoD4N0rSCm/YuZcfRhFx2eJ+cSgjiaIrltBjKgf4bIl
         fqr5hxlVRsJwKhLfiwJ4M+xY0JLFMXCwGA7k//A8XBD0owNc1MPb3yGKRyJO2ADyzPOy
         7TIEeY6peKbRm2YI5eS0uQLn0MjvvtN/dIB/CdTzoIfQIodzycHw++Hk/00iDZW39fZV
         pANw==
X-Gm-Message-State: APjAAAUkSwIUhzwD4+t5haRT90w8c9jVbKTuskX1daeyRMM7f93zDhVQ
        E13L+AP554/UWd5b9xVH6G8x91bB
X-Google-Smtp-Source: APXvYqySh1JGX7FCsXOzRY7l6RtQXIpzj1bNh7VkwUTjOaGIphYPw0JLUOKWn2stGc06nUE6tjr14Q==
X-Received: by 2002:a05:600c:218b:: with SMTP id e11mr14016974wme.56.1580501782234;
        Fri, 31 Jan 2020 12:16:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm12846934wmc.20.2020.01.31.12.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:21 -0800 (PST)
Message-Id: <66caabef5f998e15cc564e91231590280892191b.1580501775.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
        <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:08 +0000
Subject: [PATCH v4 08/15] sparse-checkout: warn on globs in cone patterns
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
asterisk or other glob character is invalid. Add checks to disable
cone mode when seeing these values.

A later change will properly handle escaped globs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 36 +++++++++++++++++++++++++++
 t/t1091-sparse-checkout-builtin.sh | 39 ++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/dir.c b/dir.c
index c2e585607e..71d28331f3 100644
--- a/dir.c
+++ b/dir.c
@@ -635,6 +635,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	struct pattern_entry *translated;
 	char *truncated;
 	char *data = NULL;
+	const char *prev, *cur, *next;
 
 	if (!pl->use_cone_patterns)
 		return;
@@ -652,12 +653,47 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
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
+		/* Watch for glob characters '*', '\', '[', '?' */
+		if (!is_glob_special(*cur))
+			goto increment;
+
+		/* But only if *prev != '\\' */
+		if (*prev == '\\')
+			goto increment;
+
+		/* But allow the initial '\' */
+		if (*cur == '\\' &&
+		    is_glob_special(*next))
+			goto increment;
+
+		/* But a trailing '/' then '*' is fine */
+		if (*prev == '/' &&
+		    *cur == '*' &&
+		    *next == 0)
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
index 2e57534799..c732abeacd 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -348,4 +348,43 @@ test_expect_success 'pattern-checks: too short' '
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
+test_expect_success 'pattern-checks: contained glob characters' '
+	for c in "[a]" "\\" "?" "*"
+	do
+		cat >repo/.git/info/sparse-checkout <<-EOF &&
+		/*
+		!/*/
+		something$c-else/
+		EOF
+		check_read_tree_errors repo "a" "disabling cone pattern matching"
+	done
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

