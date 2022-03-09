Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8490AC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbiCINSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiCINSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B26105A9B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:48 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id i8so2980657wrr.8
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVYpo1KgbYbl9ylNUepqtec7JP7ElijGpXN7W5fdH14=;
        b=JI2GsLhstfmKZr/fnIIaQ3NmdNmVNkVyKwTREUKw7JKmpiFsZlcLVUG1EJPQP8xhFS
         Z3o9cokufa8b6Ey4sYeef06dp1NiaUk4IJLtqiNUexJK8qclA56uBl8jyxJHaK8ROWjj
         09N0l/jkAzhJuIX8DOARHjxwP0CHzt0PXAtMqbg3FLyw0xpZUg2rRmofvbjVKe4MYdKc
         3OgEGIRXw7IoQo7FGA4b99CSBk4LstYWMb6vokVcyiZIqhtxO/X/SuwLGy3kGwA4tbl0
         GAkzkWeDcW5TKkT4217BIzrAj+acHhttKTIls6TZC4W5FFbw1qr0Emsb3NSu8Qf1PGOj
         FIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVYpo1KgbYbl9ylNUepqtec7JP7ElijGpXN7W5fdH14=;
        b=XAfc0k1kf2dL+rHX3DLm6hij5QClbHn7+1ak1PCPtMiwiDfuTEl0Rsuk0ZU02cWwVn
         mmEVu8esHFn490wpWV7G08hKbxYQwULAZ5kY9E7NVwD9+qf0UQjo1GkaILfwnSikIAYu
         Ja8g4v18K/pQSbYCwMjCeQHH/utn64c/h8fg3kbypah56ZLFkAYOUlBBDQ5DnJ7EjmKh
         AiVnEXuNH9Zi5BsVSOz52o5POZQwLa64vgDSXf3lFPz6lC2w0cQWktbfSPylSkaLrcfk
         6Mp+IaEmDsmLlrbGOo8c3AqwEOgYUBxYJL4NL+sJNH46/q1G+SShZIB+k91zkNVZOp+b
         PZyQ==
X-Gm-Message-State: AOAM532uZIHikw0T6aupJj/9CkIYmfKPWSG6gxzYKA/H5m0vtHRSfznd
        2e55aNYz3dZeMuNUChXD8cZjpmJ+zeOSFA==
X-Google-Smtp-Source: ABdhPJwJt3p/u145gpp7F3lNU1+ZgqwGgSuDGH2ltZqCAdPgQsmuEWTNxjOgPdeLGiaMZiKzNoea0w==
X-Received: by 2002:adf:d211:0:b0:203:8141:4db6 with SMTP id j17-20020adfd211000000b0020381414db6mr405611wrh.706.1646831867093;
        Wed, 09 Mar 2022 05:17:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm2599988wri.0.2022.03.09.05.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 05:17:46 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/24] revision.[ch]: split freeing of revs->commit into a function
Date:   Wed,  9 Mar 2022 14:16:34 +0100
Message-Id: <patch-04.24-763e0ab3425-20220309T123321Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1295.g6b025d3e231
In-Reply-To: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the existing code for invoking free_commit_list() and setting
revs->commits to NULL into a new release_revisions_commit_list()
function. This will be used as part of a general free()-ing mechanism
for "struct rev_info".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 2bb913f2f3f..5824fdeddfd 100644
--- a/revision.c
+++ b/revision.c
@@ -2916,6 +2916,16 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	return left;
 }
 
+static void release_revisions_commit_list(struct rev_info *revs)
+{
+	struct commit_list *commits = revs->commits;
+
+	if (!commits)
+		return;
+	free_commit_list(commits);
+	revs->commits = NULL;
+}
+
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
 {
 	struct commit_list *l = xcalloc(1, sizeof(*l));
@@ -4073,10 +4083,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * boundary commits anyway.  (This is what the code has always
 	 * done.)
 	 */
-	if (revs->commits) {
-		free_commit_list(revs->commits);
-		revs->commits = NULL;
-	}
+	release_revisions_commit_list(revs);
 
 	/*
 	 * Put all of the actual boundary commits from revs->boundary_commits
-- 
2.35.1.1295.g6b025d3e231

