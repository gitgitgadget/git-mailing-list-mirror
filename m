Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CE7C433EF
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbiBPABg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244956AbiBPAB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:29 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8229EB142
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id y6-20020a7bc186000000b0037bdc5a531eso2024289wmi.0
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iAS+yNA4ntqks8GjtagVsZpXKuZg+FLmO/wa8K0+9Nc=;
        b=f6D1VhXOleULYgOeBhN2BEgNb+S05KwT24DAVPEj0IYHHBAqF/M6JviMEAsXq+3Oly
         rRd9V+EqW1HN21ocBO1L1BAEIP+4xVsfD7NX/xKrDFCzz7uIZq2vGVj3oxjOzY8eDG1X
         7Wp7ZFqN76eUzLRMuwvjUFLPoyluddOIAI2A0Oh5H7oAfLNALgsR1awD5KxcbajIpiui
         pPTdQZ+hQlj7OInw3XTVhKV6BHyqOZzVZNxWuw6kVQ+gNqH+gYgWSpR1biT3lDEBWoFR
         GFn9n+tx42qjXJZlA7HhN8c2G6UNSFVC5cFEF6WX30UCPEvckYoxk4EutrQfxbC2fNLD
         pMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iAS+yNA4ntqks8GjtagVsZpXKuZg+FLmO/wa8K0+9Nc=;
        b=ciRQgIkZcdScygAcwDffttPs50HeAUD4zs2Hf+x5xZzDER72Y8eMHjSIBbUhJqEZVt
         6K+pPqEYX8xO0Pq6FMzmPanK+2bw7bjd+VHa5wPKPJks6c/LF9ElAv8iEP7fQ7JqD8d5
         CosfVZQzBkENbObbDborzmeA52YGZfh+mxNY/rAltfWfj96GSZeiI6rT0JiIcwfZndLE
         cySwYLySljxHgZeMtrcyh6wK5Ze/0Ahg1NSP4XMBFL76Dcfl8JYkL7qqXWaiNj50WFVT
         CA21/SiIjRgjxYFeXGl1B6DbgliQXCMND348zxYCWFT9Xh1Dmwkq2LI01ZEX3uY5eEYw
         JMtw==
X-Gm-Message-State: AOAM531TH82SYAOd+57+/SiIXB0QhUypmGdJrntmtC2CuqGmtfQGOcud
        qpeCSZ1CjX2sMyePIif51ku+/fw+JnUEhA==
X-Google-Smtp-Source: ABdhPJxUQiiUYZcKQdR7Si3DNxgnqcj6dN8HxaDEf1PGNfIBvr9Hf21YVx1ZmHUnfPVN6z9QcJAduw==
X-Received: by 2002:a1c:a1c2:0:b0:37b:aa06:9c51 with SMTP id k185-20020a1ca1c2000000b0037baa069c51mr5159318wme.114.1644969673984;
        Tue, 15 Feb 2022 16:01:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 08/10] grep.h: make "grep_opt.pattern_type_option" use its enum
Date:   Wed, 16 Feb 2022 01:00:37 +0100
Message-Id: <patch-v11-08.10-fa0da3a9fba-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "pattern_type_option" member of "struct grep_opt" to use
the enum type we use for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3112d1c2a38..89a2ce51130 100644
--- a/grep.h
+++ b/grep.h
@@ -164,7 +164,7 @@ struct grep_opt {
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
-- 
2.35.1.1028.g9479bb34b83

