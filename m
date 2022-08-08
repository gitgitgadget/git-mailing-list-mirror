Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2348AC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 08:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiHHIfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 04:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbiHHIf1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 04:35:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00F45F51
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 01:35:25 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j1so10057034wrw.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 01:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=8gi4BLVEBZNNESlO+kq4R1yqUW+849sJt2CGyTZkjPw=;
        b=Sri4lTNSBMYyb2b7vRYVlTFkCDJ1YNrpU3ZRe0QEQgeIkupM/20pQaMb5qBnz36LvI
         tQU3JjkaGT42gV+HKXamEoYBauEv9Z5GJPIVnjeLo1Wspl+npPqEJc90Res0xnPJ5A9E
         W1BSRd5AXzCh40z/XoSwKMGRMX96zHBGkpoxPiRM5CRDtaH+hLXUvMjPxcVCDyPqyjeA
         eSuxbyCIXMKCUh4V7Rh9/YBrGCAIWK5/aaygp6N0lv94yIhcDmwe7O25dTeEKAOUCQyI
         GbSclo12O/z4innVXz6DU2KlXS1W5tuqk0+FutIwXaGYEP5vT/OUVyg5uV4DtFSXvf8H
         wyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=8gi4BLVEBZNNESlO+kq4R1yqUW+849sJt2CGyTZkjPw=;
        b=VXAN0bkfAoL+7Unm4pEHxKgzNgSdoen4GvZAKwS/Isp31A6ie94Nf9Lehx1jXgawCE
         nGUdPbiVw25yNd4/HOU6qPY4PuKklmbFfMovMvButivLrYqQq+nF8XE0D6fuM1zHSPLm
         JIRsEr5GGqE6Kvigw94TpkCd6tVzP/4ITPlA8m5SfEsZbegRLWUIti80aHqHebmTzhJX
         CpTBxTdw+OsSl7YQ26nPizEJGtQix9GiKSXtzrQprlRzDOtClE16Zwpsl50Mcmhd8FNj
         FgG621lFT8Z/8IxpEb8HjyfCZOS/F7YPXFrF/Mz7O2GjwUOLqg2+MMxKWQKxp9VK83ly
         lS1Q==
X-Gm-Message-State: ACgBeo3qTUUpYgpSFR4zdu+octYj2ahYe6ix5Mo8f95SsvReMSq8d0oh
        WKFkxAT2tqmf6JsFysl4kC+uGBtCuMY=
X-Google-Smtp-Source: AA6agR67It42EhL0mZlDR1USuZbHE8iwhatXwHhONwuCqXbnjSJb6FOpd/vOGpbcmNq2H4+Tt7HAeA==
X-Received: by 2002:a5d:6312:0:b0:220:6820:57d7 with SMTP id i18-20020a5d6312000000b00220682057d7mr10530846wru.8.1659947723755;
        Mon, 08 Aug 2022 01:35:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d6dc2000000b002235eb9d200sm530017wrz.10.2022.08.08.01.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 01:35:23 -0700 (PDT)
Message-Id: <pull.1313.v2.git.1659947722132.gitgitgadget@gmail.com>
In-Reply-To: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>
References: <pull.1313.git.1659686097163.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 08 Aug 2022 08:35:21 +0000
Subject: [PATCH v2] rev-list: support human-readable output for `--disk-usage`
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1313%2FCactusinhand%2Fllc%2Fadd-human-readable-option-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1313/Cactusinhand/llc/add-human-readable-option-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1313

Range-diff vs v1:

 1:  7f8a7d3f61d ! 1:  7e34d16efe4 rev-list: support `--human-readable` option when applied `disk-usage`
     @@ Metadata
      Author: Li Linchao <lilinchao@oschina.cn>
      
       ## Commit message ##
     -    rev-list: support `--human-readable` option when applied `disk-usage`
     +    rev-list: support human-readable output for `--disk-usage`
      
          The '--disk-usage' option for git-rev-list was introduced in 16950f8384
          (rev-list: add --disk-usage option for calculating disk usage, 2021-02-09).
          This is very useful for people inspect their git repo's objects usage
     -    infomation, but the result number is quit hard for human to read.
     +    infomation, but the resulting number is quit hard for a human to read.
      
     -    Teach git rev-list to output more human readable result when using
     -    '--disk-usage' to calculate objects disk usage.
     +    Teach git rev-list to output a human readable result when using
     +    '--disk-usage'.
      
          Signed-off-by: Li Linchao <lilinchao@oschina.cn>
      
       ## Documentation/rev-list-options.txt ##
      @@ Documentation/rev-list-options.txt: ifdef::git-rev-list[]
     - 	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
     - 	section in linkgit:git-cat-file[1] for the limitations of what
     - 	"on-disk storage" means.
     -+
     -+-H::
     -+--human-readable::
     -+	Print on-disk objects size in human readable format. This option
     -+	must be combined with `--disk-usage` together.
     - endif::git-rev-list[]
     + 	to `/dev/null` as the output does not have to be formatted.
       
     - --cherry-mark::
     + --disk-usage::
     ++--disk-usage=human::
     + 	Suppress normal output; instead, print the sum of the bytes used
     +-	for on-disk storage by the selected commits or objects. This is
     ++	for on-disk storage by the selected commits or objects.
     ++	When it accepts a value `human`, like: `--disk-usage=human`, this
     ++	means to print objects size in human readable format. This is
     + 	equivalent to piping the output into `git cat-file
     + 	--batch-check='%(objectsize:disk)'`, except that it runs much
     + 	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
      
       ## builtin/rev-list.c ##
     +@@ builtin/rev-list.c: static const char rev_list_usage[] =
     + "    --parents\n"
     + "    --children\n"
     + "    --objects | --objects-edge\n"
     ++"    --disk-usage | --disk-usage=human\n"
     + "    --unpacked\n"
     + "    --header | --pretty\n"
     + "    --[no-]object-names\n"
      @@ builtin/rev-list.c: static int arg_show_object_names = 1;
       
       static int show_disk_usage;
     @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
       				 int filter_provided_objects)
       {
       	struct bitmap_index *bitmap_git;
     -+	struct strbuf bitmap_size_buf = STRBUF_INIT;
     ++	struct strbuf disk_buf = STRBUF_INIT;
      +	off_t size_from_bitmap;
       
       	if (!show_disk_usage)
     @@ builtin/rev-list.c: static int try_bitmap_disk_usage(struct rev_info *revs,
      -	printf("%"PRIuMAX"\n",
      -	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
      +	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
     -+	if (human_readable) {
     -+		strbuf_humanise_bytes(&bitmap_size_buf, size_from_bitmap);
     -+		printf("%s\n", bitmap_size_buf.buf);
     -+	} else
     -+		printf("%"PRIuMAX"\n", (uintmax_t)size_from_bitmap);
     -+	strbuf_release(&bitmap_size_buf);
     ++	if (human_readable)
     ++		strbuf_humanise_bytes(&disk_buf, size_from_bitmap);
     ++	else
     ++		strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)size_from_bitmap);
     ++	puts(disk_buf.buf);
     ++	strbuf_release(&disk_buf);
       	return 0;
       }
       
     -@@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
     - {
     - 	struct rev_info revs;
     - 	struct rev_list_info info;
     -+	struct strbuf disk_buf = STRBUF_INIT;
     - 	struct setup_revision_opt s_r_opt = {
     - 		.allow_exclude_promisor_objects = 1,
     - 	};
      @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
       			continue;
       		}
       
     -+		if (!strcmp(arg, "--human-readable") || !strcmp(arg, "-H")) {
     -+			human_readable = 1;
     -+			continue;
     -+		}
     -+
     - 		usage(rev_list_usage);
     +-		if (!strcmp(arg, "--disk-usage")) {
     +-			show_disk_usage = 1;
     +-			info.flags |= REV_LIST_QUIET;
     +-			continue;
     ++		if (skip_prefix(arg, "--disk-usage", &arg)) {
     ++			if (*arg == '=') {
     ++				if (!strcmp(++arg, "human")) {
     ++					human_readable = 1;
     ++					show_disk_usage = 1;
     ++					info.flags |= REV_LIST_QUIET;
     ++					continue;
     ++				} else
     ++					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);
     ++			} else {
     ++				show_disk_usage = 1;
     ++				info.flags |= REV_LIST_QUIET;
     ++				continue;
     ++			}
     + 		}
       
     - 	}
     -+
     -+	if (!show_disk_usage && human_readable)
     -+		die(_("option '%s' should be used with '%s' together"), "--human-readable/-H", "--disk-usage");
     - 	if (revs.commit_format != CMIT_FMT_USERFORMAT)
     - 		revs.include_header = 1;
     - 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
     + 		usage(rev_list_usage);
      @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *prefix)
       			printf("%d\n", revs.count_left + revs.count_right);
       	}
     @@ builtin/rev-list.c: int cmd_rev_list(int argc, const char **argv, const char *pr
      -	if (show_disk_usage)
      -		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
      +	if (show_disk_usage) {
     -+		if (human_readable) {
     ++		struct strbuf disk_buf = STRBUF_INIT;
     ++		if (human_readable)
      +			strbuf_humanise_bytes(&disk_buf, total_disk_usage);
     -+			printf("%s\n", disk_buf.buf);
     -+		} else
     -+			printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
     ++		else
     ++			strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)total_disk_usage);
     ++		puts(disk_buf.buf);
     ++		strbuf_release(&disk_buf);
      +	}
       
       cleanup:
       	release_revisions(&revs);
     -+	strbuf_release(&disk_buf);
     - 	return ret;
     - }
      
       ## t/t6115-rev-list-du.sh ##
      @@ t/t6115-rev-list-du.sh: check_du HEAD
       check_du --objects HEAD
       check_du --objects HEAD^..HEAD
       
     -+
     -+test_expect_success 'rev-list --disk-usage with --human-readable' '
     -+	git rev-list --objects HEAD --disk-usage --human-readable >actual &&
     -+	test_i18ngrep -e "446 bytes" actual
     ++# As mentioned above, don't use hardcode sizes as actual size, but use the
     ++# output from git cat-file.
     ++test_expect_success 'rev-list --disk-usage=human' '
     ++	git rev-list --objects HEAD --disk-usage=human >actual &&
     ++	disk_usage_slow --objects HEAD >actual_size &&
     ++	grep "$(cat actual_size) bytes" actual
      +'
      +
     -+test_expect_success 'rev-list --disk-usage with bitmap and --human-readable' '
     -+	git rev-list --objects HEAD --use-bitmap-index --disk-usage -H >actual &&
     -+	test_i18ngrep -e "446 bytes" actual
     ++test_expect_success 'rev-list --disk-usage=human with bitmaps' '
     ++	git rev-list --objects HEAD --use-bitmap-index --disk-usage=human >actual &&
     ++	disk_usage_slow --objects HEAD >actual_size &&
     ++	grep "$(cat actual_size) bytes" actual
      +'
      +
     -+test_expect_success 'rev-list use --human-readable without --disk-usage' '
     -+	test_must_fail git rev-list --objects HEAD --human-readable 2> err &&
     -+	echo "fatal: option '\''--human-readable/-H'\'' should be used with" \
     -+	"'\''--disk-usage'\'' together" >expect &&
     ++test_expect_success 'rev-list use --disk-usage unproperly' '
     ++	test_must_fail git rev-list --objects HEAD --disk-usage=typo 2>err &&
     ++	cat >expect <<-\EOF &&
     ++	fatal: invalid value for '\''--disk-usage'\'': '\''typo'\'', try --disk-usage=human
     ++	EOF
      +	test_cmp err expect
      +'
      +


 Documentation/rev-list-options.txt |  5 +++-
 builtin/rev-list.c                 | 42 ++++++++++++++++++++++++------
 t/t6115-rev-list-du.sh             | 22 ++++++++++++++++
 3 files changed, 60 insertions(+), 9 deletions(-)

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
index 30fd8e83eaf..05ef232dcbe 100644
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
@@ -473,6 +475,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 				 int filter_provided_objects)
 {
 	struct bitmap_index *bitmap_git;
+	struct strbuf disk_buf = STRBUF_INIT;
+	off_t size_from_bitmap;
 
 	if (!show_disk_usage)
 		return -1;
@@ -481,8 +485,13 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
 	if (!bitmap_git)
 		return -1;
 
-	printf("%"PRIuMAX"\n",
-	       (uintmax_t)get_disk_usage_from_bitmap(bitmap_git, revs));
+	size_from_bitmap = get_disk_usage_from_bitmap(bitmap_git, revs);
+	if (human_readable)
+		strbuf_humanise_bytes(&disk_buf, size_from_bitmap);
+	else
+		strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)size_from_bitmap);
+	puts(disk_buf.buf);
+	strbuf_release(&disk_buf);
 	return 0;
 }
 
@@ -624,10 +633,20 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (!strcmp(arg, "--disk-usage")) {
-			show_disk_usage = 1;
-			info.flags |= REV_LIST_QUIET;
-			continue;
+		if (skip_prefix(arg, "--disk-usage", &arg)) {
+			if (*arg == '=') {
+				if (!strcmp(++arg, "human")) {
+					human_readable = 1;
+					show_disk_usage = 1;
+					info.flags |= REV_LIST_QUIET;
+					continue;
+				} else
+					die(_("invalid value for '%s': '%s', try --disk-usage=human"), "--disk-usage", arg);
+			} else {
+				show_disk_usage = 1;
+				info.flags |= REV_LIST_QUIET;
+				continue;
+			}
 		}
 
 		usage(rev_list_usage);
@@ -752,8 +771,15 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			printf("%d\n", revs.count_left + revs.count_right);
 	}
 
-	if (show_disk_usage)
-		printf("%"PRIuMAX"\n", (uintmax_t)total_disk_usage);
+	if (show_disk_usage) {
+		struct strbuf disk_buf = STRBUF_INIT;
+		if (human_readable)
+			strbuf_humanise_bytes(&disk_buf, total_disk_usage);
+		else
+			strbuf_addf(&disk_buf, "%"PRIuMAX"", (uintmax_t)total_disk_usage);
+		puts(disk_buf.buf);
+		strbuf_release(&disk_buf);
+	}
 
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
