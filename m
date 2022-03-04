Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B929C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 18:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiCDSdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbiCDSdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 13:33:14 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E773F1D3AF4
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 10:32:24 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c192so5506757wma.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuG8BQaVIV16NS3gajQrqaVX3W7LNb3pEqctcyKRxgw=;
        b=dHBgNh89V1TjeH9wM8rRQZ52ScD1s2aF91AVMk5NJG+cskOVI1+ukX0zpaOkTd+Oas
         ePwp0UBy62KTRymtDLfUbCepqZT6IA8FjLFuu7TkGTCEgh1IBezGBz7U1pdEPeIRYMCT
         +sPK1onPl1GB9r3Mmzb1y6bOnh1p0zHI0V3C+jBqWzA/Gb8aVSUuhxOwPTwKEvT8K9NR
         hP+XvZetbMfeBpSCwVOykxDCyCqzWn4T9+6bmmXGzxieDVnoxpovkr34sjAhG5vQI3lk
         45yTkjG7n+MUt8oPOJ46k6fakVjNJqSh97ASapxRYSmQEpNCrBJwIeH0IXXZhp6tut/g
         N6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuG8BQaVIV16NS3gajQrqaVX3W7LNb3pEqctcyKRxgw=;
        b=j+K62eSlDrus7O0LH3lYJ7GvXkaE1sfpW9dyfaxdMVs2w+vNkXjIE8JD8ZJZ7jMm5r
         2HPb+QBWWl+RspBsK4tJe7sjCOuz+il6n5pqGXxv4Sqv77swNXiAYLq3OHOOKycBn6m/
         xP+vswl17LuywpKvygxWFVUZzz4A4xuL29X+VkpWXG7O9V9TVz8+qV1BqOjCVK1MubVn
         vkgAzAXpdDGq8kGmgGvlUsQuKCZJyR7zEHd3p3GNklDVdyYpnbaorbH090TcxNg+rFxW
         zRIAehBzusYmz8f+UJe+tpZc7tBGZIyPVumuhtcvNGxBQgbXEMrTxSFmrejTMJoSau2Q
         4//g==
X-Gm-Message-State: AOAM533cthMy/R7FGw9pnu22Lkg9HQcUXXOsUatmZGPRKgvbBv5LB5z5
        9ZLegKez7wwNEnzoVS/r4t13pfKwAWQm8g==
X-Google-Smtp-Source: ABdhPJz4c+MgUFOHydWGyGFLfUhVq8QBxExvBLRcPMUb/itE2xZPALCWBd9N4k5XxmmqK+W60h9Mjw==
X-Received: by 2002:a05:600c:35c4:b0:381:782e:9645 with SMTP id r4-20020a05600c35c400b00381782e9645mr8911247wmq.63.1646418743164;
        Fri, 04 Mar 2022 10:32:23 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c22cb00b00382a960b17csm10573990wmg.7.2022.03.04.10.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:32:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/14] diff.c: free "buf" in diff_words_flush()
Date:   Fri,  4 Mar 2022 19:32:06 +0100
Message-Id: <patch-v2-03.14-90517a05582-20220304T182902Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1248.gb68c9165ad8
In-Reply-To: <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
References: <cover-00.14-00000000000-20220302T170718Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220304T182902Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the freeing logic added in e6e045f8031 (diff.c: buffer all
output if asked to, 2017-06-29) to free the containing "buf" in
addition to its members.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index c4ccb6b1a34..c5bc9bc5128 100644
--- a/diff.c
+++ b/diff.c
@@ -2150,6 +2150,7 @@ static void diff_words_flush(struct emit_callback *ecbdata)
 
 		for (i = 0; i < wol->nr; i++)
 			free((void *)wol->buf[i].line);
+		free(wol->buf);
 
 		wol->nr = 0;
 	}
-- 
2.35.1.1248.gb68c9165ad8

