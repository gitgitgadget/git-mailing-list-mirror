Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 764D71FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935831AbeCHLnM (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:12 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:46954 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935780AbeCHLnL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:11 -0500
Received: by mail-pl0-f68.google.com with SMTP id y8-v6so3151999pll.13
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QWf7KnDoV2RnGwTTYDg405CM4IxMocJ/Xra30zBS+24=;
        b=l9qArhlLIMcBFBux5rmpSD07pcolwYNEsGqS0PqL6FTcRO+zZWZDh9c3cgkMl/IF2u
         Hz3AT9nmszIYluMiVV+J8hOPPXKlpfPkd1DgcW9bf3fF3BQE0PbNJwi9PAiaoFFYLirI
         ipxq80KuylrZqiZcsUlO000cesh2eLRmfVShaXw/wbdgQXd4wXw5arRjLCSMh63HF2HU
         Vo9df4LnTAmHFFvYj78kqdVoLN/ghl9aQ6nI4FYEW7U5TcG2AOX97zsbM/wfJpQuLwOo
         or3P+wnC0E5lEtlEs7YSe7v2JUcr5NAi0W35mKPNGjk6DJdDlQBbNYtkjA1FGWnQpj+3
         0toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWf7KnDoV2RnGwTTYDg405CM4IxMocJ/Xra30zBS+24=;
        b=MtmZeUqBYVDiXa4TbDrSL/WwqRBikVrC/W4cRoNt5M3UKQi5EvPKb+DWzg2UPX5Qwd
         ZQJbP9tppoqPZ4InMwL8CWtJ+KRugCLGeL6VVp0WG1UR3hCnkGeqsd1eHYmQa5mGSVt1
         zU+yD3ySf75RvWdSeCWn96jK/RA8NYJhIjJBD8Jl1rKmjlsTnqVQAOJWKk6kifrioCrY
         QCHPu0Jio+dT9bY7ddEfTHRjYPFYlTcd7PfSTv2POVDfn3YBGgCX8t3XOFAY3Y3D/Hp1
         gTSLzDja1PHrK+kFPe6qpxH9+vVHBHyz9LUzHhUhZNBunlzsS6h0sv5ql6xDlezpnkJV
         5azA==
X-Gm-Message-State: APf1xPCjGGz7EzrzKN1SThaOEp5XFFTLJywSf0UR44kXwULVCfe7QQxG
        kUX5cJKDu3gW8K4GgSV1mgY=
X-Google-Smtp-Source: AG47ELuVurpOcKZvTuqgkJKGrNrk2GAiqa0u6c0PIX+q/x/LbHRLSH9koOw9ZFSt/6NW+wKQc193rg==
X-Received: by 2002:a17:902:599b:: with SMTP id p27-v6mr22871876pli.289.1520509391473;
        Thu, 08 Mar 2018 03:43:11 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id t126sm34013915pgb.85.2018.03.08.03.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 05/12] pack-objects: note about in_pack_header_size
Date:   Thu,  8 Mar 2018 18:42:25 +0700
Message-Id: <20180308114232.10508-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Object header in a pack is packed really tight (see
pack-format.txt). Even with 8 bytes length, we need 9-10 bytes most,
plus a hash (20 bytes). Which means this field only needs to store a
number as big as 32 (5 bits).

This is trickier to pack tight though since a new hash algorithm is
coming, the number of bits needed may quickly increase. So leave it
for now.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-objects.h b/pack-objects.h
index 4b17402953..2ccd6359d2 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -78,7 +78,7 @@ struct object_entry {
 	unsigned long z_delta_size;	/* delta data size (compressed) */
 	uint32_t hash;			/* name hint hash */
 	unsigned int in_pack_pos;
-	unsigned char in_pack_header_size;
+	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned type:TYPE_BITS;
 	unsigned in_pack_type:TYPE_BITS; /* could be delta */
 	unsigned preferred_base:1; /*
-- 
2.16.2.873.g32ff258c87

