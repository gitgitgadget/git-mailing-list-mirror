Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F217220281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969193AbdEXFRb (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:17:31 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34614 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969138AbdEXFRL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:17:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id w10so31063651oif.1
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mcsexx8VRjp5cfFs/frUPt/x3HU6aBxXKu0yUoXgKbs=;
        b=NZFDohs5fRMnzz5NEYd5ctxd3NE9XUvJotSgnt9RuPer2bVGpqXgSiXeP0JVJdT38D
         O/T/T3tpdOWzrebMadCpgOLpsmZyY/4IbhwEu/xQrW50jlj+eQQVoEkz1MkoEMJvseRW
         1h7PNZ+5LSgFQOcywqFyvPyOzG5Q6GZttUjruSOZOYzSHhbzzdZ8uncZxI4D5EvQBQ0u
         pS5xzgzjkxhTkGYsPZczs72VUj+Xv9Wr80ECHRda9x8MDn+VLTVQjyyZP5jLwExVBBer
         PVYbB2mWX5nZxW4kK4GEM8R8xvwaz4xBerj5JgtgaGC0i9jFH3lwP4ZKTBBxAgrG93jn
         cJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mcsexx8VRjp5cfFs/frUPt/x3HU6aBxXKu0yUoXgKbs=;
        b=M5ldS5tXyRO0FuI3YfnOmVwWTpgAiGlMCn/yvSnQDxwlxrRvKE+r7hQqjhbWdi9gf4
         /H5svfDD+PDN99s0hwIaVO2//cjQ8PF7z+FBORuFYPl3ifyaDdUPia/l0/cFqmcf6kNC
         6U+6ZXmOsVvGGrX/kDlteLL1WE59M7e6J+netz36QCZFvBCzIiZetQjlsh2a4l2Y0vDp
         NO/Iu/gkov9DtBBMPUWeu4JuU/m/ejLdl/XXXFGtzk2RUm+t/VZbDyNohZvuqxdmO+RP
         Cj3UllkzMKiz0csdGoJxp1NW0eC2GRvW7n2q0gzRZBcamyk5XagPbcw5vZxyztwZ6oj3
         RNhA==
X-Gm-Message-State: AODbwcADfRZQXkVensbFRlB4jJwZOwNjeDIB/krLu1IInPbzBZcVdlCN
        OE/bZHdVkRMVcQ==
X-Received: by 10.157.17.139 with SMTP id v11mr4294846otf.197.1495603020704;
        Tue, 23 May 2017 22:17:00 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:17:00 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 29/29] blame: move entry prepend to libgit
Date:   Wed, 24 May 2017 00:15:37 -0500
Message-Id: <20170524051537.29978-30-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 blame.c         | 16 ++++++++++++++++
 blame.h         |  2 ++
 builtin/blame.c | 14 --------------
 3 files changed, 18 insertions(+), 14 deletions(-)

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
index 7d9e322..08f35bd 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -648,20 +648,6 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
-struct blame_entry *blame_entry_prepend(struct blame_entry *head,
-					long start, long end,
-					struct blame_origin *o)
-{
-	struct blame_entry *new_head = xcalloc(1, sizeof(struct blame_entry));
-	new_head->lno = start;
-	new_head->num_lines = end - start;
-	new_head->suspect = o;
-	new_head->s_lno = start;
-	new_head->next = head;
-	blame_origin_incref(o);
-	return new_head;
-}
-
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
-- 
2.9.3

