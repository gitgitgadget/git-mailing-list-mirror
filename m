Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A5A31F576
	for <e@80x24.org>; Sun, 25 Feb 2018 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751545AbeBYLSw (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Feb 2018 06:18:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42875 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeBYLSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Feb 2018 06:18:50 -0500
Received: by mail-pg0-f65.google.com with SMTP id y8so5118286pgr.9
        for <git@vger.kernel.org>; Sun, 25 Feb 2018 03:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eUFmrqtccgInlI88XH04Fond9tdUgjuyIbVGlCSJtEk=;
        b=mJvgXMPetTTyrlXAuZMRnxOe9VllWEBXkg2jgfXDV/XspQb0G7pjGheoDgdItZytZ/
         PQUkO4T9tlqDB8+Oh+/czL1n1tKpJAzPQdfLtwUPAN/609Paludh1A+cZv3lhD0GUz3/
         umemd5PD0OGWvY5kFvB+wze6KLhnahYx2rLLAwgEPJg3wPiEF/bmW/I2op7Z7CJjA/II
         ZP2dk38OQz41CNPF+q4vv50eDPIcRP5A9yUQkvaHbOlHLcwpZcfw8prqJkUVFY+9ThsE
         TOo6xzumI82dcDzlJsPyu9hpNIIoamyUymYpPYN+t7U7OhdMARuCv7OfS62xOdiUmafp
         +I9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eUFmrqtccgInlI88XH04Fond9tdUgjuyIbVGlCSJtEk=;
        b=P+8tGQ7cTENJS63nEfQmXLE1fjcOxYdu2DiG7RLs0uwD29rfBKAxIYYzv8oRYGJl9f
         S3LFKGTPk2bF5XzvUascMCKmbjXtJRp5k+5b16Dq+y3XTj/E/eLiRXrwQI6S/64cu/NU
         nTZnssLpVhLIq4B98skx7RRkZkB5DWiDm7W6/N+4K5QX2IVBFl9scxM8iUpHrcK4psME
         wtPVMmOH8/fZJ8npLT3My6InRGl4o5tRs1F3GmtdZI1xWZGvmF925bkJjzWaTYNtqfdP
         6axZ+ut9BySZPUJRYKOy+QfgEzkt272X/xrWqSlA6Gz+gEic7prxkv+LcNiHCkm3foFT
         3KZg==
X-Gm-Message-State: APf1xPD2Uz04QNKlDw39RaaGIoAe030uYkPFpcvj1qWxCTGNxFQPhryn
        xG+FCMrZe6u0Oal2OmD1Za4=
X-Google-Smtp-Source: AG47ELsGnfLb/JnkBzUnAPDxUcg7ZSlcXjk3F2I2yHwSrEROXMFu/M3B/RDtevXq7UPJrr2C01rgDQ==
X-Received: by 10.98.141.205 with SMTP id p74mr2566840pfk.211.1519557529959;
        Sun, 25 Feb 2018 03:18:49 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j13sm14673080pfk.174.2018.02.25.03.18.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Feb 2018 03:18:49 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 25 Feb 2018 18:18:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, sandals@crustytoothpaste.net,
        sbeller@google.com, sunshine@sunshineco.com
Subject: [PATCH v3 0/6] Fix initializing the_hash_algo
Date:   Sun, 25 Feb 2018 18:18:34 +0700
Message-Id: <20180225111840.16421-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180224033429.9656-1-pclouds@gmail.com>
References: <20180224033429.9656-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v3 refines v2 a bit more:

- fix configure typo (and stray words in commit message)
- use repo_set_hash_algo() instead of reassigning the_hash_algo
- compare hash algos by format_id
- catch NULL hash algo, report nicely and suggest GIT_HASH_FIXUP

The last point makes me much happier about keeping this workaround
around until we are confident we can live without it. Interdiff

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 1144458140..2c75f28b41 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -331,21 +331,24 @@ static const char *open_pack_file(const char *pack_name)
 
 static void prepare_hash_algo(uint32_t pack_version)
 {
+	int pack_algo_id;
 	const struct git_hash_algo *pack_algo;
 
 	switch (pack_version) {
 	case 2:
 	case 3:
-		pack_algo = &hash_algos[GIT_HASH_SHA1];
+		pack_algo_id = GIT_HASH_SHA1;
 		break;
 	default:
-		die("BUG: how to determine hash algo for new version?");
+		die("BUG: how to determine hash algo for version %d?",
+		    pack_version);
 	}
 
-	if (!the_hash_algo)	/* running without repo */
-		the_hash_algo = pack_algo;
+	if (!repo_has_valid_hash_algo(the_repository)) /* running without repo */
+		repo_set_hash_algo(the_repository, pack_algo_id);
 
-	if (the_hash_algo != pack_algo)
+	pack_algo = &hash_algos[pack_algo_id];
+	if (the_hash_algo->format_id != pack_algo->format_id)
 		die(_("incompatible hash algorithm, "
 		      "configured for %s but the pack file needs %s"),
 		    the_hash_algo->name, pack_algo->name);
diff --git a/cache.h b/cache.h
index 6b97138264..55b31e9756 100644
--- a/cache.h
+++ b/cache.h
@@ -53,7 +53,7 @@ struct object_id {
 	unsigned char hash[GIT_MAX_RAWSZ];
 };
 
-#define the_hash_algo the_repository->hash_algo
+#define the_hash_algo repo_get_hash_algo(the_repository)
 
 #if defined(DT_UNKNOWN) && !defined(NO_D_TYPE_IN_DIRENT)
 #define DTYPE(de)	((de)->d_type)
diff --git a/diff.c b/diff.c
index f5755425b6..5f28d84b87 100644
--- a/diff.c
+++ b/diff.c
@@ -3997,15 +3997,15 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 
 	/*
 	 * NEEDSWORK: When running in no-index mode (and no repo is
-	 * found, thus no hash algo conifugred), fall back to SHA-1
+	 * found, thus no hash algo configured), fall back to SHA-1
 	 * hashing (which is used by diff_fill_oid_info below) to
 	 * avoid regression in diff output.
 	 *
 	 * In future, perhaps we can allow the user to specify their
 	 * hash algorithm from command line in this mode.
 	 */
-	if (o->flags.no_index && !the_hash_algo)
-		the_hash_algo = &hash_algos[GIT_HASH_SHA1];
+	if (o->flags.no_index && !repo_has_valid_hash_algo(the_repository))
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
 
 	diff_fill_oid_info(one);
 	diff_fill_oid_info(two);
diff --git a/repository.h b/repository.h
index 0329e40c7f..40bd49611f 100644
--- a/repository.h
+++ b/repository.h
@@ -107,4 +107,20 @@ extern void repo_clear(struct repository *repo);
  */
 extern int repo_read_index(struct repository *repo);
 
+static inline const struct git_hash_algo *repo_get_hash_algo(
+	const struct repository *repo)
+{
+	if (!repo->hash_algo)
+		die("BUG: hash_algo is not initialized!\n%s",
+		    _("You can work around this by setting environment"
+		      " variable GIT_HASH_FIXUP=1.\n"
+		      "Please report this to git@vger.kernel.org"));
+	return repo->hash_algo;
+}
+
+static inline int repo_has_valid_hash_algo(const struct repository *repo)
+{
+	return repo->hash_algo != NULL;
+}
+
 #endif /* REPOSITORY_H */

Nguyễn Thái Ngọc Duy (6):
  setup.c: initialize the_repository correctly in all cases
  sha1_file.c: keep a good name for "unknown" hash_algos[UNKNOWN]
  cache.h: make the_hash_algo read-only
  index-pack: check (and optionally set) hash algo based on input file
  diff.c: initialize hash algo when running in --no-index mode
  Revert "repository: pre-initialize hash algo pointer"

 builtin/index-pack.c             | 29 ++++++++++++++++++++++++++++-
 builtin/init-db.c                |  3 ++-
 cache.h                          |  5 +++--
 common-main.c                    | 10 ++++++++++
 diff.c                           | 12 ++++++++++++
 path.c                           |  2 +-
 repository.c                     |  2 +-
 repository.h                     | 16 ++++++++++++++++
 setup.c                          |  5 ++++-
 sha1_file.c                      |  2 +-
 t/helper/test-dump-split-index.c |  2 ++
 11 files changed, 80 insertions(+), 8 deletions(-)

-- 
2.16.1.435.g8f24da2e1a

