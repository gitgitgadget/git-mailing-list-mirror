Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 785091F462
	for <e@80x24.org>; Wed, 22 May 2019 02:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbfEVCog (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 May 2019 22:44:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38134 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfEVCof (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 May 2019 22:44:35 -0400
Received: by mail-it1-f195.google.com with SMTP id i63so729627ita.3
        for <git@vger.kernel.org>; Tue, 21 May 2019 19:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oK7Bkjr9DN6dQUzKEPyjloIOJyy6fuacavUKrinvBt4=;
        b=OThE1ddGX4z8M/SbEGkgjdYcaXNHDGWPATr5TqRXYkQAKvkPTKaldvMML5deweD7lh
         G6m7ITXUqpaq7kqjHXPmUikXa0xjYxsRMyOcaCDMR0rLUtXXo6BawOYhpFRWDhL0Fjvn
         JHepPQ+tWUSyP3hk/tnkXMGcoSvLIcOzFG8iPc2B7opVM6YDAR9XxR63T/rWHJBj6xZO
         Old9eeXdLLFPkCmxH/D+MIQoKnmO44GmUIIusvpz8bXiXGCqC9hBcS98Ik5VXmTRHqqo
         SSfrDJN2RGqXDFwBmi2WgVU4jJY5iONLcrp0kK/g0k9H7mMHleZHkh5VGSLsUnkx2FIL
         knTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oK7Bkjr9DN6dQUzKEPyjloIOJyy6fuacavUKrinvBt4=;
        b=YIYp4y5WR7uWrw7nTFDKflG+A7Vjkmp5bndv29Xo4LagYxcc9gcy6ZP3fiUtE7UowN
         SeKGmmNhQDYWxsSWoqtBy/GXeJ/aLHrlyKmtO4x1wwrtjeG77hA6GJH9EqlO/0fRfCfR
         brsoWWDcZRnduXdjCzyEJVZPqwhzupFwJ9wC+e5wR+DvvM8DTtGsBIWK8UacRBrBuClA
         ITEcI2rbd6fapX+squ5Dmfpi2k2u9a/xPepbsU6zhFTNopm6lzDAQ09iyIJrx5LxOeRU
         PEzNnGfSrvD6nRKLSwh8ntrlzCryD+QTykaPkPNOHiezAHy8+Zow6n6B9CKmsSHNqdoO
         IstA==
X-Gm-Message-State: APjAAAWGKqTPsBYOKSISGcFhOA6p5S7XFVs6wscKpyiQrDrPY5Rn/Q/u
        gjbDd/iC5llFA6TDJ+Oun48TZsyA
X-Google-Smtp-Source: APXvYqziFYV6WOCbaN2nM8VvU4f0conD4M/5jBQcAROVUBE5LDe9RgKhruPwZYJsG8gUABl9az2OMA==
X-Received: by 2002:a24:764e:: with SMTP id z75mr4403136itb.52.1558493074897;
        Tue, 21 May 2019 19:44:34 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id j11sm2595416itj.11.2019.05.21.19.44.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 19:44:34 -0700 (PDT)
Date:   Tue, 21 May 2019 22:44:32 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 4/8] format-patch: move extra_headers logic later
Message-ID: <52ee126825b7bc4cb788c307e1055753d9da7d51.1558492582.git.liu.denton@gmail.com>
References: <cover.1558052674.git.liu.denton@gmail.com>
 <cover.1558492582.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558492582.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we need to perform the addition of To: and Cc:
to extra_headers after the branch_name logic. Simply transpose this
logic later in the function so that this happens. (This patch is best
viewed with `git diff --color-moved`.)

Note that this logic only depends on `git_config` and
`repo_init_revisions` and is depended on by the patch creation logic
which is directly below it so this move is effectively a no-op as no
dependencies being reordered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 617f074d60..3f97f344df 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1667,35 +1667,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		rev.subject_prefix = strbuf_detach(&sprefix, NULL);
 	}
 
-	for (i = 0; i < extra_hdr.nr; i++) {
-		strbuf_addstr(&buf, extra_hdr.items[i].string);
-		strbuf_addch(&buf, '\n');
-	}
-
-	if (extra_to.nr)
-		strbuf_addstr(&buf, "To: ");
-	for (i = 0; i < extra_to.nr; i++) {
-		if (i)
-			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_to.items[i].string);
-		if (i + 1 < extra_to.nr)
-			strbuf_addch(&buf, ',');
-		strbuf_addch(&buf, '\n');
-	}
-
-	if (extra_cc.nr)
-		strbuf_addstr(&buf, "Cc: ");
-	for (i = 0; i < extra_cc.nr; i++) {
-		if (i)
-			strbuf_addstr(&buf, "    ");
-		strbuf_addstr(&buf, extra_cc.items[i].string);
-		if (i + 1 < extra_cc.nr)
-			strbuf_addch(&buf, ',');
-		strbuf_addch(&buf, '\n');
-	}
-
-	rev.extra_headers = strbuf_detach(&buf, NULL);
-
 	if (from) {
 		if (split_ident_line(&rev.from_ident, from, strlen(from)))
 			die(_("invalid ident line: %s"), from);
@@ -1798,6 +1769,35 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
+	for (i = 0; i < extra_hdr.nr; i++) {
+		strbuf_addstr(&buf, extra_hdr.items[i].string);
+		strbuf_addch(&buf, '\n');
+	}
+
+	if (extra_to.nr)
+		strbuf_addstr(&buf, "To: ");
+	for (i = 0; i < extra_to.nr; i++) {
+		if (i)
+			strbuf_addstr(&buf, "    ");
+		strbuf_addstr(&buf, extra_to.items[i].string);
+		if (i + 1 < extra_to.nr)
+			strbuf_addch(&buf, ',');
+		strbuf_addch(&buf, '\n');
+	}
+
+	if (extra_cc.nr)
+		strbuf_addstr(&buf, "Cc: ");
+	for (i = 0; i < extra_cc.nr; i++) {
+		if (i)
+			strbuf_addstr(&buf, "    ");
+		strbuf_addstr(&buf, extra_cc.items[i].string);
+		if (i + 1 < extra_cc.nr)
+			strbuf_addch(&buf, ',');
+		strbuf_addch(&buf, '\n');
+	}
+
+	rev.extra_headers = strbuf_detach(&buf, NULL);
+
 	/*
 	 * We cannot move this anywhere earlier because we do want to
 	 * know if --root was given explicitly from the command line.
-- 
2.22.0.rc1.169.g49223abbf8

