Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 452691F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeFZHdH (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:33:07 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33984 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752323AbeFZHa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:30:57 -0400
Received: by mail-it0-f68.google.com with SMTP id y127-v6so14532521itd.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/6T2a7TRrwA8hbWk6zptXGxqRaJiYQfczNORmTjDXx4=;
        b=C93o23TLVogqvl+/mhrAkdUvCS/DjK1Qd5g4RMtzXJRxAe9+thxeSRebjuAypnVZ4/
         2sqOVKLMlCHBbFcFeYvq2tI2UVBrgQ2GGlIaVFdFEXDQaaMpzj5LY6XV8iLJa0JcgxcP
         NfJcNQTQPYau6AarD15TJCqqxPTzwoLQhPYPkNuTXmtx2dI/JMPGqrkKwo4AnXGYb6+P
         a5B8eFlRvXCr7s7lkqlx/6zFK9oMf+Tu83+Bfkd/ZUcuVC2a15QjX39pVsnr+l/JsUY9
         T/zDLTOp8GT6tvzm//f4hm2AHNPV2b0PFxujF3yTqC/qXPSji3u93o5YxvNdlapd/p8Q
         712g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/6T2a7TRrwA8hbWk6zptXGxqRaJiYQfczNORmTjDXx4=;
        b=Sg5eb2+mPL+FCksMTyKt5R74fpm7F5/nAnFqgs1U97KVqSLu+O5S4ZSlWcLbrcEqPz
         Jqap3WByAh47FONL8SKMVwf2/oeFQEWVll44ZOizaGHZb5iLZcJfWjVrOt0x2uwg/8+Z
         e3kdzVs0s+/AlLL56mEGhdxGRdDQ2ZS8tuejxFcABuNTf4jW7/Pm4FO4InaMD08OYVXV
         jh+jrIm2bKzZaiko/u8VrO0IH9RqP6UnWLe+9OLSizjcgMLx9qWhnhxs+eIRWhzpTcMA
         rPaA9B4P+xRL5lGrBM9mrOSQM757spUUZo3gI+te+EyUw5buy3EYPE+DVYHYy1uK2RoE
         CZHw==
X-Gm-Message-State: APt69E3DKZpsAd5lEUoJ3ZKkkMKMaMwHvFbbdm6plygDqPydW+5jMh/S
        DDtsxed+Y+fOh4lzsv1j4NLccg==
X-Google-Smtp-Source: AAOMgpdg81NucTP8eULuafjdUc54xjxhUmYOSo21iqeJ+XEJSVuYsg/vFCLUGpIfHBmTwkM7ev88rA==
X-Received: by 2002:a24:2bc1:: with SMTP id h184-v6mr526241ita.84.1529998256664;
        Tue, 26 Jun 2018 00:30:56 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:56 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 07/29] t7201: drop pointless "exit 0" at end of subshell
Date:   Tue, 26 Jun 2018 03:29:39 -0400
Message-Id: <20180626073001.6555-8-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test employs a for-loop inside a subshell and correctly aborts the
loop and fails the test overall (via "exit 1") if any iteration of the
for-loop fails. Otherwise, it exits the subshell with an explicit
"exit 0", presumably to indicate that all iterations of the for-loop
succeeded. The &&-chain is (perhaps deliberately) broken between the
for-loop and the "exit 0".

An upcoming change will teach --chain-lint to detect &&-chain breakage
inside subshells, thus the missing &&-chain link will run afoul of
--chain-lint. Rather than fixing the &&-chain breakage, instead just
drop the unnecessary "exit 0".

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t7201-co.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index ab9da61da3..8d8a63a24b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -673,7 +673,6 @@ test_expect_success 'custom merge driver with checkout -m' '
 		do
 			grep $t arm || exit 1
 		done
-		exit 0
 	) &&
 
 	mv arm expect &&
-- 
2.18.0.419.gfe4b301394

