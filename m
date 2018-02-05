Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76521F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752161AbeBFAFo (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:05:44 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:47065 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752060AbeBFAFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:05:38 -0500
Received: by mail-pg0-f67.google.com with SMTP id s9so116180pgq.13
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wgucwZUbe6TE53fUcqAman6rpzv7b/lAZfoFlEDwrVw=;
        b=b1msq42sHolrYIQZvfNBZrdgjuXwWOp26oYGwwKUKVQiCDgaMwgTSgtGQrTfzaBClq
         e9HM6wZ5/x9VWqckRZi8mKkhvBTO9395HRPNSWhtpSYolWGGlnoGX8wI8dkwMtNC4391
         2ELdCQP7fmxS97/SX1wEvf4TjFNY/UDG55OxwGhQCvMNCn2SCG9j1K2UlA1S+A5oHPWP
         SXv0k9RXL8yaODueglX8zuILQZawNxsJDWnUsUakeNtGIKpkSxMEmtMCtzL9ERGM46o7
         PzGzXOOxfBdTseuPZDywEXS7BGYh5Z451AbP6MvUKo+cusJoneJ2Jyn66U4WRPUd6Cex
         FV8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wgucwZUbe6TE53fUcqAman6rpzv7b/lAZfoFlEDwrVw=;
        b=fi2vhHUbmmOl0BW9xSlyK1588iQF4Lgl0/I4fJQiPRm+Xn0DTzkDSbDMSYTfJPEFLz
         dchWOzX35cEwkWvSbSfCl2F52Pf7D2qHFD+5hYJpBKy5CCaY48zaIiifKy5XdClvZ0Pb
         gDL179cHzMiISb7nKcyySvpTn3W9/L7JYCQL9BqcFKUsh8NJ1XNyiAHNIiYDw1R2EFv6
         EsbW46rJvo1F2Q7lzLgeMw19XknLvPJwHvWsnWhcURvb9ZHEYLWJjNHVjS9NA5/1SRBb
         Oj/tWPMtvBtT0c9iVj40pwqEUdlCD4G7J/ceI0VCcCR2zXFK82SkoZaPVgyNUYrHfcFc
         fChw==
X-Gm-Message-State: APf1xPCqHE6xBAmxLM4Qn3m9pwVrX/kTLUAfsXUz7V6Xa9dquKDJM1qv
        nKgy2W7JlAUCvTYP7Y2qjA/+m7bRGoA=
X-Google-Smtp-Source: AH8x226nJYcb46m9SqguBpwuX68tLVzveHk4i++aYG9is01uxsVPk+t5WKPSMwIoj2vSlZDsVklifA==
X-Received: by 10.98.198.2 with SMTP id m2mr498548pfg.113.1517875537510;
        Mon, 05 Feb 2018 16:05:37 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 12sm20409064pfr.147.2018.02.05.16.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:05:36 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 055/194] replace-object: add repository argument to replace_object_pos
Date:   Mon,  5 Feb 2018 15:55:16 -0800
Message-Id: <20180205235735.216710-35-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the replace_object_pos caller
to be more specific about which repository to handle. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 replace-object.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/replace-object.c b/replace-object.c
index 8d3e0a30fb..4a07f82aa0 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -11,7 +11,9 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
 	return replace[index]->original;
 }
 
-static int replace_object_pos(const unsigned char *sha1)
+#define replace_object_pos(r, s) \
+	replace_object_pos_##r(s)
+static int replace_object_pos_the_repository(const unsigned char *sha1)
 {
 	return sha1_pos(sha1, the_repository->objects.replacements.items,
 			the_repository->objects.replacements.nr,
@@ -23,7 +25,7 @@ static int replace_object_pos(const unsigned char *sha1)
 static int register_replace_object_the_repository(struct replace_object *replace,
 						  int ignore_dups)
 {
-	int pos = replace_object_pos(replace->original);
+	int pos = replace_object_pos(the_repository, replace->original);
 
 	if (0 <= pos) {
 		if (ignore_dups)
@@ -108,7 +110,7 @@ const unsigned char *do_lookup_replace_object_the_repository(const unsigned char
 			die("replace depth too high for object %s",
 			    sha1_to_hex(sha1));
 
-		pos = replace_object_pos(cur);
+		pos = replace_object_pos(the_repository, cur);
 		if (0 <= pos)
 			cur = the_repository->objects.replacements.items[pos]->replacement;
 	} while (0 <= pos);
-- 
2.15.1.433.g936d1b9894.dirty

