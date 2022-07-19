Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6858FC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238972AbiGSOK3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238834AbiGSOKM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:12 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A174D550BE
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d10so13518281pfd.9
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b9QsySwOcVZTcFRawWKLXMNfFKp3pFjxtFgTd/+q8Uo=;
        b=BiDuytAFGaHCeal319AkUwPcXy8GpHo4gXlvuoXfAIbLLE0+U4MbeAr1wnuBvwbGDp
         jKiAWDERO3OyiZG/Y1D+UyO5QBB37GshF0BSGVCaX/etitFnsQWyiSnN4luGMPgagijM
         znV13e4mWkp+WoOSwOtunx0hp2bl1v4y3KfEh+fP9OpawOhP/35TxhqJQw+Th0K1zMyy
         QKQCVY0D/SuQPYTxYqIbQHzfbaE6C4isyciliTfonjfCyRzi9vMnvni+y+P9z51b6YJr
         9i8FenmODPZDHHr0LeZeFHITL1lkinW8smw8fhY0kPtYR9pale4aqOyjV7xMmwnW1r3X
         Rj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b9QsySwOcVZTcFRawWKLXMNfFKp3pFjxtFgTd/+q8Uo=;
        b=cu0k1SGzgIOjGbbqH9gm44BcsHu/ur/FtGNAF61dLjI/wKQFQgwBiBbX0aqnTX7qeY
         11m6dzo+cDGueUwqOsZjFCs2RVB52ZeHxF819ldHiLjtWiWhlC2uND7IKW4fpZO2+V6y
         GT6nt2skq7krD8ux96MgN2VDUH9BfwuYecnQeVArKA4gb1ZWyNweJ11jI+Hz3IXou/JJ
         QQM8wHnYgVStnS6chWuEcTXcezzFWLq3Bt5dPvEdrP3omFZgN1Lkudd/eB/9U+evByxb
         ZtV/ZeWiaXFqk0+EKQT5N6WrfsWRnw9eZN3TDduF6RGSSrL5jFqKy1TNHLmKqloH+L+5
         oxJg==
X-Gm-Message-State: AJIora9T5gAR/sVtmx23dQ100CeAxs6mpe0lckhnvfCrGFrb/c5LdFJY
        +e3are1UISlmb+w3N8oNATR7hAb2jgQSoqZc
X-Google-Smtp-Source: AGRyM1uRaT1MsCM92WM4DrQdSIT49laFkNySFJGC0QXGyi+UeonFD2iKp4ms27orS5UbTOLAFnjbpg==
X-Received: by 2002:a63:8841:0:b0:412:b40b:cfb5 with SMTP id l62-20020a638841000000b00412b40bcfb5mr30125735pgd.197.1658237336994;
        Tue, 19 Jul 2022 06:28:56 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:28:56 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 2/7] mv: add documentation for check_dir_in_index()
Date:   Tue, 19 Jul 2022 21:28:04 +0800
Message-Id: <20220719132809.409247-3-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using check_dir_in_index without checking if the directory is on-disk
could get a false positive for partially sparsified directory.

Add a note in the documentation to warn potential user.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/mv.c b/builtin/mv.c
index 4729bb1a1a..c8b9069db8 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -132,6 +132,11 @@ static int index_range_of_same_dir(const char *src, int length,
  * Return 0 if such directory exist (i.e. with any of its contained files not
  * marked with CE_SKIP_WORKTREE, the directory would be present in working tree).
  * Return 1 otherwise.
+ *
+ * Note: *always* check the directory is not on-disk before this function
+ * (i.e. using lstat());
+ * otherwise it may return a false positive for a partially sparsified
+ * directory.
  */
 static int check_dir_in_index(const char *name)
 {
-- 
2.37.0

