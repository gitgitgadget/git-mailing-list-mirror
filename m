Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340D1C4363C
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 06:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89992087D
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 06:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esMHD4iZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgJHGoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 02:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGov (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 02:44:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3745BC061755
        for <git@vger.kernel.org>; Wed,  7 Oct 2020 23:44:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g29so3453691pgl.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2020 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tisM2oqP7tyHxfqYly/IW/4kftxX8Y0PFk4FP1Tso+Y=;
        b=esMHD4iZPuDn0tR3l4BBLJnZxGQrwaVDfsUZJ6dkosPB8AQse46qYaUsX0dU6Kl14W
         CTQOyA2QZBfe/sdokzAz8AcRW8zns0SjBwRMc2E1OPnOdPnhNgxnS2Oe067RFmkLLvnI
         Kk9lUNJ0oBp7bcLaiAloC2CBvoZdJQxV9tP3OOkViQNgvrgKalcGX/I4vu6fHT5lLtxP
         QHPh0jcoZKhaWkX5Eh5/scmO2/ffQYix1LRmK4jUhQyaR5rPi9nsUYgJtIP4knctBAbi
         yrIiPbLlqODVh4qwvzobFpYrJd6lCGPMA6Zmqb1PWRDICrh91BcpNPRQNwjn9m+Rdc2d
         Y1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tisM2oqP7tyHxfqYly/IW/4kftxX8Y0PFk4FP1Tso+Y=;
        b=gezfr22tCyF0AHuG2xYQrE+X1kJBPPO/X1eIqrvXG2nzWZjp0oCkT4IrlKiY5pI0ZE
         x3ehoie/F2FDLa1H7pTXnCuqDZHKorDVpif6euPrRBmGObwAp4cvFnG7EXE30h65rwKv
         TcQY9sDIKD0ChKwbj3cJrJt4GHJy+XarCFZf9NyfxrjxS76clVGouOks4V7tZDnMUIgp
         c0DZYw+seLeduksBKk8GtJ432p6yqtu1t5E34x3dgnJ+kslyQOYWqWDEjhsVtN0mKha6
         zsXjFG5fkOrNxaCK3xqcDeJ7yKJJnB1tWR9L9y591xXyfQSVlJ+kEa4bvvxGxAxAmojp
         s1Ow==
X-Gm-Message-State: AOAM533wQaWEk1OSv2uE7mMjtsad1rPFqSImHnzB4K+0ZDt8As+cVkXr
        5cMi+1DwdTLz58zEKKU40++sh/HVcwM=
X-Google-Smtp-Source: ABdhPJzLEO9aPqtc8/I4x8UoKwikjHaBtSQHihsX6OvOWBLUmIUrR9EDoEbDBYYe81V+dv5NV41tLA==
X-Received: by 2002:a63:465b:: with SMTP id v27mr5983250pgk.318.1602139490592;
        Wed, 07 Oct 2020 23:44:50 -0700 (PDT)
Received: from archbookpro.hsd1.ca.comcast.net (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id u6sm5228232pjy.37.2020.10.07.23.44.49
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 23:44:50 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 2/2] contrib/git-resurrect.sh: use hash-agnostic OID pattern
Date:   Wed,  7 Oct 2020 23:44:40 -0700
Message-Id: <6fad1fc7fdad98c3dda1ec334a10a6a9e311fef8.1602139448.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.29.0.rc0.261.g7178c9af9c
In-Reply-To: <cover.1602139448.git.liu.denton@gmail.com>
References: <cover.1602139448.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git now supports hashes other than SHA-1, the hash length isn't
guaranteed to be 40 characters. Replace $_x40 with a hash-agnostic OID
pattern.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 contrib/git-resurrect.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
index 57a77c03f9..d843df3afd 100755
--- a/contrib/git-resurrect.sh
+++ b/contrib/git-resurrect.sh
@@ -37,19 +37,18 @@ search_reflog_merges () {
 	)
 }
 
-_x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+oid_pattern=$(git hash-object --stdin </dev/null | sed -e 's/./[0-9a-f]/g')
 
 search_merges () {
 	git rev-list --all --grep="Merge branch '$1'" \
 		--pretty=tformat:"%P %s" |
-	sed -ne "/^$_x40 \($_x40\) Merge .*/ {s//\1/p;$early_exit}"
+	sed -ne "/^$oid_pattern \($oid_pattern\) Merge .*/ {s//\1/p;$early_exit}"
 }
 
 search_merge_targets () {
 	git rev-list --all --grep="Merge branch '[^']*' into $branch\$" \
 		--pretty=tformat:"%H %s" --all |
-	sed -ne "/^\($_x40\) Merge .*/ {s//\1/p;$early_exit} "
+	sed -ne "/^\($oid_pattern\) Merge .*/ {s//\1/p;$early_exit} "
 }
 
 dry_run=
-- 
2.29.0.rc0.261.g7178c9af9c

