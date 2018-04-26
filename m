Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A93F11F404
	for <e@80x24.org>; Thu, 26 Apr 2018 07:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753748AbeDZHvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 03:51:17 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35638 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753545AbeDZHvP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 03:51:15 -0400
Received: by mail-wr0-f193.google.com with SMTP id w3-v6so55695070wrg.2
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 00:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sfX9NPs4nLPXG8saphFGFj2chQVWMD9ty9opwjWuB+E=;
        b=tZ0DubctOwGST4t/OZuwoAIsae5keaCyUWrlsiN9jLngvJ3SCWtzRlTYkXThx7AikG
         RnG+eM/yRkTezY/aM41H9I+/m5z0tFqi1TIjjMbXvk5ORUvyAu9AtUUJrOoJfA420wJH
         OUmFFbTwksUj3iNkIvMzkGtWI//0SdGfQ6yO+CuJWM7Oso5cgT+VF4eLH7yRRNbHbsvf
         1xo/u+ZsuSkbI7AU1itHFs2CkAG0AxWXqldeZEUhWhVNem15CaDWm5KFeusH6sPqVl3v
         jb7oug9Ocr6j22KdienkwU1Aaaed0F3AiG3sRR1D8X3M1Wz3A2cYKBa52ktwW8UuaSaU
         L57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sfX9NPs4nLPXG8saphFGFj2chQVWMD9ty9opwjWuB+E=;
        b=hVmwuqN/tdIW/oO7S4b9j00A7MczPhR11KRQDX++eQdemjh9dKCuYvwCI4/bHq8KGW
         2wyGo60Y6m+b8fghnZXS/Q0pEsctclvCLMH/byxhqPoeukWyXDbKALabHiXFx8NjSaXM
         N34vOe/327h5II3A4cmkOUDQ8zfCh0D87tqoz+Wp1s81w9KrEjO+nykVophzzJ6Le9kd
         ttkr3UwNVTI9J1nW3AFPrWRW5+h2QW2puso++PdQ9ACXS3vfByQRzPR62p/0OWAsXJTr
         m1wwNObtbrsu0xY2qEvpP2niESBE3hrqaKzLW5UUUclmDR+F7saBYqeQiSz7v8yFyZKr
         a/Fg==
X-Gm-Message-State: ALQs6tC4KIsatvdvQFk7BMX0ue6el+iOJMxbEQJ1ssTqCce7dk1cXHYt
        DATe+UQaDe4+jDw6R9REEqtcSdia
X-Google-Smtp-Source: AIpwx4/wfe9ujfVJuDg686jldRoKaQFL47bF0+WBu/B2GRRnqUtRDfdC3WINrDlmdIlCglU6k8rl8Q==
X-Received: by 2002:adf:cd08:: with SMTP id w8-v6mr23897731wrm.187.1524729073450;
        Thu, 26 Apr 2018 00:51:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w6-v6sm3424551wra.16.2018.04.26.00.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Apr 2018 00:51:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] .gitattributes: use the "perl" differ for Perl
Date:   Thu, 26 Apr 2018 07:50:57 +0000
Message-Id: <20180426075058.9322-3-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180426075058.9322-1-avarab@gmail.com>
References: <20180426075058.9322-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in gitattributes(5) this gives better patch context for these
types of files.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 .gitattributes | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 482af05a6a..aa08dd219d 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,9 +1,9 @@
 * whitespace=!indent,trail,space
 *.[ch] whitespace=indent,trail,space diff=cpp
 *.sh whitespace=indent,trail,space eol=lf
-*.perl eol=lf
-*.pl eof=lf
-*.pm eol=lf
+*.perl eol=lf diff=perl
+*.pl eof=lf diff=perl
+*.pm eol=lf diff=perl
 /Documentation/git-*.txt eol=lf
 /command-list.txt eol=lf
 /GIT-VERSION-GEN eol=lf
-- 
2.17.0.290.gded63e768a

