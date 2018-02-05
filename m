Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513131F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBFAO3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:14:29 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:40100 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752229AbeBFAO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:14:27 -0500
Received: by mail-pl0-f67.google.com with SMTP id g18so114044plo.7
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fda5lHdrooovOyh91RMtYWnKCoN/ZyFSuRLIhimMWWE=;
        b=OsPzIRngF98vgsXRcbzA2CTN3yTmejo4Nw6o7fM+ntPGRV99O7WktENAXLJf/Ab/YE
         yZtpY7y94ZfdnufMMGPHHsuIZk4OwOqOGZpAXS/hjXF9IYl7Liy7cLXae3oxVbcV83Df
         jLeKNjXkvfda6dwmDtlpvv96w25mlnWewdeqRE2mX/utbsxqSmF+5TRLyiPO4wX6/yHd
         0XIegj8Sdl3IQ9yNc0k7e5A7uhFgOwqDTB6aEE2UMBgXI1zznU1cbM1Q12sTW1YH7aYm
         7Vl715nIHdgFaRMM4X2sxMu7bDuNYBom7ogC5NgW1BjJnpoQZVubJra2529+0G5I91hY
         a5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fda5lHdrooovOyh91RMtYWnKCoN/ZyFSuRLIhimMWWE=;
        b=ZA9bipQUp21Y7OeJ1Pebj61RiCPagk/Nk7nGdml89OFz3nQFgSAZ8HEk5bBvU8Nek5
         i/MsPM5s/lhmbZw+xC6WeX8oRevvQ9IS+M8D64t4iDnO03HUUEvuN+75Hf7TysbeWP4M
         dn9+6ByrgOj42ZRMxMnkA4J8AnyL5qFk07HWQH780Zhn+SuH32meyJgqDLUWTwUsJQoZ
         Vl/X9FSgPaZr0GBmQNQ0AAwGBboOOstX02MBsm/YxRxIVNyUVuv2GqXzZnCdSFanBC6I
         bC0EU9Lo5HN1O6DtEwXtT4rcn3ogVYlUzj7zKX81bAcZP6lBi8Sy+1hKtHpdA7lzZ2R2
         QxJg==
X-Gm-Message-State: APf1xPAdDXILcOwH76pWItdlKh5rXSdiHWp+4AxU5XTUgMHAABiVP9gT
        +rKe365WLXkhKOPNOoBqzfHwYagjtLA=
X-Google-Smtp-Source: AH8x227PAZPZtC3oKwzTn7S1raxmTOKt7ApYe32daGQ6p0LAYUbU8JRnnD3bH+8Vs7XOL1s1oEouEw==
X-Received: by 2002:a17:902:14d:: with SMTP id 71-v6mr565846plb.42.1517876066668;
        Mon, 05 Feb 2018 16:14:26 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id w10sm15057906pgr.57.2018.02.05.16.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:14:26 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 094/194] commit: add repository argument to parse_commit_buffer
Date:   Mon,  5 Feb 2018 15:55:55 -0800
Message-Id: <20180205235735.216710-74-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180205235735.216710-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180205235735.216710-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a repository argument to allow the callers of parse_commit_buffer
to be more specific about which repository to act on. This is a small
mechanical change; it doesn't change the implementation to handle
repositories other than the_repository yet.

As with the previous commits, use a macro to catch callers passing a
repository other than the_repository at compile time.

Add the cocci patch that converted the callers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c                               | 4 ++--
 commit.h                               | 3 ++-
 contrib/coccinelle/object_parser.cocci | 9 +++++++++
 object.c                               | 2 +-
 sha1_file.c                            | 2 +-
 5 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/commit.c b/commit.c
index a77c05f51c..f10a882d87 100644
--- a/commit.c
+++ b/commit.c
@@ -323,7 +323,7 @@ const void *detach_commit_buffer(struct commit *commit, unsigned long *sizep)
 	return ret;
 }
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size)
 {
 	const char *tail = buffer;
 	const char *bufptr = buffer;
@@ -403,7 +403,7 @@ int parse_commit_gently(struct commit *item, int quiet_on_missing)
 		return error("Object %s not a commit",
 			     oid_to_hex(&item->object.oid));
 	}
-	ret = parse_commit_buffer(item, buffer, size);
+	ret = parse_commit_buffer(the_repository, item, buffer, size);
 	if (save_commit_buffer && !ret) {
 		set_commit_buffer(item, buffer, size);
 		return 0;
diff --git a/commit.h b/commit.h
index 61e01112eb..20ad5acabc 100644
--- a/commit.h
+++ b/commit.h
@@ -65,7 +65,8 @@ struct commit *lookup_commit_reference_by_name(const char *name);
  */
 struct commit *lookup_commit_or_die(const struct object_id *oid, const char *ref_name);
 
-int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long size);
+#define parse_commit_buffer(r, i, b, s) parse_commit_buffer_##r(i, b, s)
+int parse_commit_buffer_the_repository(struct commit *item, const void *buffer, unsigned long size);
 int parse_commit_gently(struct commit *item, int quiet_on_missing);
 static inline int parse_commit(struct commit *item)
 {
diff --git a/contrib/coccinelle/object_parser.cocci b/contrib/coccinelle/object_parser.cocci
index c3cc4dfc9e..60f93c30c4 100644
--- a/contrib/coccinelle/object_parser.cocci
+++ b/contrib/coccinelle/object_parser.cocci
@@ -45,6 +45,15 @@ expression E;
 + the_repository,
  E)
 
+@@
+expression E;
+expression F;
+expression G;
+@@
+ parse_commit_buffer(
++the_repository,
+ E, F, G)
+
 @@
 expression E;
 expression F;
diff --git a/object.c b/object.c
index 6676887315..f518e5703b 100644
--- a/object.c
+++ b/object.c
@@ -211,7 +211,7 @@ struct object *parse_object_buffer(const struct object_id *oid, enum object_type
 	} else if (type == OBJ_COMMIT) {
 		struct commit *commit = lookup_commit(the_repository, oid);
 		if (commit) {
-			if (parse_commit_buffer(commit, buffer, size))
+			if (parse_commit_buffer(the_repository, commit, buffer, size))
 				return NULL;
 			if (!get_cached_commit_buffer(commit, NULL)) {
 				set_commit_buffer(commit, buffer, size);
diff --git a/sha1_file.c b/sha1_file.c
index df8bd4c260..0c2e215ae5 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1751,7 +1751,7 @@ static void check_commit(const void *buf, size_t size)
 {
 	struct commit c;
 	memset(&c, 0, sizeof(c));
-	if (parse_commit_buffer(&c, buf, size))
+	if (parse_commit_buffer(the_repository, &c, buf, size))
 		die("corrupt commit");
 }
 
-- 
2.15.1.433.g936d1b9894.dirty

