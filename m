Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9668DC433DF
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B6020724
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 15:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tD9BqX7f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389342AbgF3PQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389334AbgF3PQ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 11:16:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B1EC061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so19179595wmj.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvdArNTuNFTGPsnaWFvZ5ZJQbVEjIqkdNyGC6HTg0OE=;
        b=tD9BqX7fQFIapTyCGMoEeAeiNj74IQz4FCOOa+5m+V1uwhMiwFpY8E9tVSRS/NYDML
         ZkFnRLfz8OkUxEpoDbKcaLj6rucetFjMt8KQN60EiAThizX3ENgOEF4JAVBiDHjox0d1
         XTOz990hisM3eR/nSsAC0IOli1JqJUPePTZ7gB7v2sTc1cHMA2GKZx2ucPKCVmbuP88V
         27GZ8Wzc+yyhVRayl8JmnNdXSh9CslTUPde+w7/HeaU1WyBf9ZFofWR3x3dYeODjgT2B
         zwmcV/29whXiqbsRyEw36NO9rC8ZnXZFatbgzEgw9Ip0oVg1PMCdIqMUykKPdV52JQhu
         /d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvdArNTuNFTGPsnaWFvZ5ZJQbVEjIqkdNyGC6HTg0OE=;
        b=k0UsqO3g9BFet7qw1HbE2K4beb7REv7aIwVplFkMsrWp7R6fgYzCurjXSi2EfyYggo
         UdHMebjDkql6GDxty0+qdZ9+EzJhog5Hir16K5MNFjEnkB29W+5uLUHG6N7zkmsVl+AB
         gHMpaTFdTJIAPt3S6GpRicJi0aqfekB3JKMzY7NDexGVArn9l2qBCy5tfXu0cMjpSs9c
         tE2ySSSmgcZbvDjzbompvSswick8WUPBtCcvZTEWh91MSY3yTgqujNN0mEe2r7fJ+Spu
         N5ItaFLIfwtnHbkaL/HEKFH9XIId5mZzrF3DrApVayQDyQfvJdq3WeMvqhzqmEauh9MQ
         SVhg==
X-Gm-Message-State: AOAM531I+K2qg0B/lm0oK0jRiLhae2harfrlRoaxvSMtxZGdZoqKnFjR
        WG6cdB4l/INZgfUP60lPJYEAvI85
X-Google-Smtp-Source: ABdhPJwEOYfnBM0M9UbvrQ9ha/DrQK1jx2lzSLfFJ0fezfrIu/eV8snmObLTXT3/fE087pJXTj012Q==
X-Received: by 2002:a05:600c:285:: with SMTP id 5mr22763254wmk.41.1593530185064;
        Tue, 30 Jun 2020 08:16:25 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-323-12.w86-199.abo.wanadoo.fr. [86.199.210.12])
        by smtp.googlemail.com with ESMTPSA id 63sm4263911wra.86.2020.06.30.08.16.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 08:16:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v2 1/6] stash: mark `i_tree' in reset_tree() const
Date:   Tue, 30 Jun 2020 17:15:53 +0200
Message-Id: <20200630151558.20975-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200630151558.20975-1-alban.gruin@gmail.com>
References: <20200505104849.13602-1-alban.gruin@gmail.com>
 <20200630151558.20975-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In reset_tree(), the value pointed by `i_tree' is not modified.  In a
latter commit, it will be provided with `the_hash_algo->empty_tree',
which is a constant.  Hence, this changes `i_tree' to be a constant.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 0c52a3b849..9baa8b379e 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -228,7 +228,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
 	return do_clear_stash();
 }
 
-static int reset_tree(struct object_id *i_tree, int update, int reset)
+static int reset_tree(const struct object_id *i_tree, int update, int reset)
 {
 	int nr_trees = 1;
 	struct unpack_trees_options opts;
-- 
2.20.1

