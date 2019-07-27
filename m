Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0343C1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 20:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfG0U2E (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 16:28:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34378 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0U2E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 16:28:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id n9so20099475pgc.1
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSLZN9tKqSCuPMuDP5zKmry2teTM44PTghzrAEtU3Bg=;
        b=BumO03yjSB6zrCma4qcGhzRg190dnQcl7QDxsbV4vveQ5nGp/yuBRZ3rTJXINDaEOn
         09wwViw7ZknSCt28nh3MVEsxfT3x1aZZdoLJU8lySQ3EttX2Eru6ClZg4m0SfwJzYdG2
         GKtqfab9Rbd1MNGVHTcJO+mk4SkymXZ/P4WHVGfL3D53m225pTbdUVADk/ORaGmw7kXl
         jKdnmNoln2b9E53sTdUHOeZIl44cYDDwoWqkUctKmRM3xpBwGdwhZd+Y2FM2InS2DjZf
         Cqxq0BH5LvZ990Pr/3PU17WvlvYb9DgfI6MrAAlqK25Cw61Ce29spJjO0WF644mMo7fg
         SBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSLZN9tKqSCuPMuDP5zKmry2teTM44PTghzrAEtU3Bg=;
        b=FUfvjGswzxVbiI2tjL6sLmnxyqrUgWZAJSNruKtn0VKMc8tk1x2MTz3iHdRTLxCuFj
         NtuzNnNx5R9lzHAuCR9uRHIZbCAdogx3hCiWHjpX2FFYHbMnmYjrR8JL6x07jL4QGSXR
         qow3zHgbNN23hjQNRqL0QVxTjVkCHSlq4mKJv0W2K6x99d0hrdtBnOZMyMz3ZI4bSn4X
         mOUHrCoNcFEquATi5jO48UnDqi+NTRKZ3ppjGfzXyiOtYMBOsgWD1SY1JtUc/zKIbwQI
         tmXeAXBMj/ZZd7KaouHF0KYl4Kg5yayX1geC55uDfn1oRZjfWgWXQLT66RIcbx5RB9/P
         8SPA==
X-Gm-Message-State: APjAAAX7hnzD6uv51HKFVo1M1G3cxiNZvfD6LzrU9MQYMO7Ug4utp7wQ
        G8qIdxQSV0N8Ph40nGRbv5m5AZw2K14=
X-Google-Smtp-Source: APXvYqyA0dWTP7Z/r0f7POg2fw4w+OuVqfMA4BbSpImpRWqbzwz46GjS2wa6DJ5wVg8Jk7SBTRMq7A==
X-Received: by 2002:a17:90a:e38f:: with SMTP id b15mr106604708pjz.85.1564259283024;
        Sat, 27 Jul 2019 13:28:03 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t8sm64671302pfq.31.2019.07.27.13.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 13:28:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH 1/3] grep: make pcre1_tables version agnostic
Date:   Sat, 27 Jul 2019 13:27:57 -0700
Message-Id: <20190727202759.22310-2-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727202759.22310-1-carenas@gmail.com>
References: <20190727202759.22310-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

6d4b5747f0 ("grep: change internal *pcre* variable & function names
to be *pcre1*", 2017-05-25), renamed most variables to be PCRE1
specific to give space to similarly named variables for PCRE2, but
in this case the change wasn't needed as the types were compatible
enough (const unsigned char* vs const uint8_t*) to be shared.

Revert that change, as 94da9193a6 ("grep: add support for PCRE v2",
2017-06-01) failed to create an equivalent PCRE2 version.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 6 +++---
 grep.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..cc65f7a987 100644
--- a/grep.c
+++ b/grep.c
@@ -389,14 +389,14 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern))
-			p->pcre1_tables = pcre_maketables();
+			p->pcre_tables = pcre_maketables();
 		options |= PCRE_CASELESS;
 	}
 	if (is_utf8_locale() && has_non_ascii(p->pattern))
 		options |= PCRE_UTF8;
 
 	p->pcre1_regexp = pcre_compile(p->pattern, options, &error, &erroffset,
-				      p->pcre1_tables);
+				      p->pcre_tables);
 	if (!p->pcre1_regexp)
 		compile_regexp_failed(p, error);
 
@@ -462,7 +462,7 @@ static void free_pcre1_regexp(struct grep_pat *p)
 	{
 		pcre_free(p->pcre1_extra_info);
 	}
-	pcre_free((void *)p->pcre1_tables);
+	pcre_free((void *)p->pcre_tables);
 }
 #else /* !USE_LIBPCRE1 */
 static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 1875880f37..d34f66b384 100644
--- a/grep.h
+++ b/grep.h
@@ -89,7 +89,7 @@ struct grep_pat {
 	pcre *pcre1_regexp;
 	pcre_extra *pcre1_extra_info;
 	pcre_jit_stack *pcre1_jit_stack;
-	const unsigned char *pcre1_tables;
+	const unsigned char *pcre_tables;
 	int pcre1_jit_on;
 	pcre2_code *pcre2_pattern;
 	pcre2_match_data *pcre2_match_data;
-- 
2.22.0
