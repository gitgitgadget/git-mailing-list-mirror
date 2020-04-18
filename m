Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1726C38A29
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99AF021D93
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2OBHLmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgDRUTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUTQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:19:16 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB8DC061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:16 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z26so5685420ljz.11
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jd9LgKzoOq+hd7wqtU/p8gY/rWBNQiwrdfRnY+o7Fk=;
        b=Y2OBHLmAU3tWHy8M7xlOTiYTQaYQn/OrgptlPoQApXwYPUlmtFjpqokwZah+iRCTgQ
         nYtkNJw7PEOScW1YggPw1yVB9KGcTrbp498k5u98PXRUCEdiKqUWXaCJljs8ZYq3nkLT
         eHx5KPEb3TB7AOwnPuuQJ1o6jDSnSQgi/Cnl4neWsb+qR2NfXEyUNHs9Jna6kChOeEP9
         +5L3OmO3oYKWF5NMgO7NMM+eind1hdlitStMj3WdZtkiPnWzVABorPsPhaEFRVSNdkE9
         F0pn+GCOE8In1kJuk9sCn3/bk+8+g5RmH455YxGgKqRlV80zycFgK2QisYCXzAa6hUnb
         lcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jd9LgKzoOq+hd7wqtU/p8gY/rWBNQiwrdfRnY+o7Fk=;
        b=T5B43l3+hoWuD4nmFZ5dK81zrwYUwenTkm09DuApX1Pc65WIpBoRLT+3ztbxiBU39O
         NmfobFqQjxZhTMeWiUQrNof3Eik3f+J4Goyjnu9rihNsoMhKusZJQtis5HOj/0GweG3j
         qHLxaDXuXXtjJzYAGPe+4jM+MhEKuaa3ecc4Tz8UdywsaQPszrebJ8cQoJBk83/fL4B5
         BRjmhYx5UcTHSwwjghPe+QOd89LYeEO2MfDvi1X+3Z5rNsNUGqRcBhSZxV5iymI9jfKx
         y3914kBI/pF50iXxy1VAsIwDUFIlhAVpRsZbQCA2k6t1t0GtodAQdP0p8XBUbyuhj91A
         MEnw==
X-Gm-Message-State: AGi0PuaMgGsTKlXdUaAvcCJTlcRBo0GuCUD4KByzPrYx2f9dUl51cmen
        f8+8iBVlivBDJv1fmX9dHGCPX2EF
X-Google-Smtp-Source: APiQypLcmME2E5SJTKEKTNxgyU9jnUI99uy8BhDLulESS06LWIdOi79AJuufWeVzg0DBGLB6xjkRoQ==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr1116762ljh.65.1587241154428;
        Sat, 18 Apr 2020 13:19:14 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:13 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 5/6] rerere: avoid awkward use of `strbuf_attach()`
Date:   Sat, 18 Apr 2020 22:18:28 +0200
Message-Id: <e9a8e5b061fc07b6e6450b028f97378044f9c2cd.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com> <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to the previous commit, avoid passing `strbuf_attach()` the same
value for `len` and `alloc` by switching to `strbuf_add()`. This avoids
a subtle allocate+copy+free dance in favour of a much more obvious one.

Unlike in the previous commit, for this site, I know that it's not safe
to pass in "len, len + 1". Trying that makes `strbuf_attach()` write a
trailing '\0' at `result.ptr[len]`. Running our test suite with
AddressSanitizer will spot an out-of-bounds write due to this.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 rerere.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rerere.c b/rerere.c
index 9281131a9f..c3e3714824 100644
--- a/rerere.c
+++ b/rerere.c
@@ -1007,7 +1007,8 @@ static int handle_cache(struct index_state *istate,
 	else
 		io.io.output = NULL;
 	strbuf_init(&io.input, 0);
-	strbuf_attach(&io.input, result.ptr, result.size, result.size);
+	strbuf_add(&io.input, result.ptr, result.size);
+	free(result.ptr);
 
 	/*
 	 * Grab the conflict ID and optionally write the original
-- 
2.26.1

