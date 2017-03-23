Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D407120958
	for <e@80x24.org>; Thu, 23 Mar 2017 13:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934524AbdCWNGm (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 09:06:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752128AbdCWNGk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 09:06:40 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so16563379wmb.2
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 06:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwDYwYqzL9attduLRhabFp5q+qQsLdNvkblQK4x5SlU=;
        b=G5ToAR7nuXSLNGVOq/XgwEhmcSu7M6O5BBXo1GRvSFBaylmWgKxsLXqm8dTupD57l8
         jw4PTip9HQTeaR0VvLzVbo9oehQIFq5F4W81sndtxCLbnYDxNu2/GIw2Vcmxeu9ODZOK
         dCNi6w/sw2umRI3mCZnaepRVSfZO20dSjnT3F4cz+HKMA7mrUWd2CP+GOdCKT5DJbKUS
         +z0/MPE8NqlfNctcwS2vLEoGdsjH6kCtr97G3IX+iw92DQGkJJpIcmvofo/PJdkGv+M7
         y4Nc+adKqTXWWrE7mWsVhR6KkILrVGH6jywzYtEJM2elucWvfI3APmR6hEuZ3KePp/3c
         xFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwDYwYqzL9attduLRhabFp5q+qQsLdNvkblQK4x5SlU=;
        b=Kirt4pqgIiiI71TM6503ZXqSazh1Djpklq3WsX4X64ANgew+u12aPsHVOUCyxLjTCT
         yuc9f0zbm0TlrDkx/V2UHPfS3b3plA60qJjvJbpoAUVAeY8ItHUjtcePWAt5E4ZvOuo8
         qQK8IC5dI+rqlzooRDABcQlTaVt4/f15nyR1MlspfApo1+5kQuOv7yRnXERORyUjOaKB
         r6DUnu1y7FrHopnoj/ZeYTsR9pKOW4huwVSLuMVuwZ2enErBS7cSU0+cph8XgcGUM5G8
         jLOdkgW7XBUHc9nnBHun5cVwKdkO1YAUKqr6rm8jwe+aQwGzLW/6TPufAblwZSJjAi4h
         jcoA==
X-Gm-Message-State: AFeK/H0o3OPqxGQp4tibY+ZplwPFAxFNipI4nSsUhZxx2V+fETuHDyDyU55CxTQ/HuZUsg==
X-Received: by 10.28.159.143 with SMTP id i137mr12837081wme.128.1490274398819;
        Thu, 23 Mar 2017 06:06:38 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h3sm5810071wrb.6.2017.03.23.06.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Mar 2017 06:06:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 08/16] for-each-ref: partly change <object> to <commit> in help
Date:   Thu, 23 Mar 2017 13:05:21 +0000
Message-Id: <20170323130529.11361-9-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170323130529.11361-1-avarab@gmail.com>
References: <20170323130529.11361-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change mentions of <object> to <commit> in the help output of
for-each-ref as appropriate.

Both --[no-]merged and --contains only take commits, but --points-at
can take any object, such as a tag pointing to a tree or blob.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/for-each-ref.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index df41fa0350..1a5ed20f59 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -8,8 +8,8 @@
 static char const * const for_each_ref_usage[] = {
 	N_("git for-each-ref [<options>] [<pattern>]"),
 	N_("git for-each-ref [--points-at <object>]"),
-	N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
-	N_("git for-each-ref [--contains [<object>]]"),
+	N_("git for-each-ref [(--merged | --no-merged) [<commit>]]"),
+	N_("git for-each-ref [--contains [<commit>]]"),
 	NULL
 };
 
-- 
2.11.0

