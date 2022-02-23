Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E9C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 16:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242569AbiBWQDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240555AbiBWQDq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 11:03:46 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409547E08B
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:03:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id s13so11874281wrb.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 08:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s/CZEzPjYxFygFdH4NuFkOv/sJbCmDhnqsdbwhsLjzY=;
        b=iZoi8VuptxRXGEIoiA7cM36ASb8aXiCJ5s739AFdedgIUJocb+gL69nKfpZ8vkxPvJ
         9jrsIUcoEQRyR/bcxadKqHpnYs3lzxGjrxumicsEdbmTt5z73RH5Ip0C04pV/B0sLQ8r
         hu10xFJokoVUk7ZVcTKYd94zoTe8YQTO0Xr5lqCy+3ZtrmBMvLloBxbi5Cp4mVy+us+Y
         tCd3940+zAjuMFOVI61ty1sfRLLSGsLjY/19x+nP+Zievbufsx9jIfrz3j6t9UOWffeQ
         n88gJcRX0Z+I+e3gjUsJ8kbxwo3MOKqKIB5bFoS5anVudP5bBE2ruRzR1+/eG+7GbchN
         YWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s/CZEzPjYxFygFdH4NuFkOv/sJbCmDhnqsdbwhsLjzY=;
        b=BGWjLV+NoUhNJpmnNmo41zZn4TTW/py2o8FIfFs9hqi2gA1fGVR1dZ4rTolekEmE6w
         CLw5ySUQuiKWgzBxslEbKFId9JanfGgeQ+DscuM+ysMG4CS4bdkFx09rYpjuI55s2xwv
         r/f+DPAxloyWc/R2c8K9N2XWtT/gQTlz86/Hg8/NDlDoLGAJIRSA+ZIF13WWPnXCA+Js
         /7rAZECD9653BSqYAJDx0rEyZdsaAXC4l1jh35ZbFgbp2Q0ncxHZUCtlhqSlzsXyb33J
         y6JNvmWxzqYzLBb0w1qe8LGSv0IzgJu8aaLmZVVQUXzapN3aSPxQFFrh6yRYAWNIiOiF
         g4xA==
X-Gm-Message-State: AOAM533SKq7Nra1pJMwhhSN2M1bIBc0TYCn3aycT2H9w6V/g5YYBrv3+
        IlbECDdq/A5OLpmqbJZfKNQd2TOS/JI=
X-Google-Smtp-Source: ABdhPJzKubz4YnaUmHXKuX7qt2JzwrHGT85vhP5s8FjOHXHAN5CaLO/cfEy9CS8uvrs0Z1J7PtOkBg==
X-Received: by 2002:a5d:6411:0:b0:1e5:6bed:3df6 with SMTP id z17-20020a5d6411000000b001e56bed3df6mr219110wru.477.1645632196526;
        Wed, 23 Feb 2022 08:03:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm119045wrt.59.2022.02.23.08.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 08:03:15 -0800 (PST)
Message-Id: <a2eb3956f3e811a1d96618b94738ce862f2c6483.1645632193.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
References: <pull.1158.git.1645632193.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 16:03:12 +0000
Subject: [PATCH 1/2] index-pack: clarify the breached limit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, derrickstolee@github.com,
        Matt Cooper <vtbassmatt@gmail.com>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

As a small courtesy to users, report what limit was breached. This
is especially useful when a push exceeds a server-defined limit, since
the user is unlikely to have configured the limit (their host did).

Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
---
 builtin/index-pack.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 3c2e6aee3cc..c45273de3b1 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -323,8 +323,12 @@ static void use(int bytes)
 	if (signed_add_overflows(consumed_bytes, bytes))
 		die(_("pack too large for current definition of off_t"));
 	consumed_bytes += bytes;
-	if (max_input_size && consumed_bytes > max_input_size)
-		die(_("pack exceeds maximum allowed size"));
+	if (max_input_size && consumed_bytes > max_input_size) {
+		struct strbuf size_limit = STRBUF_INIT;
+		strbuf_humanise_bytes(&size_limit, max_input_size);
+		die(_("pack exceeds maximum allowed size (%s)"),
+		    size_limit.buf);
+	}
 }
 
 static const char *open_pack_file(const char *pack_name)
-- 
gitgitgadget

