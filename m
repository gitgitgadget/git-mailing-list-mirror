Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BB6C20281
	for <e@80x24.org>; Wed, 24 May 2017 05:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969156AbdEXFQs (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:48 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36284 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969138AbdEXFQd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id w138so31033749oiw.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oB1RGV1yj5PmZoLJNK2y2hcRo/eY6ntwouDtzyT+uXE=;
        b=FJC7ooC3CuLQw8nRNgrNDLadOf9dRacb5ynpQbivi+fbt7z0v0PI+qgonr2ZIkv1dX
         BD8vOFVtJ/4WemjnDkwuN7sMGWUBbHPRkNYcjbY1rWdcRpD3cY62Tdg2lO0+uIZ4OEJ9
         cMg405Yg9fZO6H8+A78DThQHIxoq7VuGy+apRYEqi8K8ve/r/gSya2E0+FtVW67YlcNE
         woSxQaN3GVkzTi96ELXdaAcYLY5/cGQnITySKNFilDxaHNT7x5fhr6OWsAeeAzCxhtb4
         Zp7wQnMP4bWQL7yX8j6eNRd0uQVpO85ihK6v8qiGfW1GReWBr2yWKci2whr2tqfko/lj
         2brQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oB1RGV1yj5PmZoLJNK2y2hcRo/eY6ntwouDtzyT+uXE=;
        b=BTKYScqBjEVDVHZgLJKtgIAsUuJYJE29IC0jMw4/rP3pQIFav4TvQZUdQC4/WIn78G
         O7Ml9QfdOyqan0J3odyMEUF5YOUzmYEfrESvqx7ynl9vBCobapNdfRbgHh0MQmM660c9
         0y6Uy53Ahh2LtL9mbVWb2iH0PhPKe+B9K+LlyJzI4VCCVoS5mn8OWHN4PWOCFM9YoaTp
         Lu/p+tmGxWwFbefUo+OFQRH7kC2Dz7EJ1SVnANdBpZbWe7IhiuFqh3J2P3emriT7Mkbb
         E8IBtAg/5bWDy9X0xocBZWwsgOwmSB4szjlpIyuJCpgoyj0+5TRU21T3X30EvCOizWmk
         TmDw==
X-Gm-Message-State: AODbwcDVLNFFdD2FB9AxwG2uxKqNTH68nkRIC25M56i689/gtRdWIybY
        rSeq00shCePP1A==
X-Received: by 10.157.26.125 with SMTP id u58mr4104437otu.167.1495602988161;
        Tue, 23 May 2017 22:16:28 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:27 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 09/29] blame: rename nth_line function
Date:   Wed, 24 May 2017 00:15:17 -0500
Message-Id: <20170524051537.29978-10-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Functions that will be publicly exposed should have names that better
reflect what they are a part of.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 129ef28..5082543 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -653,14 +653,14 @@ static void dup_entry(struct blame_entry ***queue,
 	*queue = &dst->next;
 }
 
-static const char *nth_line(struct blame_scoreboard *sb, long lno)
+static const char *blame_nth_line(struct blame_scoreboard *sb, long lno)
 {
 	return sb->final_buf + sb->lineno[lno];
 }
 
 static const char *nth_line_cb(void *data, long lno)
 {
-	return nth_line((struct blame_scoreboard *)data, lno);
+	return blame_nth_line((struct blame_scoreboard *)data, lno);
 }
 
 /*
@@ -968,8 +968,8 @@ static unsigned blame_entry_score(struct blame_scoreboard *sb, struct blame_entr
 		return e->score;
 
 	score = 1;
-	cp = nth_line(sb, e->lno);
-	ep = nth_line(sb, e->lno + e->num_lines);
+	cp = blame_nth_line(sb, e->lno);
+	ep = blame_nth_line(sb, e->lno + e->num_lines);
 	while (cp < ep) {
 		unsigned ch = *((unsigned char *)cp);
 		if (isalnum(ch))
@@ -1078,9 +1078,9 @@ static void find_copy_in_blob(struct blame_scoreboard *sb,
 	/*
 	 * Prepare mmfile that contains only the lines in ent.
 	 */
-	cp = nth_line(sb, ent->lno);
+	cp = blame_nth_line(sb, ent->lno);
 	file_o.ptr = (char *) cp;
-	file_o.size = nth_line(sb, ent->lno + ent->num_lines) - cp;
+	file_o.size = blame_nth_line(sb, ent->lno + ent->num_lines) - cp;
 
 	/*
 	 * file_o is a part of final image we are annotating.
@@ -1866,7 +1866,7 @@ static void emit_porcelain(struct blame_scoreboard *sb, struct blame_entry *ent,
 	       ent->num_lines);
 	emit_porcelain_details(suspect, repeat);
 
-	cp = nth_line(sb, ent->lno);
+	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		if (cnt) {
@@ -1900,7 +1900,7 @@ static void emit_other(struct blame_scoreboard *sb, struct blame_entry *ent, int
 	get_commit_info(suspect->commit, &ci, 1);
 	oid_to_hex_r(hex, &suspect->commit->object.oid);
 
-	cp = nth_line(sb, ent->lno);
+	cp = blame_nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
 		char ch;
 		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
-- 
2.9.3

