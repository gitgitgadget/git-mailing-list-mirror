Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C369AC433DF
	for <git@archiver.kernel.org>; Tue, 19 May 2020 20:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C7E207D4
	for <git@archiver.kernel.org>; Tue, 19 May 2020 20:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTAlABjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgESUwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 16:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESUwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 16:52:11 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB84C08C5C0
        for <git@vger.kernel.org>; Tue, 19 May 2020 13:52:10 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b6so1209846qkh.11
        for <git@vger.kernel.org>; Tue, 19 May 2020 13:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8D5jAaFU7Z237U4f3jH24xnqJKCSTDe2XfokLYbwxCA=;
        b=RTAlABjzm44WTNIKTgknnD+3rcwOyl5HE9x+sgP1ECiUb9HbJCFr6adNfiUFvcLgL1
         /TuBScHvSo2gab3h78gpphYrdd7CDcM+4Ub+1eHNH3N8c2RjK7glywcAFtu/ALQAkNyT
         2BvYjXgrwoUzRwmNWlogYZESJlGNmUwzo4Bu5aAmH4oOiN/X3qT5j0Tkq+FdSilY8gcC
         NAfdSUBBAZlfH6IBv7JKOBYzBG5/p56uz1MK3G4ILYiBXaMJNqIpqGFYrCfU2B7b0wyK
         1M0NoH7+EdtiqaYMqBd3kyjRGVcek4ykr8MGsjP/Nd7E7/JAMjAucKUFm0411LiuzLaZ
         BtmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D5jAaFU7Z237U4f3jH24xnqJKCSTDe2XfokLYbwxCA=;
        b=afbOdwGO4gM3y9RmK9Donleddm3TiGqB5YFJDApG1PHt1sCXluvx5hsjjnQN+5mm4F
         CVeb3f9NP0iSm1pyB0m5b9vmdba9uByMQjKihiXTmIDSiW3b7R9UK2scw5uNXTWCRnVQ
         u//iJz6N2dw4hcdVYYcDwbggDwYN7bG+iMQxazg4/xP6Fq9hwb1xYCEQESiYPyrjnebb
         jtCRQ78vNSxVOnif4K2TgSdchL7aZtEUeJ3ODp6gyAGc0EcQo5UXn2ghZyqehf2BIHMt
         mZne2v6dEyVEOe7RYNuzZq3XeRVVoYOZMgs1vVbzm/5dOSR2EZ1fEf5lGrd3+mCpBeeV
         SBJQ==
X-Gm-Message-State: AOAM532bTsqGOxntLsCBiFLwduSZ4L4P7h6Eg1rxf6u1eFdAE0TpvwFl
        7NRJyGqK7VgA8oh+INk+Ux2OdZ2+
X-Google-Smtp-Source: ABdhPJwkzVT838suikdE869At4txkFk7Xh2KX0UbvwstOlHRYTF8ua3dY1ISWDYz/EWWCDrQpvUEpg==
X-Received: by 2002:a37:a642:: with SMTP id p63mr1427052qke.113.1589921529875;
        Tue, 19 May 2020 13:52:09 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id f33sm812722qta.44.2020.05.19.13.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:52:09 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 8/7] fixup! pkt-line: extern packet_length()
Date:   Tue, 19 May 2020 16:51:57 -0400
Message-Id: <04fbb741689d5f25b176c8d9709bfc6d19b2dbb5.1589921435.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.114.g141fe7d276
In-Reply-To: <cover.1589885479.git.liu.denton@gmail.com>
References: <cover.1589885479.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pkt-line.h b/pkt-line.h
index 6cb92d7a5d..5b373fe4cd 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -79,7 +79,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
  * Convert a four hex digit packet line length header into its numeric
  * representation.
  *
- * If linelen contains non-hex characters, return -1. Otherwise, return the
+ * If lenbuf_hex contains non-hex characters, return -1. Otherwise, return the
  * numeric value of the length header.
  */
 int packet_length(const char lenbuf_hex[4]);
-- 
2.27.0.rc0.114.g141fe7d276

