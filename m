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
	by dcvr.yhbt.net (Postfix) with ESMTP id 195421F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 12:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbfJPMHC (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 08:07:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42378 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389066AbfJPMG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 08:06:59 -0400
Received: by mail-wr1-f65.google.com with SMTP id n14so27700304wrw.9
        for <git@vger.kernel.org>; Wed, 16 Oct 2019 05:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Holr5Whn4FU3Ir4OeV6g9EcEnpLAUwMwoNU0V/n9YHo=;
        b=VkFrBa27KNovmkgm6712X7FfwNoOImgrB3ytw+Zt7abtSa/UWjY+h0ZUJeI0oL5vAu
         wPIFrIdhAo2+2zmyJOAYxG4nqMmaLeTUzcERmAdmWnzVEQD++1150vIPR8kY4et0B0ge
         bYoncuAFfmkRpc3NqYCSCM3qTLp0d9E2+CfZf9liwMczz7AdsPu4gUv9FwhhmkqmU5RR
         6dEa97AzjRUMcDWrbND0T0slXJIUl1uVEvbud1CSDBQfW3bz+CGScWmzddY1IqBOt0wh
         oj303qWsBh14+FWZ/613JBbRPs6tEfwOoqZO/Q+I+MYS/C5hN5L7vcOAImoRKhoirG6n
         nTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Holr5Whn4FU3Ir4OeV6g9EcEnpLAUwMwoNU0V/n9YHo=;
        b=NHCpqsPKMDuXa9xGjFHRpo1YnEpfvr5OWQKa6LLrQCLHTFpxoknCaTTV+pn9rZ1/OZ
         QlleYVLY7JCzOjKHdVEhXE3rJhVjHOwg1dG62gEE/cpV9vzM4p+bQOfG3bsmvXA1i6Pb
         sV0TAR1NC0ohThG0tBVUquwIKn3T8NEGXd3coJ18XEx5z805nbRT/ZFh2JyMxEBx/ZMR
         Zep5jWm7KFNSi2Va4tSF1X+voy36byq2DdjQGGZrb/yLJ34/iOmytuWgTbyQZPGQaE9/
         v99up7+FB8iULwkoqzSzxPl6Au2U8RjwOX2i8T7DaRwZFxNsiniXSGzKDr3jquII/Uw4
         i4gg==
X-Gm-Message-State: APjAAAUC0sE8U8FtdxS4alTM+0vpS+yv/JvNqx/FGazB5bHf5yb+Sfkr
        yxlLq0BUgTw2nTXMgH+z1huqPrle
X-Google-Smtp-Source: APXvYqzAhD/8c814Z6DH2cI71HG3I9JqadxdAC5c+Gb+qKyfjVH4htRCFzfojjcLYASlf46BzOQbXQ==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr2320402wrw.195.1571227617496;
        Wed, 16 Oct 2019 05:06:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q19sm50160566wra.89.2019.10.16.05.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2019 05:06:56 -0700 (PDT)
Message-Id: <f21b2c9eb5881396303de4b607631205142cf389.1571227613.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.402.git.1571227613.gitgitgadget@gmail.com>
References: <pull.402.git.1571227613.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Oct 2019 12:06:53 +0000
Subject: [PATCH 3/3] grep: avoid leak of chartables in PCRE2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) introduced
a small memory leak visible with valgrind in t7813.

Complete the creation of a PCRE2 specific variable that was missing from
the original change and free the generated table just like it is done
for PCRE1.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 grep.c | 7 ++++---
 grep.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 296edbb56f..9556d13dc1 100644
--- a/grep.c
+++ b/grep.c
@@ -525,7 +525,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -539,9 +538,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 		if (has_non_ascii(p->pattern)) {
 			if (!pcre2_global_context)
 				BUG("pcre2_global_context uninitialized");
-			character_tables = pcre2_maketables(pcre2_global_context);
+			p->pcre2_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
-			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+			pcre2_set_character_tables(p->pcre2_compile_context,
+							p->pcre2_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
@@ -645,6 +645,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_match_data_free(p->pcre2_match_data);
 	pcre2_jit_stack_free(p->pcre2_jit_stack);
 	pcre2_match_context_free(p->pcre2_match_context);
+	free((void *)p->pcre2_tables);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 526c2db9ef..533165c21a 100644
--- a/grep.h
+++ b/grep.h
@@ -96,6 +96,7 @@ struct grep_pat {
 	pcre2_compile_context *pcre2_compile_context;
 	pcre2_match_context *pcre2_match_context;
 	pcre2_jit_stack *pcre2_jit_stack;
+	const uint8_t *pcre2_tables;
 	uint32_t pcre2_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
-- 
gitgitgadget
