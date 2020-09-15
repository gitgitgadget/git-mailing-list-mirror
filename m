Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CF8C433E2
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 09:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1558221D1B
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 09:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHU6Ytvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgIOJ66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 05:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIOJ65 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 05:58:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6C5C06174A
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 02:58:56 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id f2so1730498pgd.3
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jTZQ31mtMWxwSvHvDRHm45lHcgOK3Fudagf4JUQTq+s=;
        b=UHU6Ytvr9L7/7FYGdzNTJfp6JEhVGCrlYaVvLGbKSgOyE4Zbq7viY2ZiyguzURwBPe
         O8DJ6AtDXdGxkMmNl386vWop4CUR/L0PtvoiXhu0fqFwY+Gqnszbg3froujH3n0oeQBp
         uuV9UmOA2rmg1easIeEF74wLOU9ce3cuV3W6w8dNn2Wb0Wz6pD3Y+74bpe2gtlTSMZMp
         ow64uOWvsHGYEl/JvF3f6+6+uH7I1r1E9+0GVMiiQVzOj3LJsUvgIJkKafMq8m7UZAWO
         qPHhooQV6EYhrsATWRQjGBCnPrGSh1oXt0x0RSh7oIWct85FPkKroGUIR8nfG8kHRkgZ
         s/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jTZQ31mtMWxwSvHvDRHm45lHcgOK3Fudagf4JUQTq+s=;
        b=J1jYX8deBO9e9KCLkkmoSJ4lrhV1aC4QLTlk/HJ1ljx/gosiVDkFRfnFvmyCrj7d0H
         SIF6vVd3cX/K0RoN7lxiGXABJad04Y8muVtGvUlFFGOAz9XsRI5xy7Kvm4JSFpYgh0aH
         djS/FvlxOv7VlqF0NHf7Gd1MLPaGSSssFHDz4TU1Q+eYbBwU7PiKDMF6QmhLKjjc7PFY
         KCT6cQ4z7BuLl51P5j1G6yVvZd2Gp/YY6fe0pFZOeDAtFaqBwQA4/RvmHIvlA3ApXpiv
         W2J9xGKvyOFX9V8wwaVmIbz6DAQQd9IE67HjSenUoemlMbsH/C7a3yPRTf8K0rI4vHRz
         Isfw==
X-Gm-Message-State: AOAM532f7ba6yyVMB3Vkgoak7EbUsY0yS4+kiyJ+5RvbfiwVdQgz+Nqo
        HJrwPur8TiCALUmyVjj0tpY=
X-Google-Smtp-Source: ABdhPJwF9IkY9A8HwjjLRhN48YL2+sbo32tFKEnpltd3pFXlCFdP/aIOWye51+eC02Ws96/xIFWMwA==
X-Received: by 2002:a62:cfc5:0:b029:13e:d13d:a083 with SMTP id b188-20020a62cfc50000b029013ed13da083mr17464651pfg.26.1600163936310;
        Tue, 15 Sep 2020 02:58:56 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.14])
        by smtp.gmail.com with ESMTPSA id i62sm12839400pfe.140.2020.09.15.02.58.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 02:58:55 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
X-Google-Original-From: Han Xin <hanxin.hx@alibaba-inc.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH 2/2] send-pack: check atomic push before running GPG
Date:   Tue, 15 Sep 2020 17:58:27 +0800
Message-Id: <20200915095827.52047-2-hanxin.hx@alibaba-inc.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
References: <20200915095827.52047-1-hanxin.hx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Atomic push may be rejected, which makes it meanigless to generate push
cert first. Therefore, the push cert generation was moved after atomic
check.

Reviewed-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 send-pack.c            | 14 +++++++-------
 t/t5534-push-signed.sh |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index d671ab5d05..58416a6f6d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -447,13 +447,6 @@ int send_pack(struct send_pack_args *args,
 		if (ref->deletion && !allow_deleting_refs)
 			ref->status = REF_STATUS_REJECT_NODELETE;
 
-	if (!args->dry_run)
-		advertise_shallow_grafts_buf(&req_buf);
-
-	if (!args->dry_run && push_cert_nonce)
-		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
-					       cap_buf.buf, push_cert_nonce);
-
 	/*
 	 * Clear the status for each ref and see if we need to send
 	 * the pack data.
@@ -489,6 +482,13 @@ int send_pack(struct send_pack_args *args,
 			ref->status = REF_STATUS_EXPECTING_REPORT;
 	}
 
+	if (!args->dry_run)
+		advertise_shallow_grafts_buf(&req_buf);
+
+	if (!args->dry_run && push_cert_nonce)
+		cmds_sent = generate_push_cert(&req_buf, remote_refs, args,
+					       cap_buf.buf, push_cert_nonce);
+
 	/*
 	 * Finally, tell the other end!
 	 */
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index d0fcdc900e..927750a408 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -273,7 +273,7 @@ test_expect_success GPGSM 'fail without key and heed user.signingkey x509' '
 	test_cmp expect dst/push-cert-status
 '
 
-test_expect_failure GPG 'check atomic push before running GPG' '
+test_expect_success GPG 'check atomic push before running GPG' '
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
 	write_script gpg <<-EOF &&
-- 
2.28.0

