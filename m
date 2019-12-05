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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A6EC43603
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1836C24670
	for <git@archiver.kernel.org>; Thu,  5 Dec 2019 22:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s4KqbQ+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfLEWzK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:55:10 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43475 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfLEWzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Dec 2019 17:55:10 -0500
Received: by mail-qk1-f193.google.com with SMTP id q28so4819966qkn.10
        for <git@vger.kernel.org>; Thu, 05 Dec 2019 14:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iHffExdsipN2HkGOkK2D4Cw6qCnJmlkaGmTRXZ7cCLA=;
        b=s4KqbQ+AisbdJzR2O5yXkedvPCZ02EPPIxLhBvcdhvOQjvuOnFGoZsYX2Gu/x9mDak
         2Z5R59mRLbmn8WIfufsZmnGcY45KHiRPfpXoCSQObtMHcg7iR1wPC1OGbrVX8ELB2fjK
         Mvgtr+isDWLb4taDrlVPp5CxJXNi5GPVc6uOkvqnZYsNnpcdcGFJMlBzsABodkvGitAK
         7ERvfzG2VE89C/VjY2miMXomqWGcylRwXJXvaRVWPjWahS18lcaOzm5B6xP2HkBKatnD
         cYKFsbMXhxYP5+/x/SW6REVlAQPAIOszijv9vrvTQpDYFThpww6OLpLY14JBzhbHTVN2
         5zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iHffExdsipN2HkGOkK2D4Cw6qCnJmlkaGmTRXZ7cCLA=;
        b=Rw4sTOqt2cuFHiLfnIJipXDdiyWJTOFyU/mA8EMYyaeX2z/O22i+6TfnspLrjebKjO
         KF4cyMq4DQ3n7fJL8k9eaWYix1TZlojM3spqaK4u5CcDNw4t85JDOXWU57N0YepGqemm
         aEhLNYA7XY5vKcLv7xq4Y8ZQOLMm+Cgv+S1Oy79erkZcRj6zao8tuP4w+joqzFpFwzt/
         H2Dg+rMlOM8cSIwBulYLiLjYo9gPA4DqNR9HKuRlbT5afyPjHF7rE7DByAdo2atM5BEW
         tbAiQZ4Y3xHOo+7pYUw1bjzqg7tPOMlHpbHbnazleID1VP+sHXLhX1VTKtjEfqmDiXik
         uEiA==
X-Gm-Message-State: APjAAAWQCQ0Ms13uBU3tZeuSPttr7mbFkcOONKGM7FmoIIulI5Y5llpr
        JXClMk8lq9ACAK0Ie6TTalwK3e+0QMA=
X-Google-Smtp-Source: APXvYqxUHVXmP3P3ZcKO71pfHJ5tVx74gXcEunyNU1P9ZK7CGBf8DocJRBCGL2ozz6EFzIZn2NG7Zg==
X-Received: by 2002:a05:620a:1249:: with SMTP id a9mr11027761qkl.147.1575586508505;
        Thu, 05 Dec 2019 14:55:08 -0800 (PST)
Received: from alex-torok-7530.int.uberatc.com ([216.99.208.249])
        by smtp.googlemail.com with ESMTPSA id f23sm5426066qke.104.2019.12.05.14.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2019 14:55:07 -0800 (PST)
From:   Alex Torok <alext9@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Torok <alext9@gmail.com>
Subject: [PATCH 3/3] rebase: fix rebase to use full ref to find fork-point
Date:   Thu,  5 Dec 2019 17:53:22 -0500
Message-Id: <20191205225322.5529-4-alext9@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205225322.5529-1-alext9@gmail.com>
References: <20191205225322.5529-1-alext9@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rebase --fork-point needs to look up the full ref name before calling
get_fork_point in the same manner that merge-base --fork-point does.

Signed-off-by: Alex Torok <alext9@gmail.com>
---
 builtin/rebase.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e755087b0f..821994f676 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1980,8 +1980,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		struct commit *head =
 			lookup_commit_reference(the_repository,
 						&options.orig_head);
+		char * full_name;
+		dwim_ref_or_die(options.upstream_name, strlen(options.upstream_name), &full_name);
 		options.restrict_revision =
-			get_fork_point(options.upstream_name, head);
+			get_fork_point(full_name, head);
 	}
 
 	if (repo_read_index(the_repository) < 0)
-- 
2.17.1

