Return-Path: <SRS0=FHek=5A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CFEC0044D
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA69220722
	for <git@archiver.kernel.org>; Sun, 15 Mar 2020 03:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+LtjR0N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgCODNP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:13:15 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45681 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCODNO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Mar 2020 23:13:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id h62so17417870edd.12
        for <git@vger.kernel.org>; Sat, 14 Mar 2020 20:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t2TKyN5RTnXDltMr66E5/PQPABoY3muWSJHQFaxKrAQ=;
        b=p+LtjR0NOBnwSem6/UJbSoBIFKQfVZEIUHC/xWbmIhuDz+qy1h1RuEkqm4qrAnC/uS
         Q+OKX72qe7uqxd5zdeDvoIl74ZBvuUD7BmXdynP395g7NQZAP5bFASd4KG6pYH5CaRvG
         S/UpL37QGqtpxxkI/CK33g1w7XxoNuNXcDw0NiUgxY8bpxtFicJ0lN6XllRCpYrN+OQW
         YI13qZKZ9AWd4uPvSbzKXvGdnLtNV8cpYVv5kIzHA4yF+9zP6jeBjGB99JKlMjdmTbVi
         pgSBHuzhlB0pGt6veOfIGzmrvwkC4wNZb8vS2SeC7IAVYMU7UvNNRWhVhxvibUXakLno
         KuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t2TKyN5RTnXDltMr66E5/PQPABoY3muWSJHQFaxKrAQ=;
        b=nCogjiZtEAGueMnv3MbUrZhH6S0NAce0yjvWUoCvf7MMYP7sn8sTBuCe2HyDaELwa1
         8JePppaiDFUEEj/6Tl/S8rqJsd9O155YBtmjy8D9FLkZIvZY5rscUbZs3QaU+EmV0XAR
         YoDM/wQib7Wa/WApkvPcFShsfsYn4EOaMHFETJfQzijgPIrjH3XPo40CJkQEGJZfZd4X
         S2TDM55AJSJPhZtsj+MzgbVFMubbk913f0ijdQEZ7lXReNHLr8q6NubDFmq6AsNtSPFv
         DjDn/Mc4HhxY6MTtNgmVUb5SAJg/56s31AFYDb/mo9zYZl8XWDTeIdhe78UQl+HQW/mZ
         bP9w==
X-Gm-Message-State: ANhLgQ0NPlJ5uTWlLfjxZdstZwTsRBloV45EO+aEEdlNNuV/9DJBeb05
        Z1nFTm3FMR1DlBEBNnQ8BwvqIRKm
X-Google-Smtp-Source: ADFU+vtc1cS6fjf+oq+XYLeJ65djUeV/fafzufHJzceYxcQpI4XDQnoXW4ZmosEKyTS1PAKjfidAQA==
X-Received: by 2002:aa7:d757:: with SMTP id a23mr16883338eds.26.1584169897018;
        Sat, 14 Mar 2020 00:11:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a7sm4138657ejr.30.2020.03.14.00.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 00:11:36 -0700 (PDT)
Message-Id: <02afa9c13c1cd299d67003e6984da0b38a53790b.1584169893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 14 Mar 2020 07:11:29 +0000
Subject: [PATCH 3/7] unpack-trees: allow check_updates() to work on a
 different index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

check_updates() previously assumed it was working on o->result.  We want
to use this function in combination with a different index_state, so
take the intended index_state as a parameter.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 unpack-trees.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 0d0eec0221e..853d843b17a 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -357,12 +357,12 @@ static void report_collided_checkout(struct index_state *index)
 	string_list_clear(&list, 0);
 }
 
-static int check_updates(struct unpack_trees_options *o)
+static int check_updates(struct unpack_trees_options *o,
+			 struct index_state *index)
 {
 	unsigned cnt = 0;
 	int errs = 0;
 	struct progress *progress;
-	struct index_state *index = &o->result;
 	struct checkout state = CHECKOUT_INIT;
 	int i;
 
@@ -1667,7 +1667,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 	}
 
-	ret = check_updates(o) ? (-2) : 0;
+	ret = check_updates(o, &o->result) ? (-2) : 0;
 	if (o->dst_index) {
 		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
-- 
gitgitgadget

