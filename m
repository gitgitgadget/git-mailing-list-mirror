Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7792BC433E2
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C85A6196B
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 13:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbhC1NQn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbhC1NQA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 09:16:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621C3C0613B1
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so5315257wmj.2
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 06:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQMV2pG1Bc7kiV1kYOHpImLGiweUK4H4KfyF35uruKA=;
        b=sAf6Qx3IEDcd2oAOrbCKrkNtRx/J/KdoyTctWN/WuRXy2Ncjt0BODH3nz+3RjmmE98
         Zih4/U2+SGk8zlcq2ZvRlbN5WBzNSrxiAohVqsFEe2vfGcZrNjsjMdSH/5UIpkLI5dfu
         zT/gpvxx2/0PF+zY9t2wEPf+mh4UgIkYe8GRILJCwdUSb1LA8Fe4MmxvveyS5C5PRmG8
         QXVo5vP+5gIOFD8euYRPEQjdQGUDvRRN63ivS7MLX3fBEiKer9eUNoYCiuw56LoYtHI8
         UQykCF58bmeeGOiPXB2pW2FtK1cpWrbOnv2rjT3vIvPhrr+l5Pkq3SqRzuRY0rjkNzmJ
         Zt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQMV2pG1Bc7kiV1kYOHpImLGiweUK4H4KfyF35uruKA=;
        b=h8d7bglgPiNdQZwTHyQ9bWkSEX35mieRFJTeYAmVvAH+JZFTm8y06IioVoBOUucwQN
         onIWST8uBQqhpQYOKjA3tFcoznh5nu16XYIgt+a19LQ8PTMM3HnBOwh3ukfa25CF/Qys
         489UlIVfMpX7F+WVROBfQy39CeQsrgS7k7RmAipOK6qFnMo2B59Op+bZjLi5xGk1ZJo1
         n/vpjq4eqRkAj8RDy3qLPVV3HMbgFv3m7ejn7jI43o+cfc/Ymc5FTdBaLTIRGBLtk/Bm
         NmQwK/7p0BMjIoOmyMB9L3pbkgtbjEwUKEG6baHO+F/0NZRkp2/GTgiLnDkiqJg9s53r
         G17Q==
X-Gm-Message-State: AOAM532TGSE9S4ph8Qv9mXbuXjRdK9LTN9V8SLfco059BLQ37D4Ocbkz
        BTaZaA1lU3hfa5B0ihj8ktOaZj5bAmdOOw==
X-Google-Smtp-Source: ABdhPJw9QBFGZkxpjWqo4R8S9nPSQS5JCvrxht2z1Aem6ri4h6oOybnqBAGPgqo5UxJ7nV6IuF++6g==
X-Received: by 2002:a05:600c:6d4:: with SMTP id b20mr20883091wmn.142.1616937358946;
        Sun, 28 Mar 2021 06:15:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8sm27364935wrd.55.2021.03.28.06.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Mar 2021 06:15:58 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 06/19] fsck.c: rename remaining fsck_msg_id "id" to "msg_id"
Date:   Sun, 28 Mar 2021 15:15:38 +0200
Message-Id: <patch-06.20-321b0c652de-20210328T130947Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.445.g087790d4945
In-Reply-To: <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
References: <20210317182054.5986-1-avarab@gmail.com> <cover-00.20-00000000000-20210328T130947Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the remaining variables of type fsck_msg_id from "id" to
"msg_id". This change is relatively small, and is worth the churn for
a later change where we have different id's in the "report" function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsck.c b/fsck.c
index 25c697fa6a2..a0463ea22cc 100644
--- a/fsck.c
+++ b/fsck.c
@@ -273,11 +273,11 @@ static int object_on_skiplist(struct fsck_options *opts,
 __attribute__((format (printf, 5, 6)))
 static int report(struct fsck_options *options,
 		  const struct object_id *oid, enum object_type object_type,
-		  enum fsck_msg_id id, const char *fmt, ...)
+		  enum fsck_msg_id msg_id, const char *fmt, ...)
 {
 	va_list ap;
 	struct strbuf sb = STRBUF_INIT;
-	int msg_type = fsck_msg_type(id, options), result;
+	int msg_type = fsck_msg_type(msg_id, options), result;
 
 	if (msg_type == FSCK_IGNORE)
 		return 0;
@@ -291,7 +291,7 @@ static int report(struct fsck_options *options,
 		msg_type = FSCK_WARN;
 
 	prepare_msg_ids();
-	strbuf_addf(&sb, "%s: ", msg_id_info[id].camelcased);
+	strbuf_addf(&sb, "%s: ", msg_id_info[msg_id].camelcased);
 
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
-- 
2.31.1.445.g087790d4945

