Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B69EA1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbeGPXff (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:35 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:42567 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:34 -0400
Received: by mail-qk0-f202.google.com with SMTP id d25-v6so45139918qkj.9
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=zFg223ZIen/VC5royX711S2JsfP/S/KIxrs5Go/VcMA=;
        b=aD+OSlh8K3+KjpMuWrUWiJdCdpcrHErNpu6fVZ8dXBrTt12hohR/tY45fpg73mPYos
         t4ZTI7KounB+xjDU0H9InPr/Db/tdELMYmQbLSxjgpqXlJP4vRsjhmg6sy3nnMl48rtt
         C/cSO3Py31mKVtumSxwW6lkdjR0oE9OTLpn06dy7+uGLMIzMtNMiWmg2HCFA6UYDcQSf
         nqEhOe5oNgepgiEy9FH6SpeIZqKafwuAOMEy4vnrcOtQEPfmKTLdsVgAsXUb8f2sG/0X
         1jp3R1Xw6xxbA+Q7AFAcoLdlj5cjUFC7rMclExsxhCmp8x/tEiT/4HoqHmafJe9ZW+wY
         HJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=zFg223ZIen/VC5royX711S2JsfP/S/KIxrs5Go/VcMA=;
        b=RFUkPkZ9Sw6whz0QQ6CAHMdC0qHn96YLo9I7wNvDmPtvpnakgje+dF7D/6ngm2HbCu
         wmpXAE7AV54i8oeCeAU0uQXEqDupzGh/3ZwUuZ1pMMJdqCbJPxkzIRe8K83JOb1/rJDx
         HIwDrAgo4kkMtdk6YBi/DYRrahVo9PM4uCYGT3X9lR+NUaQh6ZhJV3jgDjV+7nm9Y3Y1
         isY98YLr3N412GtzyGt2HOQ4CG2yM874P55qzac2k2WgcYjivaXwxP9KhiBl1Kjez2kq
         yrjeHvmO+lnpyUvEfkKArjgmY4/BEGqjVOZYNFErlMDLDrG4jR1ecCL5Zy8noaTxoel1
         4+Gg==
X-Gm-Message-State: AOUpUlEJM8Kr20WsVm8nsGsuzZu5fZZUGceAIDn/9lbr85miZU19h7Q4
        9olW7uMkBbE3H1YQsjIN8qKmad3S2hdjlX9ks81KPDvqwMc3cvcczgb6fmiYpFTpOEaV8N5Tti+
        gMjrjVFr0/85wXWkrwQSNS2kudjCnfBcjEeyJDx8UCyEEhnLEi7IPMqsQf4jF
X-Google-Smtp-Source: AAOMgpdYF033703agPf19aCIooYDXyGP4m8hry8HCY4eym8ksCRUtl1bhlPpvn7TnvyPxT2bS7AqNHXTS9rY
MIME-Version: 1.0
X-Received: by 2002:a0c:c3cd:: with SMTP id p13-v6mr6281337qvi.22.1531782359498;
 Mon, 16 Jul 2018 16:05:59 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:38 -0700
In-Reply-To: <20180716230542.81372-1-sbeller@google.com>
Message-Id: <20180716230542.81372-6-sbeller@google.com>
References: <20180716230542.81372-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 5/9] diff.c: adjust hash function signature to match hashmap expectation
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the follow up patch easier.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index ce7bedc1b92..d1bae900cdc 100644
--- a/diff.c
+++ b/diff.c
@@ -707,11 +707,15 @@ struct moved_entry {
 	struct moved_entry *next_line;
 };
 
-static int moved_entry_cmp(const struct diff_options *diffopt,
-			   const struct moved_entry *a,
-			   const struct moved_entry *b,
+static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
+			   const void *entry,
+			   const void *entry_or_key,
 			   const void *keydata)
 {
+	const struct diff_options *diffopt = hashmap_cmp_fn_data;
+	const struct moved_entry *a = entry;
+	const struct moved_entry *b = entry_or_key;
+
 	return !xdiff_compare_lines(a->es->line, a->es->len,
 				    b->es->line, b->es->len,
 				    diffopt->xdl_opts);
@@ -5534,10 +5538,8 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 		if (o->color_moved) {
 			struct hashmap add_lines, del_lines;
 
-			hashmap_init(&del_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
-			hashmap_init(&add_lines,
-				     (hashmap_cmp_fn)moved_entry_cmp, o, 0);
+			hashmap_init(&del_lines, moved_entry_cmp, o, 0);
+			hashmap_init(&add_lines, moved_entry_cmp, o, 0);
 
 			add_lines_to_move_detection(o, &add_lines, &del_lines);
 			mark_color_as_moved(o, &add_lines, &del_lines);
-- 
2.18.0.203.gfac676dfb9-goog

