Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D431F461
	for <e@80x24.org>; Fri, 17 May 2019 00:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfEQA1v (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 20:27:51 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36885 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbfEQA1v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 20:27:51 -0400
Received: by mail-it1-f194.google.com with SMTP id m140so9273492itg.2
        for <git@vger.kernel.org>; Thu, 16 May 2019 17:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5/3yJSUXSOYVpbu+ME4jLP1VIc/h0vIssRXaGQalDDI=;
        b=d3giQB1JWgmfIMiNXfp0Go35nNgtum1Db3cvrvqJs4SAS2IZqfqhVuQRfnEeqP0IbB
         BWh/WTDJNb42nQ8tkRf9sku5QJs4GUPT/W+gNOXoF0FEEKqedmjwn9z2WmDQhQsJsvVn
         ngwgoiSdDO9Y7hhUG9MBlYU0KkE+6NGx0cW4fOImg8A0IE5bIQG6WJtVQMamFZjavMsb
         R2o33ytk6rQ0u4hUzPbB2OXNnrH5EVjaRqKrWkOy4gYzLkn3rwOSPbkyH2cLS6zzE7YA
         V3epjUjVp2e0KXv9JyMizwwVpQCrRSzZe7Qfzr5d83J61ZOubAE2X7a6XhKdYyncohnU
         o0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5/3yJSUXSOYVpbu+ME4jLP1VIc/h0vIssRXaGQalDDI=;
        b=mc1a0o/9KxIj1BRgKTOmqI/8IKywnhy2x23YvfWDVWyqbLVYL4EGA5Q8karpksmtWC
         KOf/trMctIEtkQJrE9uJQ9sFhIMlU4hY8bM9n/N0IFTYLt8DgRfGBGbEwIEj6cTIiIq0
         W1oS56xnO94eLuM31J6pkBEmAZU18IvpeLIqMX0u5yoRiGTko1fKFddYDqeZx42zeRAz
         VAZC9qrUrNVCHmi010TsrwCNaVSCcvdRaaCbd0yLbusTdOEsifNTekMl4KO8BhySMfLP
         5H5uUE7np+GfpN3FInGUoHtJGYeaBsym1Lw2n/wWaC7t9/zMVfnB5u1qwnrlzgtsf+GP
         3lFw==
X-Gm-Message-State: APjAAAWQKJSAnG621i2a9E351845haN/IzTcx/TP9ZFX3nyPJ9on1gzC
        Kb0q9Ns3SY5giwKW2MHP6BLLK6JQ
X-Google-Smtp-Source: APXvYqwUCQYCoUyrnW6ROWqymEcRh/cZJRmeRCcbhZdrXMp/BlGRkt9rED0h56HkqMxywUs5h1koLw==
X-Received: by 2002:a24:8b07:: with SMTP id g7mr390181ite.129.1558052870280;
        Thu, 16 May 2019 17:27:50 -0700 (PDT)
Received: from archbookpro.localdomain ([2620:101:f000:700:2553:5cea:cc9b:df9d])
        by smtp.gmail.com with ESMTPSA id m67sm2719913itc.22.2019.05.16.17.27.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 17:27:49 -0700 (PDT)
Date:   Thu, 16 May 2019 20:27:48 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/6] format-patch: move extra_headers logic later
Message-ID: <57d067b3bbd2e7169c573e565d3420776b6b5152.1558052674.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
 <cover.1558052674.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1558052674.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we need to perform the addition of To: and Cc:
to extra_headers after the branch_name logic. Simply transpose this
logic later in the function so that this happens. (This patch is best
viewed with `git diff --color-moved`.)

Note that this logic only depends on the `git_config` and
`repo_init_revisions` and is depended on by the patch creation logic
which is directly below it so this move is effectively a no-op as
no dependencies being reordered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 2bbe712e7c..f66a65fe84 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1680,35 +1680,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
@@ -1811,6 +1782,35 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
2.21.0.1049.geb646f7864

