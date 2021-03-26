Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8DC2C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78D8B61A38
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 02:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhCZCof (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 22:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhCZCoT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 22:44:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3549BC06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:44:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x13so4191874wrs.9
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 19:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrPvuIbLXWpjx6l3qD7YOQlcS+S/Tawb5LZNJa3MpP4=;
        b=OE4jFBlRi9kyrwFPpEVPd34S0WqmNQeD6KwdXesinKkJq4Bko6c47b/K+2duiMqjB5
         lsCB9tdkj8DebcFKCy/b1F/Geh1rB22toFnqtXxCNHTCAE5kFkg5sLqf3Pxi2IxMF2uP
         ze2bwwxasX/QJSVo2yWEjpw4y6gySHsq1UlOMdtl43f95yxzbdWJD6qJwm0EyTum5W0M
         v2J/hWEnlvz52CJq75J4Y/s28jgPrmhCu8wJd6p3iMVp/QxQhy9h0tbLlIYX3NiGWFaY
         436RVTAFSkgMsOs/Psi7wFSctArm6XURN4XLks9C3wJ9ehS6AojyHfRI1tClA5AEjBlN
         mCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrPvuIbLXWpjx6l3qD7YOQlcS+S/Tawb5LZNJa3MpP4=;
        b=hBXCNGVterNroum1Zb+MU+XnNjIHfWttpa1p84Je0my5hBPH/EF0//XtSqRYq0xnM3
         rl3jQvtz7Qn7kNwBrN+Jxmakrc+P3PpjnfRdZ8qc+JsW0nwdLoWuVKKwa3iW4t+DF9JF
         AdUC5iLPtE7rBfqeGYPdOm0fxq2te1axIaGIdVOxCPPQBnEQAylux56fMluxGQpY8U0s
         gED317Y1/m9tH7e8k/j5RTcsb+SGEKdyNXwsI25mojEBQC/g/GSoH+UZUOXyT1bJvNfi
         Kd2o6JIBLJwWXm5sJc5JqXGv6iK7jiphDJb9NzWdIiUmY5drhDf2as1tzX5asD5MFJJM
         1Nbg==
X-Gm-Message-State: AOAM531MVvfzAiSi4OjCgBV2r7jTpEC9eky7jVRRhKalbIxrf/3gVRpt
        nzm+g3ggHNHvc9iUep0Iv73hvakHwK69L/WLwYc=
X-Google-Smtp-Source: ABdhPJxWWtqOCOS3ejJTykVecyiBxI6pU0KEgmJ2DhcIFvAFXp3vVmHqZ5tdMT/1pLbu4tETqylGIg==
X-Received: by 2002:adf:9148:: with SMTP id j66mr12212895wrj.124.1616726657512;
        Thu, 25 Mar 2021 19:44:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id m2sm6748579wmp.1.2021.03.25.19.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 19:44:17 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [RFC PATCH v1] pathspec: warn: long and short forms are incompatible
Date:   Fri, 26 Mar 2021 04:44:11 +0200
Message-Id: <20210326024411.28615-2-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210326024411.28615-1-stdedos+git@gmail.com>
References: <xmqqft1iquka.fsf@gitster.g>
 <20210326024411.28615-1-stdedos+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

Namely, `!` and any other long magic form (e.g. `glob`)
cannot be combined to one entry.

Issue a warning when such thing happens, and hint to the solution.

Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
---
 pathspec.c                  | 24 ++++++++++++++++++++++++
 pathspec.h                  |  1 +
 t/t6132-pathspec-exclude.sh | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..4ac8bfdc06 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,3 +1,5 @@
+#include <stdio.h>
+#include <string.h>
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
@@ -5,6 +7,7 @@
 #include "attr.h"
 #include "strvec.h"
 #include "quote.h"
+#include "git-compat-util.h"
 
 /*
  * Finds which of the given pathspecs match items in the index.
@@ -586,6 +589,8 @@ void parse_pathspec(struct pathspec *pathspec,
 	for (i = 0; i < n; i++) {
 		entry = argv[i];
 
+		check_mishandled_exclude(entry);
+
 		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
 		if (item[i].magic & PATHSPEC_EXCLUDE)
@@ -739,3 +744,22 @@ int match_pathspec_attrs(const struct index_state *istate,
 
 	return 1;
 }
+
+void check_mishandled_exclude(const char *entry) {
+	char *flags, *path;
+	size_t entry_len = strlen(entry);
+
+	flags = xstrdup(entry);
+	memset(flags, '\0', entry_len);
+	path = xstrdup(entry);
+	memset(path, '\0', entry_len);
+
+	if (sscanf(entry, ":!(%4096[^)])%4096s", flags, path) == 2) {
+		if (count_slashes(flags) == 0) {
+			warning(_("Pathspec provided matches `:!(...)`\n\tDid you mean `:(exclude,...)`?"));
+		}
+	}
+
+	FREE_AND_NULL(flags);
+	FREE_AND_NULL(path);
+}
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..879d4e82c6 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -157,5 +157,6 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
+void check_mishandled_exclude(const char* pathspec_entry);
 
 #endif /* PATHSPEC_H */
diff --git a/t/t6132-pathspec-exclude.sh b/t/t6132-pathspec-exclude.sh
index 30328b87f0..b32ddb2a56 100755
--- a/t/t6132-pathspec-exclude.sh
+++ b/t/t6132-pathspec-exclude.sh
@@ -244,4 +244,37 @@ test_expect_success 'grep --untracked PATTERN :(exclude)*FILE' '
 	test_cmp expect-grep actual-grep
 '
 
+cat > expected_warn <<"EOF"
+Pathspec provided matches `:!(...)`
+EOF
+test_expect_success 'warn pathspec :!(...) skips the parenthesized magics' '
+	git log --oneline --format=%s -- '"'"':!(glob)**/file'"'"' >actual 2>warn &&
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	cat actual &&
+	cat warn &&
+	test_cmp expect actual &&
+	grep -Ff expected_warn warn
+'
+
+test_expect_success 'do not warn that pathspec :!(...) skips the parenthesized magics (if parenthesis would not be part of the magic)' '
+	git log --oneline --format=%s -- '"'"':!(gl/ob)/file'"'"' >actual 2>warn &&
+	cat <<EOF >expect &&
+sub2/file
+sub/sub/sub/file
+sub/file2
+sub/sub/file
+sub/file
+file
+EOF
+	test_cmp expect actual &&
+	! grep -Ff expected_warn warn
+'
+
 test_done
-- 
2.31.0

