Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4230EC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 16:30:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 266AC613F1
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 16:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbhFCQc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:32:27 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:56110 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhFCQc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 12:32:26 -0400
Received: by mail-wm1-f44.google.com with SMTP id g204so3766932wmf.5
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L6egE5MBL5QmD/R+LWR+R6L7puy//voLdsYYFLvmZfU=;
        b=fpj/vCESPijLRAwbFzppHuURx0t+JCyOHd/oBRDoKHambjz7ojFBmvjoTUr9Qz5P+L
         g5s86jPTR0tS7Aj62+nL7/S+dc6DB1eiX0hzXWHSOgyxoLglfgRsfisBVmsPVokUcRwg
         0Se3dukywa8SvmjURKeGTOiRnP/eOhij77BzmpgeIuIgUg1MUIoLI/8MBjzdsovtgagL
         ZqRm0aEKDRIuC9Uqvt8BAhee4QTlSJf1YObgViatPPs8wBwo4rSotUdU7NMNO+Xxr5Ms
         jBwZ74h2hAioxjqxGisvVb4hFnNMsAV9KDCB5C7cSqKvkIGVgWNz1bIsFAPLoEZgnZNx
         MqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L6egE5MBL5QmD/R+LWR+R6L7puy//voLdsYYFLvmZfU=;
        b=UGxkTktp9pdPtZn3WQuyp5XjVEQyF8if9DiKfr1hdNq5UHUtKN8aOFIUToxZ4oHMjZ
         Jeg/Kvjie5ZdiY8ynkHwZTxq82fD2sqHYAZLQIVsqms+jzEIFL8UcUWjftROI+fmkB0S
         4TDo7A0O4hOmsBuX4g3L1Jn+fMGMmzGwVJS9JkGnFAN/Fwb6vy0l9x71L+Jut9lx1U4z
         yhhafPhVG0+MQ93Us+gOAPPqDLoRuVj986X+u/WO3pvdDpfOjcnpgcaoJopfjemveaSg
         j4uNzJRYXPKI3hfWJoDP2GLRHEtX14cr9oAIMlaNT/9fAltdpIfw/ePf5jg06szkbjGk
         J/jA==
X-Gm-Message-State: AOAM532mwWqIhMHGVAsXQodUB6tFxBGN16q1LQBwDwPDeXqde2mmb8ZM
        0w28kcwkP31UFM4uajA4qsyg8BA83uM=
X-Google-Smtp-Source: ABdhPJxQdAbbYov9bQhR8OzZZ+HGsdyJ+h0KSd/ONRcRj1HYv8I1SmZuyaOuBNgvRQNLNxma3+8gDg==
X-Received: by 2002:a7b:c7c5:: with SMTP id z5mr5052336wmk.77.1622737769234;
        Thu, 03 Jun 2021 09:29:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g26sm5923841wmh.24.2021.06.03.09.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 09:29:28 -0700 (PDT)
Message-Id: <759451e784deb7b0cc84665ff7c0d9a98ec0fc0c.1622737766.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
References: <pull.967.git.1622558157.gitgitgadget@gmail.com>
        <pull.967.v2.git.1622737766.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Jun 2021 16:29:26 +0000
Subject: [PATCH v2 2/2] [GSOC] cat-file: merge two block into one
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

There are two "if (opt->all_objects)" blocks next
to each other, merge them into one to provide better
readability.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 02461bb5ea6f..243fe6844bc6 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -520,14 +520,11 @@ static int batch_objects(struct batch_options *opt)
 		data.info.typep = &data.type;
 
 	if (opt->all_objects) {
+		struct object_cb_data cb;
 		struct object_info empty = OBJECT_INFO_INIT;
 
 		if (!memcmp(&data.info, &empty, sizeof(empty)))
 			data.skip_object_info = 1;
-	}
-
-	if (opt->all_objects) {
-		struct object_cb_data cb;
 
 		if (has_promisor_remote())
 			warning("This repository uses promisor remotes. Some objects may not be loaded.");
-- 
gitgitgadget
