Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B14B01F462
	for <e@80x24.org>; Thu, 25 Jul 2019 17:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbfGYRq3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jul 2019 13:46:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37833 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403803AbfGYRq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jul 2019 13:46:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id b3so23696650plr.4
        for <git@vger.kernel.org>; Thu, 25 Jul 2019 10:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=53fVpHZ+LyJ/i6jHMR5ePplq5egxpKeEUFZXjt8XBEg=;
        b=aUPwMFNCOX27EBvW94drHtyPGGocDWt4hIsB0McrB05iNxNnuukPCP+4QDHmx1r+od
         s8zU2+bHPJSod6sUeYUYlWlkArFEZg6heneHEmRnDCyE+rIRqcQ8t1PkdIaww3bbmjXe
         ElIDlUO7qgiNr+xaagNicJFESgIZekkKtTtQOh5jfYxKijYuFBCNK+E/j78YxCCVYHtw
         xQNVuLu5Innbg04x241QRuzyDSqO9qYMvUxkXElPIEidsVsCcSpNE8GowEtRfLWoEKyb
         4YUnGUxLve4pVnM1e6sL9lga5BO7LZSBcFfpVYq7WbVy2AB+KYdmPdIGGjMk3Hi7RMil
         RUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=53fVpHZ+LyJ/i6jHMR5ePplq5egxpKeEUFZXjt8XBEg=;
        b=ZKU/JAfCdhurSex9X3FZCtikUaf/OXQ5qGxZs2+v3rEr/ufKYoU70Lm3tmqu+QnKjB
         VCWmGXNv5Qiam0N0g62aWFiGku02NRLCVyLY5mCZtoeuIBWbjnnA479ee0PqQbD0G4D8
         o7Pqupk17fu3oooAnDABbbOdPhxDERMts5pEuYMCkiqJJyo+0YureMC2b+9mL0bACc8C
         ke3oD7R6DloZbRN/uJ4z3F5KeJDvotlDrlJF+WcYlbAz9N3aS280uPfw7R/3wLh9yQwB
         bTifDyi+ANNdokUYwWtPUxGEe0y6dxTFOvxLJllHnraAE6D6fHGVyNgfc3xsJ3Cinl5d
         ipSw==
X-Gm-Message-State: APjAAAVBEXx066nf33jK6yl88FrU9a19D1tz2j/ie67tpm8pvIAJnXDO
        dJquh2+p+nyCkoXRxfOadFDCLNXe
X-Google-Smtp-Source: APXvYqwqUuCB1B9nXPvtHUgtwqHW2Ql/OYSJEv4NdorO3m9hPCqFzg8Ui5gHev4Zi8rCA/j4s5BkRg==
X-Received: by 2002:a17:902:110b:: with SMTP id d11mr96093593pla.213.1564076786606;
        Thu, 25 Jul 2019 10:46:26 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id v138sm58171800pfc.15.2019.07.25.10.46.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jul 2019 10:46:26 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 10/19] merge-recursive: rename 'mrtree' to 'result_tree', for clarity
Date:   Thu, 25 Jul 2019 10:46:02 -0700
Message-Id: <20190725174611.14802-11-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.559.g28a8880890.dirty
In-Reply-To: <20190725174611.14802-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not at all clear what 'mr' was supposed to stand for, at least not
to me.  Pick a clearer name for this variable.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0a90546824..61faa26c4f 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3475,7 +3475,7 @@ static int merge_recursive_internal(struct merge_options *opt,
 {
 	struct commit_list *iter;
 	struct commit *merged_merge_bases;
-	struct tree *mrtree;
+	struct tree *result_tree;
 	int clean;
 
 	if (show(opt, 4)) {
@@ -3545,14 +3545,15 @@ static int merge_recursive_internal(struct merge_options *opt,
 				     repo_get_commit_tree(opt->repo, h2),
 				     repo_get_commit_tree(opt->repo,
 							  merged_merge_bases),
-				     &mrtree);
+				     &result_tree);
 	if (clean < 0) {
 		flush_output(opt);
 		return clean;
 	}
 
 	if (opt->call_depth) {
-		*result = make_virtual_commit(opt->repo, mrtree, "merged tree");
+		*result = make_virtual_commit(opt->repo, result_tree,
+					      "merged tree");
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-- 
2.22.0.559.g28a8880890.dirty

