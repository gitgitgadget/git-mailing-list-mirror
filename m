Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAB1C433FE
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 20:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbiKXUW7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKXUWz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 15:22:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F4D5DBB6
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 83-20020a1c0256000000b003d03017c6efso4012623wmc.4
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 12:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFH4VlCTdQoHEmDrDdwcoLZXL+BjE9FIsZo4iptzw2U=;
        b=qtqpxkVIS6pgFxctfUyGEKJUEDe1XQfiy9vP5u8YBBiQU/njGxrDDRP/3Uimtm5ivI
         5Q5r2rbDgSOQxAaR4oGrsF13hy1fcyr5Hew52upL0lkElwh6gQuiqEgTnk5G5N4JtMYD
         3wnQYQl3kU5k8cWdMeFl/c8MXnFXrZNxO8e5LtLO+I7oRSHaI2ooPbzeJCImuDDQ2f/o
         FtCGGJDhSYDiza7mNBptloz8r61MQyfXlHsZAvhtUzlTOnAYz2i8hIwxp7AjUYiZ0lNH
         ppDBv/lK6r9VVFj5NXhndVSonzp6kDqYAdFihGq1QqTAGHNUZFyBRGRAQiTEeM4OfTfn
         ecPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFH4VlCTdQoHEmDrDdwcoLZXL+BjE9FIsZo4iptzw2U=;
        b=WvY4QTb1D15vX3U4u37buREwGNM2cmt4S+6rf31LpFPXoIDye4d0SndOSP0DzrJvlf
         IR5q1GcpUMFIzRtLqhjt07teM4zaciIx04nPSBqjIpxFbLHqaQ41jI4ji6DgMsN84H0w
         tFkc658yO3QFkwX1Ay/ZKyOyggjU+1BhXauhKl/oV+KmWdEE0/8QaEmPB4R3UMGHaaj9
         2MuXT4bej44KCaKMsXDTcsxjEQS9M0OiBPozWHtA/NZ+HZsk/opG7GxYvJ23yzV10W7K
         s9ro4OFHSNz0gdIKhChe5TOh5J7q64RhpNTBHgeiqoyLcKE56pabDAoOM4Qqztwg8x9+
         a/vA==
X-Gm-Message-State: ANoB5pnoOYsvlvyCZz3ifK/UBtt0/OJQnu2IIJOU+HoyIuRgJkLLA27f
        7mdm7IKvQ6LF/R7kARVuC48cugCw/Y4=
X-Google-Smtp-Source: AA0mqf70nuE+OwohRuU6Nw3CFRxnI/ksnAECw8wylynXTDi1bR2vc8pSbuQGXPuzhMq8j57aJZ2SPQ==
X-Received: by 2002:a05:600c:314f:b0:3cf:9efc:a9b7 with SMTP id h15-20020a05600c314f00b003cf9efca9b7mr25322904wmo.10.1669321371889;
        Thu, 24 Nov 2022 12:22:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020adffc86000000b00241c4bd6c09sm2172193wrr.33.2022.11.24.12.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 12:22:51 -0800 (PST)
Message-Id: <905b109b458e291da04d9879cbc6b032bbd9a302.1669321369.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
References: <pull.1434.git.1669321369.gitgitgadget@gmail.com>
From:   "Sean Allred via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Nov 2022 20:22:47 +0000
Subject: [PATCH 2/3] var: remove read_var
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sean Allred <code@seanallred.com>,
        Sean Allred <allred.sean@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sean Allred <allred.sean@gmail.com>

With our target git_var value now available, we no longer need to call
into read_var() to find its read() function again. This does avoid a
second loop through git_vars, but mostly it just removes a lot of
duplicated logic.

Signed-off-by: Sean Allred <allred.sean@gmail.com>
---
 builtin/var.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index 776f1778ae1..e215cd3b0c0 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -67,20 +67,6 @@ static const struct git_var *get_git_var(const char *var)
 	return NULL;
 }
 
-static const char *read_var(const char *var)
-{
-	struct git_var *ptr;
-	const char *val;
-	val = NULL;
-	for (ptr = git_vars; ptr->read; ptr++) {
-		if (strcmp(var, ptr->name) == 0) {
-			val = ptr->read(IDENT_STRICT);
-			break;
-		}
-	}
-	return val;
-}
-
 static int show_config(const char *var, const char *value, void *cb)
 {
 	if (value)
@@ -108,7 +94,7 @@ int cmd_var(int argc, const char **argv, const char *prefix)
 	if (!git_var)
 		usage(var_usage);
 
-	val = read_var(argv[1]);
+	val = git_var->read(IDENT_STRICT);
 	if (!val)
 		return 1;
 
-- 
gitgitgadget

