Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CE41F404
	for <e@80x24.org>; Sun, 15 Apr 2018 15:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeDOPgu (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 11:36:50 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35848 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbeDOPgg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 11:36:36 -0400
Received: by mail-lf0-f68.google.com with SMTP id d20-v6so18611264lfe.3
        for <git@vger.kernel.org>; Sun, 15 Apr 2018 08:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NiuiiG3oVvawTSCyNQoqhmE0qlAaSua6on2iXUXoMvs=;
        b=hR7RlLVCB84kaE7mYy2mXBpNB9fr+zdCIfA1KUSAFgkT7/qdpiDfJrqhFtKT7SfzPl
         1ZdP2dWVwZ4Gpn2J6GXGXGhpVq1yza5lONZhE83+Hj7nU17BTpcPqR0OV5PZz03ZAVhy
         VwxL+JoxaKy/4Af36QGH1wZtFr0OSJ3AMKrRR4CXjHOH5dXdg1XiNWgs27FpjOWXPuuw
         5aZbOEc2++6sU4rgtgsJ3Zft1wIugtu1MpsHjAgwuTK/hczODIXogDsPPJ2ZFC4QJTii
         KMwURAn979hLkrQz/AmhvN/UA/SuhVOdLApuOhoVhG3do3KYYoKdpr5W/mvgHmXI5k7T
         /mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NiuiiG3oVvawTSCyNQoqhmE0qlAaSua6on2iXUXoMvs=;
        b=r6I8PaOioqYlv1oBbyNcutDRcKDfy+f54GIDd4ZopwdAlVyYcEl9TerVzPktojboEA
         rfKEFV+qufk9imBLiMm6K9CA86XJY79hL5xrazzZN6/8Oghoe778Fa0Hzum7UanMn4W+
         sFM8fmTI8wZgfmrzBbpKQcoY4rnonUT/tUmAQo4XflF5XcYDaDUMp2jNhZ+DoYh6A1/j
         UfF2cobIbh1XXNxaGFNHlO9Ft4i5epdwgzZLJshfqAFXmZnbqi2MyDtHLTXQ6gjGS3We
         jW3dlQAkiH8KPmw4ToIQfrN3eM/hPLqeSRI/d/CM+QfjsBzjwKQcphQVtnK+o+5Nccmf
         +HKw==
X-Gm-Message-State: ALQs6tCz7vhSjRNVmjNfLmaodaxpQ6CAsywrNd8u+50kcN8ppD/0f0s2
        wGlV9BmvfQQVvSLQv4lre5c=
X-Google-Smtp-Source: AIpwx4+9zt+dUmERXjG/ilwgavXTRD9r01d68gas+1CveplbR6sn0EsMpD+oBTTLV1+F7o+NWjshOg==
X-Received: by 2002:a19:a8d4:: with SMTP id r203-v6mr13120851lfe.146.1523806594670;
        Sun, 15 Apr 2018 08:36:34 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id w10sm826176lji.47.2018.04.15.08.36.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Apr 2018 08:36:33 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>
Subject: [PATCH v2 4/7] gc: add gc.bigPackThreshold config
Date:   Sun, 15 Apr 2018 17:36:15 +0200
Message-Id: <20180415153618.32019-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180415153618.32019-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
 <20180415153618.32019-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The --keep-largest-pack option is not very convenient to use because
you need to tell gc to do this explicitly (and probably on just a few
large repos).

Add a config key that enables this mode when packs larger than a limit
are found. Note that there's a slight behavior difference compared to
--keep-largest-pack: all packs larger than the threshold are kept, not
just the largest one.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt |  7 +++++++
 Documentation/git-gc.txt |  6 ++++--
 builtin/gc.c             | 26 ++++++++++++++++++++------
 3 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..728ae902e6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1558,6 +1558,13 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.bigPackThreshold::
+	If non-zero, all packs larger than this limit are kept when
+	`git gc` is run. This is very similar to `--keep-base-pack`
+	except that all packs that meet the threshold are kept, not
+	just the base pack. Defaults to zero. Common unit suffixes of
+	'k', 'm', or 'g' are supported.
+
 gc.logExpiry::
 	If the file gc.log exists, then `git gc --auto` won't run
 	unless that file is more than 'gc.logExpiry' old.  Default is
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 8f903231da..649faddfa6 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -56,7 +56,8 @@ single pack using `git repack -d -l`.  Setting the value of `gc.auto`
 to 0 disables automatic packing of loose objects.
 +
 If the number of packs exceeds the value of `gc.autoPackLimit`,
-then existing packs (except those marked with a `.keep` file)
+then existing packs (except those marked with a `.keep` file
+or over `gc.bigPackThreshold` limit)
 are consolidated into a single pack by using the `-A` option of
 'git repack'. Setting `gc.autoPackLimit` to 0 disables
 automatic consolidation of packs.
@@ -86,7 +87,8 @@ be performed as well.
 
 --keep-largest-pack::
 	All packs except the largest pack and those marked with a
-	`.keep` files are consolidated into a single pack.
+	`.keep` files are consolidated into a single pack. When this
+	option is used, `gc.bigPackThreshold` is ignored.
 
 Configuration
 -------------
diff --git a/builtin/gc.c b/builtin/gc.c
index f251662a8f..81ecdc5ffa 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -41,6 +41,7 @@ static timestamp_t gc_log_expire_time;
 static const char *gc_log_expire = "1.day.ago";
 static const char *prune_expire = "2.weeks.ago";
 static const char *prune_worktrees_expire = "3.months.ago";
+static unsigned long big_pack_threshold;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
@@ -128,6 +129,8 @@ static void gc_config(void)
 	git_config_get_expiry("gc.worktreepruneexpire", &prune_worktrees_expire);
 	git_config_get_expiry("gc.logexpiry", &gc_log_expire);
 
+	git_config_get_ulong("gc.bigpackthreshold", &big_pack_threshold);
+
 	git_config(git_default_config, NULL);
 }
 
@@ -166,14 +169,17 @@ static int too_many_loose_objects(void)
 	return needed;
 }
 
-static void find_base_packs(struct string_list *packs)
+static void find_base_packs(struct string_list *packs, unsigned long limit)
 {
 	struct packed_git *p, *base = NULL;
 
 	for (p = get_packed_git(the_repository); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
-		if (!base || base->pack_size < p->pack_size) {
+		if (limit) {
+			if (p->pack_size >= limit)
+				string_list_append(packs, p->pack_name);
+		} else if (!base || base->pack_size < p->pack_size) {
 			base = p;
 		}
 	}
@@ -244,9 +250,15 @@ static int need_to_gc(void)
 	 * we run "repack -A -d -l".  Otherwise we tell the caller
 	 * there is no need.
 	 */
-	if (too_many_packs())
-		add_repack_all_option(NULL);
-	else if (too_many_loose_objects())
+	if (too_many_packs()) {
+		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
+
+		if (big_pack_threshold)
+			find_base_packs(&keep_pack, big_pack_threshold);
+
+		add_repack_all_option(&keep_pack);
+		string_list_clear(&keep_pack, 0);
+	} else if (too_many_loose_objects())
 		add_repack_incremental_option();
 	else
 		return 0;
@@ -464,7 +476,9 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 
 		if (keep_base_pack != -1) {
 			if (keep_base_pack)
-				find_base_packs(&keep_pack);
+				find_base_packs(&keep_pack, 0);
+		} else if (big_pack_threshold) {
+			find_base_packs(&keep_pack, big_pack_threshold);
 		}
 
 		add_repack_all_option(&keep_pack);
-- 
2.17.0.367.g5dd2e386c3

