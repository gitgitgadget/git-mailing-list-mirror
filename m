Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69CAC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 11:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiHJLOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 07:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHJLOh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 07:14:37 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF993204A
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 04:14:35 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b6so7614149wmq.5
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 04:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=0DCpRvl11u0K+CPpAtMRw3QqpjHROe3hctL7Swl4Cxo=;
        b=MPzSzGBqQWrkaxTT71bMS9oQbBtig3cdGTr0mymkEsLu1aAYABz2QR81oJ6a+OXADV
         NWhALSpQ26/D1EGlc3vKRbZndx9Er+efkP8W+XsBxEPHFR/G4ZkzKHiLR3yOFp4pULN7
         OUSGm9crYSAUShqntbibtrZ/JMjbOcZgubTm88ceveUHmmFJaCj2Y2nRq7WqIpWyvpn/
         3i6EJ9QAciWpatE4Rchjth8Mf8zd5K7oNRKZ8v9WokF6b3eX8kzteCS7PHIKZUWbj7uA
         HcpcaaGKYwNMlCWxlzaPPjW6t+gsu8CdY2Ssr2AS+xpv5pI0gL68cewX6oLvL3JIcCiL
         Nmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=0DCpRvl11u0K+CPpAtMRw3QqpjHROe3hctL7Swl4Cxo=;
        b=Rx0DGMja6gxQ+HouhUyqqNbJ3EM2yiEBG7KB+b/rohJt5O0HD/QTg7jhCTX4Nu9xt4
         qP3lI36rUKRnnPmUGX9yZKBbGb8Urc8NGSe8ky0VDICrlvEiNBGMeX8IvAnKYSeVvuDM
         gVj2p5F0vxlC43HW63t7jpRCa1D/27TXG8dtetVG2XI7oYIJMDhsFMTKVtjhYdNIKal3
         Le0tm5shywTztbtg1Ei4WR8c/ypDg98sHTfe0q03CCLRoYxxdPziQzlKl9Otfdipgh5J
         cpe0SS5knPvsonh4x944Cx6z9sRLHR4e53m2zbwc0MYXgHqdu8AUC/3QkRbCU4FGpWvi
         Ku/Q==
X-Gm-Message-State: ACgBeo3fti2Pef4nKC82yQfkDcsBVVv9sRAML2VXRixDehNnOGGSgMXG
        bdMosqlypfv0DhpJ55czrv7a5/uTCIQ=
X-Google-Smtp-Source: AA6agR4pvIsKnZVAkvx3rknhWkzhLjqi5vAx+zHh3gdm8Yo6goIex+S3FZ09vSSW8hOkcprV6gTGXg==
X-Received: by 2002:a1c:2947:0:b0:3a5:b746:abc6 with SMTP id p68-20020a1c2947000000b003a5b746abc6mr279736wmp.163.1660130073948;
        Wed, 10 Aug 2022 04:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc11-20020a5d5c0b000000b002205ffe88edsm13509202wrb.31.2022.08.10.04.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:14:33 -0700 (PDT)
Message-Id: <pull.1313.v4.git.1660130072657.gitgitgadget@gmail.com>
In-Reply-To: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
References: <pull.1313.v3.git.1660111276934.gitgitgadget@gmail.com>
From:   "Li Linchao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 11:14:32 +0000
Subject: [PATCH v4] rev-list: support human-readable output for `--disk-usage`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Li Linchao <lilinchao@oschina.cn>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1313%2FCactusinhand%2Fllc%2Fadd-human-readable-option-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1313/Cactusinhand/llc/add-human-readable-option-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1313

Range-diff vs v3:

 1:  000a6b37ec9 ! 1:  e56da057a9a rev-list: support human-readable output for `--disk-usage`
     @@ Documentation/rev-list-options.txt: ifdef::git-rev-list[]
       --disk-usage::
      +--disk-usage=human::
       	Suppress normal output; instead, print the sum of the bytes used
     --	for on-disk storage by the selected commits or objects. This is
     -+	for on-disk storage by the selected commits or objects.
     -+	When it accepts a value `human`, like: `--disk-usage=human`, this
     -+	means to print objects size in human readable format. This is
     + 	for on-disk storage by the selected commits or objects. This is
       	equivalent to piping the output into `git cat-file
     - 	--batch-check='%(objectsize:disk)'`, except that it runs much
     +@@ Documentation/rev-list-options.txt: ifdef::git-rev-list[]
       	faster (especially with `--use-bitmap-index`). See the `CAVEATS`
     + 	section in linkgit:git-cat-file[1] for the limitations of what
     + 	"on-disk storage" means.
     ++	When it accepts a value `human`, like: `--disk-usage=human`, this
     ++	means to print objects size in human readable format.
     + endif::git-rev-list[]
     + 
     + --cherry-mark::
      
       ## builtin/rev-list.c ##
      @@ builtin/rev-list.c: static const char rev_list_usage[] =


 Documentation/rev-list-options.txt |  3 +++
 builtin/rev-list.c                 | 35 ++++++++++++++++++++++++++----
 t/t6115-rev-list-du.sh             | 22 +++++++++++++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 195e74eec63..5d3880874fc 100644
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
+	When it accepts a value `human`, like: `--disk-usage=human`, this
+	means to print objects size in human readable format.
 endif::git-rev-list[]
 
 --cherry-mark::
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
