Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8737020281
	for <e@80x24.org>; Wed, 24 May 2017 05:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969170AbdEXFQ7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 01:16:59 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33697 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S969127AbdEXFQv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 01:16:51 -0400
Received: by mail-oi0-f65.google.com with SMTP id h4so31067402oib.0
        for <git@vger.kernel.org>; Tue, 23 May 2017 22:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wJuDeRrmEecWFSJRZ3XFV4vqYrVuGVYS2NkZZNLgwUQ=;
        b=tyTDnFFAdTNOwMkCCz+9Gaewyfhek/J+ihZX6DrhpG2BJfhvZ9E9oOGWdZd7deUsvu
         nDH5ZCQ0ese6CEKoob6W1UjYVsLOpcgQSxhZ+hssmjDdiVZrja61dQQ1Wlgqrr3m4kOS
         CNsCigN0w+IyiHpQ+2wL19UHjssCWLz9JFAGUGCaH7fOYthia2YY+L3dlfEiIrXL3nlj
         zoXF+5kBg/UoAL0XoXFkoQ+nyjstXbSJhvm1yJ90wtDDKSAERflrWxwCPOK3FZp88P6Z
         2vmQxuKT7+uuCJbswmJvtteqRJEoKm+vpQohKgqOiinmyDHMQF+KVzevr4fg+DIXzqus
         I2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wJuDeRrmEecWFSJRZ3XFV4vqYrVuGVYS2NkZZNLgwUQ=;
        b=kAnoza1GziUoO58BFC6+1+hL4voI64Gh0d86SRHr+M8Se9zsvBNZIM0kJNW5BAGdbk
         5QahukwCtvbGgEJt7z+C//NbFxuBp84Cs/z9Y8U9qGDGagPZR+eHrwPkJyXcnOo+7VyS
         6mgCKIV8iDLNlAUzC4fxOfxXA1TiCYuD6BHFu+ILdaOoK39Uh80NWsk4FsTbMbLPLN5M
         Bf8cR7q7aN6RBrT65wAjM7c93Q6C1g6Pv+Nhg/hoeACVqGUaDsuwfiorcnZQaslfvkln
         E+rLeoIhgd8nxM2pydiWC6RGlq8Y8yWmbE+iESi04wne6J8t671fXJkTBi3iH0HXBvk8
         ZBXQ==
X-Gm-Message-State: AODbwcAYCUpO+h3T0fv8kr4bd/GA1+DlVXif7ZUOd6WzS//PsQVAKluh
        FWaWT2TFqIW24g==
X-Received: by 10.202.244.86 with SMTP id s83mr16987547oih.116.1495603011029;
        Tue, 23 May 2017 22:16:51 -0700 (PDT)
Received: from whydoubt.T-mobile.com (ip68-12-240-88.ok.ok.cox.net. [68.12.240.88])
        by smtp.gmail.com with ESMTPSA id f81sm1429917oih.1.2017.05.23.22.16.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 22:16:50 -0700 (PDT)
From:   Jeff Smith <whydoubt@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, Jeff Smith <whydoubt@gmail.com>
Subject: [PATCH 23/29] blame: create entry prepend function
Date:   Wed, 24 May 2017 00:15:31 -0500
Message-Id: <20170524051537.29978-24-whydoubt@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170524051537.29978-1-whydoubt@gmail.com>
References: <20170524051537.29978-1-whydoubt@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create function that populates a blame_entry and prepends it to a list.

Signed-off-by: Jeff Smith <whydoubt@gmail.com>
---
 builtin/blame.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fd41551..29771b7 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2643,6 +2643,20 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 		*orig = o;
 }
 
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
+
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -2885,16 +2899,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
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

