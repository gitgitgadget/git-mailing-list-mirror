Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7331F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfEHPxv (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:53:51 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45676 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfEHPxu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:53:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so22505863edc.12
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eSEy4lb7WYgAWpgS/k1w9gk9+9sz/RGuF/mmdJjwxO0=;
        b=IAtylEVphJ+LXcE9Oy0ooQGee8H5bTCXmeFecHNL3tGEp8Zf+tc5rKEhNnSaHPcI7M
         ViC9/3jvKiNEmHepgH8kfJACXKQgDFQD320dKjdzUlyaRoc1vPsZZAvKEMbh7Mq4ve2R
         +fXG46jF7zszzH9gLdzNVuK17PqDg2De3+VCARvnznf+Levmid0rukKmQdIPXkoMFy9S
         E9fEV16cAxs4+Xf3cazxMsry/h9xvaHBdSUwvBf69CjdksrXC6YYysqioTx9W2r0YIGl
         tlLPMH34oyak0yTraPYUTgFY7eNTTtKC+k5VbgsZ0f6gv7Xgb11M9OcERwCasneZlhwF
         pFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eSEy4lb7WYgAWpgS/k1w9gk9+9sz/RGuF/mmdJjwxO0=;
        b=rl93s9FpW7ZhPYQrXn4aGWOJMkDH/1QLB/xQSn6lKC9drdBvUldefu//iemYXnz00O
         YOu4ngY1uk1sijOvCkbCCorNwnB7wQ6Tabe/+YQJIfYjdgNi58+kuv/Ws30nq0G6SpHr
         ZG/mqz1i6ShpKhK1H8Yt5bkcocCk2lzsypVDDhPyyuQOSnY211arXCp4NhZ827oC1bBe
         j2+ilyPNnuk6mJZApPuWQ8taieM4AmgSVJxjUs+tkwU80vaKORt5ZxvUVro3z0siKmT2
         e2N1KW9eukxEXPuUJf+NGSFlcwjfAo7NENIWyzToH/8HSLQiB6u4EinXycEG28cIPRJF
         t2jg==
X-Gm-Message-State: APjAAAWq1KTBorZywacdVGvDi5W3SLdSGeKffbJaYhBchfUKhad95F+N
        oirbzYaWFa4xmBnHDI5MqRgoqUYSOCg=
X-Google-Smtp-Source: APXvYqwIGpJlF8GsvYcoLJadapU5bl1/Y3SJvdsWTjDiTNxFbEqSNGHR9bB0SsKVGEARuSOCoT70IA==
X-Received: by 2002:a50:be01:: with SMTP id a1mr34975230edi.12.1557330828988;
        Wed, 08 May 2019 08:53:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y5sm2611587ejc.41.2019.05.08.08.53.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:53:48 -0700 (PDT)
Date:   Wed, 08 May 2019 08:53:48 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 15:53:30 GMT
Message-Id: <0be7713a255d6f52c51ccb19299d0c9797e9a03f.1557330826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 01/17] commit-graph: fix the_repository reference
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The parse_commit_buffer() method takes a repository pointer, so it
should not refer to the_repository anymore.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..e4d1233226 100644
--- a/commit.c
+++ b/commit.c
@@ -443,7 +443,7 @@ int parse_commit_buffer(struct repository *r, struct commit *item, const void *b
 	item->date = parse_commit_date(bufptr, tail);
 
 	if (check_graph)
-		load_commit_graph_info(the_repository, item);
+		load_commit_graph_info(r, item);
 
 	return 0;
 }
-- 
gitgitgadget

