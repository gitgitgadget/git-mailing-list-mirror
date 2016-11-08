Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 896CE2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933233AbcKHUMd (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 15:12:33 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33435 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932468AbcKHUMa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 15:12:30 -0500
Received: by mail-pf0-f195.google.com with SMTP id 144so12330980pfv.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 12:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5TxhUJvgtL3ngIBrU7NfKHzz2O/C1FNSFhE+O5LlZzQ=;
        b=wdrC4OK0ohKspR8mLiFlFl949TQ2ivR3IDp+ZZglN0Co7fbsoZMe+DqMzszGNn0wK8
         NECxbsGWGFwFaD0Un6K1CdFar4RwHQa014jPC+iefvGwP0Ph2XN5IriPe+NZoHd9fTxi
         kXui58No33JFg+oTJ0dkRhFe0JK4BkWA2HdEBe/XC3DT8khOttxRBc2gSeMCNNgjSoOj
         RNtA3lN1B4Ztua/BHfwk4yQsxRr3NyYrHqX27X4sK0VYJHky5PHAdIHFwMzFSpZr4KJ6
         b9DYFDSdqxPEza/1tRDuiJsOuyskeNnuoqWFxN9G2qZBpAv8/0g0Buk3+/C9waUiQ/9Z
         fGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5TxhUJvgtL3ngIBrU7NfKHzz2O/C1FNSFhE+O5LlZzQ=;
        b=PbhNWnV1B9zL54R4YdhNwosVklZrdH7VpqC1O1Zm2+G27R2goNSVYuU0oAh0MFJuAu
         lDfZdYKZtT6EBSSHBdf07hqOPz6HClvDUlo3AI0DDbsrTczDbJ7Bo3ANJdjqSf3+T6sA
         GHK3/qR7OYO7HUbgTJYmSdWPa7hRTnOf0FrURkXNBn+1Y4Jo4B+hTfkcRSfNhe/o8CXZ
         nWM2z/9L6MepKwqPmJI9+hdTX7eLWuulD/HrHkoV+eQbzNCWEV6s+5sngiA1rHBcrprv
         U+KK8Mr6nNGU8RR1uAUQ1JJkEQXxTWFSXWl9iNh/fM2fosVmA6DC0Yty8aA4KvN/DWi7
         BlQQ==
X-Gm-Message-State: ABUngvewcPvql1XAAFvB58fJvBwjJbNFVlRPwpt7zC3fWnOiPA4sT+Sm3urQmst26s0JNA==
X-Received: by 10.99.198.6 with SMTP id w6mr21218782pgg.35.1478635944813;
        Tue, 08 Nov 2016 12:12:24 -0800 (PST)
Received: from localhost.localdomain ([27.5.65.216])
        by smtp.gmail.com with ESMTPSA id hv3sm50239466pad.30.2016.11.08.12.12.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Nov 2016 12:12:24 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v7 07/17] ref-filter: make %(upstream:track) prints "[gone]" for invalid upstreams
Date:   Wed,  9 Nov 2016 01:42:01 +0530
Message-Id: <20161108201211.25213-8-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161108201211.25213-1-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Borrowing from branch.c's implementation print "[gone]" whenever an
unknown upstream ref is encountered instead of just ignoring it.

This makes sure that when branch.c is ported over to using ref-filter
APIs for printing, this feature is not lost.

Make changes to t/t6300-for-each-ref.sh and
Documentation/git-for-each-ref.txt to reflect this change.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Helped-by : Jacob Keller <jacob.keller@gmail.com>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt | 3 ++-
 ref-filter.c                       | 4 +++-
 t/t6300-for-each-ref.sh            | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 92184c4..fd365eb 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -119,7 +119,8 @@ upstream::
 	"[ahead N, behind M]" and `:trackshort` to show the terse
 	version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
 	or "=" (in sync).  Has no effect if the ref does not have
-	tracking information associated with it.
+	tracking information associated with it. `:track` also prints
+	"[gone]" whenever unknown upstream ref is encountered.
 
 push::
 	The name of a local ref which represents the `@{push}` location
diff --git a/ref-filter.c b/ref-filter.c
index b8b8a95..6d51b80 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1049,8 +1049,10 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
 		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
 	else if (atom->u.remote_ref == RR_TRACK) {
 		if (stat_tracking_info(branch, &num_ours,
-				       &num_theirs, NULL))
+				       &num_theirs, NULL)) {
+			*s = "[gone]";
 			return;
+		}
 
 		if (!num_ours && !num_theirs)
 			*s = "";
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 2be0a3f..a92b36f 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -382,7 +382,7 @@ test_expect_success 'Check that :track[short] cannot be used with other atoms' '
 
 test_expect_success 'Check that :track[short] works when upstream is invalid' '
 	cat >expected <<-\EOF &&
-
+	[gone]
 
 	EOF
 	test_when_finished "git config branch.master.merge refs/heads/master" &&
-- 
2.10.2

