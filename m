Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD44C433DF
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC6F92065D
	for <git@archiver.kernel.org>; Wed, 13 May 2020 18:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAB8CjF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbgEMSFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 14:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSFP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 13 May 2020 14:05:15 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE2C061A0C
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:15 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id 59so324353qva.13
        for <git@vger.kernel.org>; Wed, 13 May 2020 11:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYo/5DpGKwvgnCq4IIcE5/0TPlCiDxKXWx5hvmTizTA=;
        b=RAB8CjF1Yk62j/okyJGZhBxxEM5juQbMZwljp+zF49zfkDdkyO/m3hkrweksWSNxDp
         /k40gnnpoMARNpWL4FZffv08L+fv6FRbglPBxneDj1pgtM9NujzW0BUEzsA33PzUC/6e
         4GAntqpDn6AEmRDuPERnatGd2B/vSSILTozM8B85tpoBHcbWzELRsAAldE80ejFbAi6v
         iqtBDApJPloOTl8+dhjUocZSRp4wsvobJY4ica32QqNZRx5vsuf3YCttTFc8+rE3CJnD
         AS+A4uhm4nylDiZsNwKG6HSsJ8aq6hoicpUBoKXHTzF+Y4ROrB8773Y02kT5ebzB5nKt
         og1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYo/5DpGKwvgnCq4IIcE5/0TPlCiDxKXWx5hvmTizTA=;
        b=ueXeXqDqEP+uKSLZMvW8D9JsYRrtr4iVhTF/3yoFMuGnkTdyB5SDUqSFgGDg2tJ+r/
         UZXBDp2kpee97TGtw5piTAs9rT3YWqtQmp7aTEondS57dAXEDoVGaPOvCp/3ItKVKDww
         6T3ErQ9QwRKJC5vJEGQJC7DObxewsYPJ7TO46H4wvOmCwPgHpVLYso9wQ1fMuYFKLH1W
         RQpXZTG5REtUfIVgzz2otBA7J14XH4vlupuw/dO6zdK6nT2Q9bw5Xksg4ISwyCo/HPVL
         VjO0u9EfKxvcq+z6J7PHxuhumYZhqDFUKPP7nl9K1ecaXUVk+FbCvDYyXsuovLb/5Yh7
         KiGg==
X-Gm-Message-State: AOAM5324SHwSLGozEsKTmI59sZHG/5A+fR+GKHgogAMyGG9ufUGDau4Y
        WNwqHNU+jVl3MK6sEJiVSWU+4hHj
X-Google-Smtp-Source: ABdhPJxY8vLmzlUFOU48u33cQgk3pnZRG+WhsB48zTaVW0GRJN8bcJNDWGtUwP7H04jYzMfgbqeCfw==
X-Received: by 2002:a05:6214:cf:: with SMTP id f15mr834598qvs.59.1589393113409;
        Wed, 13 May 2020 11:05:13 -0700 (PDT)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id z60sm301153qtc.30.2020.05.13.11.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 11:05:12 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 4/6] pkt-line: extern packet_length()
Date:   Wed, 13 May 2020 14:04:56 -0400
Message-Id: <891a39c853ce3669b6167dc9ad8a2328e4321a9e.1589393036.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.2.706.g87896c9627
In-Reply-To: <cover.1589393036.git.liu.denton@gmail.com>
References: <cover.1589393036.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future commit, we will be manually processing packets and we will
need to access the length header. In order to simplify this, extern
packet_length() so that the logic can be reused.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 pkt-line.c | 2 +-
 pkt-line.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index a0e87b1e81..6b60886770 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -306,7 +306,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
 	return ret;
 }
 
-static int packet_length(const char *linelen)
+int packet_length(const char *linelen)
 {
 	int val = hex2chr(linelen);
 	return (val < 0) ? val : (val << 8) | hex2chr(linelen + 2);
diff --git a/pkt-line.h b/pkt-line.h
index fef3a0d792..f443185f8f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -74,6 +74,11 @@ int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);
 int packet_read(int fd, char **src_buffer, size_t *src_len, char
 		*buffer, unsigned size, int options);
 
+/*
+ * Reads a packetized line and returns the length header of the packet.
+ */
+int packet_length(const char *linelen);
+
 /*
  * Read a packetized line into a buffer like the 'packet_read()' function but
  * returns an 'enum packet_read_status' which indicates the status of the read.
-- 
2.26.2.706.g87896c9627

