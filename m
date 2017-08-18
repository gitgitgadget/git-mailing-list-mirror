Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02ABA20899
	for <e@80x24.org>; Fri, 18 Aug 2017 01:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753892AbdHRB7p (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 21:59:45 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36050 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753828AbdHRB7n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 21:59:43 -0400
Received: by mail-lf0-f68.google.com with SMTP id t128so5396813lff.3
        for <git@vger.kernel.org>; Thu, 17 Aug 2017 18:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=w7Ke0/kojdOQTq6T4skukH5g3Y4TSwhi0lx+dIUOQWc=;
        b=SubLjk38/el7JltrscQD2jGPzwwi7tqUWupNgvML2O0bQtCmUah9UpPYhFtjSJd00g
         Obheyz1m7u1qN2w7hJmpdB/GxTszFj/f2GT3Ry0kqI/vPkxnJ9ewOsYuavsfr7jy9pqH
         PZp9Us3WaqX/9iwCUhctvh2wbPB2lmpXPevFsJ+qxyVaf2BDhw67WiSU35VMTiw7pGR/
         69N8rLg+OYHXiro8a5NMBIcnOCKTK0iTiCu73lyY/50teHjt1AgMH1zZp2tNC8o4rX9X
         1w/4SYicm+zb9ISGHMOivH5KLwi7d5g1rJmbQAQSV7PiPsXeRKgjxwi+fL8fBZorBsNA
         k3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=w7Ke0/kojdOQTq6T4skukH5g3Y4TSwhi0lx+dIUOQWc=;
        b=EpEXMpVKHasgizYlBnoqzpycCYIHFUclMj3+s5HxIGGVu1NddpzmjMX3MipjNzBltD
         JogZO5a/0+lfyuvdyKzBB9+bxTOgUD97kQjvOMs43jzV/YngaoS7ovLK/3lIIBY7Yu9w
         Az4B9gzhZs/3nKqY+Zqts7EuoNzLdPn9ZQiId13DJfT10+7i/5bG6MSOHjKzzDPf1y5x
         hkIENb7oib3jxjZgucoMJMen4GcNPzb96pWiX/eklOMltOgzyOiWsFwKem20GmZdM5Ie
         6MmyGmRxCdlrFDROTWC6FyO3dnRtE2AcB39KnIKRdOJESg/HBzMsxyTRf4ATXHBVei0E
         I7IQ==
X-Gm-Message-State: AHYfb5jE+/LphHjiLTn6gy7QTWVGFk4iGCfkEQNUUtWU75t2V4n1FKv2
        Q0EY/aH2G9L/xMOhZpY=
X-Received: by 10.25.90.215 with SMTP id y84mr931934lfk.65.1503021582292;
        Thu, 17 Aug 2017 18:59:42 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id c23sm363156lfh.79.2017.08.17.18.59.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Aug 2017 18:59:41 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3 1/4] sha1_file: fix definition of null_sha1
Date:   Fri, 18 Aug 2017 03:59:35 +0200
Message-Id: <08a1c3de7d35243c36296d88ed17e8307aa9fff2.1503020338.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1502905085.git.patryk.obara@gmail.com>
 <cover.1503020338.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503020338.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The array is declared in cache.h as:

  extern const unsigned char null_sha1[GIT_MAX_RAWSZ];

Definition in sha1_file.c must match.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index b60ae15..f5b5bec 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -32,7 +32,7 @@
 #define SZ_FMT PRIuMAX
 static inline uintmax_t sz_fmt(size_t s) { return s; }
 
-const unsigned char null_sha1[20];
+const unsigned char null_sha1[GIT_MAX_RAWSZ];
 const struct object_id null_oid;
 const struct object_id empty_tree_oid = {
 	EMPTY_TREE_SHA1_BIN_LITERAL
-- 
2.9.5

