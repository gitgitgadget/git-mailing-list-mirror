Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1C4C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B3BC6108E
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 12:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbhI0M4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 08:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbhI0M41 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 08:56:27 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A35DC061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id t8so51851152wrq.4
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJeiwCZH5nxkGhJeH+F7+wV5ZTs4Ci15y2jAWq6iu6U=;
        b=fOd4QF7PcUaG6ZHMn3IkaVKuu/WJFu4TXMn5JWYj9I8zj8bhf/Ob1+X9opCuX7o3+g
         gW5BO+NysVMxyzPWqs3y0/T0LqUQYyt+ucTpt6Jc5pWHpaf5qsnZ0JSsb8I7pQGa4Pyg
         8ukMyyOf+zjB93uMH9aBEyCmKOrHy55bz6t2zVMoT7ip+py5zFwRItBEvNGsm8H0J5zO
         r1a6t9Qmqd8FjYw9nvNoopHSZGmKqkFQZb3HwfHaDw7HArM0BsHxhgxoYa9X5XTj5RNB
         nLJs6KOq1rN4oPeCKCYh7pnwoDyUQcQ2QfMoxViiKC2Nra81TQOF0hI+abx2V29mZOVB
         iAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJeiwCZH5nxkGhJeH+F7+wV5ZTs4Ci15y2jAWq6iu6U=;
        b=k061EyfVCZB1gLq1tmOldS0xe6dxjnKp9ok/eA62xQ6raBaBlNggNL8wAOKMGBsfmP
         yWyMc1BBA6WQKw2USF4PWeNawlvT1nJolsQyurpesz5P4hap+evuJO2hbvrSmmPr3058
         U7aGaMq+EeXUGcUmlnXyyCZdNTUa+kX/UxQ9EXZpbE+knrdnB45Ejd6ItbkLDl3o7Api
         4bvrzx3RlGni/mHGzFg82f1H1/TTOoN1L8Rhk00Lwz5Qo/un29LHgOQg4l+3wsQcdNIj
         nayOPJnIopZKX01WgytQhJ4ho8fLJk6+9ZleWt+EMHEf7crKtNNcuHIZ2WEDem1XfBhU
         tw7Q==
X-Gm-Message-State: AOAM5315hSh//ViRqg3od5ajbr2fD8p3HwvUEA7xYfQMNmmI1AAMFyJz
        zrskehUxaUeE9hXIC/x51BnR24Wt1G/MOQ==
X-Google-Smtp-Source: ABdhPJzMdn6geJnnhgJX9sKQ2082Ubmmhwqcgp9j4NUxP+417UWaMm5NdQPZwN09G7xrEvlTUzNmJw==
X-Received: by 2002:adf:dd42:: with SMTP id u2mr26005573wrm.39.1632747287735;
        Mon, 27 Sep 2021 05:54:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w14sm16460434wro.8.2021.09.27.05.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 05:54:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/5] cbtree.h: define cb_init() in terms of CBTREE_INIT
Date:   Mon, 27 Sep 2021 14:54:28 +0200
Message-Id: <patch-v2-5.5-76b47e7c80a-20210927T124407Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1316.gb2e9b3ba3ae
In-Reply-To: <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210927T003330Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210927T124407Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use the same pattern for cb_init() as the one established in the
recent refactoring of other such patterns in
5726a6b4012 (*.c *_init(): define in terms of corresponding *_INIT
macro, 2021-07-01).

It has been pointed out[1] that we could perhaps use this C99
replacement of using a compound literal for all of these:

    *t = (struct cb_tree){ 0 };

But let's just stick to the existing pattern established in
5726a6b4012 for now, we can leave another weather balloon for some
other time.

1. http://lore.kernel.org/git/ef724a3a-a4b8-65d3-c928-13a7d78f189a@gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 cbtree.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/cbtree.h b/cbtree.h
index a04a312c3f5..dedbb8e2a45 100644
--- a/cbtree.h
+++ b/cbtree.h
@@ -37,11 +37,12 @@ enum cb_next {
 	CB_BREAK = 1
 };
 
-#define CBTREE_INIT { .root = NULL }
+#define CBTREE_INIT { 0 }
 
 static inline void cb_init(struct cb_tree *t)
 {
-	t->root = NULL;
+	struct cb_tree blank = CBTREE_INIT;
+	memcpy(t, &blank, sizeof(*t));
 }
 
 struct cb_node *cb_lookup(struct cb_tree *, const uint8_t *k, size_t klen);
-- 
2.33.0.1316.gb2e9b3ba3ae

