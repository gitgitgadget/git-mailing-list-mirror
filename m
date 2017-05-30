Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8CEC2027C
	for <e@80x24.org>; Tue, 30 May 2017 17:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbdE3Rc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 13:32:29 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33332 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbdE3Rc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 13:32:27 -0400
Received: by mail-pf0-f174.google.com with SMTP id e193so78479473pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 10:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wW+E5VMuSim3E4Gj7HzxOZPQ5OTjuMDD/PITWFLoCCA=;
        b=h/EHUa6FEDFHj2lBjeT6/Cg8Brd9tcS5WviZDxoqywK4q+G4iNjE/XakjvFP3xBrEd
         cyH4GG32e/jNnrT7d+kxh3by2qhb1pZBcLLdfj4BylSs6X7IKRc5xNAGo4MAzGPMeGss
         GxOE9iKUH+ls0j9IxZo4OA06F8u6/0QX9OSmVkh7fb0sB+JxD/AQRs6dC9dwn5y3Sz03
         sN9cVW29GVtYUQM0eh2+2r0b8LeHFzy8I5hKptd+tTTKXRy5LFZs1vG+OjhLCGFOAB3k
         dGku7Nd75jSn2NunAS3SXep18YsaljRZLYmNcufpIr8GFih6+OLN8zcPTkQMfqtCGfqA
         79Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wW+E5VMuSim3E4Gj7HzxOZPQ5OTjuMDD/PITWFLoCCA=;
        b=q/TT4FirlhqyqFcHg5Tg7c53MiE6MbE4yrWcBTNl+LouxXzHXXQQIz4RkEvqPtcb6p
         pVMyAMDJdcustTkGjsEiXsMp+34VB7yFdCzBUnMyhJVWu3/tgv+6ZGOWGE50svPSlBeJ
         Ohe/wuO+jiqikm0DcC4kqWWYkq3micJm4DxwdnmUQrFT0ctbcURpeZ96Xctet4RDP6fK
         QnzeuFI2ThlumgCeh9Z3YHZTm5jGHKgZN3v0CHFyh2uN3Ugb3cIQDHPXpkqvMjeTHFIm
         nM/ym0/zqcto17jsjYyRGQeBIqSs2HySlOWEyWQOqLDqkAWAi0XhuYlo/QP1PVAhYd3t
         GHiQ==
X-Gm-Message-State: AODbwcCKkwYO96u//g0U4v/cD0+whQ2Os6y1pjgDNhyPz6njRkk0zCRQ
        e7NIRxsuojPbEytU
X-Received: by 10.84.245.8 with SMTP id i8mr83954747pll.109.1496165536592;
        Tue, 30 May 2017 10:32:16 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t19sm24940187pfg.31.2017.05.30.10.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 May 2017 10:32:02 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sandals@crustytoothpaste.net,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 31/33] tree-diff: convert path_appendnew to object_id
Date:   Tue, 30 May 2017 10:31:07 -0700
Message-Id: <20170530173109.54904-32-bmwill@google.com>
X-Mailer: git-send-email 2.13.0.219.gdb65acc882-goog
In-Reply-To: <20170530173109.54904-1-bmwill@google.com>
References: <20170530173109.54904-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Signed-off-by: Brandon Williams <bmwill@google.com>
---
 tree-diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 6a960f569..467e38172 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -132,7 +132,7 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
  */
 static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	int nparent, const struct strbuf *base, const char *path, int pathlen,
-	unsigned mode, const unsigned char *sha1)
+	unsigned mode, const struct object_id *oid)
 {
 	struct combine_diff_path *p;
 	size_t len = st_add(base->len, pathlen);
@@ -162,7 +162,7 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	memcpy(p->path + base->len, path, pathlen);
 	p->path[len] = 0;
 	p->mode = mode;
-	hashcpy(p->oid.hash, sha1 ? sha1 : null_sha1);
+	oidcpy(&p->oid, oid ? oid : &null_oid);
 
 	return p;
 }
@@ -221,7 +221,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	if (emitthis) {
 		int keep;
 		struct combine_diff_path *pprev = p;
-		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid ? oid->hash : NULL);
+		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid);
 
 		for (i = 0; i < nparent; ++i) {
 			/*
-- 
2.13.0.219.gdb65acc882-goog

