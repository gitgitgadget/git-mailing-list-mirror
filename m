Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF0FF1F453
	for <e@80x24.org>; Fri, 15 Feb 2019 15:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387633AbfBOPtZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 10:49:25 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:43061 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBOPtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 10:49:25 -0500
Received: by mail-qt1-f171.google.com with SMTP id y4so11316025qtc.10
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 07:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/0cvxAKMsdwQaYj9X5pJKCdPorZdzB1E8vwY9Q1HNM=;
        b=aQjW8jKA+2CdP4NLAe2wuYjqZWTtdtaUmLrAoj4h9uYop8G/taEI/AlJ8g+Tr5PeYg
         Pu41g+FcAs5AwP3j9oisC/YLnegpg/1XYlA+3WNN7zsu1vnPpdzclXzCxp7ValtsCgw9
         Tn0/paJC5YFzOGPqdnAIYmUplzGUHRvd+ugPGF3lb2NP5qqw9g4O0U+oqi5RpSV8M6e/
         U5A5EeRP74v2tP7mo71x8zhSz4QS+4Nz6Z3nRC0nEnmi6X/y9dpopf2H8/nqu0mw+39H
         o30uwHQpshKwhSKanh8PNVxkR2MR56jVWiD4xi+8BtWdO8ZM5d/3HmdTR9K3DigChvy7
         RbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/0cvxAKMsdwQaYj9X5pJKCdPorZdzB1E8vwY9Q1HNM=;
        b=AV99vLg65FzqdG1A1eh0xFpBo4jfOK+Jls7bFVvLt/9bDYdGAIOgTLJs6Pw6vvULwQ
         2nNeqVrFB+iaPZiyAelpVIy6kDcSMJubaSDqbKLtByvOjfDxCvC0L7YuUZ0Fx8IhywP2
         qDl+faBXrHm9y7JWfMwCvtvwTBOl1FXBlDAjlL2+lkVrTVcX/vgzD7NhVgDz0y7zfDSL
         q84e4tPLkmW6/QV/b7ZTWnAfMGxE2PrVDqX3k+MzzDvBlNmMc/2knUdT83xHwQyoV28Q
         C7zJtCdt8OcJkQJcqcC9RNn2meczSiqEP8/rCoDfzRTfAuotFTXUqmJnOKEQbZ7xDLGt
         hBuA==
X-Gm-Message-State: AHQUAubBsxtSVxhc5TwzXlbOI1PLHb4Ivprapl0iCJHgFFis1Bwoonam
        KKSmPFcGrTw/So13hJN1E4hruvmBtC4=
X-Google-Smtp-Source: AHgI3Ibk5RYWNxU03kUVf6mHelNtF2pY+c5tyw1x/gIlpQqIGE5KSGz6+BXovWQsERK3o2QHaOoUAg==
X-Received: by 2002:a0c:d963:: with SMTP id t32mr1345214qvj.231.1550245763789;
        Fri, 15 Feb 2019 07:49:23 -0800 (PST)
Received: from mango.spo.virtua.com.br ([2804:14c:81:942d::2])
        by smtp.gmail.com with ESMTPSA id j6sm2909593qte.29.2019.02.15.07.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 07:49:23 -0800 (PST)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][PATCH 1/2] clone: extract function from copy_or_link_directory
Date:   Fri, 15 Feb 2019 13:49:12 -0200
Message-Id: <20190215154913.18800-2-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190215154913.18800-1-matheus.bernardino@usp.br>
References: <20190215154913.18800-1-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extract dir creation code snippet from copy_or_link_directory to its own
function named mkdir_if_missing. This change will help removing
copy_or_link_directory's explicit recursion, which will be done in patch
"clone: use dir-iterator to avoid explicit dir traversal". Also makes
code more readable.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 builtin/clone.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 50bde99618..2a1cc4dab9 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -392,6 +392,24 @@ static void copy_alternates(struct strbuf *src, struct strbuf *dst,
 	fclose(in);
 }
 
+static void mkdir_if_missing(const char *pathname, mode_t mode)
+{
+	/*
+	 * Create a dir at pathname unless there's already one.
+	 */
+	struct stat buf;
+
+	if (mkdir(pathname, mode)) {
+		if (errno != EEXIST)
+			die_errno(_("failed to create directory '%s'"),
+				  pathname);
+		else if (stat(pathname, &buf))
+			die_errno(_("failed to stat '%s'"), pathname);
+		else if (!S_ISDIR(buf.st_mode))
+			die(_("%s exists and is not a directory"), pathname);
+	}
+}
+
 static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 				   const char *src_repo, int src_baselen)
 {
@@ -404,14 +422,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
 	if (!dir)
 		die_errno(_("failed to open '%s'"), src->buf);
 
-	if (mkdir(dest->buf, 0777)) {
-		if (errno != EEXIST)
-			die_errno(_("failed to create directory '%s'"), dest->buf);
-		else if (stat(dest->buf, &buf))
-			die_errno(_("failed to stat '%s'"), dest->buf);
-		else if (!S_ISDIR(buf.st_mode))
-			die(_("%s exists and is not a directory"), dest->buf);
-	}
+	mkdir_if_missing(dest->buf, 0777);
 
 	strbuf_addch(src, '/');
 	src_len = src->len;
-- 
2.20.1

