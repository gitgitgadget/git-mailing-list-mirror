Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6104C201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:27:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751207AbdBWI1b (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:27:31 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36486 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdBWI1b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:27:31 -0500
Received: by mail-it0-f66.google.com with SMTP id w185so1563074ita.3
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 00:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m+9Ox5iJ8S8zO4XXKAPIWt0VOhvpChmAHb74NmF7glk=;
        b=ohsq54CXskxI81wRyul5yIparQ1/vhIdaBupWEt2FWcoXooMNa3C27oSjAVnhnKJlI
         OrQyl2ei+4QbrSRCOjm7b4LXhg74tsZXw2SoSwx1MyZve7aeS0xOt94CCEIQ4Gq7GS7A
         /lMCYr4TepXZzaqiqCF0OSxA4PAdsCO5/Bz9xMeZ8+wKbEqfDJtXH11pASQD+3rbmUNT
         m/IKOUnQ1Rk3pMryriWEj9waOUfsX6XRei2NdV6flHw+tfZMyuvEZNzsT4PVI7G6/+RV
         CDrFV7yhroGX6gEUIDNUTtAW62mjc8xcYgTfA4VOgB7rPybuWLmwFWVyAU47nMtQ4TXs
         g5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m+9Ox5iJ8S8zO4XXKAPIWt0VOhvpChmAHb74NmF7glk=;
        b=HO7rHoEZH4uDoUGF3EndBuI1r0ZP46zM9HMjdAiCPKFutZ6GXGGrAjLeZevmGfrhTO
         6DsnYLzt1x3En7KvfJGKAJkLDrjjB4/X7gjC+GdnzL31NB/K2YywwWMqSof7eGbEkDla
         yZae8zyA9CKJYd6zL15m8OiRhcfKoSIW46nbU7W9U6Bt8s3gCKg0OcmeNnC/SPdfOx79
         sNoVjLypTTOX99TUsXSlA/80IbEr2AP31LVVXmNmNvtXOLHjuWfecWn1cg3Ejx7e59Fx
         ILwzXodNJDze9G6a2XudovcLW29fhDyignw9HX+/I11yaBcS+KL+zZkV4LsuI7YhnFQR
         KKxw==
X-Gm-Message-State: AMke39n7qQG+8XLuQvG+JKebyWf83XUBX5twsMqONgUIpIBPWVZi3sHMSLZD/X7vR1Mrnw==
X-Received: by 10.36.213.3 with SMTP id a3mr1760831itg.30.1487838450007;
        Thu, 23 Feb 2017 00:27:30 -0800 (PST)
Received: from prospect.wheaton.edu (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id e126sm1779353itb.18.2017.02.23.00.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 00:27:29 -0800 (PST)
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     git@vger.kernel.org
Cc:     "Devin J. Pohly" <djpohly@gmail.com>
Subject: [PATCH 2/4] t7003: ensure --prune-empty removes entire branch when applicable
Date:   Thu, 23 Feb 2017 02:27:34 -0600
Message-Id: <20170223082736.31283-2-djpohly@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170223082736.31283-1-djpohly@gmail.com>
References: <20170223082736.31283-1-djpohly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sanity check before changing the logic in git_commit_non_empty_tree.

Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
---
 t/t7003-filter-branch.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index 2dfe46250..7cb60799b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -371,6 +371,13 @@ test_expect_success '--prune-empty is able to prune root commit' '
 	test_cmp expect actual
 '
 
+test_expect_success '--prune-empty is able to prune entire branch' '
+	git branch prune-entire B &&
+	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t B.t" prune-entire &&
+	test_path_is_missing .git/refs/heads/prune-entire &&
+	test_must_fail git reflog exists refs/heads/prune-entire
+'
+
 test_expect_success '--remap-to-ancestor with filename filters' '
 	git checkout master &&
 	git reset --hard A &&
-- 
2.11.1

