Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F08C433F5
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238682AbiBJJ3x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbiBJJ3b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:31 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495CB10F2
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:27 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id gj12-20020a17090b108c00b001b89b5f3dd4so5798508pjb.6
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6ns3Xfnn3SvI0lg4fojBZdtCWkLa/bIJPZdKcTfMtvI=;
        b=TgH8hfz+C500f4J6xfoAfFmdG8xqYj4EQdoGYoV6WuKnG01z31GPbGUL0hEayC/mc3
         0TSzRCE/8s+NU5rTXaQeQYrfkkhdDLnUS8ElUGplfdaL1A3btoMk8ddfDRJvirTp0PBL
         RjamwVsIsL9X9Eva47JAkNMxb9K1Uz6z5aVxoqY1UTQKinnTUXYXUwNztsbyOSz9pETY
         +Ki7HN6Zf7qReEPispgjdungZS/GCL0CZ1es5XTgw6V1oU/+umhUdg3Cz1ySON9LMHqe
         o7qIcuPx/BkjCIgJDUMCeG1As2hfiJy41biNwkfulMQXdPGbBkejaZRz8NtUtyvV8d8N
         ZQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6ns3Xfnn3SvI0lg4fojBZdtCWkLa/bIJPZdKcTfMtvI=;
        b=OowALhtgTofa8vbNZU0BN+BBM/IOSiF//ql3hZV6bLJX/pxF3+Vac7eB+1E0PVqW5B
         UiXQts+gEPBkVCiL5fwiy8oReWXMETUKZba1x/Qg3PTOIHp48sQxMw8ml4fiLGPmQoA3
         oGTL4zT1CgzJJuTnKBsF82e3VSDuKwqPtN86VKHWouh6Rvgnw32VXjw5uiW1wZa+jqDR
         61MOn0mijnik7hDRaFjYoZ10RzRmtEzK+8hstIcSoQCbBkZ5//s98yRvSRd5w/PiQCF1
         k+0Ypihpkzf1u3POc6dbMzmcRujU8TXurC39vLMBZSgbBdl5Di3+asH3oyjbkOSa/t1p
         tbbw==
X-Gm-Message-State: AOAM530VKnMNM4X8N+dkjDBuO2pM7BHiZUV+LCH4uWmTmT6zcmuVQBdt
        QY7CltY3FyFngcDdEs0eoP00jzXc6G7gPPDn3c6UXmOADt5nV9dVoBL1Q0A3WQYdtnIkLiE/sAX
        8WyuF1DoxRNDuELMehyhiNjy8k/bABWi0+yRsgHG8nok8wl7X/m9aaIx93/q+eMc=
X-Google-Smtp-Source: ABdhPJz7WVeQwtP1xTloHCCztmxPdcKLB2pwzGhZDBJdUUDxsKpi21war7iTgQjFWJXfXAbodGcGH/zl11ZoJQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1785:: with SMTP id
 s5mr6564098pfg.72.1644485366688; Thu, 10 Feb 2022 01:29:26 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:31 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-19-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 18/20] fixup! submodule--helper run-update-procedure:
 remove --suboid
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b895e88a64..98d8910930 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2886,14 +2886,11 @@ static int update_submodule(struct update_data *update_data)
 					    update_data->sm_path, update_data->update_default,
 					    &update_data->update_strategy);
 
-	/* NEEDSWORK: fix the style issues e.g. braces */
-	if (update_data->just_cloned) {
+	if (update_data->just_cloned)
 		oidcpy(&update_data->suboid, null_oid());
-	} else {
-		if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
-			die(_("Unable to find current revision in submodule path '%s'"),
-			    update_data->displaypath);
-	}
+	else if (resolve_gitlink_ref(update_data->sm_path, "HEAD", &update_data->suboid))
+		die(_("Unable to find current revision in submodule path '%s'"),
+			update_data->displaypath);
 
 	if (update_data->remote) {
 		char *remote_name = get_default_remote_submodule(update_data->sm_path);
-- 
2.33.GIT

