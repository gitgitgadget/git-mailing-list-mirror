Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F18C433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 15:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D083E613CD
	for <git@archiver.kernel.org>; Sat, 15 May 2021 15:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbhEOPaH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 11:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhEOPaC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 11:30:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1962C06174A
        for <git@vger.kernel.org>; Sat, 15 May 2021 08:28:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c14so219319wrx.3
        for <git@vger.kernel.org>; Sat, 15 May 2021 08:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=quu6wgTeIjBA1kV7o0O2ZgbLtCXyj3suFBWBlOx2IxI=;
        b=HyE8H/3TcHeSFFWcZzJMxd6otMerD3w3RxS5pY8zJXlB9A3GW7PfXMqJBdQn+L2J0W
         QHSmEvHmn+VeFXcmnBY+0mSX7Rf+jeu5y29J1aCeoG1VI2EfmjN0tcyyd/JtU24EqiAO
         YBXRnZX/PEKDGGMCK63ynGGqP1FKkhiCMVVY0GNjziwCqZpvd5TP0Mk5vtvLQjB/ihWw
         AcL5ppE8yG6IIiRVZBZS+a6ZmKQ2NhF42985Azx/owADvKScc1rRT1eAoVumVq058y9C
         HWsjQPR3ASXCnTBwjLaUDJQXcdKD7nQSJXb9pTQiXc6GHwfStGQv3qaQXw988D0LGQ8l
         VfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=quu6wgTeIjBA1kV7o0O2ZgbLtCXyj3suFBWBlOx2IxI=;
        b=pYsi9M1zKZbzkqp7pN8McXmedevTWkYjur8LhL+RejtLpjCnUbFUF7HVj2idSmt8ZB
         FvpqXxY9FT2+KtZhglufdoLQgxkDgQFlzMRca/WRBSOtwmyKb9HA0+xyvJLy0f6jpdUu
         JjOjOuSaKEMR/dEHidmDRKAnDjmt6AuKrNsBwiKSPAf7K2zVptFG2pghgyPXm7t4aM4T
         pIL9IJ0Yyj3LGHzf9jIpfSHHwy/pEG2v0OtczQxs9YVPnAf2KNLHOxMSqBSRw8xdjKAH
         E4hJ4XYAaLHfDhZ/Gu0v5peTr96s9GsG4Vog2lK6sCow1hAQ1MKGzWcN8yIQkcioD3xV
         ZB4Q==
X-Gm-Message-State: AOAM530zmvNZq6IDXj4RxyvwVgGbY61mm1MrecOEUqTEymGPT6VtaBNh
        Rs57xYjpB001xuaO0fTVaOU=
X-Google-Smtp-Source: ABdhPJy3VeYadpa5q644818CyBgCPvd3oteTMz23m4s1CAVGIMnPkxFku4BjrI5Y9/i8AYt4d5XB6A==
X-Received: by 2002:a5d:44cb:: with SMTP id z11mr14686174wrr.159.1621092527545;
        Sat, 15 May 2021 08:28:47 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42001504451e90ab6b33.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:1504:451e:90ab:6b33])
        by smtp.gmail.com with ESMTPSA id v18sm11617271wro.18.2021.05.15.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 08:28:47 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/2] t/README: document test_config
Date:   Sat, 15 May 2021 17:27:20 +0200
Message-Id: <20210515152721.885728-2-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g67a420f573
In-Reply-To: <20210515152721.885728-1-firminmartin24@gmail.com>
References: <20210514065508.247044-1-firminmartin24@gmail.com>
 <20210515152721.885728-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

test_config is used over one thousand times in the test suite, yet not
documented. Give it a place in the "Test harness library" section.

Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 t/README | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/README b/t/README
index 8eb9e46b1d..aaf1c9cadc 100644
--- a/t/README
+++ b/t/README
@@ -1046,6 +1046,21 @@ library for your script to use.
    Abort the test script if either the value of the variable or the
    default are not valid bool values.
 
+ - test_config <config-option> [<value>]
+
+   Set the configuration option <config-option> to <value>, and unset it at the
+   end of the current test. For a similar purpose, test_config_global for
+   global configuration is also available. Note, however, that test_config_*
+   must not be used in a subshell.
+  
+   Example:
+
+	test_config format.coverLetter auto
+
+   Is a concise way to write:
+	test_when_finished "git config --unset format.coverLetter" &&
+	git config format.coverLetter auto
+
 
 Prerequisites
 -------------
-- 
2.31.1.443.g67a420f573

