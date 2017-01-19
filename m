Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C004A20756
	for <e@80x24.org>; Thu, 19 Jan 2017 11:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752320AbdASLlr (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 06:41:47 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34592 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752194AbdASLlq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 06:41:46 -0500
Received: by mail-pf0-f195.google.com with SMTP id y143so3227193pfb.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jzJh3o80xsEyT9LrOMZVmCjmHzMThgw0jYdiQnCNWOc=;
        b=BOqhC6xsfHwYtKR29JLvf/Nik9s32wMKeH186UHfL9KWIdROuMg+sk7tpFiLq/G94o
         EnqI9JB7xQNuXMZyGPkyfoEizUdrczluvERYSBTrj90uU4S8yCrIy5wQKI8dm5V/brAl
         f0W91rLYjc8P9yFpBm+j81F9ZkwKr7/mIsjXeO9GCfg7Xs8expTpMjugiqtk9OctCrBX
         +gkD90jvHYNiJTP5Dmd4m0F+GH0GBdSkv41vUftiMROixXE2TNQ+29b+DhwxgD3+qTRb
         H0P8JW27wCZ1uoAygb9R9Zj4mlzL6mrvZrj3GZGa+58/RC3WvhBbX47PGEpUvzaGPz8U
         ZggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jzJh3o80xsEyT9LrOMZVmCjmHzMThgw0jYdiQnCNWOc=;
        b=R12GObuttXVEhWOLDUbxlzDvdTSaFX1jks1yzFxzYhSVHzkkBoBolZs3mZsE0k+90W
         k/1DlMuBTvo2da0yefuxBa0QZ+/aldRinUnm9An/0TFLb15sviXB6SFJ1vVK7padB8sp
         xL203DpwrKveUFVNbRbylauE50So3rJiaP4YHnd0181L8fJDkD05t5WgLHcFn+VPciJL
         Zr0w7JPmcd4yXcTEx+sTe3BibsXc6G0OS1Rk7iXrC2GNECxp5u1KJwsHziEoB2G0hIsh
         VaJVEnOdREE7oX1Iipk0ZAefavnifEXCgsir384rx8Z4Wy0cOafI7A803IyXLg8c/re7
         /J3w==
X-Gm-Message-State: AIkVDXIHzdF+PjxmGE1XCe0tNhQKdqFS2wbSTbbxU7DURwx96EZhiDeE03RSeIQm80XDKQ==
X-Received: by 10.98.163.23 with SMTP id s23mr9453615pfe.60.1484826105741;
        Thu, 19 Jan 2017 03:41:45 -0800 (PST)
Received: from ash ([115.72.179.24])
        by smtp.gmail.com with ESMTPSA id c2sm8159771pfl.61.2017.01.19.03.41.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2017 03:41:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 19 Jan 2017 18:41:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 2/3] color.c: trim leading spaces in color_parse_mem()
Date:   Thu, 19 Jan 2017 18:41:22 +0700
Message-Id: <20170119114123.23784-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170119114123.23784-1-pclouds@gmail.com>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally color_parse_mem() is called from config parser which trims the
leading spaces already. The new caller in the next patch won't. Let's be
tidy and trim leading spaces too (we already trim trailing spaces before
comma).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 color.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/color.c b/color.c
index a9eadd1..7bb4a96 100644
--- a/color.c
+++ b/color.c
@@ -207,10 +207,15 @@ int color_parse_mem(const char *value, int value_len, char *dst)
 	struct color fg = { COLOR_UNSPECIFIED };
 	struct color bg = { COLOR_UNSPECIFIED };
 
+	while (len > 0 && isspace(*ptr)) {
+		ptr++;
+		len--;
+	}
+
 	if (!len)
 		return -1;
 
-	if (!strncasecmp(value, "reset", len)) {
+	if (!strncasecmp(ptr, "reset", len)) {
 		xsnprintf(dst, end - dst, GIT_COLOR_RESET);
 		return 0;
 	}
-- 
2.8.2.524.g6ff3d78

