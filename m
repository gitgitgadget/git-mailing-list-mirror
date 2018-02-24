Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B91DB1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbeBXAsd (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:48:33 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36290 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752620AbeBXAs2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:48:28 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so4197537pfx.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qqouZFqeVZ/e3rGd5R/g82nsLU/XMviiwprGBPmXD/8=;
        b=sntJaerFWaWf+LvoqwB/xzj64yVk5l9qDBHlX7t247sMojidGN1VtDU+yXSH48nK8q
         I51K4BGvkNLq/gTkN0AlHiWEdNJOz7plga9G8jQBiuN1RifZWYKxfWQ0wTKjRWtyLeAu
         /14JnFpQy/EimbEo/PVleN92i+imxUzRyTrYBMH/zbPaWuUVTsPki8HZ96zGK9LG5Wp6
         kK+S9j/t1eviypQ8P6XltpRYpsG50hxwp4RMkkL9o/kTWsH/rJHhFlsaLys+KAxxGdvf
         4LvFzzmO5gjUYsiFSBzesZhn+d2zQ/Q77aCgLfFcFhqrXNTOw7b2n7RF73+nZb0htAyS
         lgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qqouZFqeVZ/e3rGd5R/g82nsLU/XMviiwprGBPmXD/8=;
        b=o3sQCi/mH133kk4joMtuFnViMZk5CI3Q9aMUMk+gJkPTEPzhJD221qepJvNVrjtKtZ
         b3TB3uVffv97Q5uJdXBEY9DEErxc0cy8yARnRO/EBAD0i08fZtaE4jjb0lz/mTUZv4Wo
         SGhQpE9DqFLOPO6+qpMkCV7r3S2CGFekXzhJypvz6/GJyDDxmBs7MpHp9Ma7nVdd9Loa
         //pSpuS1gMO69sbg4i/fhhXkwWiO7eLdK4tXfrFBuGrcnY4EO/v3lJYx4Ekkn+Y3O47R
         UOvjdNqEFeSZ1Q5Y4w5niONiKDn7SuxVoxYpjqgteDDDmNlQBGVIOOCczXkqITvUk5xh
         gG5w==
X-Gm-Message-State: APf1xPCwlUU4+dERqah3uNwZY86T4Op2dxgr71hZ98POoO7wJT1D/NkT
        fYZS086/F03AaCNjrVpgW6fjF/uqyj8=
X-Google-Smtp-Source: AH8x224DvxWKdxpkGgOWGbKq+1nko50CNmR0EUa4Up7NuermlkIZxy7WrY2tQquPuzy+cl8GXxSHXA==
X-Received: by 10.167.130.193 with SMTP id f1mr3371271pfn.241.1519433307238;
        Fri, 23 Feb 2018 16:48:27 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 76sm4285454pfm.124.2018.02.23.16.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:48:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sunshine@sunshineco.com, bmwill@google.com,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCHv4 21/27] sha1_file: add repository argument to sha1_loose_object_info
Date:   Fri, 23 Feb 2018 16:47:48 -0800
Message-Id: <20180224004754.129721-22-sbeller@google.com>
X-Mailer: git-send-email 2.16.1.291.g4437f3f132-goog
In-Reply-To: <20180224004754.129721-1-sbeller@google.com>
References: <20180221015430.96054-1-sbeller@google.com>
 <20180224004754.129721-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the sha1_loose_object_info caller
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 sha1_file.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 6ec43e745d7..831e2da3572 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1154,9 +1154,10 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
 	return parse_sha1_header_extended(hdr, &oi, 0);
 }
 
-static int sha1_loose_object_info(const unsigned char *sha1,
-				  struct object_info *oi,
-				  int flags)
+#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
+static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
+						 struct object_info *oi,
+						 int flags)
 {
 	int status = 0;
 	unsigned long mapsize;
@@ -1275,7 +1276,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi,
 			break;
 
 		/* Most likely it's a loose object. */
-		if (!sha1_loose_object_info(real, oi, flags))
+		if (!sha1_loose_object_info(the_repository, real, oi, flags))
 			return 0;
 
 		/* Not a loose object; someone else may have just packed it. */
-- 
2.16.1.291.g4437f3f132-goog

