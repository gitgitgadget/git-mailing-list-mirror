Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8657B1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 21:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfFNV4Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 17:56:24 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36705 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNV4X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 17:56:23 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so9043080ioh.3
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 14:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RjPUHS8fZw1CRehX/IPdQG1g11oOLvgXM8CVigcZ9ws=;
        b=ZyNJs6zpafC/k3FMW+kXjKgxWrE7gNrQ7ArjL2tlC80Syjken4EqA4r/JqwM17qGFb
         3DUqykHLkw9Z4ftMjlvFEYg5Yr9fBXoNTgfujFo/xUaJ30k14vLo1ecSaIqj3B3wAjTt
         f4ivxz6PN4Chy+i+Dbj3cFayHyZDtY7A8mvOe/6yAnA/gYSED2Pa+GsU07sDbfZEOp0q
         fesmbaAKZJA9rWSPofK3+a1h09MSy2jOSCmp8/QHyvxMRgs/xwPZo9aeQ6mWPwOhNOTV
         sxWdiVLoXRkKCq4vmZtbCo+m8Ofu4VAH8jwKjVmdTw6Xl00TfRDgWEBgzq+DsNkWi0ZA
         WGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RjPUHS8fZw1CRehX/IPdQG1g11oOLvgXM8CVigcZ9ws=;
        b=O1hN9Hu5zLkgYIX5/Y2OVvMaQRUKJXi4uOR2m22sygCGQ0gUYDeQW5XwuDPCdxAVQ/
         mh9OCwQ4zXEO6u9PD9xHbsl9c7agXm1FcN3cr9j5IOxcsGGZjhaJGN9pYbpwFZylPgD5
         GyuCjq8De8nkFy/rEwtO6c1c1mp3fUkgsmVNmI8wiS5YTs8eTijTTXviaHbE+SmCBdWC
         tfCkOviTBBtdvowg6DKzZh1iXO0MKe2PAd/yIMLehVyn0YWhGl48kuaJv/Fkb1U5RSbz
         hjQA2HmRG7SNlQm2JytwR4rNtpxJyEP5bNly2NQcPdcGUTMCeAqtoegqr58G3NEIRrOt
         SmSA==
X-Gm-Message-State: APjAAAW2W4Zu7FeaTpXIUFfPg507ozuE0utpQ8V9aKhS/Lk+W2XaOx7G
        1XuCbmNjRNHhwhI41tx7J9NPqEt7
X-Google-Smtp-Source: APXvYqxaIgtAtaDLefV/hOtDq/TJSKbYOCBa1vVwBJnv9ko1aqP4d9//IAZnAtE6ZriYl4rOAOAzUQ==
X-Received: by 2002:a02:1006:: with SMTP id 6mr70750957jay.47.1560549382931;
        Fri, 14 Jun 2019 14:56:22 -0700 (PDT)
Received: from archbookpro.localdomain (ktnron0919w-grc-01-76-68-140-144.dsl.bell.ca. [76.68.140.144])
        by smtp.gmail.com with ESMTPSA id h18sm3456277iob.80.2019.06.14.14.56.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 14:56:22 -0700 (PDT)
Date:   Fri, 14 Jun 2019 17:56:20 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [RESEND PATCH v3 4/8] format-patch: move extra_headers logic later
Message-ID: <82a56a0d76c1028773ced5ffbbf832ee8dba7173.1560547501.git.liu.denton@gmail.com>
References: <cover.1558492582.git.liu.denton@gmail.com>
 <cover.1560547500.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560547500.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we need to perform the addition of To: and Cc:
to extra_headers after the branch_name logic. Simply transpose this
logic later in the function so that this happens. (This patch is best
viewed with `git diff --color-moved`.)

Note that this logic only depends on `git_config` and
`repo_init_revisions` and is depended on by the patch creation logic
which is directly below it so this move is effectively a no-op as no
dependencies being reordered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 617f074d60..3f97f344df 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1667,35 +1667,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
@@ -1798,6 +1769,35 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
2.22.0.355.g3bfa262345

