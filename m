Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC9AC352BE
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAEE21D93
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 20:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeqzeGpX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgDRUTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727927AbgDRUTM (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 18 Apr 2020 16:19:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79858C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 131so4669425lfh.11
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 13:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYMvdEnNs1mIQ+phRpew+SOBmCpz1HTNiCuhFQTchUU=;
        b=WeqzeGpXXU/POf1qeN0JjObLs9ZdpaP7zbwy+r3PhKeNNrs71NDvlyMicKX/oB0R9M
         EE3BWghzmBwbBTkN08+RA/ZehxZXmwX8H0iQhj+i34N6rJi3nHBjr43uOjN6aGAR9ANk
         DMjSBA/G+5Trp3ublvwvAM9yDUqBIysD/EUWpZn4fVSwaypnMUtwxH9BXH+gmJdCmfAH
         LdUKPyQtwFEtZBvySliLeG3gU6BfRTQQcFuT5y0arEsqWIsKILT8IB/b6Ox+Q8o12DGn
         PdLhKSh60oDDTb+V24p+ZKh4Il5b5Ba3h1n+ubs5I1QzVfb1d/y0JwF2oTydPtdHuCer
         S7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYMvdEnNs1mIQ+phRpew+SOBmCpz1HTNiCuhFQTchUU=;
        b=hbslHnzb2rbESmNk7HxtgirAweZCudSTd1Y7LDY1ewzx6SwIRwgLYKYNbaLRhHlRpI
         dgAA4S9zzh+kGlqEV3nPYDtvU4RDSoWPqSYmxlfTHTj9BKCQP5HemEHqDvdzV192E14R
         gWBxFN9Ip1xBEK808BFx3h3n6hJ2gTtIJpmqRN4JYOLVIFJeJTWuKwNiMSW8Ce/uQPxX
         2asmLtJ8036sB9hgCu0DFSN6z9C1gRa1JuRNOdEHo++8FHT/Ovpog+2fN3SsBoDHFrku
         lxwktqSHQn39v9BRgfv9cx5wOP17JGVptBbV/KcONDRyVqR2tWCF6igS67lFnSStmB8p
         IDvw==
X-Gm-Message-State: AGi0PuYHFGLrRvAICQQhboiYTtEtaazKuEO4OgUdgT6v2p/+fK4sXojH
        rcb2u9yhlk10a12cOfwTBj26Pv2S
X-Google-Smtp-Source: APiQypIdpHgmYIIcAm6Hp0r7lL5+8XLMW6nqGS4Mq1f4tgEAbF2idP8H5aRW5slyvhgExHQ2lQj6/Q==
X-Received: by 2002:ac2:4c89:: with SMTP id d9mr5838688lfl.165.1587241150732;
        Sat, 18 Apr 2020 13:19:10 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id 73sm218713ljj.72.2020.04.18.13.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:10 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 4/6] fast-import: avoid awkward use of `strbuf_attach()`
Date:   Sat, 18 Apr 2020 22:18:27 +0200
Message-Id: <5db92b51c0363694c72b2de0c841449fa4e03f28.1587240635.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <cover.1587240635.git.martin.agren@gmail.com>
References: <CAN0heSppn6BBX4V1T1qgKc4XP+8i6qbcEqd1_3NqWQtZJLaJww@mail.gmail.com> <cover.1587240635.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As explained in an earlier commit, per the documentation of
`strbuf_attach()`, it is incorrect to pass in the same value for `alloc`
as we do for `len`. But, and this was also explained earlier, doing so
is still ok-ish because we'll end up allocating a large enough buffer
under the hood.

But then one really has to wonder whether

  strbuf_attach(&sb, buf, size, size);

is any better than

  strbuf_reset(&sb);
  strbuf_add(&sb, buf, size);
  free(buf);

The latter is certainly a lot less subtle about what is going on, and if
we're lucky, the strbuf's allocated buffer is large enough that we won't
even need to allocate. So let's change to this more explicit form.

In short, this commit should not make things any worse.

Nearby commits are changing other callsites to pass in a larger 'alloc`
parameter. Maybe that's safe here, too -- I admit I don't quite follow
where this memory comes from. In the future, we could possibly switch
back to `strbuf_attach()` here after looking into the allocations in
more detail. The immediate reason for this commit is that we want to
simplify the usage of `strbuf_attach()`, and we won't be able to pass in
"size, size" any more.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 fast-import.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 202dda11a6..7fd501c5cf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2946,10 +2946,11 @@ static void cat_blob(struct object_entry *oe, struct object_id *oid)
 	cat_blob_write("\n", 1);
 	if (oe && oe->pack_id == pack_id) {
 		last_blob.offset = oe->idx.offset;
-		strbuf_attach(&last_blob.data, buf, size, size);
+		strbuf_reset(&last_blob.data);
+		strbuf_add(&last_blob.data, buf, size);
 		last_blob.depth = oe->depth;
-	} else
-		free(buf);
+	}
+	free(buf);
 }
 
 static void parse_get_mark(const char *p)
-- 
2.26.1

