Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38723C38A2D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 22:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbiJXWIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbiJXWIA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 18:08:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C47AC50A5
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:21:21 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n14so2927742wmq.3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk6MZfMqzn+raVOyv75OPLEUfBN82Uea/f0hPREBhzc=;
        b=aGnGc7igIB/DmTd238M/d1z79TVrRl6Z3wg6f6FI8RjLIAe4SeDM6jYaY1NSV7Nx6+
         VGEQLCMBiZDx3fHPYbmYEbLjJ8nyMbyjC+7fslEgoihFynxZ6pDRCfmLGb/4oUrAFksj
         cpZyt0RM2z94wz9saWOH5wjaB724a+Zzfp2T6fYxOKhUGlrV+3Miy88BFS+vhYDzNYrr
         6q4jXYVgj7Lv7rIRCI7ueaBnvlOdg793wUFwNyjoifahV3dGUNL+uRAb0aKXJ2i0UPv0
         EkcCOEu9sX3YJbTahbc3/P8E9+bSjYR1+v8EFojHPhOXvKYJ+dPk1fJ4Qr8PBzkzuk0U
         1wPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk6MZfMqzn+raVOyv75OPLEUfBN82Uea/f0hPREBhzc=;
        b=hY+l1JneoarU6CFy63CdTPoiB1p6q6rOJnfiTAqCKghPgjXQvGS4pRkqGZIKvJJPcK
         8YZ1VNb2kiBgVuPMy+iMpX7jzmB0xAvg7wuyp1ATQ0ve9AUgu7ZcdSaeVfqbWutKc6al
         1LUNVWz1DnUr9ZBBaKlGyNQD8O48ri0Cze2DqXK5Xa4Wuraj2C8WOuA/VAFGR1YfQBRc
         MgMR28s1OADfsvxOTVAXtbXULJmPwFlAcUl4iV4GURlUJ69Mssk4B7IkuoLjSFnBArOX
         5I4akZ0stff86l+DC2bDK0oP7LCgCTycJNaCbCWgbOq66nhNAoNGR9z0SZbdbUlqTX2p
         dPbg==
X-Gm-Message-State: ACrzQf1Z8vhSl7mWwYoC1AgUzGTLqfqNBOr9tLAoin/gdn9oACdZEp7J
        o54ZetQhqKI26RQ9ZERvu0OSt5Mqvtc=
X-Google-Smtp-Source: AMsMyM4UuixLX4ILgu+UJ4hiMgAcsuT60mE/hGHeELUV1eFMskp3JdxW4CQf1s7Wy+ehopCMsfqqMA==
X-Received: by 2002:a05:600c:524a:b0:3c6:f820:fc7c with SMTP id fc10-20020a05600c524a00b003c6f820fc7cmr24266195wmb.172.1666642073880;
        Mon, 24 Oct 2022 13:07:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v13-20020adfe28d000000b002366a624bd4sm514577wri.28.2022.10.24.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:53 -0700 (PDT)
Message-Id: <eef2a32f008899cec6d66891f830907c26573a55.1666642065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:44 +0000
Subject: [PATCH v5 6/6] builtin: patch-id: remove unused diff-tree prefix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <Jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <Jerry@skydio.com>

The last git version that had "diff-tree" in the header text
of "git diff-tree" output was v1.3.0 from 2006. The header text
was changed from "diff-tree" to "commit" in 91539833
("Log message printout cleanups").

Given how long ago this change was made, it is highly unlikely that
anyone is still feeding in outputs from that git version.

Remove the handling of the "diff-tree" prefix and document the
source of the other prefixes so that the overall functionality
is more clear.

Signed-off-by: Jerry Zhang <Jerry@skydio.com>
---
 builtin/patch-id.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index afdd472369f..f840fbf1c7e 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -74,8 +74,8 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		const char *p = line;
 		int len;
 
-		if (!skip_prefix(line, "diff-tree ", &p) &&
-		    !skip_prefix(line, "commit ", &p) &&
+		/* Possibly skip over the prefix added by "log" or "format-patch" */
+		if (!skip_prefix(line, "commit ", &p) &&
 		    !skip_prefix(line, "From ", &p) &&
 		    starts_with(line, "\\ ") && 12 < strlen(line)) {
 			if (verbatim)
-- 
gitgitgadget
