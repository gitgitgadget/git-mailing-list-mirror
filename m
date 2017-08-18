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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3360B208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 18:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbdHRSdV (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 14:33:21 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:36922 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751204AbdHRSdU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 14:33:20 -0400
Received: by mail-lf0-f67.google.com with SMTP id x16so6745982lfb.4
        for <git@vger.kernel.org>; Fri, 18 Aug 2017 11:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=w7Ke0/kojdOQTq6T4skukH5g3Y4TSwhi0lx+dIUOQWc=;
        b=Llngq6h9y0Xa1iTuIshRox4TDxRUyK/+DdoETe5lrc4hMi29O73zzp1Qf/HyJAcSDb
         KI6eYtoKmm/Py1BiJf3qCkfb8eYBdRfTbd+JwNrcj8ErsieTd6fvzML8Bi5Lkic83pv0
         76lUwixOIe+M1BQN2nwp4CWW/cJp+UrlTi2pN87LIkrQjhQ92lA2oOw1mYAhu4s/u2NV
         6jMjytO6BM/dYq0rdl3EMMVDovQTWoj7Q/UtNwgdGUneYxZwjDDW1h2M1eUS2flzupKU
         E9YiyVnU/HesxB/Q2vYHiDNK9KQGap72hYnIU0GV0BKhgDqt3XRuVsx04R0wUxMxJ3GF
         85GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=w7Ke0/kojdOQTq6T4skukH5g3Y4TSwhi0lx+dIUOQWc=;
        b=ucOnw+L61lqt10Kp7HA5gLQ6MxBUMMkjYuHfOmcrRLPVM+pjGUuabMlyAf//6LQiO5
         XrkxpsfYDiv86I27CDtpdNPA4d/KTMqYalthSZ9fubkrWXG7JNH22Hrs4ItkbBEENI+9
         IS4nP8SyVnVvXGkN7W7Q1zj6rQlKy7OLWuoIHYGIu2BDqwdG0ZiJA5oRIo3x58yXayxj
         2jV8beoGM4/BAc8hq1FQZEa1wHz4nmJ3iXHVfAnBofnUzf/w3uZoOod5SRsIITpFLtqi
         oh7qy7EOQcfBdCk3CaPiphvrakZYOmsPuxugqVS+ww32sW8vK4IyKH0X/jCpHuSa0UF1
         QZXw==
X-Gm-Message-State: AHYfb5hhk83ItLtzN8CdwX42LTk2zVyI+doXBKlFubtfMhxgdGb80HYR
        7zR1oQ9j4144zWhtqao=
X-Received: by 10.25.80.15 with SMTP id e15mr304217lfb.95.1503081198521;
        Fri, 18 Aug 2017 11:33:18 -0700 (PDT)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id r82sm813568lfd.45.2017.08.18.11.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Aug 2017 11:33:17 -0700 (PDT)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Cc:     "brian m . carlson" <sandals@crustytoothpaste.ath.cx>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: [PATCH v4 1/4] sha1_file: fix definition of null_sha1
Date:   Fri, 18 Aug 2017 20:33:11 +0200
Message-Id: <08a1c3de7d35243c36296d88ed17e8307aa9fff2.1503079879.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <cover.1503079879.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1503079879.git.patryk.obara@gmail.com>
References: <cover.1503079879.git.patryk.obara@gmail.com>
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

