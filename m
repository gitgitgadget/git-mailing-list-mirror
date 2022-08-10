Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F86C38142
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 06:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiHJGBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 02:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiHJGBW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 02:01:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5978526AF1
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 23:01:20 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z16so16476119wrh.12
        for <git@vger.kernel.org>; Tue, 09 Aug 2022 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=nJlfNvpdwjCrLZScGqLiQScoGvfxmNgCZKmmv8HF6Ao=;
        b=GOErShhsA/d5WROukG+SHa6xcuQ5GOndjsmhUYW7bmw3+bxQXaCBF180wHFiJ1EwUt
         Axx2kjZfxgSv2SsUBdkn06eoGgWBsuiNOk339OVlPdwhG65OAopgKZ5qIO47pm8gMRqM
         7JTnDfoLHKGGGPTLwM9IQx3dJ8JDqkLIUNwnMNNocPi/N2Bs87Hkw0KwBSIsQ0/0EAso
         MNsaQk+llTCtrnbia5/ttCPm17wER80vVqe1ss/3Ul/wC/qJjDzEy5XmcB7cLs7mLSf4
         FRSr6oW2rR6ZKZD0UTUAIliCSa8gQi1MkOUDceVIq5Avu+CewqSmCUaxLtClZ0nUKMh/
         oyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=nJlfNvpdwjCrLZScGqLiQScoGvfxmNgCZKmmv8HF6Ao=;
        b=IXWmyhuowOvUzs6vCDp8YXei5mWiL/4jKAzGsm7NGRMtZTTmQaMbDq6eA3/612mU3l
         AGi8zbSU7uh2aBXmwEFWi9kK4Y3zahCXYKuGWbzDkhbEsRJY0Ms1Gsa/z2NbSD7DP6JZ
         ZLbIWKp916xL7p+n2mMMcnDUibtJn4XuRXUXYdLMeqhcp6QgYTWHuPNKY2XoegMYrRzi
         9ZurAT1jMSiczkydkJN86Il8L6Is10WezbrytSXmB+LsoBoohUQM7QpdBBF2/gm0SATO
         X5cF3zLkuiWkgCNpzWuJgEYRNA9xOQP/RU27KMhhRkuE41m9QxI2vraNidnPnvN9w0Jf
         imLA==
X-Gm-Message-State: ACgBeo0D5Pd9QNMHMhmOGvbH1xXSO7b3nFdJENwL2zbX+tGEZW29CBVH
        ylVj4eziyVHtygkC9fLfciId2AzhDNg=
X-Google-Smtp-Source: AA6agR6FdfK8ElGW4oxWyJ/IJlFtm0+8NZ98Em4XzEWq393Lw2BAoH7qCe4ASATdkV0/gcwYGsThYA==
X-Received: by 2002:a5d:63c9:0:b0:220:68e1:7f3f with SMTP id c9-20020a5d63c9000000b0022068e17f3fmr16318525wrw.134.1660111278381;
        Tue, 09 Aug 2022 23:01:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14-20020a05600c190e00b003a31673515bsm1245794wmq.7.2022.08.09.23.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 23:01:17 -0700 (PDT)
Message-Id: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
In-Reply-To: <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
References: <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 06:01:16 +0000
Subject: [PATCH v3] rev-list: support human-readable output for `--disk-usage`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Li Linchao <lilinchao@oschina.cn>,
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
    
    The '--disk-usage' option for git-rev-list was introduced in 16950f8384
    (rev-list: add --disk-usage option for calculating disk usage,
    2021-02-09). This is very useful for people inspect their git repo's
    objects usage infomation, but the result number is quit hard for human
    to read.
    
    Teach git rev-list to output more human readable result when using
    '--disk-usage' to calculate objects disk usage.
    
    Signed-off-by: Li Linchao lilinchao@oschina.cn

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1313%2FCactusinhand%2Fllc%2Fadd-human-readable-option-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1313/Cactusinhand/llc/add-human-readable-option-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1313

Range-diff vs v2:

 1:  7e34d16efe4 ! 1:  000a6b37ec9 rev-list: support human-readable output for `--disk-usage`
     @@ builtin/rev-list.c: static int arg_show_object_names = 1;
       
       static off_t get_object_disk_usage(struct object *obj)
       {
     +@@ builtin/rev-list.c: static int show_object_fast(
     + 	return 1;
     + }
     + 
     ++static void print_disk_usage(off_t size)
     ++{
     ++	struct strbuf sb = STRBUF_INIT;
     ++	if (human_readable)
     ++		strbuf_humanise_bytes(&sb, size);
     ++	else
     ++		strbuf_addf(&sb, "%"PRIuMAX, (uintmax_t)size);
     ++	puts(sb.buf);
     ++	strbuf_release(&sb);
     ++}
     ++
     + static inline int parse_missing_action_value(const char *value)
     + {
     + 	if (!strcmp(value, "error")) {
      @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
       				 int filter_provided_objects)
       {
       	struct bitmap_index *bitmap_git;
     -+	struct strbuf disk_buf = STRBUF_INIT;
      +	off_t size_from_bitmap;
       
       	if (!show_disk_usage)
     @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
      -	printf("%"PRIuMAX"\n",
      -	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
      +	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
     -+	if (human_readable)
     -+		strbuf_humanise_bytes(&disk_buf, size_from_bitmap);
     -+	else
     -+		strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)size_from_bitmap);
     -+	puts(disk_buf.buf);
     -+	strbuf_release(&disk_buf);
     ++	print_disk_usage(size_from_bitmap);
       	return 0;
       }
       
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
       		}
       
      -		if (!strcmp(arg, "--disk-usage")) {
     --			show_disk_usage = 1;
     --			info.flags |= REV_LIST_QUIET;
     --			continue;
      +		if (skip_prefix(arg, "--disk-usage", &arg)) {
      +			if (*arg == '=') {
      +				if (!strcmp(++arg, "human")) {
      +					human_readable = 1;
     -+					show_disk_usage = 1;
     -+					info.flags |= REV_LIST_QUIET;
     -+					continue;
      +				} else
      +					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);
     -+			} else {
     -+				show_disk_usage = 1;
     -+				info.flags |= REV_LIST_QUIET;
     -+				continue;
     ++			} else if (*arg) {
     ++				/*
     ++				* Arguably should goto a label to continue chain of ifs?
     ++				* Doesn't matter unless we try to add --disk-usage-foo
     ++				* afterwards
     ++				*/
     ++				usage(rev_list_usage);
      +			}
     - 		}
     - 
     - 		usage(rev_list_usage);
     + 			show_disk_usage = 1;
     + 			info.flags |= REV_LIST_QUIET;
     + 			continue;
      @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
     - 			printf("%d\n", revs.count_left + revs.count_right);
       	}
       
     --	if (show_disk_usage)
     + 	if (show_disk_usage)
      -		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
     -+	if (show_disk_usage) {
     -+		struct strbuf disk_buf = STRBUF_INIT;
     -+		if (human_readable)
     -+			strbuf_humanise_bytes(&disk_buf, total_disk_usage);
     -+		else
     -+			strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)total_disk_usage);
     -+		puts(disk_buf.buf);
     -+		strbuf_release(&disk_buf);
     -+	}
     ++		print_disk_usage(total_disk_usage);
       
       cleanup:
       	release_revisions(&revs);


 Documentation/rev-list-options.txt |  5 ++++-
 builtin/rev-list.c                 | 35 ++++++++++++++++++++++++++----
 t/t6115-rev-list-du.sh             | 22 +++++++++++++++++++
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..9966ce4ef91 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -242,8 +242,11 @@ ifdef::git-rev-list[]
 	to `/dev/null` as the output does not have to be formatted.
 
 --disk-usage::
+--disk-usage=human::
 	Suppress normal output; instead, print the sum of the bytes used
-	for on-disk storage by the selected commits or objects. This is
+	for on-disk storage by the selected commits or objects.
+	When it accepts a value `human`, like: `--disk-usage=human`, this
+	means to print objects size in human readable format. This is
 	equivalent to piping the output into `git cat-file
 	--batch-check='%(objectsize:disk)'`, except that it runs much
 	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 30fd8e83eaf..df42e1b667e 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -46,6 +46,7 @@ static const char rev_list_usage[] =
 "    --parents\n"
 "    --children\n"
 "    --objects | --objects-edge\n"
+"    --disk-usage | --disk-usage=human\n"
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
 
@@ -624,7 +638,20 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!strcmp(arg, "--disk-usage")) {
+		if (skip_prefix(arg, "--disk-usage", &arg)) {
+			if (*arg == '=') {
+				if (!strcmp(++arg, "human")) {
+					human_readable = 1;
+				} else
+					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);
+			} else if (*arg) {
+				/*
+				* Arguably should goto a label to continue chain of ifs?
+				* Doesn't matter unless we try to add --disk-usage-foo
+				* afterwards
+				*/
+				usage(rev_list_usage);
+			}
 			show_disk_usage = 1;
 			info.flags |= REV_LIST_QUIET;
 			continue;
@@ -753,7 +780,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	}
 
 	if (show_disk_usage)
-		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
+		print_disk_usage(total_disk_usage);
 
 cleanup:
 	release_revisions(&revs);
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b713..b34841a4ba8 100755
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
+	fatal: invalid value for '\''--disk-usage'\'': '\''typo'\'', try --disk-usage=human
+	EOF
+	test_cmp err expect
+'
+
 test_done

base-commit: 679aad9e82d0dfd8ef3d1f98fa4629665496cec9
-- 
gitgitgadget
