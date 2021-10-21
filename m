Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCACDC433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4E0D611CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhJUQAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbhJUQAB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:00:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1DFC061764
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:45 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so227898wrv.9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/opoB5BVXgEvuPJdb6xV7Te3QJvo22WiNDNaNJ9eRFo=;
        b=gbmWwSIIAfuOuPvkjmkRLAgHAIEUeyCVEmz/6effVb6mkAIZt4GxwAdP0DoIBOAW3f
         6Z1we5C3DrV+lXYvMTKCopZidiE307OjraFGVzKBn4R6MKVTysQ1NFx55Tsri72xZSZE
         PL89GTP7US7gGzTxOr2gQIpSZEep7yjKKD5n048gAP/+x8k9GCSi/bStqMOnlZKzJbz5
         VWcIBttoqpt/uVaqKSloT7zCmqMi5eReZTywKq49rqnIlku6KycML1ti5cjq7035O8QJ
         LDpIwZp+a+w+YYtIWyFCAqEpDuueHSBYje+mLbAKJBJr+00xn3iNCWsmqfTRYLR+aaKw
         f4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/opoB5BVXgEvuPJdb6xV7Te3QJvo22WiNDNaNJ9eRFo=;
        b=sQF5AiFy9IcFu18NPOChH2rKE7sEqLjH234CSrge5dWPo94/iHtX9IIQQbyB2K0szV
         CT5QmhvUvPqOP1n0bXuNUNBxUKSAyl8IgQhwTYE4RF4e4RS5ru+wZKPrjUlvrlHOg1ok
         Er9M8BmamXE4ybc9CTKpfjY/j+cps3Zx5roA9r2ezFyt7Lc5Dd+k5qSYb9s4pKzVFJxf
         eUyXT9UegTCATihAPI0vMI2so1dfvjCgYrTe/sxA6W8lwON6popB5e8nTu0/uE8JVZSK
         pz80jTdwMc+aicUmVkimdfLky/JkCxz8d+CXvOfEmqk1S8164WByHoOAEHi+ysGx0EZ6
         pwwA==
X-Gm-Message-State: AOAM5331sU4Gt5/qiDGzVLFrvHnFeA7zbHFqDt30nPu0TFv4dX1S/htQ
        anJeCUqfYM3rNF8fqT0MgIbOG4gn+DHT6Q==
X-Google-Smtp-Source: ABdhPJwCeEym8twCSVIPCWye53BgVsLTdnFU5CuzvrJcMRy5+4BhI4cSAwT5VVwE6HsXHcl9NTQatg==
X-Received: by 2002:adf:f386:: with SMTP id m6mr8426621wro.389.1634831863895;
        Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] reflog: free() ref given to us by dwim_log()
Date:   Thu, 21 Oct 2021 17:57:36 +0200
Message-Id: <patch-5.6-85b7b7aef37-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When dwim_log() returns the "ref" is always ether NULL or an
xstrdup()'d string.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index bd4c669918d..175c83e7cc2 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -653,6 +653,7 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 					should_expire_reflog_ent,
 					reflog_expiry_cleanup,
 					&cb);
+		free(ref);
 	}
 	return status;
 }
-- 
2.33.1.1494.g88b39a443e1

