Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200E01F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbeHZNpd (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:33 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36050 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbeHZNpb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:31 -0400
Received: by mail-lj1-f194.google.com with SMTP id v26-v6so6223119ljj.3
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=idv+9ANYxAZgoS/bf9XB1nbfiE2C12ErxySsASWtJk0=;
        b=eHU6zZ3eRS03PfliW7S3PHB6ah9V90E+qhN1tErsUHBdpi1XLu1KZ4YH3700FRM3rb
         g2EkTF0LmtZKp0nJYUT7qe/XAzFvKwAG8ESo+IfNtlTDbDrNMiw2WGrMv7DK9AryT2Rf
         JKbkCu/EUsnexIc9ThboY5cDM9QnjYtdgBZthPnLIe1SmuYmwqdxqF3mZQ1vr2HUVTmP
         NjsUTXG2MrZoBBBTkoGUlr1QEReOh06DYmzBlnrY2LfbRcPkSG3FbYJhBkW29EdKiAcx
         H3L2a3/ukcAobeYD1Gw4YEWGtRkKdop7LgPNVaC9+rX2z5le/T9Pbwibt/K/36qFkodz
         A3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=idv+9ANYxAZgoS/bf9XB1nbfiE2C12ErxySsASWtJk0=;
        b=Tx7ppyx2I5zVrZbiax4OqPo+TDTKdqZffg+TKItnGAjndU7+WE63WZ1rfcALGoEc9F
         PnSormADCJxo5AH/TyOTbaM2GPGSWQj1q6E0NTnQYWtT1AzenrsyeLezYGC6gNskbOEm
         EeyFJDrq89TZNdDxsoD5Va8eox4GvluM5M6rcVLKVZ8C3KGgHjSg9cxW9tRMvWZEYrQk
         i0fk7jU6+G/UPi3rdG88tzWEbe6Cv2D6SZQruIlJMHneQKSNglRI7MupYpPcCOeDI9Yj
         AHWwgCzER+hS+2kkafvblByyUhDhfWcF4OaW4AZ4fiudS4Uu5Sf6xumFIUqIcAq8sc8N
         aYYg==
X-Gm-Message-State: APzg51ABD3weXSbpPBtJN1o9d0biG5C031pWIpPhp1qkjNhKKEXOg5al
        jCpgDO08cH6DZL/bY58bLplb/gLI
X-Google-Smtp-Source: ANB0VdZkRFnMbk1FQyJvXDQP57GzMr3EpGyCZwz44WwpRGZzyguE3AAeW1+gU0uX6x7aKGzVGGzT+g==
X-Received: by 2002:a2e:d1:: with SMTP id e78-v6mr5526119lji.127.1535277804915;
        Sun, 26 Aug 2018 03:03:24 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/21] read-cache.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:00 +0200
Message-Id: <20180826100314.5137-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 8e92b1e21f..b9df81e94e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -823,7 +823,7 @@ struct cache_entry *make_cache_entry(struct index_state *istate,
 	ce->ce_namelen = len;
 	ce->ce_mode = create_ce_mode(mode);
 
-	ret = refresh_cache_entry(&the_index, ce, refresh_options);
+	ret = refresh_cache_entry(istate, ce, refresh_options);
 	if (ret != ce)
 		discard_cache_entry(ce);
 	return ret;
@@ -1493,7 +1493,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
 
-		if (pathspec && !ce_path_match(&the_index, ce, pathspec, seen))
+		if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
 			filtered = 1;
 
 		if (ce_stage(ce)) {
-- 
2.19.0.rc0.337.ge906d732e7

