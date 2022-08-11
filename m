Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5361BC19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 04:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiHKEsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 00:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiHKEr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 00:47:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8118647DD
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 21:47:57 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 186-20020a1c02c3000000b003a34ac64bdfso2115753wmc.1
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 21:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=mnoF2mg+o0hKj+J8jyu7PAcpE/kW8az2NNsMg25Y3aU=;
        b=lY09GNfPsiBoPY6tuD3kaLzTXyl37/f2alRGWYQd3iZbT3xPyxGytvc//TNKSsfa8e
         XkRMV2d6bb2TktvD9IsP3ie7W9htk4zcOVDGe23ypn/SJqPcL2saxiEz8TbL5hifpqpb
         1O6CUOEtukxCPgOOoaiL16lIO12WVkBpJqTvzM4j/BG7RsjzTZRtsJ+JT0osoFYQUa/l
         +wpJ0JuLa0yG+8pRuShUeebKnQw91wuB4usVo2RYgjxJdh5uysglEFUrDAxHkWJIZcqT
         /8RrQG7gglnGOuQfJFsTg81Qo+Id5+QQ14Z/wVw6Bx5o7qnSBc1iYt8rwITJMiwiD95C
         b6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=mnoF2mg+o0hKj+J8jyu7PAcpE/kW8az2NNsMg25Y3aU=;
        b=nxVtXzuanBVwsi+D/34lMTD7nuRixNyN4ntq1z/vd2udWUYHKBb/WZMZBuoMeXWLtu
         v6Dncrh8JCWmDeKYz5CpYIlJfQ/V2QaNOAJBxTPJ3SKqDk614TmAyx8NG3QRmkE5+03/
         VICvzcqK3wMr1E1RSB7QpvfqSNskZ5ph3KDKVis51pyI8BhzFO67z43RKkp4wc89SOIX
         ccNWBBxgz8gVRT/v5d88zsFBQ5lAJxBLESKxTxzLhTYA3kNc/AhCSMsR3pv58zednfi6
         tG3fABlOfqtahYCNo4abmFM7vAdB3R7yZ1zmNVlaBx5nTbOqePBd/dlTUIMICQ3yS0EF
         fMGw==
X-Gm-Message-State: ACgBeo0ojPpvwuRmGnTvNaraz8zYzO4FBeUb7jd2jzplBQzD/TNMW76V
        zOdkdCYqILM2J5XSijrBO91qRz3GCmk=
X-Google-Smtp-Source: AA6agR6q7jq/p/b/7ASFEA+j96EpTJWftOtM9syknOiTknPw71f8Yx1SKDtc2LEmyzoxBwoz8dn+2A==
X-Received: by 2002:a05:600c:1c0f:b0:3a5:4d6b:a883 with SMTP id j15-20020a05600c1c0f00b003a54d6ba883mr4384926wms.45.1660193275728;
        Wed, 10 Aug 2022 21:47:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11-20020a5d534b000000b00222c96d8656sm10310563wrv.114.2022.08.10.21.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:47:55 -0700 (PDT)
Message-Id: <pull.1313.v5.git.1660193274336.gitgitgadget@gmail.com>
In-Reply-To: <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
References: <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 Aug 2022 04:47:54 +0000
Subject: [PATCH v5] rev-list: support human-readable output for `--disk-usage`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Li Linchao <lilinchao@oschina.cn>,
        Li Linchao <lilinchao@oschina.cn>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Li Linchao <lilinchao@oschina.cn>

The '--disk-usage' option for git-rev-list was introduced in 16950f8384
(rev-list: add --disk-usage option for calculating disk usage, 2021-02-09).
This is very useful for people inspect their git repo's objects usage
infomation, but the resulting number is quit hard for a human to read.

Teach git rev-list to output a human readable result when using
'--disk-usage'.

Signed-off-by: Li Linchao <lilinchao@oschina.cn>
---
    rev-list: support human-readable output for disk-usage
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn Cc: Jeff King
    peff@peff.net cc: Ævar Arnfjörð Bjarmason avarab@gmail.com cc: Johannes
    Sixt j6t@kdbg.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1313%2FCactusinhand%2Fllc%2Fadd-human-readable-option-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1313/Cactusinhand/llc/add-human-readable-option-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1313

Range-diff vs v4:

 1:  e56da057a9a ! 1:  7fbf4b636d6 rev-list: support human-readable output for `--disk-usage`
     @@ Documentation/rev-list-options.txt: ifdef::git-rev-list[]
       	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
       	section in linkgit:git-cat-file[1] for the limitations of what
       	"on-disk storage" means.
     -+	When it accepts a value `human`, like: `--disk-usage=human`, this
     -+	means to print objects size in human readable format.
     ++	With the optional value `human`, on-disk storage size is shown
     ++	in human-readable string(e.g. 12.24 Kib, 3.50 Mib).
       endif::git-rev-list[]
       
       --cherry-mark::
     @@ builtin/rev-list.c: static const char rev_list_usage[] =
       "    --parents\n"
       "    --children\n"
       "    --objects | --objects-edge\n"
     -+"    --disk-usage | --disk-usage=human\n"
     ++"    --disk-usage[=human]\n"
       "    --unpacked\n"
       "    --header | --pretty\n"
       "    --[no-]object-names\n"
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
      +				if (!strcmp(++arg, "human")) {
      +					human_readable = 1;
      +				} else
     -+					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);
     ++					die(_("invalid value for '%s': '%s', the only allowed format is '%s'"),
     ++					    "--disk-usage=<format>", arg, "human");
      +			} else if (*arg) {
      +				/*
     -+				* Arguably should goto a label to continue chain of ifs?
     -+				* Doesn't matter unless we try to add --disk-usage-foo
     -+				* afterwards
     -+				*/
     ++				 * Arguably should goto a label to continue chain of ifs?
     ++				 * Doesn't matter unless we try to add --disk-usage-foo
     ++				 * afterwards.
     ++				 */
      +				usage(rev_list_usage);
      +			}
       			show_disk_usage = 1;
     @@ t/t6115-rev-list-du.sh: check_du HEAD
      +test_expect_success 'rev-list use --disk-usage unproperly' '
      +	test_must_fail git rev-list --objects HEAD --disk-usage=typo 2>err &&
      +	cat >expect <<-\EOF &&
     -+	fatal: invalid value for '\''--disk-usage'\'': '\''typo'\'', try --disk-usage=human
     ++	fatal: invalid value for '\''--disk-usage=<format>'\'': '\''typo'\'', the only allowed format is '\''human'\''
      +	EOF
      +	test_cmp err expect
      +'


 Documentation/rev-list-options.txt |  3 +++
 builtin/rev-list.c                 | 36 ++++++++++++++++++++++++++----
 t/t6115-rev-list-du.sh             | 22 ++++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..bd08d18576f 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -242,6 +242,7 @@ ifdef::git-rev-list[]
 	to `/dev/null` as the output does not have to be formatted.
 
 --disk-usage::
+--disk-usage=human::
 	Suppress normal output; instead, print the sum of the bytes used
 	for on-disk storage by the selected commits or objects. This is
 	equivalent to piping the output into `git cat-file
@@ -249,6 +250,8 @@ ifdef::git-rev-list[]
 	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
 	section in linkgit:git-cat-file[1] for the limitations of what
 	"on-disk storage" means.
+	With the optional value `human`, on-disk storage size is shown
+	in human-readable string(e.g. 12.24 Kib, 3.50 Mib).
 endif::git-rev-list[]
 
 --cherry-mark::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 30fd8e83eaf..fba6f5d51f3 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -46,6 +46,7 @@ static const char rev_list_usage[] =
 "    --parents\n"
 "    --children\n"
 "    --objects | --objects-edge\n"
+"    --disk-usage[=human]\n"
 "    --unpacked\n"
 "    --header | --pretty\n"
 "    --[no-]object-names\n"
@@ -81,6 +82,7 @@ static int arg_show_object_names = 1;
 
 static int show_disk_usage;
 static off_t total_disk_usage;
+static int human_readable;
 
 static off_t get_object_disk_usage(struct object *obj)
 {
@@ -368,6 +370,17 @@ static int show_object_fast(
 	return 1;
 }
 
+static void print_disk_usage(off_t size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	if (human_readable)
+		strbuf_humanise_bytes(&sb, size);
+	else
+		strbuf_addf(&sb, "%"PRIuMAX, (uintmax_t)size);
+	puts(sb.buf);
+	strbuf_release(&sb);
+}
+
 static inline int parse_missing_action_value(const char *value)
 {
 	if (!strcmp(value, "error")) {
@@ -473,6 +486,7 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 				 int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
+	off_t size_from_bitmap;
 
 	if (!show_disk_usage)
 		return -1;
@@ -481,8 +495,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!bitmap_git)
 		return -1;
 
-	printf("%"PRIuMAX"\n",
-	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
+	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
+	print_disk_usage(size_from_bitmap);
 	return 0;
 }
 
@@ -624,7 +638,21 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!strcmp(arg, "--disk-usage")) {
+		if (skip_prefix(arg, "--disk-usage", &arg)) {
+			if (*arg == '=') {
+				if (!strcmp(++arg, "human")) {
+					human_readable = 1;
+				} else
+					die(_("invalid value for '%s': '%s', the only allowed format is '%s'"),
+					    "--disk-usage=<format>", arg, "human");
+			} else if (*arg) {
+				/*
+				 * Arguably should goto a label to continue chain of ifs?
+				 * Doesn't matter unless we try to add --disk-usage-foo
+				 * afterwards.
+				 */
+				usage(rev_list_usage);
+			}
 			show_disk_usage = 1;
 			info.flags |= REV_LIST_QUIET;
 			continue;
@@ -753,7 +781,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_disk_usage)
-		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
+		print_disk_usage(total_disk_usage);
 
 cleanup:
 	release_revisions(&revs);
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b713..d59111dedec 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,4 +48,26 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+# As mentioned above, don't use hardcode sizes as actual size, but use the
+# output from git cat-file.
+test_expect_success 'rev-list --disk-usage=human' '
+	git rev-list --objects HEAD --disk-usage=human >actual &&
+	disk_usage_slow --objects HEAD >actual_size &&
+	grep "$(cat actual_size) bytes" actual
+'
+
+test_expect_success 'rev-list --disk-usage=human with bitmaps' '
+	git rev-list --objects HEAD --use-bitmap-index --disk-usage=human >actual &&
+	disk_usage_slow --objects HEAD >actual_size &&
+	grep "$(cat actual_size) bytes" actual
+'
+
+test_expect_success 'rev-list use --disk-usage unproperly' '
+	test_must_fail git rev-list --objects HEAD --disk-usage=typo 2>err &&
+	cat >expect <<-\EOF &&
+	fatal: invalid value for '\''--disk-usage=<format>'\'': '\''typo'\'', the only allowed format is '\''human'\''
+	EOF
+	test_cmp err expect
+'
+
 test_done

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
gitgitgadget
