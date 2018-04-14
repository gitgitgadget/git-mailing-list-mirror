Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DE41F404
	for <e@80x24.org>; Sat, 14 Apr 2018 15:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751073AbeDNP1Z (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 11:27:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:39969 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbeDNP1F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 11:27:05 -0400
Received: by mail-lf0-f68.google.com with SMTP id i18-v6so1355199lfc.7
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 08:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zo8khbYfviYrJvKG4wkky+w6J0viNAjWGwhB9dY7UtA=;
        b=Ba9YbAYASehS0BFzK1GpoX4P4KwBe7R1gA5e652Mf/P4+EMmUmcYmm0jXm4AiMRlej
         8PXRUgBhTHxuAuFuXe8kzf5KKLofyAQLf4PnFYCESPiovcZElX+krYJYH91SDF+b9bVX
         UEk8qSVRjwu/rpo6TJdDomnrMYH/YhO7ys1YnbLSCN8qumGj+KE2lRpO9nvosYAs+hPX
         ie7fAfdEgWkq8rUorvdt2ln545h4mpicjy4qQZDYlmnZ361LagjsswK9tQqyt8blQS5F
         DfnLNdIPiQe6Wwp+VPb/VuVSgFEZrZ+ScKljLTRLeRJbWj5I8EeIxv1Ofzz7hmjEcfpr
         qpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zo8khbYfviYrJvKG4wkky+w6J0viNAjWGwhB9dY7UtA=;
        b=FOsmaLB0traADWx/7Yh6L1vOfjyFqnzo8A3wqGNpOogHXybwwFnU9SR4SDzVrFPgja
         zkuTfs0JkdJ19tPFwMGwhrrmfFbFatJMTFJGuTt+5cm59IPw+I4WMTf+0WLKCgPIhybZ
         bkQqUF0FeU4b6XcvJmpff5xS8CFzcUVShKztt1UsxiBycTEXubnLoW3lwcu54fdKUw/J
         WmvYZKcl/JoDssLU1fzMl6qLg39I/DCyGjxyBoUUnQOQVI0FUnjvVt9Rc6Uq2b2fZAGt
         7+pVGMGT8N7R66cJwSOcPCvMVRIIyXKRsdAOLJXq5bbyPXxRgqENRqzLtqIFqL0MAxex
         k2bA==
X-Gm-Message-State: ALQs6tB6lrm3CjADOqdFkE7ieOtQvK5n8VetovtH8LBjS57YGjXRFi4C
        iPzw7rUCa3sJiTHTeGQQecXTgA==
X-Google-Smtp-Source: AIpwx49cZfqOROIH+91aJJKJaNrKf+ukE7bLc54+LggLJNdIW/uflJrBtGDaGVdeQI2/b8L90pJ+Zg==
X-Received: by 2002:a19:cfc2:: with SMTP id f185-v6mr11110557lfg.75.1523719623390;
        Sat, 14 Apr 2018 08:27:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id f133-v6sm1803378lfg.28.2018.04.14.08.27.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Apr 2018 08:27:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 4/7] gc: add gc.bigPackThreshold config
Date:   Sat, 14 Apr 2018 17:26:39 +0200
Message-Id: <20180414152642.4666-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.367.g5dd2e386c3
In-Reply-To: <20180414152642.4666-1-pclouds@gmail.com>
References: <20180414152642.4666-1-pclouds@gmail.com>
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
 Documentation/config.txt |  8 ++++++++
 Documentation/git-gc.txt |  6 ++++--
 builtin/gc.c             | 26 ++++++++++++++++++++------
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2659153cb3..40516675b6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1558,6 +1558,14 @@ gc.autoDetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.bigPackThreshold::
+	If non-zero, all packs larger than this limit are kept when
+	`git gc` is run. This is very similar to `--keep-base-pack`
+	except that all packs that meet the threshold are kept, not
+	just the base pack. Defaults to zero. Common unit suffixes of
+	'k', 'm', or 'g' are supported.
+
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

