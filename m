Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE7D1F45F
	for <e@80x24.org>; Wed,  8 May 2019 00:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEHANQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 20:13:16 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39835 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfEHANP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 20:13:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id v10so12390849wrt.6
        for <git@vger.kernel.org>; Tue, 07 May 2019 17:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68Ijm1mnGsc2fw8tsrbw7RkdgF/VBWVApE61JHQ7+Nc=;
        b=VSvP5AEfIaaS5Km8qZ9jxS4Y8V7l3EFg64hTb0dyuI4MAjJDqDx3mP/YXr9NC4i8sp
         Of/kAcQNZzFfWNgz9n7CIUkIpL/46W0Hybxk9y8tEOpaPRw+p4q89F+5rYxpThjLnFyB
         V+obvEjGtw7wOZesIQChCWOFHjbXWkE9NspLvTafrOhRCpnJCWvQvnGCC1pY3oURaw97
         WsK7kjc9s3x2/o81YlaHuWSPw5SDNXDOVWDPdcorymxnGoCbq14rxDXqHCfihr0vkOmp
         WjP0Jcl/AGCyaSBLA89dqQD+7Cvz7HPwVpmBLCB2w4yjVd8ghjzeTnh8IKJhu2jxaicL
         5cDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68Ijm1mnGsc2fw8tsrbw7RkdgF/VBWVApE61JHQ7+Nc=;
        b=ln5Wav0s2ZtVa02B5hKQci71poP1BIeniNlORiD0i9z66LJ/6QX75rut/0kMARjuQ+
         LbCTnH38dtpeTsPhovdLR3ElZbf7yKagk73TSJhkI6AMDihUlBAkwvi2XI+wbWDJsrE3
         PRe4bguYjbF874T8xYKzjhU0HOyY37qLQGa9NYgaknv4BawFovF//uZgIPUOCIJhZA8Z
         F7CEN8fAZEkDKZl7Zap+/GhkV22WTXpHvWWAXNwF7WL8SnraI3OCKSPlXZNWxIQ4IoUV
         x6M4XmhlqdcbcNpZCXroZAd8Eo923zWvWOTP2LTB6YpaZkBqKu+j4YdEgARexOOmoH1a
         wQHw==
X-Gm-Message-State: APjAAAWqx2YEUU06JJk0RD2gx4VjqaSTTdyjscZHaJTb2XUJwkSp8hEX
        HiupIsmSIpkFbNlUV4EvhNTQlcD3rp0=
X-Google-Smtp-Source: APXvYqz2DIVm7J4CG+g39uwFdHKUlLA5hOCs+kL66IH/yaoL5xGySxaG3b8IeBdpO4pbvZM8MDfU6A==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr25123674wrn.51.1557274393511;
        Tue, 07 May 2019 17:13:13 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm5167825wrp.58.2019.05.07.17.13.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 17:13:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [RFC WIP PATCH v8 05/13] rebase: refactor can_fast_forward into goto tower
Date:   Wed,  8 May 2019 02:12:44 +0200
Message-Id: <20190508001252.15752-6-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <cover.1555832783.git.liu.denton@gmail.com>
References: <cover.1555832783.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Denton Liu <liu.denton@gmail.com>

Before, can_fast_forward was written with an if-else statement. However,
in the future, we may be adding more termination cases which would lead
to deeply nested if statements.

Refactor to use a goto tower so that future cases can be easily
inserted.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rebase.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 2e41ad5644..f7008b10af 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -882,21 +882,27 @@ static int can_fast_forward(struct commit *onto, struct object_id *head_oid,
 			    struct object_id *merge_base)
 {
 	struct commit *head = lookup_commit(the_repository, head_oid);
-	struct commit_list *merge_bases;
-	int res;
+	struct commit_list *merge_bases = NULL;
+	int res = 0;
 
 	if (!head)
-		return 0;
+		goto done;
 
 	merge_bases = get_merge_bases(onto, head);
-	if (merge_bases && !merge_bases->next) {
-		oidcpy(merge_base, &merge_bases->item->object.oid);
-		res = oideq(merge_base, &onto->object.oid);
-	} else {
+	if (!merge_bases || merge_bases->next) {
 		oidcpy(merge_base, &null_oid);
-		res = 0;
+		goto done;
 	}
-	free_commit_list(merge_bases);
+
+	oidcpy(merge_base, &merge_bases->item->object.oid);
+	if (!oideq(merge_base, &onto->object.oid))
+		goto done;
+
+	res = 1;
+
+done:
+	if (merge_bases)
+		free_commit_list(merge_bases);
 	return res && is_linear_history(onto, head);
 }
 
-- 
2.21.0.1020.gf2820cf01a

