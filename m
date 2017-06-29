Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B3FF1F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbdF2WWh (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33563 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751560AbdF2WWg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id j85so4977935wmj.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3Yv1bardrUnbYdlKOCiF379FMyHYHYszuA04qlc3uA0=;
        b=Y02aGp9USxXvjZyCrYdRM9493k20qzPruDCXd0Pih4q/5V/vrFPegu4RAAjCWbMUH8
         IVOrcK1lchA/RiBJqmk1Duf/hz8eG8MvnoxuU1U5Kylt+SoFsa3i/G2S6MOIHgVkP4NL
         50OmPT9LE/pe8YSzZuNCT0Q9NvtjQThbDnwfOEGSkUOVY5olec923U9LJBYGoSefsGkc
         y4ZZZytMJAx56Zgxg+xSKAwpVGQeGl6J8dJhkuDqedepWVQA6iXzGIoCkaKKap8GcByK
         Cs+Yqebl2eZuWrLe2XJyaxJcGLehyxpBnexibt8lQOH+i63fSReVLCstH5m+QouStwMr
         Braw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3Yv1bardrUnbYdlKOCiF379FMyHYHYszuA04qlc3uA0=;
        b=hLqYwM2dSfVILarIXfbFU8sxLoLwzHd0QcJ9mzCTLgsu8SEzddxRug17DtIrq4nLbh
         QVggaXrUXzTGNrbefrc1hfGJ/9GB5w8FOzrNY84cnRCd6DoZXtEMfd2gyAe5aOzyAncV
         R328xghwlSAV8HOLEi3zhMhBte3Ygxlr2mSkR543QJHwrGPssLQNbzUXzvHQtZKuZNbg
         U9Fn91XklOk5mavnxEdao+noYSs94TZ4qy287IwWJobSM3xPVOFJ5x2tEgJ48mBRpM77
         /dgh6wYfgy0u4VVRNrMBr6NAnFEvWth1OBqMllIhwWx2BB7Y/qykrL94oBMJthTuXzRD
         Y/TA==
X-Gm-Message-State: AKS2vOx+b0iBYITKUPwAZ8yJQStwmOSVL3+SP1K6JY+3UrpockC3jNbJ
        Mi2sRv1D8VK+999ZNl0=
X-Received: by 10.80.182.180 with SMTP id d49mr3215467ede.56.1498774954332;
        Thu, 29 Jun 2017 15:22:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] grep: remove redundant double assignment to 0
Date:   Thu, 29 Jun 2017 22:22:17 +0000
Message-Id: <20170629222222.4694-2-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170629222222.4694-1-avarab@gmail.com>
References: <20170629222222.4694-1-avarab@gmail.com>
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop assigning 0 to the extended_regexp_option field right after we've
zeroed out the entire struct with memset() just a few lines earlier.

Unlike some of the code being refactored in subsequent commits, this
was always completely redundant. See the original code introduced in
84befcd0a4 ("grep: add a grep.patternType configuration setting",
2012-08-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/grep.c b/grep.c
index 98733db623..29439886e7 100644
--- a/grep.c
+++ b/grep.c
@@ -38,7 +38,6 @@ void init_grep_defaults(void)
 	opt->regflags = REG_NEWLINE;
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
-	opt->extended_regexp_option = 0;
 	color_set(opt->color_context, "");
 	color_set(opt->color_filename, "");
 	color_set(opt->color_function, "");
-- 
2.13.1.611.g7e3b11ae1

