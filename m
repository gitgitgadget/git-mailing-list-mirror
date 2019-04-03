Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31E9020248
	for <e@80x24.org>; Wed,  3 Apr 2019 22:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbfDCWAI (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 18:00:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45718 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCWAI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 18:00:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id e24so234507pfi.12
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5tfKftff+plXN2Z0LESKqeKbprtjq2EQT7SyUUxHMbg=;
        b=tkpjx1MRAvTANivqydRW+P7q9UvNBpACfmtXjXQzxpxf/+PAs2NSZ2jUHDg777X0M0
         NfyafU05a1Di+glX10zufumwycSoMcG4RN/RRCJ2XMng4Ev2U3GTKMZ02egfHQBqmvIX
         haN+Ilh6dYPxRA7z+/O5iV5iERE5FOVBatLP92fyOo6L8O8c0jdUEtiPpJNc/v2J0LAN
         jCm3+7q+V4yjv8uoCT29hgZir8FzD7+Ei6wqbkNqotrrlG4X5wsOe3gKZOZU3Xa6IwUW
         7dE3G3h2Yf8SlEv8t47fbFVM6Q+K2p2THXnYRmwBc3ALaPnhtluRyOMyGLmZLHskPl+/
         7ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5tfKftff+plXN2Z0LESKqeKbprtjq2EQT7SyUUxHMbg=;
        b=lnEBfMD1eWHWrv9Zj0EH1xTth2oNP1aLxtXvZRkNTTh6YkMzOfR+8TOJj2vtvvULi6
         p5OTVRHpxPs4+ATXe/3GoQEHLtD1z8D9G55C0kjr6GAJ8XW4b2yOeBQ9nguRXs+r9frc
         GkocbqavMZ0MwWSV/MmJzOHlVBa6czrombSa7fJLXQouXaR74xyWyivsN3USg4ftzCJ/
         Et6DCVNYcQ3K5h8eekiMT0GwwNIUpvmaJDQM2H3BDoW5HRl2+ETiLVc/sSXeMpShkldu
         M0GaVeG1NlGU90vehNdOKHGy19WgBk5sgGjsLyrI5mNlLudocpwDq7ErMVIa8Xz+l2vq
         7CVA==
X-Gm-Message-State: APjAAAUPJlIKmy6aA6H34MlKsOZoTGpQPzaNi7XbB7gx6KdYzVlCpr+g
        hVsdvq+UnlqV5PEdeEnI0ojkcyO2
X-Google-Smtp-Source: APXvYqzM4P+X/5mMH9ItOhirysvvWMqcS2QL2IpFiQApfXdFFrrsv3PzbfI0M7SrZqPVSwkHw1Fskw==
X-Received: by 2002:a63:6844:: with SMTP id d65mr2069859pgc.393.1554328806861;
        Wed, 03 Apr 2019 15:00:06 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id 10sm24893451pft.83.2019.04.03.15.00.06
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 15:00:06 -0700 (PDT)
Date:   Wed, 3 Apr 2019 15:00:05 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] midx.c: convert FLEX_ALLOC_MEM to FLEX_ALLOC_STR
Message-ID: <48c968a2923f76ab759327d21b37de86f7a61236.1554328261.git.liu.denton@gmail.com>
References: <cover.1554328261.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1554328261.git.liu.denton@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 midx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 8a505fd423..cb8190329a 100644
--- a/midx.c
+++ b/midx.c
@@ -70,7 +70,7 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 
 	midx_map = xmmap(NULL, midx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 
-	FLEX_ALLOC_MEM(m, object_dir, object_dir, strlen(object_dir));
+	FLEX_ALLOC_STR(m, object_dir, object_dir);
 	m->fd = fd;
 	m->data = midx_map;
 	m->data_len = midx_size;
-- 
2.21.0.834.geaa57a21fa

