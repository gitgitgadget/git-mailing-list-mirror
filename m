Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60CDC433E1
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C02E61A45
	for <git@archiver.kernel.org>; Thu, 25 Mar 2021 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhCYXiQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Mar 2021 19:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhCYXh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Mar 2021 19:37:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF136C06174A
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:37:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2083331wmj.1
        for <git@vger.kernel.org>; Thu, 25 Mar 2021 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JTM+LEcEE6afZTpx/G8otxKMGUOKVlGx4dpi8ZyiIR4=;
        b=Mr4IU2xaZxB9i7VXwVjikgs7upSva4EiCaVSD/+NsNpeyqUd6RTyRnHdUHS2JQIplA
         0ZIstzwytmzcC8JHJSEZJHHAViam4Ew1Z6S9ejzffwEhvJvu1HvtiK2FzUvGd0rNQCef
         y2wxYC651DqcCX3Pdi1fToc3JICZuQZeBu//iqXk6yRL1iQ3GQ+APPbWhHSfcdGQOUkP
         +r6PLQJoTzrEbWpSnhuSNS9KEW3WYd7WvtfICmWT26C+PugP7LZ+KOpnESjtzUCzu98i
         LBIy2QIj2mH4WKtFb9qcV9IE6sw94cJdSS02YzPjmMKkEaDtRIHUPS1qTr8hqIPnbppy
         Ja+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JTM+LEcEE6afZTpx/G8otxKMGUOKVlGx4dpi8ZyiIR4=;
        b=CLOKu+xqVihZSXeTnamqumw2TIhS8zJbN+F/NeyYYOEvmUC7fXWhMVV/2wHCv5q8G1
         otJuhtohBktPCxP2FwOM5W0Op7cxx4horuIi/5qMrsGIZ1/iFnDBuJed5eJybBDnN1sa
         Q0XPlB8EMAk4zJNahGITnxfKRWaLVcDIFNE0OOnIIpV2xZe/NLwos2cIsSmxNWMCvd0Q
         W9tjqT31HFdxDLPHP+8oscXDEQ8OxIgpuP5es5p05yzpYXRxbz2XGHXL4w55PNXwbwb/
         wEJYMu/AdT04LyzKj6brabBXFU5sRVmzlvS845vfiiZ8GAtWKy0Q98Db7rm38vk19WHp
         CMBw==
X-Gm-Message-State: AOAM531WJo6fNY6O2fC7qRG/8FfUAfpn4pg6YVzAsLhDZ8Um/QgZNt50
        +IgXoQQ/1hSN8/cMZmLpEcHDoYDUFquFnAQFUV4=
X-Google-Smtp-Source: ABdhPJzHy+2P4qtC4WMTC8mgWaMADm2ve4WJVq0H33o2TUWzTtdHW47d4KdoanqoVQw2XsGcwYf62Q==
X-Received: by 2002:a05:600c:220d:: with SMTP id z13mr10198558wml.1.1616715475074;
        Thu, 25 Mar 2021 16:37:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:85f:2a0a:9300:501f:ca6d:3b18:1e72])
        by smtp.googlemail.com with ESMTPSA id d204sm8559512wmc.17.2021.03.25.16.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 16:37:54 -0700 (PDT)
From:   "=?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?=" 
        <stdedos@gmail.com>
X-Google-Original-From: =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= <stdedos+git@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     =?UTF-8?q?=CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82=20=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82?= 
        <stdedos+git@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Stavros Ntentos <133706+stdedos@users.noreply.github.com>
Subject: [PATCH v2 1/1] pathspec: warn for a no-glob entry that contains `**`
Date:   Fri, 26 Mar 2021 01:36:49 +0200
Message-Id: <20210325233648.31162-2-stdedos+git@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <xmqqft1iquka.fsf@gitster.g>
References: <xmqqft1iquka.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stavros Ntentos <133706+stdedos@users.noreply.github.com>

If a pathspec given that contains `**`, chances are that someone is
naively expecting that it will do what the manual has told him
(i.e. that `**` will match 0-or-more directories).

However, without an explicit `:(glob)` magic, that will fall out the sky:
the two `**` will merge into one star, which surrounded by slashes, will
match any directory name.

These changes attempt to bring awareness to this issue.

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

