Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0D5EC875F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 22:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbjIGWUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 18:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbjIGWUX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 18:20:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D961BDD
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 15:20:18 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-401bdff4cb4so15631605e9.3
        for <git@vger.kernel.org>; Thu, 07 Sep 2023 15:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694125217; x=1694730017; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAdMcJmsl1UanPeZ7HNoKYmoBWhQMLXpHLt9O3kOd1A=;
        b=onHAW9K6y5rwJmuRdr0q72RlZjMFZNl6lRPJn5C3GCHTZr9dk+2XxkH2kqxcK8l45d
         d7+TnJ7h9ukLFBDkFsIqxlfaMTQx8lQc3EG+wIYrXYf0Sv+EEuoQkdh6wK68TvFJZaTd
         nUBFdz33SsYNTlSzc7z5BR+sNJfKkuqkHWGIr5MKnZh55wgqjcTBCG621BFjrbs4sQ4+
         N30hUmdZ6JdvCmSt3sQ+KJnmWDXeAq+aawNOGm0MaVF47aXn1NS2+CnRf2X8t7wcQG+j
         7JndkwyKr6UImgCzITEgK+GyacWT0ygkosjrGEWEzQy+ubmsIB8S8k/0rAeSkiO98ZBQ
         gBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694125217; x=1694730017;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAdMcJmsl1UanPeZ7HNoKYmoBWhQMLXpHLt9O3kOd1A=;
        b=i595MdZrfQGtnrppz6e+HiBUxWkPBr2zhS0HWG6Lfl6wq9u7fxF26RB1RuHtZ+J/8x
         neoif+C0tZ4QMyA61aECgkRlWJXIvztj/VxtnWW6AjZ0ZRhQVCi6ReiDEFWtkWVVkc1Y
         CzXGuf0DUQQXLGLydDsWt5E+aomtvMg6NoI4oi7JkWhfcPS5IciJKgImyew7SfhP308g
         n3x9Nk0k5ofb5Zqtsd34hQuT8aYaLdwMRk6YPNxuB090Ev/SJZN0ieYaAZqaTULtMiUQ
         JeBJGVL29HmDQygz1slx6WNQ/nDVfPQoyt9B47z0JL0luy4Z5BvRqtpv2vBodY2EM9cA
         ps7Q==
X-Gm-Message-State: AOJu0YxEgIt325tKqE2jB6IrJBUhy+rfE05MbBQwQYuDgUVddsDvdFfT
        jJkuk98kPvpFp5L0mAbJvbi1p+VV4TQ=
X-Google-Smtp-Source: AGHT+IHpya4cMJ7gzLDUOvxImCWw2IrH7hlIRcu4+rl2HkrHECUMEe34lw7P4WQYaW0YwDp16zYOaQ==
X-Received: by 2002:a5d:4c4f:0:b0:317:69d2:35c2 with SMTP id n15-20020a5d4c4f000000b0031769d235c2mr531422wrt.2.1694125217124;
        Thu, 07 Sep 2023 15:20:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm424494wrv.111.2023.09.07.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 15:20:16 -0700 (PDT)
Message-ID: <5cfff52da8ff586248ba394248e7b086ed792549.1694125210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
References: <pull.1564.v2.git.1691702283.gitgitgadget@gmail.com>
        <pull.1564.v3.git.1694125209.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Sep 2023 22:20:04 +0000
Subject: [PATCH v3 08/13] trailer --only-input: prefer "configuration
 variables" over "rules"
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Use the phrase "configuration variables" instead of "rules" because

(1) we already say "configuration variables" in multiple
    places in the docs (where the word "rules" is only used for describing
    "--only-input" behavior and for an unrelated case of mentioning how
    the trailers do not follow "rules for RFC 822 headers"), and

(2) this phrase is more specific than just "rules".

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 4 ++--
 builtin/interpret-trailers.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index b5284c3d33f..0eea937c30e 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -149,8 +149,8 @@ OPTIONS
 
 --only-input::
 	Output only trailers that exist in the input; do not add any
-	from the command-line or by following configured `trailer.*`
-	rules.
+	from the command-line or by applying `trailer.*` configuration
+	variables.
 
 --unfold::
 	Remove any whitespace-continuation in trailers, so that each
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 5f3e1a38eee..f70c5df8d4b 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -105,7 +105,7 @@ int cmd_interpret_trailers(int argc, const char **argv, const char *prefix)
 			     N_("action if trailer is missing"), option_parse_if_missing),
 
 		OPT_BOOL(0, "only-trailers", &opts.only_trailers, N_("output only the trailers")),
-		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply config rules")),
+		OPT_BOOL(0, "only-input", &opts.only_input, N_("do not apply trailer.* configuration variables")),
 		OPT_BOOL(0, "unfold", &opts.unfold, N_("join whitespace-continued values")),
 		OPT_CALLBACK_F(0, "parse", &opts, NULL, N_("alias for --only-trailers --only-input --unfold"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, parse_opt_parse),
-- 
gitgitgadget

