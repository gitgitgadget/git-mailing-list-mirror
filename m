Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A50D1F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 14:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750955AbdBDObW (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 09:31:22 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35280 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750890AbdBDObV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 09:31:21 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so4597086pge.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 06:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M4fJ/WUsoq9K1KTw1DjhmIlgT5r4ktXXGXezR9BOTFU=;
        b=lJo8Yuw0ALTG0/W3ftKDw+Oo08xwiJLMb1l1jJJcnBQQXr4MuMtVV9VBc7SFsqYxC3
         i81qwJBjb9Sk6+El3qMUf3CHvNi5LpbY37wdpgi22QDucRXqECo/0VgkT7NMMjHIF4a0
         4nkNxm0JQJ9DyCgcfymJf5vQgiVxVn6d/6hXvqZMJtXPedRhLIaEEbJy/XLDA5gM8RtT
         MNCH71HzKEzElLma4xf5EZpANU2ZbkiJ49s8VilDvDn5/7stOF1OaRndnr5/OGIgfJS0
         rnjtTR4+NGBuGklbHHXn92Rya1Xf5X3PfpR3SEIl0sBSmxPICYKnVKfcF6j26GM+wQxG
         T+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M4fJ/WUsoq9K1KTw1DjhmIlgT5r4ktXXGXezR9BOTFU=;
        b=WOfkh06sjJbzShvzE7Ivdxl61x90r8qeOeV/uMmWLzx+eXLrZMfGqazxxX95/LFt4W
         9YPRl9zQaWChIMH3DSPClLRiA9QrGmD7gnJUjveSnWoeS7Q5l0qSnJqwj4j+nKC4Tu7x
         5GDo+FBXPuq0LF5/1t+iJbWr4zuYCrnEP9ElfRTbD7TQfpJDtQKWOObsqapxsMHib0vF
         RPTTXTNjIuzRcaJqAlwPwSEC7XL857EFOa2e6AqOu+MGxAEoImeGmdBxnbY+2173Ho+f
         R1F6X1bFnINKiwQy5Ct8qLD7oSAiHMSR7lJJT7XQhSSxpeKn7za2Lj82G+Szw0E5N7eX
         WWdw==
X-Gm-Message-State: AIkVDXK3O/TtgTCqc3Pcek9Uhtn1MX8snBoEdLZSFCfkoiE1IjNIgGwYP+BUexrrhkBccw==
X-Received: by 10.98.137.73 with SMTP id v70mr2860796pfd.125.1486218680961;
        Sat, 04 Feb 2017 06:31:20 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id i82sm75743318pfk.52.2017.02.04.06.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Feb 2017 06:31:20 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     pranit.bauva@gmail.com,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH v3] parse-remote: remove reference to unused op_prep
Date:   Sat,  4 Feb 2017 14:31:03 +0000
Message-Id: <1486218663-31820-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error_on_missing_default_upstream helper function learned to
take op_prep argument with 15a147e618 ("rebase: use @{upstream}
if no upstream specified", 2011-02-09), but as of 045fac5845
("i18n: git-parse-remote.sh: mark strings for translation",
 2016-04-19), the argument is no longer used.  Remove it.

Signed-off-by: Siddharth Kannan <kannan.siddharth12@gmail.com>
---
Thanks a lot for the review, Pranit and Junio! I have made the appropriate
changes, and the edit to the file inside contrib/examples/ has been removed from
this patch.

 git-parse-remote.sh | 3 +--
 git-rebase.sh       | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index d3c3998..9698a05 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -56,8 +56,7 @@ get_remote_merge_branch () {
 error_on_missing_default_upstream () {
 	cmd="$1"
 	op_type="$2"
-	op_prep="$3" # FIXME: op_prep is no longer used
-	example="$4"
+	example="$3"
 	branch_name=$(git symbolic-ref -q HEAD)
 	display_branch_name="${branch_name#refs/heads/}"
 	# If there's only one remote, use that in the suggestion
diff --git a/git-rebase.sh b/git-rebase.sh
index 04f6e44..b89f960 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -448,7 +448,7 @@ then
 		then
 			. git-parse-remote
 			error_on_missing_default_upstream "rebase" "rebase" \
-				"against" "git rebase $(gettext '<branch>')"
+				"git rebase $(gettext '<branch>')"
 		fi
 
 		test "$fork_point" = auto && fork_point=t
-- 
2.1.4

