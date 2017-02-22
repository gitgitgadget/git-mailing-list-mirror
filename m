Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C6A201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932733AbdBVOIU (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:08:20 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34418 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932741AbdBVOIS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:08:18 -0500
Received: by mail-pg0-f68.google.com with SMTP id s67so560020pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xsLxElHr2DjamFY5WGF+XXEmTDM7jhbjkPlbHFxi8So=;
        b=oL0oft648GS9/UMmrTRop7tiesNoi2DC4igW6n0rue47kgKZfRoJ5CV25aQR0bBek+
         P+CJjElBHAqqIwbU1Q6NT0Aji2ohQfbp08/kBdTbeGcEnOaKNxxhwbwB2UFgeIfHZkFD
         B3T+pIYa+K4bIuxCzbJbQOiybUDDtmoxnXReJh0d5cfvqbvmvY5jFVYaEMqUICqeR+CQ
         y/Svb6miC27DG0tguPXBVj5hhmC1QUHwfS7zFDZnUpYFX5xnBBCtvdllloV2ngZY2jv+
         qj6eFa87av9IZ6/d0Zjo/XHZ3lQf0vPHh6g35o/sXDv16/UTJ9gE298Dk4rxglBmHCkd
         jbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xsLxElHr2DjamFY5WGF+XXEmTDM7jhbjkPlbHFxi8So=;
        b=JUZad0vtLYdQ9i3IbUHmuqT2RkccqNeM6M4ZT09xNjogsj8gEjSTzt/DRDzYsJhaW1
         Mv16Mi/EbjBofkKRifQWChGX0IJyGfewBBIBwlI+dRMuPED8/hg+U/hPTge6JZFUF1US
         6TbwmI7f1NpAgj6saYIHzp98HoaNantHa0EFi9QBp7v7G8/d1om3D3JXUNZORdfjxjCm
         zq971eL5zn5SCexz9t1yT9yo7hXjy1rL1KwY3SPAo/ON4GsOnlkNx90PtY3c289WzVc0
         HYGryXWcmfrkxF2PF9dVKv56pKi+6FrJV8VfO1WoGAUhdJYg5yuf7F/zF+HbVXe3+6m1
         s2uw==
X-Gm-Message-State: AMke39nycqbMkv5DbeCOBaOYowXnedxDaXihtoicNLoQRBCXfUTR3HYedQ0Hy4Dm5H+DtA==
X-Received: by 10.84.208.227 with SMTP id c32mr47606050plj.71.1487772497205;
        Wed, 22 Feb 2017 06:08:17 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id 17sm4096333pgd.45.2017.02.22.06.08.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:08:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:08:08 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 21/24] refs: delete pack_refs() in favor of refs_pack_refs()
Date:   Wed, 22 Feb 2017 21:04:47 +0700
Message-Id: <20170222140450.30886-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It only has one caller, not worth keeping just for convenience.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/pack-refs.c | 2 +-
 refs.c              | 5 -----
 refs.h              | 1 -
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 39f9a55d1..b106a392a 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -17,5 +17,5 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	};
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
-	return pack_refs(flags);
+	return refs_pack_refs(get_main_ref_store(), flags);
 }
diff --git a/refs.c b/refs.c
index 851b5e125..6efe5957d 100644
--- a/refs.c
+++ b/refs.c
@@ -1594,11 +1594,6 @@ int refs_pack_refs(struct ref_store *refs, unsigned int flags)
 	return refs->be->pack_refs(refs, flags);
 }
 
-int pack_refs(unsigned int flags)
-{
-	return refs_pack_refs(get_main_ref_store(), flags);
-}
-
 int refs_peel_ref(struct ref_store *refs, const char *refname,
 		  unsigned char *sha1)
 {
diff --git a/refs.h b/refs.h
index 342cecd23..1af41eaef 100644
--- a/refs.h
+++ b/refs.h
@@ -294,7 +294,6 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
  * flags: Combination of the above PACK_REFS_* flags.
  */
 int refs_pack_refs(struct ref_store *refs, unsigned int flags);
-int pack_refs(unsigned int flags);
 
 /*
  * Flags controlling ref_transaction_update(), ref_transaction_create(), etc.
-- 
2.11.0.157.gd943d85

