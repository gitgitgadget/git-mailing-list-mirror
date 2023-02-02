Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94280C636D3
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 19:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjBBTQ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 14:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjBBTQx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 14:16:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B858C757AC
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 11:16:51 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id y1so2664787wru.2
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 11:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFcxcN/2O91ScD7FUw1x5jeWm6GFujRgxk1KF+LO0rI=;
        b=Ei9PTiLGWmE2oxpUgpBiBhe6hr+FG72lEDM89Vr7MjeMbIZkZGVoE1LWX3iSUW21cS
         bI36sY7MPl2dNJtpUU/o8alMhYyrs0V6eEwr4bslEChIUa/cqR06tgrq3tDYy0HeI8Mu
         gSWdT5Y+iNbM4ayvKHcihkeM+YVmvSAOfrKC3tUNHk/HcvNUCgvCJIfqS4nENhI9NgrW
         3azuOSRZna0+RVXls51VaG3A5Ii3QAPGHcdzks0LfKRRezip/8aUr7SY8aSiSZVsZo9t
         /4pE3VK96Ub23Jxbr6zzlBt97e4yu54UrAs5g2qmdjbrutc7ck/9jG9BLKA/Ny7rQuER
         MsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFcxcN/2O91ScD7FUw1x5jeWm6GFujRgxk1KF+LO0rI=;
        b=cQP2DPbVojZbBOp1+g0YcTvDq0ghRSuz+YG+i1foA6BdccYE1xzuGKchaiNr9QP7A+
         9irCY/E034ueV5NeOEqMjRQ+FUi1akDd21szs7/WKSqrZoInmSfj7RNasf6Bu+pacomG
         3XGKlXu7h18q55pSIs4QgpWP/025c8QgY/HFfmua7/osIr4hq79N3fH7fdFWeLw5LJKm
         9Ynd83cyaK6AgyZMZfwxIC0sD4BP+Pbba3UGAq/5zYEKGDl9K5JEA3LhSknhxFk3fOGI
         CaQ+MOYaf1Kd5MUMMiU5dWviNf67aMp5G1rCztsHgsicBuPwJ+dJ/PEpiAARU5GXqceJ
         n9WA==
X-Gm-Message-State: AO0yUKVq55VGA8UqPr478Y/N7XSe9yoMZm19PbdGBtG6AYiRm8RD0JLB
        e96vX6TNd47qfr9Xhh0eyUE+0vusNrg=
X-Google-Smtp-Source: AK7set8B74YJ6Jn+SxrITn9llle6zC8hhPsVnB6wkNWPGo2S+85C1bF6Qv/P3kYW9x22h7htJQCCfg==
X-Received: by 2002:adf:f5ca:0:b0:2c3:be89:7c2d with SMTP id k10-20020adff5ca000000b002c3be897c2dmr2423040wrp.16.1675365410147;
        Thu, 02 Feb 2023 11:16:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d6048000000b002bfb02153d1sm233124wrt.45.2023.02.02.11.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 11:16:49 -0800 (PST)
Message-Id: <e33ae071e27faf16f90f4a71e80840c7f3897b50.1675365406.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
References: <pull.1449.git.git.1675365406.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Feb 2023 19:16:46 +0000
Subject: [PATCH 3/3] blame: support multiple values in blame.coloring
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

`blame.coloring` is now parsed as a comma-separated list, so that both
colorizers ("by age" and "by repeated lines") can be enabled via
configuration. Previously, they could be specified together on the
command line via --color-by-age and --color-lines, but not by config.

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
 Documentation/config/blame.txt |  1 +
 builtin/blame.c                | 47 +++++++++++++++++++++++++---------
 t/t8012-blame-colors.sh        |  8 ++++++
 3 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/config/blame.txt b/Documentation/config/blame.txt
index 4d047c17908..8624c4dc5d4 100644
--- a/Documentation/config/blame.txt
+++ b/Documentation/config/blame.txt
@@ -6,6 +6,7 @@ blame.coloring::
 	This determines the coloring scheme to be applied to blame
 	output. It can be 'repeatedLines', 'highlightRecent',
 	or 'none' which is the default.
+	Multiple values may be separated by commas.
 
 blame.date::
 	Specifies the format used to output dates in linkgit:git-blame[1].
diff --git a/builtin/blame.c b/builtin/blame.c
index 71f925e456c..eea1418d209 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -685,6 +685,39 @@ static const char *add_prefix(const char *prefix, const char *path)
 	return prefix_path(prefix, prefix ? strlen(prefix) : 0, path);
 }
 
+static unsigned parse_blame_coloring_mode(const char *arg)
+{
+	int ret = 0;
+	struct string_list l = STRING_LIST_INIT_DUP;
+	struct string_list_item *i;
+
+	string_list_split(&l, arg, ',', -1);
+
+	for_each_string_list_item(i, &l) {
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addstr(&sb, i->string);
+		strbuf_trim(&sb);
+
+		if (!strcmp(sb.buf, "none")) {
+			ret = 0;
+		} else if (!strcmp(sb.buf, "repeatedLines")) {
+			ret |= OUTPUT_COLOR_LINE;
+		} else if (!strcmp(sb.buf, "highlightRecent")) {
+			ret |= OUTPUT_SHOW_AGE_WITH_COLOR;
+		} else {
+			warning(_("invalid value for '%s': '%s'"),
+				"blame.coloring", sb.buf);
+			ret = 0;
+		}
+
+		strbuf_release(&sb);
+	}
+
+	string_list_clear(&l, 0);
+
+	return ret;
+}
+
 static int git_blame_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "blame.showroot")) {
@@ -739,18 +772,8 @@ static int git_blame_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "blame.coloring")) {
-		if (!strcmp(value, "repeatedLines")) {
-			coloring_mode |= OUTPUT_COLOR_LINE;
-		} else if (!strcmp(value, "highlightRecent")) {
-			coloring_mode |= OUTPUT_SHOW_AGE_WITH_COLOR;
-		} else if (!strcmp(value, "none")) {
-			coloring_mode &= ~(OUTPUT_COLOR_LINE |
-					    OUTPUT_SHOW_AGE_WITH_COLOR);
-		} else {
-			warning(_("invalid value for '%s': '%s'"),
-				"blame.coloring", value);
-			return 0;
-		}
+		coloring_mode = parse_blame_coloring_mode(value);
+		return 0;
 	}
 
 	if (git_diff_heuristic_config(var, value, cb) < 0)
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index 820f86c3aed..051f734ea03 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -89,6 +89,14 @@ test_expect_success 'blame color by age and lines' '
 		hello.c \
 		>actual.raw &&
 
+	git \
+		-c color.blame.repeatedLines=blue \
+		-c color.blame.highlightRecent="yellow,1 month ago, cyan" \
+		-c blame.coloring=highlightRecent,repeatedLines \
+		blame hello.c \
+		>actual.raw.2 &&
+	test_cmp actual.raw actual.raw.2 &&
+
 	test_decode_color <actual.raw >actual &&
 	normalize_color_decoded_blame <actual >actual.norm &&
 
-- 
gitgitgadget
