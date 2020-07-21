Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C502BC433E6
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40F122BF3
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 00:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mGPaHdhw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgGUAV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jul 2020 20:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgGUAVy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jul 2020 20:21:54 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63264C061794
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:21:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id 67so9246472pla.23
        for <git@vger.kernel.org>; Mon, 20 Jul 2020 17:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SWzX4/N+hE7+AtL3qr3COBMwi1M7B9eL8e2LVJ3c3io=;
        b=mGPaHdhwqvpSl5sEeuNDi2yC5r9hnNqxkeTTV9yFr0a4HFSSTAOLvD5EkYA6D+pNMd
         V+Fk/Y64cKmYgqU0iVOk6lz+HHVm/wBX9eGFysC9h+5RDiUiGJfyDoVYkKPTN7H8DwXk
         HW2chvkXm9ZpJSE4tatT7AYAxuNsZ6eeyGSz/InRJBq561/5f2oYjmEGSi5290xfREC0
         /VNEcA5D7mPHRzWETBUHPq0v9K3x6yVL2ZiHDpzOrM1Nv7DOIOYHAt5mUXynGB+jdJ3u
         s33m4G2CDNX5EAU36i15F4iSNqfIenofjj3k9o3dvqx4F9GsmDejKJKR8LirmPSehVC7
         fpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SWzX4/N+hE7+AtL3qr3COBMwi1M7B9eL8e2LVJ3c3io=;
        b=EW5Rylj9WvBNY3liAPMDnxtIQsbva1gd9IASx0vZs70UTatuLSAxi2ojAX2TpuJFX1
         pMuDpBbfwxzrZWPleaVmDq/m5VFTYD++AaAMnU+r5QJya+mfEr+jtXvmLe5+v4DBHiIR
         jO0tV58doaPZaiYp2SHQAOY0OkNaWAHZWIXtfBAtdPnyDYdCZyhLoTphtHZgThWKyOwl
         aLYWsP1cSeA3VAsAkg3X/APPKrcSEGDDFbQHZ+MQ1nDhJ6Cdvg6z0GsQ2m7YdWYTkNHT
         3zZ236TfdA1Vuri5X/TArdb6WEyNClCn7PY6PYe8jWZ9QkemJZKfxYQelXxwPD/pSwUA
         MnJw==
X-Gm-Message-State: AOAM533kzqd0IXbgwMy7xF4AP0pTvlqvPwHa6qw9HLmIZtOnxwRaCi+7
        6qSclETQT2VOzs73sx9Nw/PCQE6rIUPKbIqHq7C06cRAw3Et0SCZ4RCut9+8PyfDR5EvKMbDnRC
        vUylRFMmk0d8/hj7cU03Xg0dkWcdhHgoHjhMUrDDp7tG0SIdv5U1eN64fsHuWLB1gWjHo/zmwwX
        W9
X-Google-Smtp-Source: ABdhPJx4ao2kNMX6jO4gsx0GtVjAtLfjZOVeV9ikx4gXNefsfAOW1we1e5nTy2Cf/3CF0qbYQW2iLMZnHIBahKPzGQB2
X-Received: by 2002:a05:6a00:22cf:: with SMTP id f15mr102118pfj.121.1595290913812;
 Mon, 20 Jul 2020 17:21:53 -0700 (PDT)
Date:   Mon, 20 Jul 2020 17:21:43 -0700
In-Reply-To: <cover.1595290841.git.jonathantanmy@google.com>
Message-Id: <1c32a00601b0cb3c48807d56fb34b10df5373e81.1595290841.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1595290841.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH 1/2] pack-objects: refactor to oid_object_info_extended
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use oid_object_info_extended() instead of oid_object_info() because a
subsequent commit needs to specify an additional flag here.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/pack-objects.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7016b28485..e09d140eed 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1707,6 +1707,8 @@ static int can_reuse_delta(const struct object_id *base_oid,
 static void check_object(struct object_entry *entry)
 {
 	unsigned long canonical_size;
+	enum object_type type;
+	struct object_info oi = {.typep = &type, .sizep = &canonical_size};
 
 	if (IN_PACK(entry)) {
 		struct packed_git *p = IN_PACK(entry);
@@ -1840,8 +1842,10 @@ static void check_object(struct object_entry *entry)
 		unuse_pack(&w_curs);
 	}
 
-	oe_set_type(entry,
-		    oid_object_info(the_repository, &entry->idx.oid, &canonical_size));
+	if (oid_object_info_extended(the_repository, &entry->idx.oid, &oi,
+				     OBJECT_INFO_LOOKUP_REPLACE) < 0)
+		type = -1;
+	oe_set_type(entry, type);
 	if (entry->type_valid) {
 		SET_SIZE(entry, canonical_size);
 	} else {
-- 
2.28.0.rc0.105.gf9edc3c819-goog

