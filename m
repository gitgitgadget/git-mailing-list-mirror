Return-Path: <SRS0=NBeB=5G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6039C4332B
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B99FA2076E
	for <git@archiver.kernel.org>; Sat, 21 Mar 2020 18:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HICHKEIt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCUSAR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 14:00:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46251 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgCUSAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 14:00:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id cf14so1922818edb.13
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 11:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ja2imtO7F6ErC0w/uEQNVFpx8uzMl67k57jEKpbuYXI=;
        b=HICHKEIt4frFe9k4O69c8VK85injd8WKjHif3vdDPu0CHhabRDwjgJ98130JDNf0Rb
         zFzvkvP+thoC+ftTaaGVaJLiMzLilPFbBogQinDcQQVaSahZ6s6WjREc2W1BbrIHDIic
         8aerjwKkAK/Zm7Da7srG2eI1NOPIRouD5kE6e+zr8A3mQuawxuOAHtDm7A4P6cFKSPgG
         ayEqBY4Q/CiefPGCsxRKSBTIxf7PMuW/snSSCCBOg6tao3qlEeEb2n8u9M0gJwQ7ghOu
         Iaf8Qyh9f34ufnCSNVWk/wki3QnRvITzlocoLebMZXLbHPMM9+/PNJNCgSitFcYgb+cN
         i3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ja2imtO7F6ErC0w/uEQNVFpx8uzMl67k57jEKpbuYXI=;
        b=bPoYcXKzZiCxi+jGTm0QbiOjqt+6+vuTneUBlto474u/Ik/WcvLLzrttA4fWUR9N4Y
         EcUeD5A5puwL8O5haJWgonup6aN49QMoC/KliEtqu7UPSkMF6IhZvcn7XZgHoXLaG5p9
         B9pGuiQbanEC4tJ4powvUsHU8bxz0ekmys1pQeqzmm6/jKzeat/XBfGlJVxlw+xsJnBj
         ABZz9sa599dZ16prHp11WH95kpT0YFazIsESIYs5EZZQTJgqM8ra6pll/C5seUc1a+Ca
         E9r9Bne55LnZkskfAzY+Cq/+0JUVa+2WyarvdolCQCu9kHACVJ11/svkY2pW/iwizpWv
         tGvw==
X-Gm-Message-State: ANhLgQ0YNgg1bmyUHxM8pORdulRqcoyfECl21aJ837XGOVVqt5+rBv8K
        GxcrnGA00c+JRk1iAPBeFUFY/Gf0
X-Google-Smtp-Source: ADFU+vtXHEvp0O7eF0dpEdfznBpZuxlRy3utGtAPakJ1YfEpmF11LTIoTgw4YIUvqNyL9O0wEZ6J1A==
X-Received: by 2002:a50:fc93:: with SMTP id f19mr14059288edq.72.1584813614612;
        Sat, 21 Mar 2020 11:00:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16sm165531edv.71.2020.03.21.11.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 11:00:14 -0700 (PDT)
Message-Id: <5fea19f0136a849c70f18591d88abae8cee99841.1584813609.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
References: <pull.726.git.git.1584169893.gitgitgadget@gmail.com>
        <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 Mar 2020 17:59:57 +0000
Subject: [PATCH v2 06/18] unpack-trees: allow check_updates() to work on a
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
index d2863fa0310..dde50047a82 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -353,12 +353,12 @@ static void report_collided_checkout(struct index_state *index)
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
 
@@ -1665,7 +1665,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 	}
 
-	ret = check_updates(o) ? (-2) : 0;
+	ret = check_updates(o, &o->result) ? (-2) : 0;
 	if (o->dst_index) {
 		move_index_extensions(&o->result, o->src_index);
 		if (!ret) {
-- 
gitgitgadget

