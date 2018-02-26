Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SORTED_RECIPS,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0F6D1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 10:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeBZKbO (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:31:14 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37070 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752353AbeBZKbH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:31:07 -0500
Received: by mail-pg0-f67.google.com with SMTP id y26so6009797pgv.4
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/L8DPG0dZ5QGxQ3EpcLf/Um9+/MMx0AxB2aKssL+M8=;
        b=PH7mMJD2PaYq2c/2RR5U+xDUcUD0U3YIThKD/OINxZD8bS1kFo295jIgmII4TPz27M
         IOmtRLSLLmPNgX7DUDpQr39Q4ESMqiQwAemJ9PhJuKJDOhbCj7l65qhHE+xBloxoR3Kf
         aG+0V56y1DU3MaV3OckMFgCZKkPqEHoFeopyMF09WkWZrdezPfUbxEt+6VTPCSLK57nH
         jxrtjUEdTcSb3i/IBLfXvbVcGT1mHglkNuK+9hHdPguK+WZsR8pFPhmyzTQVPnedzYSf
         EUXOZFY2aiwmKsOJQqxTTIzueJGxtj6lYXgbA+razN3JAKBThE5SlMIhgROlVo27mnoA
         BL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/L8DPG0dZ5QGxQ3EpcLf/Um9+/MMx0AxB2aKssL+M8=;
        b=T7qsdR7cBRzRbG541INTQEWZMx4RRvkO0S5Yu9X3AwVRUyNE+sSVb0e39n1FST8s2q
         1V9fFk7KGGjp3LLJrMj9QhO5idgfGX7T1dsvSY9RDCKX7MbUPs3iifliKBSXD3crnwSG
         iFJaiB8tAwGe18MBqNFsVDtmS5zyzag8mdpbP81ImSMfiO+WRoOKtNA/jNQVIebG5ajf
         iCI8ichw9KzGnZS7oOIJUTdCNF+mLIRb+PIXDtS4rLtbNEETu7BAprTF4Dlz5nss6g+Y
         14mM96BR/aTq9QI4KgQYpTuvIGSTPaXDBe0JqSC1dw2mkpwivyyX1A+IZ9IwNfFXbMVu
         okAw==
X-Gm-Message-State: APf1xPCK/L/koPvnub1YA9tSUeqRAy9A1/K7UjUjYXVQhk8JycDp1p+h
        lSQPBJ0UjboHudaoRvwpDQw=
X-Google-Smtp-Source: AH8x226eP1VgbolNqCQYILBMbjGyqX2lJfaYqjxVnG83J8PJ0Row2nO11I2SNwVhjaGCdB2x+H2uxQ==
X-Received: by 10.99.103.195 with SMTP id b186mr8060145pgc.446.1519641066905;
        Mon, 26 Feb 2018 02:31:06 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id p63sm16766311pfk.74.2018.02.26.02.31.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Feb 2018 02:31:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Mon, 26 Feb 2018 17:31:01 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        pclouds@gmail.com, sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH 4/4] repository: delete ignore_env member
Date:   Mon, 26 Feb 2018 17:30:30 +0700
Message-Id: <20180226103030.26900-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180226103030.26900-1-pclouds@gmail.com>
References: <20180214180814.GA139458@google.com>
 <20180226103030.26900-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This variable was added because the repo_set_gitdir() was created to
cover both submodule and main repos, but these two are initialized a
bit differently so ignore_env == 0 means main repo, while ignore_env
!= 0 is submodules.

Since the difference part (env variables) has been moved out of
repo_set_gitdir(), this function works the same way for both repo
types and ignore_env is not needed anymore.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 repository.c | 4 +---
 repository.h | 9 ---------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/repository.c b/repository.c
index 19532ec5ff..8f6386022f 100644
--- a/repository.c
+++ b/repository.c
@@ -12,7 +12,7 @@ static struct repository the_repo = {
 	NULL, NULL, NULL,
 	&the_index,
 	&hash_algos[GIT_HASH_SHA1],
-	0, 0
+	0
 };
 struct repository *the_repository = &the_repo;
 
@@ -134,8 +134,6 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
 	struct repository_format format;
 	memset(repo, 0, sizeof(*repo));
 
-	repo->ignore_env = 1;
-
 	INIT_LIST_HEAD(&repo->objects.packed_git_mru);
 
 	if (repo_init_gitdir(repo, gitdir))
diff --git a/repository.h b/repository.h
index b1da2a6384..07e8971428 100644
--- a/repository.h
+++ b/repository.h
@@ -73,15 +73,6 @@ struct repository {
 	const struct git_hash_algo *hash_algo;
 
 	/* Configurations */
-	/*
-	 * Bit used during initialization to indicate if repository state (like
-	 * the location of the 'objectdir') should be read from the
-	 * environment.  By default this bit will be set at the begining of
-	 * 'repo_init()' so that all repositories will ignore the environment.
-	 * The exception to this is 'the_repository', which doesn't go through
-	 * the normal 'repo_init()' process.
-	 */
-	unsigned ignore_env:1;
 
 	/* Indicate if a repository has a different 'commondir' from 'gitdir' */
 	unsigned different_commondir:1;
-- 
2.16.1.435.g8f24da2e1a

