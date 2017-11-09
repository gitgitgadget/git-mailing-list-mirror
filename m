Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BCB01F442
	for <e@80x24.org>; Thu,  9 Nov 2017 13:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754738AbdKINrT (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Nov 2017 08:47:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53299 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754268AbdKINrS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Nov 2017 08:47:18 -0500
Received: by mail-wm0-f67.google.com with SMTP id s66so2011144wmf.2
        for <git@vger.kernel.org>; Thu, 09 Nov 2017 05:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+GJMd0KMVRApBaW4NbcaqhFsXLlP7jQGQ8O8+h7KwE0=;
        b=q9m8fxSi1ZTob29FzBZi8CfvMjewA2q9ZAB4cJPovdkXxNk+IFD/rZSQrZyH6mXnWg
         huT5qNs3soNnn+F6a/Fi4gjsSNxGz4vjHSlkPq8L7LEeb5tfB11BUGGeDwVg8sSxoUNk
         Qj2zo7zOBLT54UD86yeKesZIFhg+O3hlLn1MM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+GJMd0KMVRApBaW4NbcaqhFsXLlP7jQGQ8O8+h7KwE0=;
        b=NaDPpPeOFR05hpHoEZVW8J0otm0jT5YBUPTsNrtWmheK5Lyn5LibCzZ+jbpy/L2oQR
         XoTigMeGF4+PdOzcDyiyyPog4jgUSs0Q2NfJr1aKicA/b+v6o98XCeStRgI0QjUltFhu
         0/zEcVP5bT0Ld5EZyoRimIcK2IduhWIwc0GdgJZc/IUPfAbAWBioWGWPpWYXn2wBk1/D
         8TrmbafCCLz5kA1OtR8nZbfThlgqORhoDe7ABYcIVovake9qYOlhuthQqpbIrVo04uja
         Kk0m5R93qxcabVFD229Uh99A/8p/a1y+aztYM2eRC+2Q89fvNWOKeSJkEa3g4Iydz/dq
         dEvQ==
X-Gm-Message-State: AJaThX61YBv0m1nEL55pzC4RjAj5rv/5F89hz/LVGBpfXoGxlaFImx81
        gGpFNJe9p0ZDAbZWsjjuKzztU/OZgSc=
X-Google-Smtp-Source: AGs4zMbbyycqbsXr4VstnFC0R6aNUWvFdPiUDujcA9HIWgD+OInOhzSLXRkVsr/ehj1VhWj2FEZakg==
X-Received: by 10.28.8.145 with SMTP id 139mr430760wmi.115.1510235236427;
        Thu, 09 Nov 2017 05:47:16 -0800 (PST)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:993:9a1f:de68:e37a])
        by smtp.gmail.com with ESMTPSA id 56sm3263400wrx.2.2017.11.09.05.47.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Nov 2017 05:47:15 -0800 (PST)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Johan Herland <johan@herland.net>
Subject: [PATCH] notes: add `rm` and `delete` commands
Date:   Thu,  9 Nov 2017 13:46:17 +0000
Message-Id: <20171109134617.65244-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add `git notes rm` and `git notes delete` as alternative ways of saying
`git notes remove`.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---
 Documentation/git-notes.txt | 4 +++-
 builtin/notes.c             | 8 +++++---
 t/t3301-notes.sh            | 6 +++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 43677297f..b1059dc85 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -17,7 +17,7 @@ SYNOPSIS
 'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
-'git notes' remove [--ignore-missing] [--stdin] [<object>...]
+'git notes' (remove|rm|delete) [--ignore-missing] [--stdin] [<object>...]
 'git notes' prune [-n | -v]
 'git notes' get-ref
 
@@ -110,6 +110,8 @@ When done, the user can either finalize the merge with
 'git notes merge --abort'.
 
 remove::
+rm::
+delete::
 	Remove the notes for given objects (defaults to HEAD). When
 	giving zero or one object from the command line, this is
 	equivalent to specifying an empty note message to
diff --git a/builtin/notes.c b/builtin/notes.c
index 12afdf190..cedb37535 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -32,7 +32,7 @@ static const char * const git_notes_usage[] = {
 	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
 	N_("git notes merge --commit [-v | -q]"),
 	N_("git notes merge --abort [-v | -q]"),
-	N_("git notes [--ref <notes-ref>] remove [<object>...]"),
+	N_("git notes [--ref <notes-ref>] (remove|rm|delete) [<object>...]"),
 	N_("git notes [--ref <notes-ref>] prune [-n | -v]"),
 	N_("git notes [--ref <notes-ref>] get-ref"),
 	NULL
@@ -77,7 +77,7 @@ static const char * const git_notes_merge_usage[] = {
 };
 
 static const char * const git_notes_remove_usage[] = {
-	N_("git notes remove [<object>]"),
+	N_("git notes (remove|rm|delete) [<object>]"),
 	NULL
 };
 
@@ -1012,7 +1012,9 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 		result = show(argc, argv, prefix);
 	else if (!strcmp(argv[0], "merge"))
 		result = merge(argc, argv, prefix);
-	else if (!strcmp(argv[0], "remove"))
+	else if (!strcmp(argv[0], "remove") ||
+		 !strcmp(argv[0], "rm") ||
+		 !strcmp(argv[0], "delete"))
 		result = remove_cmd(argc, argv, prefix);
 	else if (!strcmp(argv[0], "prune"))
 		result = prune(argc, argv, prefix);
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 2d200fdf3..50df9a3f9 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -353,9 +353,9 @@ test_expect_success 'create note with combination of -m and -F' '
 	test_cmp expect-combine_m_and_F actual
 '
 
-test_expect_success 'remove note with "git notes remove"' '
+test_expect_success 'remove note with "git notes remove/rm"' '
 	git notes remove HEAD^ &&
-	git notes remove &&
+	git notes rm &&
 	cat >expect-rm-remove <<-EOF &&
 		commit 7f9ad8836c775acb134c0a055fc55fb4cd1ba361
 		Author: A U Thor <author@example.com>
@@ -390,7 +390,7 @@ test_expect_success 'removing more than one' '
 	# We have only two -- add another and make sure it stays
 	git notes add -m "extra" &&
 	git notes list HEAD >after-removal-expect &&
-	git notes remove HEAD^^ HEAD^^^ &&
+	git notes delete HEAD^^ HEAD^^^ &&
 	git notes list | sed -e "s/ .*//" >actual &&
 	test_cmp after-removal-expect actual
 '
-- 
2.14.3

