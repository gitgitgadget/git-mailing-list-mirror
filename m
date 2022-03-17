Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E688CC433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiCQSK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiCQSKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C2139268
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so5413665wmj.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BE9llqJDMouT9fAD0B2IJX+NddMQwfNmRtLvlv1XDds=;
        b=SA11ULuFLxW8BbzR34l+JUFzYJIgFSXszRbDE+xc5twZDf8hwg4/uTXxt/xbgoVdwT
         IEcrOFiwHVuLaEVnmvDWluQypbTLnhzKvIhLypCffxAz2CUewqd75UPMkqpXVzw4ta3f
         xB0Y5NtMgindl4hGGza4d5mYSW9Vi8SowMgeNnwWR9hvhBZJwiNt9dGurA1HK1VCZqXW
         X+jo4gXAydBnM5wZkMhvRkj7zrl3C4SbZuPV6TeI4dFEFzU5yMgPHhGtahivRoiLQiIJ
         9OL6Bx9WPdvCLz32iOWkm5CKvyaDgneJuHBTxDUS/TMCEPB3OaI7Nl905M/zKjqh+aTw
         vLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BE9llqJDMouT9fAD0B2IJX+NddMQwfNmRtLvlv1XDds=;
        b=Y13Uo0pVhz/zpbwwjhDDzZzmn0budFSYpY6BbJAsSTKxXbmA3tkPNy2IdbfbxmvCcQ
         rgxtbC1ABN8jlOlsemRGXZLkTVUxcEAEp1EKzareCZKv/qX7nQA1h/YRxxP6SGU+9zBC
         n5XlXIsQm7IskClwrUwj+FGOMTOA5Tc9AvC5htsIxLgUgl4lQoMi7sVF2Gyu/YQEquEs
         UaSGXICkb89UkefKkk8QYFywn9MLgUPOZI7gdUVmNlRM3CpJTePCJGyQdoxi2P7oGEMC
         lgrwxsVdJg9tIkJxl+VSTR54LnHT0zkKajhQWhwLBySyMiFjAA14xvuxfSjmKVsDUzNx
         7KWg==
X-Gm-Message-State: AOAM531zcWaB4YjV90fKpYosc82kbj5BAvNizTnH+NtQqplMIuLzv00R
        pJXLNjJOJS/tU5iAsHUpdcmfvJl3mU1S4g==
X-Google-Smtp-Source: ABdhPJyH8tKMRTcUhw49UGwDuKHFQKXCEdK6ANs3YStQnBiGhDaOqU5f5C5rQpB1/O4hS4m29uHTng==
X-Received: by 2002:a7b:cbc2:0:b0:388:faec:2036 with SMTP id n2-20020a7bcbc2000000b00388faec2036mr5071822wmi.190.1647540540624;
        Thu, 17 Mar 2022 11:09:00 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:09:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] reflog: convert to parse_options() API
Date:   Thu, 17 Mar 2022 19:08:39 +0100
Message-Id: <patch-7.8-19e1ff0c569-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue the work started in 33d7bdd6459 (builtin/reflog.c: use
parse-options api for expire, delete subcommands, 2022-01-06) and
convert the cmd_reflog() function itself to use the parse_options()
API.

Let's also add a test which would fail if we forgot
PARSE_OPT_NO_INTERNAL_HELP here, as well as making sure that we'll
still pass through "--" by supplying PARSE_OPT_KEEP_DASHDASH. For that
test we need to change "test_commit()" to accept files starting with
"--".

The "git reflog -h" usage will now show the usage for all of the
sub-commands, rather than a terse summary which wasn't
correct (e.g. "git reflog exists" is not a valid command). See my
8757b35d443 (commit-graph: define common usage with a macro,
2021-08-23) for prior art.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/reflog.c        | 40 ++++++++++++++++++++++++++++++++--------
 t/t1410-reflog.sh       | 17 +++++++++++++++++
 t/test-lib-functions.sh |  2 +-
 3 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 9847e9db3de..3971921fc14 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -32,6 +32,14 @@ static const char *const reflog_exists_usage[] = {
 	NULL,
 };
 
+static const char *const reflog_usage[] = {
+	N_("git reflog [show] [<log-options>] [<ref>]"),
+	BUILTIN_REFLOG_EXPIRE_USAGE,
+	BUILTIN_REFLOG_DELETE_USAGE,
+	BUILTIN_REFLOG_EXISTS_USAGE,
+	NULL
+};
+
 static timestamp_t default_reflog_expire;
 static timestamp_t default_reflog_expire_unreachable;
 
@@ -372,17 +380,28 @@ static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
  * main "reflog"
  */
 
-static const char reflog_usage[] =
-"git reflog [ show | expire | delete | exists ]";
-
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
-	if (argc > 1 && !strcmp(argv[1], "-h"))
-		usage(_(reflog_usage));
+	struct option options[] = {
+		OPT_END()
+	};
 
-	/* With no command, we default to showing it. */
-	if (argc < 2 || *argv[1] == '-')
-		return cmd_log_reflog(argc, argv, prefix);
+	argc = parse_options(argc, argv, prefix, options, reflog_usage,
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0 |
+			     PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_NO_INTERNAL_HELP);
+
+	/*
+	  * With "git reflog" we default to showing it. !argc is
+	  * impossible with PARSE_OPT_KEEP_ARGV0.
+	  */
+	if (argc == 1)
+		goto log_reflog;
+
+	if (!strcmp(argv[1], "-h"))
+		usage_with_options(reflog_usage, options);
+	else if (*argv[1] == '-')
+		goto log_reflog;
 
 	if (!strcmp(argv[1], "show"))
 		return cmd_log_reflog(argc - 1, argv + 1, prefix);
@@ -393,5 +412,10 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 	else if (!strcmp(argv[1], "exists"))
 		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
 
+	/*
+	 * Fall-through for e.g. "git reflog -1", "git reflog master",
+	 * as well as the plain "git reflog" above goto above.
+	 */
+log_reflog:
 	return cmd_log_reflog(argc, argv, prefix);
 }
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 68f69bb5431..0dc36d842b0 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -106,6 +106,23 @@ test_expect_success setup '
 	test_line_count = 4 output
 '
 
+test_expect_success 'correct usage on sub-command -h' '
+	test_expect_code 129 git reflog expire -h >err &&
+	grep "git reflog expire" err
+'
+
+test_expect_success 'pass through -- to sub-command' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo message --a-file contents dash-tag &&
+
+	git -C repo reflog show -- --does-not-exist >out &&
+	test_must_be_empty out &&
+	git -C repo reflog show >expect &&
+	git -C repo reflog show -- --a-file >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success rewind '
 	test_tick && git reset --hard HEAD~2 &&
 	test -f C &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..1d004744589 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -329,7 +329,7 @@ test_commit () {
 	else
 		$echo "${3-$1}" >"$indir$file"
 	fi &&
-	git ${indir:+ -C "$indir"} add "$file" &&
+	git ${indir:+ -C "$indir"} add -- "$file" &&
 	if test -z "$notick"
 	then
 		test_tick
-- 
2.35.1.1384.g7d2906948a1

