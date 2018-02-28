Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550D41F404
	for <e@80x24.org>; Wed, 28 Feb 2018 01:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751646AbeB1Bhr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 20:37:47 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37357 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbeB1Bhq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 20:37:46 -0500
Received: by mail-pf0-f194.google.com with SMTP id s24so364341pfm.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 17:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ga+CloHc78UkYclVUCDtqE1ilNeNRAbzYCTN9t2w2+A=;
        b=Aqa2tlKk/kmL8CwCoNDhUkQ79fYAv48en4miAq7ABmVOn4i3nOv3keLRFt5NycSqXF
         biJQpz4Lt5YiRUHRtQl34KsKsh7X0b/s/aKQsGBn+OY4F0P0kMTjJwwXRPD1uCVQugDC
         OZkvBzZKtSUyxa90CJ79cIKWd1YuP+K5tkjf+doCrwJHmzQTGXcP8hiqGHH1ks+SEE3F
         97alL0TS0p9OQRoi+tHa8iRQIs/vE3sSZiEw92mEAoajixsHvDND+ftOu1sklqrfe8oH
         8FWRiOnrKeKqyuj1nDfgXfgHyG4UM6l/UPX//2r2N6Ae2cAtO77zUK2SH4nmiiXGyaf3
         ODiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ga+CloHc78UkYclVUCDtqE1ilNeNRAbzYCTN9t2w2+A=;
        b=mgqFdrHb9zMoMcW2kD+jvcYnpslrxE45Qu+d6Avaum3JMXAkIYBd/koH8t0bKYgnsQ
         nfTTeIkgDo56uSAOjp3X5d+RtYfPxxeCcL8GRWPlvErwL6BBWrenQ10tQ8T6yWDvc0Rb
         coIZQtUrrYPUMWPpz8O3SeO2FDBbsDySFvFUF3ABWVyObr4Xoo0UxF7zTrut1hE1alD6
         boOuISiSY8XfbtQ+FllGPKX2ELVdrGMaEKgzrqYwerrLWDCRzx1BXsI2oxDaAkeA7t7a
         UGOxCN8IkGNACEEn/+Oh9QYq3uVpYWt0o9mmxBSm+oYkh4M8Skb9+lwRTXpdpIbqi+HL
         QrGw==
X-Gm-Message-State: APf1xPA45NXmzs2waquWpTJUlOaXhxVIS1iUAMWrZcy3NKz7rInBmeVN
        hsAQonIsGORCgtFVC3URkFc=
X-Google-Smtp-Source: AH8x224pzGGQwFGe/RvLMXp2J06P5eGV0OF99qO7LXqz7xuIDEDLnDGUrdcjS2zZIEopOViQjvWSCg==
X-Received: by 10.99.120.193 with SMTP id t184mr13110683pgc.348.1519781865770;
        Tue, 27 Feb 2018 17:37:45 -0800 (PST)
Received: from duynguyen.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id n13sm573588pfg.45.2018.02.27.17.37.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Feb 2018 17:37:45 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sbeller@google.com,
        sunshine@sunshineco.com
Subject: [PATCH v3 0/4] Delete ignore_env member in struct repository
Date:   Wed, 28 Feb 2018 08:37:23 +0700
Message-Id: <20180228013727.13815-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.399.g632f88eed1
In-Reply-To: <20180227095846.9238-1-pclouds@gmail.com>
References: <20180227095846.9238-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 fixes comment style. Also since Brandon raised a question about
shared_root, it's obviously not a good name, so I renamed it to
commondir.

I still keep the delete patch 2/4, but I move the repo_setup_env()
deletion back to 1/4 so all env logic is in one patch (the
introduction of new helper functions in 1/4 and deletion in 2/4 are
still diff noise if 2/4 is completely merged back).

Interdiff:

diff --git a/environment.c b/environment.c
index 47c6e31559..b2128c1188 100644
--- a/environment.c
+++ b/environment.c
@@ -149,7 +149,8 @@ static char *expand_namespace(const char *raw_namespace)
 	return strbuf_detach(&buf, NULL);
 }
 
-/* Wrapper of getenv() that returns a strdup value. This value is kept
+/*
+ * Wrapper of getenv() that returns a strdup value. This value is kept
  * in argv to be freed later.
  */
 static const char *getenv_safe(struct argv_array *argv, const char *name)
@@ -170,7 +171,7 @@ void setup_git_env(const char *git_dir)
 	struct set_gitdir_args args = { NULL };
 	struct argv_array to_free = ARGV_ARRAY_INIT;
 
-	args.shared_root = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
+	args.commondir = getenv_safe(&to_free, GIT_COMMON_DIR_ENVIRONMENT);
 	args.object_dir = getenv_safe(&to_free, DB_ENVIRONMENT);
 	args.graft_file = getenv_safe(&to_free, GRAFT_ENVIRONMENT);
 	args.index_file = getenv_safe(&to_free, INDEX_ENVIRONMENT);
diff --git a/repository.c b/repository.c
index c555dacad2..4f44384dde 100644
--- a/repository.c
+++ b/repository.c
@@ -27,15 +27,15 @@ static void expand_base_dir(char **out, const char *in,
 }
 
 static void repo_set_commondir(struct repository *repo,
-			       const char *shared_root)
+			       const char *commondir)
 {
 	struct strbuf sb = STRBUF_INIT;
 
 	free(repo->commondir);
 
-	if (shared_root) {
+	if (commondir) {
 		repo->different_commondir = 1;
-		repo->commondir = xstrdup(shared_root);
+		repo->commondir = xstrdup(commondir);
 		return;
 	}
 
@@ -58,7 +58,7 @@ void repo_set_gitdir(struct repository *repo,
 	repo->gitdir = xstrdup(gitfile ? gitfile : root);
 	free(old_gitdir);
 
-	repo_set_commondir(repo, o->shared_root);
+	repo_set_commondir(repo, o->commondir);
 	expand_base_dir(&repo->objects.objectdir, o->object_dir,
 			repo->commondir, "objects");
 	free(repo->objects.alternate_db);
diff --git a/repository.h b/repository.h
index 07e8971428..e05a77a099 100644
--- a/repository.h
+++ b/repository.h
@@ -81,7 +81,7 @@ struct repository {
 extern struct repository *the_repository;
 
 struct set_gitdir_args {
-	const char *shared_root;
+	const char *commondir;
 	const char *object_dir;
 	const char *graft_file;
 	const char *index_file;

Nguyễn Thái Ngọc Duy (4):
  repository.c: move env-related setup code back to environment.c
  repository.c: delete dead functions
  sha1_file.c: move delayed getenv(altdb) back to setup_git_env()
  repository: delete ignore_env member

 cache.h        |  2 +-
 environment.c  | 31 +++++++++++++++++--
 object-store.h |  5 ++-
 object.c       |  1 +
 repository.c   | 84 ++++++++++++++++++++++++--------------------------
 repository.h   | 21 +++++++------
 setup.c        |  3 +-
 sha1_file.c    |  6 +---
 8 files changed, 87 insertions(+), 66 deletions(-)

-- 
2.16.1.399.g632f88eed1

