Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF84C2BA1A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E2E20736
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 11:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqM5QSSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgDXLX7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXLX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 07:23:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113EAC09B045
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:23:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y25so4661056pfn.5
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 04:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGklJFw48CXuOGLaJHnGLIC3cGmQJhSAgDCdui6S8Lw=;
        b=VqM5QSSmoUbBtYRBIxbvEirgOjNHvjmEOgw3LdNIU47MGgPAdLqG6UhR3RhOxX6JoC
         GGfn46lb7mEbaiUDSyWj77qFK+MwvQnKqYi60XzfAQXLxE7tC49fCFEVcazpelRh0ZpF
         jupdgtPQ1G/vNEP99uyB2axM5zIu3yMoW9iqnAqERfZpZo8Qkbu+h4YZQydzmbQ7NrRd
         1r7l1lygrazKAK7Xom86XBpohHrhnUm2/IkQiFLzV0m+tUNtwsacet1qBLjKvbZgrZ/F
         mS6qNrNyFiI39S6Jvd/5OlcbuKW0Sd7758AeMZja6ZTjvD8/CR2HSqTaatiwrVI7cHKt
         ZxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGklJFw48CXuOGLaJHnGLIC3cGmQJhSAgDCdui6S8Lw=;
        b=hiUXCE2dyPARkay3N8ymsOQOhpre+syfqvnqJPjdXUGAlkGTSK+E9Ai2yX1BVKAjUz
         LhTU+vuCNnsnDmFOCl2ws+GBmNslPUuJ6Jl5EmV2llk7+/lxcyttkXdtx12Hlv9V+V68
         ivqPb4iTlerLoZHAzufBNyIM0I4WsLR1BkJiLDDqcDd06/be1MOUi0DKg3x1NNgNsowG
         2/zEQnXYr3Z/8mTCnct2lIr/ZQEYkdHgIYuWxEgX9Ru5F/72Wf16jL9qFSHBKDsn6ZmN
         3DG6j08hESw3WjGTGkBLXDxYSlp9HaPyBBHxK5H4rUMRWtSXqwPVoSDpIyGIlGC77oW4
         ygSA==
X-Gm-Message-State: AGi0PuYG2I4c0Xz1ykXJqih0CMQkeBrQiQUsTh7Q7uq3DAILqpl7aGAW
        9tg3tahe5VtjLtqtG4YxO1ANXfMZ
X-Google-Smtp-Source: APiQypLinxqo4KakjRhm2Dk2jtCrkDyh79oBu3omXMRkCM+nDR6/6Jg5I3HSstm9sEKqEkDKLyad2Q==
X-Received: by 2002:aa7:85d3:: with SMTP id z19mr8962835pfn.215.1587727438169;
        Fri, 24 Apr 2020 04:23:58 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id kb10sm4237296pjb.6.2020.04.24.04.23.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 04:23:57 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] credential: remove unnecessary forward declarations
Date:   Fri, 24 Apr 2020 04:23:56 -0700
Message-Id: <20200424112356.74165-1-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.569.g1d74ac4d14
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

46fd7b3900 (credential: allow wildcard patterns when matching config,
2020-02-20) introduced a forward declaration for credential_describe()
that wasn't needed as well as a forward declaration for a similar
function that was implemented a few lines below.

remove the unnecessary forward declarations by moving the function
to where it is needed instead.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/credential.c b/credential.c
index 064e25e5d5..24eabe8929 100644
--- a/credential.c
+++ b/credential.c
@@ -73,15 +73,29 @@ static int proto_is_http(const char *s)
 	return !strcmp(s, "https") || !strcmp(s, "http");
 }
 
-static void credential_describe(struct credential *c, struct strbuf *out);
-static void credential_format(struct credential *c, struct strbuf *out);
-
 static int select_all(const struct urlmatch_item *a,
 		      const struct urlmatch_item *b)
 {
 	return 0;
 }
 
+static void credential_format(struct credential *c, struct strbuf *out)
+{
+	if (!c->protocol)
+		return;
+	strbuf_addf(out, "%s://", c->protocol);
+	if (c->username && *c->username) {
+		strbuf_add_percentencode(out, c->username);
+		strbuf_addch(out, '@');
+	}
+	if (c->host)
+		strbuf_addstr(out, c->host);
+	if (c->path) {
+		strbuf_addch(out, '/');
+		strbuf_add_percentencode(out, c->path);
+	}
+}
+
 static void credential_apply_config(struct credential *c)
 {
 	char *normalized_url;
@@ -130,23 +144,6 @@ static void credential_describe(struct credential *c, struct strbuf *out)
 		strbuf_addf(out, "/%s", c->path);
 }
 
-static void credential_format(struct credential *c, struct strbuf *out)
-{
-	if (!c->protocol)
-		return;
-	strbuf_addf(out, "%s://", c->protocol);
-	if (c->username && *c->username) {
-		strbuf_add_percentencode(out, c->username);
-		strbuf_addch(out, '@');
-	}
-	if (c->host)
-		strbuf_addstr(out, c->host);
-	if (c->path) {
-		strbuf_addch(out, '/');
-		strbuf_add_percentencode(out, c->path);
-	}
-}
-
 static char *credential_ask_one(const char *what, struct credential *c,
 				int flags)
 {
-- 
2.26.2.569.g1d74ac4d14

