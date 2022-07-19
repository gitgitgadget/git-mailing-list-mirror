Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F2C433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240139AbiGSSc2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbiGSScZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:32:25 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348C57273
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:24 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id j1so18423452wrs.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=64PM/O5hQy7BC+JZjxzvOXnx3IBMhxyNZHwZWIl6iqM=;
        b=KI4G8LVIcCNC0pDV09hlBes6w0sel2XGy8Thq/HSW438mcyFoUIAiS55+inat4nu5n
         Vsuf2jDJquBGI12Bpq8NLfF2N27mkbv5TCnnRuijDXDZ92OAygolRmMk0C5NYcRFog8a
         XuFf8wzEfwogB1QiWKXalXULC6tS7WxIZcpTUF+TiTbafl8KO7sPfkG8sHqcA7Lt/Ba2
         y7CQsWBvzq2HUFf7L3+LGK0b2UDfK5Uok9L6yiAjQU6gzByVeulvofXfLpJD6N6Gmn5N
         KoIpLGRMKgMBkN84xldoQze0Yg3xNsGpnyY+RvcCh2FW/MPIVKaJ7OtKfWCQZcCc4K93
         HvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=64PM/O5hQy7BC+JZjxzvOXnx3IBMhxyNZHwZWIl6iqM=;
        b=MvoOtoQ3LcfOdjMnyKCYll21YXw89BQFvsx3gvPnMKECcs+SUeaYL9mYhjxyCjckfg
         Sfd7leJsxEwXEvswc6jbiteds0XhyVhJkJ12hkYD5ACJcnjn3joCDKLBOqW4Gpxv1V96
         iVw8bmq2rpy0p/UM53Yx8nACTrwj0Qb8HMNIoO3zZLhXXX8DSG/aBYjtDJn0JseusjMm
         UlKT58STBg5uoUQ0GaBg9g+vuQkTVInWNJNuqIP/zFFpUs8OchtT49a/siEeUVxe6+5C
         4JDKWJZcpgOM4I967yN6Xn8XInh4DF6xuRuaJ8plhzW1o8Oo1LAZ3w1g7+vfcbqqf3aL
         VxTQ==
X-Gm-Message-State: AJIora/Ol6vur/gnm5ovEkHF6rhPgbnhGLl1o7PolheUjS/K1uZ6Wyhz
        p7ym4n6LJQN1t+vPDOsGAKL1DeqDh5A=
X-Google-Smtp-Source: AGRyM1seEHJG9V0LmrykXzECOditag/ox+QaPzs7+lRwRUgCnFIQ7XV2Q3uOVN27NsAVCTG0Urvc8Q==
X-Received: by 2002:a5d:4c91:0:b0:21d:8293:66dc with SMTP id z17-20020a5d4c91000000b0021d829366dcmr29892379wrs.30.1658255542547;
        Tue, 19 Jul 2022 11:32:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az36-20020a05600c602400b003a31ba538c2sm7922834wmb.40.2022.07.19.11.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:32:21 -0700 (PDT)
Message-Id: <c1c83c4284ba4b041694a521c3639f33561ac5e3.1658255537.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
References: <pull.1274.v2.git.1657852722.gitgitgadget@gmail.com>
        <pull.1274.v3.git.1658255537.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:32:15 +0000
Subject: [PATCH v3 3/5] git.txt: remove redundant language
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The documentation for GIT_ALLOW_PROTOCOL has a sentence that adds no
value, since it repeats the meaning from the previous sentence (twice!).

The word "whitelist" has cultural implications that are not inclusive,
which brought attention to this sentence.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 302607a4967..47a6095ff40 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -885,9 +885,7 @@ for full details.
 	If set to a colon-separated list of protocols, behave as if
 	`protocol.allow` is set to `never`, and each of the listed
 	protocols has `protocol.<name>.allow` set to `always`
-	(overriding any existing configuration). In other words, any
-	protocol not mentioned will be disallowed (i.e., this is a
-	whitelist, not a blacklist). See the description of
+	(overriding any existing configuration). See the description of
 	`protocol.allow` in linkgit:git-config[1] for more details.
 
 `GIT_PROTOCOL_FROM_USER`::
-- 
gitgitgadget

