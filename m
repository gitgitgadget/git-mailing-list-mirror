Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476391F453
	for <e@80x24.org>; Fri, 19 Oct 2018 14:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbeJSW7R (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:59:17 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36301 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJSW7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:59:16 -0400
Received: by mail-lf1-f68.google.com with SMTP id l1-v6so5674740lfc.3
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cdunU1jiw5FYl7U1c37wJjUyjWaERejjxfqb4XYhrZE=;
        b=Y/t3j0UDUnOr7HbO/wxbM4im/S5AEGfCxcLHudus4puTuT9G52hHfWAlWasd6+USyy
         1WECgscWRMcdYPdEeOVi007ZpVaAJOuVfsZnzLJt+6gTf02Qr0/QBIT+MjSLi942FCwl
         +MIGl1q5ZK4fAK2LbY2jRNQfc7/aQ0ZNp9y+02Gt4eWjgSCw8Kw3s2eJK64FALaQCTQm
         feAn0z/pcfc2yqQbHGC8oQbzmBc8xcZLVNUrS3jACOVHv38Iu4GXP79sapCttM7eSNDf
         1Cky9xS21NGDSHJRMgU5A3hDUtxOItiOHrjpGZMvaGu0Lsh+qfoqS0aylUupP8qQJfMP
         tEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cdunU1jiw5FYl7U1c37wJjUyjWaERejjxfqb4XYhrZE=;
        b=ftV++70zPHaS5NBFDLGh/Ns26OgwGnGECNzcGnFzmgFbX08J1H6aIfR5J3dx2MVb77
         tCQKzRByf2GCqlWOEkKn116dQ5Hc70rSSAIeq5Ehb4TTk4K+ZK3+5PdQIlMJg6c5PkF2
         m0alw1DVvTQaCi+DjE0OVvcdDL8ZjUoX6S55DRdj4aEVS9b9MZKXhlx2zbSUdEeP4bxW
         XHBPZ9I8rJuoqMLde4j2G5kpT8IL4AheYwg94Q14lOnAWhwz5Vb2phjOziqrjFfNK9jO
         /VBJdVCagnNaEnEhNs7+NntUl4TEMRi2TbvYk30oenl13iWoAGB3AUroN/Yd8nLyGH73
         a7YQ==
X-Gm-Message-State: ABuFfogUsUBsogjNKZG/KvV/NcbUymF8h8CVVgX9M8z8FIE22TojN+e7
        i1feaaNFEw3M1MpD0GO5odPpxwI4
X-Google-Smtp-Source: ACcGV63CLk4Ov4qkFncn7fayjEm+PaTfy6UemRYQERfjLKMyZMR83P60MQ2JwjSmROoZ2zorTuJPig==
X-Received: by 2002:a19:5a84:: with SMTP id y4mr3350755lfk.156.1539960767315;
        Fri, 19 Oct 2018 07:52:47 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g64-v6sm4002414lfe.87.2018.10.19.07.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Oct 2018 07:52:45 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/19] list-objects.c: remove implicit dependency on the_index
Date:   Fri, 19 Oct 2018 16:52:22 +0200
Message-Id: <20181019145237.16079-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.647.g708186aaf9
In-Reply-To: <20181019145237.16079-1-pclouds@gmail.com>
References: <20181019145237.16079-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 list-objects.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/list-objects.c b/list-objects.c
index f9d36dabf2..c3a1a9b004 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -51,7 +51,7 @@ static void process_blob(struct rev_info *revs,
 	if (!(obj->flags & USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BLOB, obj,
 			      path->buf, &path->buf[pathlen],
-			      &the_index,
+			      revs->repo->index,
 			      filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
@@ -137,7 +137,7 @@ static void process_tree(struct rev_info *revs,
 	if (!(obj->flags & USER_GIVEN) && filter_fn)
 		r = filter_fn(LOFS_BEGIN_TREE, obj,
 			      base->buf, &base->buf[baselen],
-			      &the_index,
+			      revs->repo->index,
 			      filter_data);
 	if (r & LOFR_MARK_SEEN)
 		obj->flags |= SEEN;
@@ -177,7 +177,7 @@ static void process_tree(struct rev_info *revs,
 	if (!(obj->flags & USER_GIVEN) && filter_fn) {
 		r = filter_fn(LOFS_END_TREE, obj,
 			      base->buf, &base->buf[baselen],
-			      &the_index,
+			      revs->repo->index,
 			      filter_data);
 		if (r & LOFR_MARK_SEEN)
 			obj->flags |= SEEN;
-- 
2.19.1.647.g708186aaf9

