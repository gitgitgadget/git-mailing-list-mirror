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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF874C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7EE961A24
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCZPt3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhCZPt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:49:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2339C0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:49:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so6129252wmq.1
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ziVTcd6aN+EKrntv+C0fV9UfAUf6iQOIwwxAqJHZig=;
        b=U1tSx/Z60MMVKg0dAMg3p88sdcoRcY6sgkUqYIrQ5RN2gnV8G6vu213UqGn3ZGUZ2M
         oCQ9IxPAZGB0h7zyd78yxPBr47HqjGiFND8pFX5D9pHLtAx9TXOBNpwaUMX7CB5Ob0jq
         dqHnZVHAzn/0ndvJ1aD9btW7whyZt/sw5oIqLroEhf0vJQiENwPrR7H6Uhzmfr7U7cBo
         3nLQuBxa0L88ZH+GiXQkTJgTqqV603R29cmSOPi7qbMwukbZuBPQ4dOmQJNuzmtvplKB
         UC44lZekVqaTL3NeRdXvsX2eL5YfcNmtoYFuTug55VQ4Ibf7LPv1rVM/MCuLP/YYMur/
         dMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ziVTcd6aN+EKrntv+C0fV9UfAUf6iQOIwwxAqJHZig=;
        b=CiNJMrRufQHsWoM/R9DiKGsoN9++1a1L8CivjYX9f4MYS7hfaS4QDEO5BNbMS1+8Yc
         q6Sar8WjYKNC/lQkYV/C2OfI++4BAiF2ixdZpISbXhWEurpBiWcwERA62n7n/gnPpvuj
         xL8GQRVerkIBpvjyyHe3cWWuVAC28w6qZdiwhiIxnhS/FmAFgxRS09Pa7fm8OW0rrQmg
         W//FLeslyzXx7qdSPZP5DxtRCdKgQcQB6UsSPQQtvVgcQwhXLFwOBrhca/Nrt6jxarPF
         MXnGfQGepan7RqmnwUh4yhxfTSij2E2Uo7fHVEB0B3I4sXDCSsUb8jUE4tYHYIt6XxPn
         dljg==
X-Gm-Message-State: AOAM531yv9Aq9+hicnrr5vDGAvP1YQq/gS6G24sCg0FrEie+QNZOAtCF
        9GFlj7p7zl6spGGg9iQUgIGt5a7MgMcxPvOs/X4=
X-Google-Smtp-Source: ABdhPJw2lRtL68E4e8p+LF1Fy46oPSRclcscqMIbTDUk2mIH3e160lhGowkFzCBltK59Ejo/u3c9lg==
X-Received: by 2002:a1c:1d14:: with SMTP id d20mr13599103wmd.36.1616773764135;
        Fri, 26 Mar 2021 08:49:24 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id s3sm11380132wmd.21.2021.03.26.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:49:23 -0700 (PDT)
From:   Stavros Ntentos <stdedos@gmail.com>
X-Google-Original-From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
To:     git@vger.kernel.org
Cc:     stdedos+git@gmail.com, peff@peff.net, bagasdotme@gmail.com,
        gitster@pobox.com, pclouds@gmail.com, sunshine@sunshineco.com,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v3 1/2] pathspec: warn for a no-glob entry that contains `**`
Date:   Fri, 26 Mar 2021 17:48:54 +0200
Message-Id: <20210326154855.19528-1-133706+stdedos@users.noreply.github.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210325233648.31162-2-stdedos+git@gmail.com>
References: <20210325233648.31162-2-stdedos+git@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a pathspec given that contains `**`, chances are that someone is
naively expecting that it will do what the manual has told him
(i.e. that `**` will match 0-or-more directories).

When `**` appears in the pathspec, the user may be expecting that
it would be matched using the "wildmatch" semantics,
matching 0 or more directories.
That is not what happens without ":(glob)" magic.

Teach the pathspec parser to emit an advice message when a substring
`**` appears in a pathspec element that does not have a `:(glob)` magic.
Make sure we don't disturb users who use ":(literal)" magic
with such a substring, as it is clear they want to find these strings literally.

Signed-off-by: Stavros Ntentos <133706+stdedos@users.noreply.github.com>
---
 pathspec.c                 | 13 +++++++++++++
 pathspec.h                 |  1 +
 t/t6130-pathspec-noglob.sh | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..d5b9c0d792 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -1,3 +1,4 @@
+#include <string.h>
 #include "cache.h"
 #include "config.h"
 #include "dir.h"
@@ -588,6 +589,8 @@ void parse_pathspec(struct pathspec *pathspec,
 
 		init_pathspec_item(item + i, flags, prefix, prefixlen, entry);
 
+		check_missing_glob(entry, item[i].magic);
+
 		if (item[i].magic & PATHSPEC_EXCLUDE)
 			nr_exclude++;
 		if (item[i].magic & magic_mask)
@@ -739,3 +742,13 @@ int match_pathspec_attrs(const struct index_state *istate,
 
 	return 1;
 }
+
+void check_missing_glob(const char *pathspec_entry, int flags) {
+	if (flags & (PATHSPEC_GLOB | PATHSPEC_LITERAL)) {
+		return;
+	}
+
+	if (strstr(pathspec_entry, "**")) {
+		warning(_("Pathspec provided contains `**`, but no :(glob) magic.\nIt will not match 0 or more directories!"));
+	}
+}
diff --git a/pathspec.h b/pathspec.h
index 454ce364fa..913518ebd3 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -157,5 +157,6 @@ char *find_pathspecs_matching_against_index(const struct pathspec *pathspec,
 int match_pathspec_attrs(const struct index_state *istate,
 			 const char *name, int namelen,
 			 const struct pathspec_item *item);
+void check_missing_glob(const char* pathspec_entry, int flags);
 
 #endif /* PATHSPEC_H */
diff --git a/t/t6130-pathspec-noglob.sh b/t/t6130-pathspec-noglob.sh
index ba7902c9cd..af6cd16f76 100755
--- a/t/t6130-pathspec-noglob.sh
+++ b/t/t6130-pathspec-noglob.sh
@@ -157,4 +157,17 @@ test_expect_success '**/ does not work with :(literal) and --glob-pathspecs' '
 	test_must_be_empty actual
 '
 
+cat > expected <<"EOF"
+warning: Pathspec provided contains `**`, but no :(glob) magic.
+EOF
+test_expect_success '** without :(glob) warns of lacking glob magic' '
+	test_might_fail git stash -- "**/bar" 2>warns &&
+	grep -Ff expected warns
+'
+
+test_expect_success '** with :(literal) does not warn of lacking glob magic' '
+	test_might_fail git stash -- ":(literal)**/bar" 2>warns &&
+	! grep -Ff expected warns
+'
+
 test_done
-- 
2.31.0

