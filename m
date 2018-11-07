Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FCAC1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 22:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeKHIaU (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 03:30:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40324 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeKHIaU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 03:30:20 -0500
Received: by mail-wr1-f65.google.com with SMTP id i17-v6so19163357wre.7
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 14:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7PLdlXZBlCsLokckW9VL/34w9HFmJJD+xIqFfQqkcc=;
        b=jU2C8UY6j6IaAji1LulLxICl5ep0SZWMwYBMPzKUUvItHA5f+eeD47wsq6jC2f8Ija
         4M2D/u74SacAdRl+qtKP6YMnXk1nNOLXpMVEUrVBRtFtd8ekcCGAncallW5x6SXJfxYM
         Re2KaqlfQkxkY2DRGFf5qDr+7JDw96trkMmVqSgTdUCYzcaGXNPxz0yQ9y06RUsH4MZG
         1TwKzNqQg9mqe8OTOGM40/dMZqAwUgZZobUvclUOxHDCLnxOYYLkiOuzcynamcmOjlYY
         wUieeJAxabzA8T1sR/DnOfe0/aLOPBEKZn8PITH9aw5XQApK57Z3l4UppNPhD7abOEaL
         vTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7PLdlXZBlCsLokckW9VL/34w9HFmJJD+xIqFfQqkcc=;
        b=RCpkS9DTH8DOSS6RKSNHoRUzH/VaTrG+37ihMY1fQ2X7OJ8tDoOdL12QAgnENxu/wV
         hn+8FY2oJOn4sdqVM2HbowYGfJgTzd0xuoCBW+q6roNybl8OxN31gUlAFXwybYJq0FKR
         mnj3u7lepLpZ/JYfOFvrZp79f4fMiHxws/Bf0w5H0tSEfdQ1VDQV4eIF9fRiRKFAWR57
         0+ys0uFo28N9L6qCpUzLpLHSXA1vV7wi/JUaDI+DGT8vw+cYWk6t4U79Gzr/MPDtaBDi
         O6ojnk8NxMo8UTaSJv7beDZfViYjpfiUy4mrlzB5Q7O7xRAUKJIwpwyH1b9fxzYZXoKx
         vbxA==
X-Gm-Message-State: AGRZ1gJTtYhbCf5fZLD02DPaKtE/9C2n6zS2pY9cUNI82FSs/X2UN8eG
        /DREXm3h5CwMBm6zy6mm8tA=
X-Google-Smtp-Source: AJdET5f742yglCMgqRmKCNkfj69+r0rdB6LJ7VsxmehbZ/38ACh6f2ZGmw14eB1T9xE6CF61y7WOfw==
X-Received: by 2002:adf:fdc8:: with SMTP id i8-v6mr2039393wrs.276.1541631466052;
        Wed, 07 Nov 2018 14:57:46 -0800 (PST)
Received: from localhost.localdomain (236.209.54.77.rev.vodafone.pt. [77.54.209.236])
        by smtp.gmail.com with ESMTPSA id z7-v6sm2374619wrv.21.2018.11.07.14.57.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 14:57:45 -0800 (PST)
From:   =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
To:     daniels@umanovskis.se
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: [PATCH] branch: make --show-current use already resolved HEAD
Date:   Wed,  7 Nov 2018 22:56:18 +0000
Message-Id: <20181107225619.6683-1-rafa.almas@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181025190421.15022-1-daniels@umanovskis.se>
References: <20181025190421.15022-1-daniels@umanovskis.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

print_current_branch_name() tries to resolve HEAD and die() when it
doesn't resolve it successfully. But the conditions being tested are
always unreachable because early in branch:cmd_branch() the same logic
is performed.

Eliminate the duplicate and unreachable code, and update the current
logic to the more reliable check for the detached head.

Signed-off-by: Rafael Ascensão <rafa.almas@gmail.com>
---

This patch is meant to be either applied or squashed on top of the
current series.

I am basing the claims of it being more reliable of what Junio suggested
on a previous iteration of this series:
https://public-inbox.org/git/xmqq4ldtgehs.fsf@gitster-ct.c.googlers.com/

But the main goal of this patch is to just bring some attention to this,
as I mentioned it in a previous thread but it got lost. After asking on
#git-devel, the suggestion was to send it as an incremental patch. So
here it is. :)

I still think the mention about scripting should be removed from the
original commit message, leaving it open to being taught other tricks
like --verbose that aren't necessarily script-friendly.

Cheers

 builtin/branch.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 46f91dc06d..1c51d0a8ca 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -38,6 +38,7 @@ static const char * const builtin_branch_usage[] = {
 
 static const char *head;
 static struct object_id head_oid;
+static int head_flags = 0;
 
 static int branch_use_color = -1;
 static char branch_colors[][COLOR_MAXLEN] = {
@@ -443,21 +444,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
 	free(to_free);
 }
 
-static void print_current_branch_name(void)
-{
-	int flags;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, &flags);
-	const char *shortname;
-	if (!refname)
-		die(_("could not resolve HEAD"));
-	else if (!(flags & REF_ISSYMREF))
-		return;
-	else if (skip_prefix(refname, "refs/heads/", &shortname))
-		puts(shortname);
-	else
-		die(_("HEAD (%s) points outside of refs/heads/"), refname);
-}
-
 static void reject_rebase_or_bisect_branch(const char *target)
 {
 	struct worktree **worktrees = get_worktrees(0);
@@ -668,10 +654,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	track = git_branch_track;
 
-	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
+	head = resolve_refdup("HEAD", 0, &head_oid, &head_flags);
 	if (!head)
 		die(_("Failed to resolve HEAD as a valid ref."));
-	if (!strcmp(head, "HEAD"))
+	if (!(head_flags & REF_ISSYMREF))
 		filter.detached = 1;
 	else if (!skip_prefix(head, "refs/heads/", &head))
 		die(_("HEAD not found below refs/heads!"));
@@ -716,7 +702,8 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			die(_("branch name required"));
 		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
 	} else if (show_current) {
-		print_current_branch_name();
+		if (!filter.detached)
+			puts(head);
 		return 0;
 	} else if (list) {
 		/*  git branch --local also shows HEAD when it is detached */
-- 
2.19.1

