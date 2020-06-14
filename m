Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666BCC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D87206D7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 07:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N41ZRji1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgFNHcQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgFNHcL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 03:32:11 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB682C03E96F
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id d27so10339741qtg.4
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OUqaGSQUmgt1cqimaG0/jSBhT8Nv9q7xz5bD6YBWCjQ=;
        b=N41ZRji1hrCvz2MBzHoSFb2HFHD33AaMLcLICEr7CLfvAAWr3bIFkJtcEaPmVjmCXa
         l8i4xchk9okLBGP3QoZ/Zhtwbhz1qWNlGKZU+BZBz5vEsrycUWfAzNrvDAN2FPBe/cAY
         KPhkG/P1/6+DuFOfCiJD84DNpz/TMFtxLBdEnQqKJ3j3FElEq3E+TiAIXBXbUAJ7vxSo
         R0k6ci3x4r8srLHtwa8p2H43ul1spkEpyYrWpUkfNuMcROblbn7PEQ8j5EtFr5ETUxFO
         hOjlOopW411syzF5ZTryT2m0JmuiEz7TLMSqvQzfsKxEuXfZUs4PIkE9mgEKbvJKoeTW
         6B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OUqaGSQUmgt1cqimaG0/jSBhT8Nv9q7xz5bD6YBWCjQ=;
        b=WqDYQpXq9H7lp2dI4EmT83YrygPxXDSLqis/3rkV7Kib/FjY7jWw/udIlj30pW62hd
         6tH6ruVflZ5mOmJGElOeVuVi96VhEapSaI1HuOx0zIKTccFzQiENofzk8ayoaC4np3mr
         jYtgt+cE5/yJzfu9ZOC63hC2vf3ZmeecOp5ELUpsPlAg9lyIkben0LSqtioDo2rXS1nD
         tsQLi+pkBtSOcPjGbmW4mXV+TVbzeZ9kICvbSPOyb6FL9sJsEyoFkqe4l1txMECS1u6i
         ZaYntHw3DNLsm3ueES7H1lqw/ewzPiNLM3QN387Qm+v9AEpAjNESeLc1oXqcL/0TN2lq
         ilTg==
X-Gm-Message-State: AOAM531IX3UgrQz+8JOOGcxO0skXQR/HqaeFF0gbfslXDUF7MyXX6JhL
        g8wKeVivU6eZEoOcG8F4JMAz8dGZD5g=
X-Google-Smtp-Source: ABdhPJwHBPW7GFc7ZInQUOths/YRG+6t63/QFIncvXN6lZuysCIrZ+gVKoOV0gRAi/SKPnNMM49SZg==
X-Received: by 2002:ac8:e0a:: with SMTP id a10mr10412035qti.244.1592119929572;
        Sun, 14 Jun 2020 00:32:09 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id a82sm8834341qkb.29.2020.06.14.00.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 00:32:09 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] remote-curl: use strlen() instead of magic numbers
Date:   Sun, 14 Jun 2020 03:31:58 -0400
Message-Id: <aad3b9659ba36e372ddf213a5fcc10c30960bf07.1592119902.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.132.g321788e831
In-Reply-To: <cover.1592119902.git.liu.denton@gmail.com>
References: <7e803a2ba9458ce35c657e67323edfe4409205ec.1592055716.git.liu.denton@gmail.com> <cover.1592119902.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we are memcpy()ing the length header, we use the magic literal `4`,
representing the length of "0000" and "0001", the packet line length
headers. Use `strlen("000x")` so that we do not have to use the magic
literal.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 remote-curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 75532a8bae..5536372b34 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -596,10 +596,10 @@ static int rpc_read_from_out(struct rpc_state *rpc, int options,
 			set_packet_header(buf - 4, *appended);
 			break;
 		case PACKET_READ_DELIM:
-			memcpy(buf - 4, "0001", 4);
+			memcpy(buf - strlen("0001"), "0001", strlen("0001"));
 			break;
 		case PACKET_READ_FLUSH:
-			memcpy(buf - 4, "0000", 4);
+			memcpy(buf - strlen("0000"), "0000", strlen("0000"));
 			break;
 		case PACKET_READ_RESPONSE_END:
 			die(_("remote server sent stateless separator"));
-- 
2.27.0.132.g321788e831

