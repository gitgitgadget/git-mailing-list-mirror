Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14A1F20188
	for <e@80x24.org>; Sun, 14 May 2017 03:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758872AbdENDQn (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 May 2017 23:16:43 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34035 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758837AbdENDQf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 May 2017 23:16:35 -0400
Received: by mail-oi0-f68.google.com with SMTP id w10so14326206oif.1
        for <git@vger.kernel.org>; Sat, 13 May 2017 20:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IzeJZFFbFWnZt0mlSkxotji5oZI6zGka/esVsHTr/XI=;
        b=RGDzlxjj15M0J/sfI1rM9OJ12ZjjvIPptfCVM6VLsRsRuh1aZ05c0bypI01F23gQLy
         AlaX5D/W13Moq29WTLo1Un4Im69OI3R7rV1TZmmdMfjtqe+C7VJjOD6VyTWiZjpkQ9+U
         vcy9IKXhd5Q7c7KhLCiWv6HdKwfFT8JYKha3B3P8HcGOqmRhnVVSa5AqAi/fC0oEatcb
         GghcWvKUi/RNKTfHBHDH2aPuv0+MH65/Ypf7uSrzx8F59PLlson/AZlS0oHK3NvUl9no
         nwn0UnrzhGJfKkaJo8893wCFp+uX3h/VjS7K1JWToUqtDjziTc8WWO80hM6KN74jpJ96
         7LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IzeJZFFbFWnZt0mlSkxotji5oZI6zGka/esVsHTr/XI=;
        b=V53e/WGubsj1DllvQW+wIVfMIHNgtOaYDo4xWrExpcBF3zQSfBzJDPACee35ktnNDr
         OhCTBQ0vOScrmrcGptCDpF7BltKS1KeuMDDBTCnl8h7dQGHm47kFhnG2l6tlLvvicajH
         1mby2V9Ln+9W8elrElzyDoywa04YvjkGmtwC9j8I7WtfswpdGno+afyx8dZi3orZC8wz
         vdbgG1YVcef5NqkyxRLBkNbRCoa5V3VHChE4IBo1yRIUKBkt47MnsSz4QfMeJcWZpdFV
         sqzuccV8lN1XgPsAzQWUKBPwarDwS59h6F+HibYicxfXeVEyZCnN2q4t711mw0m+5RZ+
         l7Mg==
X-Gm-Message-State: AODbwcBs4B3F3+peg2Kmy7Zq/E3GFHlngSW8VawsDvpbCqTUZWtOy268
        A5ipQ3hT6npzHA==
X-Received: by 10.202.80.203 with SMTP id e194mr6079321oib.155.1494731794759;
        Sat, 13 May 2017 20:16:34 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id 67sm3735193otb.53.2017.05.13.20.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 May 2017 20:16:33 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [RFC PATCH v2 22/22] blame: create entry prepend function in libgit
Date:   Sat, 13 May 2017 22:15:13 -0500
Message-Id: <20170514031513.9042-23-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170514031513.9042-1-whydoubt@gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com>
 <20170514031513.9042-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 16 ++++++++++++++++
 blame.h         |  2 ++
 builtin/blame.c | 11 +----------
 3 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/blame.c b/blame.c
index f6c9cb7..00404b9 100644
--- a/blame.c
+++ b/blame.c
@@ -1845,3 +1845,19 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 	if (orig)
 		*orig = o;
 }
+
+
+
+struct blame_entry *blame_entry_prepend(struct blame_entry *head,
+					long start, long end,
+					struct blame_origin *o)
+{
+	struct blame_entry *new_head = xcalloc(1, sizeof(struct blame_entry));
+	new_head->lno = start;
+	new_head->num_lines = end - start;
+	new_head->suspect = o;
+	new_head->s_lno = start;
+	new_head->next = head;
+	blame_origin_incref(o);
+	return new_head;
+}
diff --git a/blame.h b/blame.h
index 76fd8ef..a6c915c 100644
--- a/blame.h
+++ b/blame.h
@@ -170,4 +170,6 @@ extern const char *blame_nth_line(struct blame_scoreboard *sb, long lno);
 extern void init_scoreboard(struct blame_scoreboard *sb);
 extern void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blame_origin **orig);
 
+extern struct blame_entry *blame_entry_prepend(struct blame_entry *head, long start, long end, struct blame_origin *o);
+
 #endif /* BLAME_H */
diff --git a/builtin/blame.c b/builtin/blame.c
index 7ec5a73..8a858b0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -890,16 +890,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	for (range_i = ranges.nr; range_i > 0; --range_i) {
 		const struct range *r = &ranges.ranges[range_i - 1];
-		long bottom = r->start;
-		long top = r->end;
-		struct blame_entry *next = ent;
-		ent = xcalloc(1, sizeof(*ent));
-		ent->lno = bottom;
-		ent->num_lines = top - bottom;
-		ent->suspect = o;
-		ent->s_lno = bottom;
-		ent->next = next;
-		blame_origin_incref(o);
+		ent = blame_entry_prepend(ent, r->start, r->end, o);
 	}
 
 	o->suspects = ent;
-- 
2.9.3

