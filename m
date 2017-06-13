Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D701FA7B
	for <e@80x24.org>; Tue, 13 Jun 2017 22:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdFMWZB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 18:25:01 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32854 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751802AbdFMWZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 18:25:00 -0400
Received: by mail-wr0-f195.google.com with SMTP id v104so34237447wrb.0
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G51jQ20qjg9XyGcWPgnwLn+/DH0v4/FPdO51U/JepQo=;
        b=UimQPnKWuSSnZodt8SGbSa4zOOZctyfEk8P0YNWgCgkLIUwNuRuALQ51hq7J7eQL8y
         PZTTL8/IJsUM9B/AT9q615zNgnQByzIkis4DthkxkMVXw2B7sQ6iVD4dPtgKWkfgoOVj
         3JWMySr3DDp7o4Ds621h19/Ajy5lEkMqsjoAD8OWkdzND1mDL3sl/Ybrau2r80eSym78
         RLC5MyZb+FEqsAc6d6tOZRGRzE4mTlpLspkUtmwlUD0gLiXk93YXHYq8XbTHUZG8iqzw
         tkXEE2PEHzXwECDAytunRa/jvounE5RkruTuYd1Rnx/nL/5VXHL6QUNH9NGacybwN9Ef
         St3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G51jQ20qjg9XyGcWPgnwLn+/DH0v4/FPdO51U/JepQo=;
        b=PAkuHHpV4JAd30fliocnYJf3DBJScMrB1heCn1e1xe7wa6UslPkiN8hpH5qkbDyCm+
         x0pxWiwH8j1sJISZEipUvgbGD9WBkX5SpndQIG0eXQyI9TD40Cd/dv+muoPWsbZMWQSU
         0t2UWdAm1+z1p1KJgr7qs0JdMapcunJd1mJnrgFI7vvnnF26uKLbTtlrip66Wyo0E1fy
         ErxY+VI/cpzTanoC1JuCbop/sTMNRtO1EuJFtgP7XvnFt7VilgKKhmsWZRMn8zTThBlx
         23OhfwyEdIA8sFr7dBcf/8bB1QlHvQ4E8qrk87CvmCaN06B+q+Z6g/NYgLYvTsAewlf1
         HLlQ==
X-Gm-Message-State: AKS2vOxzBWI9mJLklH6xaPBDLZRvm+N6L/UUlvLG20QnJyd1SahG0EGD
        ysaSnlnm/UVl4w==
X-Received: by 10.28.238.70 with SMTP id m67mr12875425wmh.74.1497392698609;
        Tue, 13 Jun 2017 15:24:58 -0700 (PDT)
Received: from localhost.localdomain (x590cc93d.dyn.telefonica.de. [89.12.201.61])
        by smtp.gmail.com with ESMTPSA id c11sm7932785wrb.58.2017.06.13.15.24.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 15:24:58 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Giuffrida <michaelpg@chromium.org>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
Date:   Wed, 14 Jun 2017 00:24:45 +0200
Message-Id: <20170613222445.15575-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.1.438.gc638325b1
In-Reply-To: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
References: <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[sorry for double post, forgot the mailing list...]

To throw in a fourth option, this one adjusts the expansions' cached
offsets when the magic makes it necessary.  It's not necessary for
'%-', because it only makes a difference when the expansion is empty,
and in that case

  - add_again() doesn't consider it cached,
  - and even if it did, the offset of a zero-length string wouldn't
    matter.

 pretty.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index d0f86f5d8..69c4f2a21 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1066,9 +1066,17 @@ static size_t parse_padding_placeholder(struct strbuf *sb,
 	return 0;
 }
 
+enum format_commit_item_magic {
+	NO_MAGIC,
+	ADD_LF_BEFORE_NON_EMPTY,
+	DEL_LF_BEFORE_EMPTY,
+	ADD_SP_BEFORE_NON_EMPTY
+};
+
 static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 				const char *placeholder,
-				void *context)
+				void *context,
+				enum format_commit_item_magic magic)
 {
 	struct format_commit_context *c = context;
 	const struct commit *commit = c->commit;
@@ -1155,6 +1163,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 					 c->pretty_ctx->abbrev);
 		strbuf_addstr(sb, diff_get_color(c->auto_color, DIFF_RESET));
 		c->abbrev_commit_hash.len = sb->len - c->abbrev_commit_hash.off;
+		if (magic == ADD_LF_BEFORE_NON_EMPTY || magic == ADD_SP_BEFORE_NON_EMPTY)
+			c->abbrev_commit_hash.off++;
 		return 1;
 	case 'T':		/* tree hash */
 		strbuf_addstr(sb, oid_to_hex(&commit->tree->object.oid));
@@ -1165,6 +1175,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		strbuf_add_unique_abbrev(sb, commit->tree->object.oid.hash,
 					 c->pretty_ctx->abbrev);
 		c->abbrev_tree_hash.len = sb->len - c->abbrev_tree_hash.off;
+		if (magic == ADD_LF_BEFORE_NON_EMPTY || magic == ADD_SP_BEFORE_NON_EMPTY)
+			c->abbrev_tree_hash.off++;
 		return 1;
 	case 'P':		/* parent hashes */
 		for (p = commit->parents; p; p = p->next) {
@@ -1184,6 +1196,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 		}
 		c->abbrev_parent_hashes.len = sb->len -
 		                              c->abbrev_parent_hashes.off;
+		if (magic == ADD_LF_BEFORE_NON_EMPTY || magic == ADD_SP_BEFORE_NON_EMPTY)
+			c->abbrev_parent_hashes.off++;
 		return 1;
 	case 'm':		/* left/right/bottom */
 		strbuf_addstr(sb, get_revision_mark(NULL, commit));
@@ -1314,7 +1328,8 @@ static size_t format_commit_one(struct strbuf *sb, /* in UTF-8 */
 
 static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 				    const char *placeholder,
-				    struct format_commit_context *c)
+				    struct format_commit_context *c,
+				    enum format_commit_item_magic magic)
 {
 	struct strbuf local_sb = STRBUF_INIT;
 	int total_consumed = 0, len, padding = c->padding;
@@ -1329,7 +1344,7 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
 	}
 	while (1) {
 		int modifier = *placeholder == 'C';
-		int consumed = format_commit_one(&local_sb, placeholder, c);
+		int consumed = format_commit_one(&local_sb, placeholder, c, magic);
 		total_consumed += consumed;
 
 		if (!modifier)
@@ -1420,12 +1435,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 {
 	int consumed;
 	size_t orig_len;
-	enum {
-		NO_MAGIC,
-		ADD_LF_BEFORE_NON_EMPTY,
-		DEL_LF_BEFORE_EMPTY,
-		ADD_SP_BEFORE_NON_EMPTY
-	} magic = NO_MAGIC;
+	enum format_commit_item_magic magic = NO_MAGIC;
 
 	switch (placeholder[0]) {
 	case '-':
@@ -1445,9 +1455,9 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
 
 	orig_len = sb->len;
 	if (((struct format_commit_context *)context)->flush_type != no_flush)
-		consumed = format_and_pad_commit(sb, placeholder, context);
+		consumed = format_and_pad_commit(sb, placeholder, context, magic);
 	else
-		consumed = format_commit_one(sb, placeholder, context);
+		consumed = format_commit_one(sb, placeholder, context, magic);
 	if (magic == NO_MAGIC)
 		return consumed;
 
-- 
2.13.1.438.gc638325b1

