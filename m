Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4D01F45F
	for <e@80x24.org>; Sun,  5 May 2019 16:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfEEQYs (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 May 2019 12:24:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35746 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfEEQYs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 May 2019 12:24:48 -0400
Received: by mail-it1-f194.google.com with SMTP id l140so16484883itb.0
        for <git@vger.kernel.org>; Sun, 05 May 2019 09:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Sp1xMBv9vXcJm5TOSj/GGmWCsYTgPGEu0knDjTbctw=;
        b=He26XxaiUipVnu/vZ5DtZN/PtHAlWob78hHxGZ+wGX5QbzZaJi847mJgQZpTVzM/9P
         aWdQE1ig5EpGOvOPp7AMUdEdvmU4t4YETKBSNNktSqJoiDMxo0jaPpEgjg8288UHW8Hh
         L9/KJsyyuMH8Pqhpg3KfntYIcgOoYeEeiO32vWW/fzfJbN3iNOuuSDTNmLIEpONlwvT4
         3UdWuRqRs7p4e9P+XrXZekOrc328Ba7Mv7eE28MdEJ1k+EmQYdRtAj9+ai2h1N1W5FGu
         vPHRzppkyRJ7Mpn7nj1AavPS7nVUKdP+mzz9A+cqkf/iCHUUaJR5lsi5Xq6Lc+Vi7PmR
         Ftqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Sp1xMBv9vXcJm5TOSj/GGmWCsYTgPGEu0knDjTbctw=;
        b=hBsFuQPLkwbD0+KYu7vBJdw1xFj2LDyUmIc+nQ0NBScaXt1USjdRyQDvynSzdGHK/D
         GtnKrr6ha5TCDkLge5y+jtztrlswMYvkHi8FHn1W7fz3333P4I1SDmipuLTRWWD8mYum
         E11qWwZGrlR2wbPPKyIABQ9EutvEyi6uVFChUj4jnxHqM0iSYtbSLY5QZ9198fOTmMGl
         ycp2s0Zg+AakcS6LXmgBohQJvbhf1ZUZjn+UNXi8zBupGPWcIOGStHQ96sH9UVwI9hoj
         jLfCD6aSAcJXQ8FvrlMnYXQEb/t7kixPy4jYp5DWHlGMHwMqHjqenKhRoXagZWATbnDO
         pUaw==
X-Gm-Message-State: APjAAAUatGO+UUmgF84V7ngch4JDC4s2/BozP6KWSLjCtgmGKFl8RQ/u
        z3lvjF6tzTGNr3LDnU+qlk1WHiKH
X-Google-Smtp-Source: APXvYqwuBZ8alOHpHlrBwQgmsCZxUP80Mz/6ScD8CpBugL16/aO2q07MKrhyNbP45gpEyrjCi3tPcg==
X-Received: by 2002:a24:7d0a:: with SMTP id b10mr16526226itc.54.1557073486874;
        Sun, 05 May 2019 09:24:46 -0700 (PDT)
Received: from archbookpro.localdomain ([199.119.233.193])
        by smtp.gmail.com with ESMTPSA id q207sm3659321itc.37.2019.05.05.09.24.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 05 May 2019 09:24:46 -0700 (PDT)
Date:   Sun, 5 May 2019 12:24:44 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 5/7] format-patch: move extra_headers logic later
Message-ID: <5ee43bc0b9c349042b60c918b2dda8ed6a7b0a6e.1557072929.git.liu.denton@gmail.com>
References: <cover.1557072929.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1557072929.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a future patch, we need to perform the addition of To: and Cc:
to extra_headers after the branch_name logic. Simply transpose this
logic later in the function so that this happens. (This patch is best
viewed with `git diff --color-moved`.)

Note that this logic only depends on the `git_config` and
`repo_init_revisions` and is depended on by the patch creation logic
which is directly below it so this move is effectively a no-op as
no dependencies being reordered.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/log.c | 58 +++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6f19326aea..685e319078 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1665,35 +1665,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
@@ -1796,6 +1767,35 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
2.21.0.1049.geb646f7864

