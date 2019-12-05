Return-Path: <SRS0=7IA6=Z3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471FFC2D0BF
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6B120706
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qK6RWY+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfLEWzJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:55:09 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:41083 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbfLEWzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 17:55:09 -0500
Received: by mail-qt1-f177.google.com with SMTP id v2so5190794qtv.8
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 14:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3usFiUwIXpR2FyFUo+EvXFfeYKgh/HZKVsx9TxDbS74=;
        b=qK6RWY+V896ZLbM87CcIIZxweS5dw/PHiUtOEFH+7x91fDQMTflX+EVZgZC9z7n/X/
         ZuwwBcMPh73OgKf1BLgXN+3bflDwOdXX393yD0lxYHLmPT7OawIQVDpm+og9YKTGoq4c
         XLTrcONNH9KI3i54+a8wF/EkPxDv1/MtsQl0t3ybmXhN4LgWPwKqMp5U/f95GYfPxfj6
         +748XXFwDC/LKBDOkzch0gLM2dGi4/OEG19T52Kv1rGhHnaKCqSZq9hQMFi03rP/jouF
         6/AWScn/fg3N+8EwsMrPJ/LmPU3CrENxiz2hbDk9T01w1a6M7XToSxlVbU8kq97N3gnW
         gfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3usFiUwIXpR2FyFUo+EvXFfeYKgh/HZKVsx9TxDbS74=;
        b=DR/zxYNbQiU5mJy3X6YzML2ESTxUwkjkWHtxuFVrzFT9cWpJkpBKBu/8SMQ8gQteGq
         p5H1csQs4ssY2Pbv7oPrGeTzPO5RQIECXd8piSVe2r+zr8wGngnKfYynmi1NCPbT2cxD
         wRJGiIPFHwIMLgvrF2oji3o2n9CumyHylJ532nZs3zwOxXPU8cq8AmZJW9zDP0iBsJLa
         Ams73/JivXGrsUi8Ht7MOjd8k3GsQ7cuWJbKnpttS9m1XzwvZXhCl6DtSBXAqydXFQTy
         ysx/MmPFewjcOK7cIUq2CY8/vL7nBMMNbhqT4sg5bpt2VOHMbf0aI6WhsslUtTp/RFKV
         yJig==
X-Gm-Message-State: APjAAAW1pBkKk5ZknU+XCwd5uO0D41BiMBLwWn47EtXiWOlfhkYhWydR
        W8srTXJO58wZEXPnYJmatys3C39jRoE=
X-Google-Smtp-Source: APXvYqzLUyEVOhuoqAf2DN0+TASOeyndOQ88TiroE2klOILbcXRg20j3jrTY3MLgPLPwcONRP3D1NQ==
X-Received: by 2002:aed:304e:: with SMTP id 72mr9962054qte.113.1575586507387;
        Thu, 05 Dec 2019 14:55:07 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id f23sm5426066qke.104.2019.12.05.14.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:55:06 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH 2/3] rebase: refactor dwim_ref_or_die from merge-base.c
Date:   Thu,  5 Dec 2019 17:53:21 -0500
Message-Id: <20191205225322.5529-3-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205225322.5529-1-alext9@gmail.com>
References: <20191205225322.5529-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pull logic for getting the full dwim ref name from a passed in ref name
out of the handle_fork_point function of merge-base.c. This will allow
git-rebase --fork-point to use the same method for getting the full ref
name before calling get_fork_point.

I saw other *_or_die methods in other places and using that pattern
seemed sane here.

I'm not 100% sure about the name or signature of dwim_ref_or_die. I feel
like it should be named something like dwim_ref_name_or_die,
unique_dwim_ref_or_die, or should be including the object_id argument
even though it isn't used by the calling merge_base code, and won't be
used in rebase.

This is my first patch submission for git, and I'd appreciate some
feedback on naming/style wrt to this.

Signed-off-by: Alex Torok <alext9@gmail.com>
---
 builtin/merge-base.c |  9 +--------
 refs.c               | 14 ++++++++++++++
 refs.h               |  1 +
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e3f8da13b6..edd16f9fcd 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -118,14 +118,7 @@ static int handle_fork_point(int argc, const char **argv)
 	struct commit *derived, *fork_point;
 	const char *commitname;
 
-	switch (dwim_ref(argv[0], strlen(argv[0]), &oid, &refname)) {
-	case 0:
-		die("No such ref: '%s'", argv[0]);
-	case 1:
-		break; /* good */
-	default:
-		die("Ambiguous refname: '%s'", argv[0]);
-	}
+	dwim_ref_or_die(argv[0], strlen(argv[0]), &refname);
 
 	commitname = (argc == 2) ? argv[1] : "HEAD";
 	if (get_oid(commitname, &oid))
diff --git a/refs.c b/refs.c
index 1ab0bb54d3..3b778f2df9 100644
--- a/refs.c
+++ b/refs.c
@@ -639,6 +639,20 @@ int dwim_ref(const char *str, int len, struct object_id *oid, char **ref)
 	return repo_dwim_ref(the_repository, str, len, oid, ref);
 }
 
+void dwim_ref_or_die(const char *str, int len, char **ref)
+{
+	struct object_id discard;
+	switch (dwim_ref(str, len, &discard, ref)) {
+	case 0:
+		die("No such ref: '%s'", str);
+	case 1:
+		break; /* good */
+	default:
+		die("Ambiguous refname: '%s'", str);
+	}
+}
+
+
 int expand_ref(struct repository *repo, const char *str, int len,
 	       struct object_id *oid, char **ref)
 {
diff --git a/refs.h b/refs.h
index 730d05ad91..a961662382 100644
--- a/refs.h
+++ b/refs.h
@@ -154,6 +154,7 @@ int repo_dwim_log(struct repository *r, const char *str, int len, struct object_
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
 
+void dwim_ref_or_die(const char *str, int len, char **ref);
 /*
  * A ref_transaction represents a collection of reference updates that
  * should succeed or fail together.
-- 
2.17.1

